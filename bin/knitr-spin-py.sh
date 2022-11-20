#!/bin/bash

## Original author: https://gist.github.com/amackcrane
## Usage: ./knitr-spin-pythin.sh <file.py>

##   Rmarkdown has an engine for native python code, but
## knitr::spin (which facilitates dual report/script
## functionality without code duplication by translating
## from .R to .Rmd) doesn't.
##   Luckily, we don't need to parse anything, just convert
## markdown annotations to plain text, and code chunks to
## rmarkdown format.
##   Note that, unlike with knitr::spin, code not in chunks 
## (i.e. following a markdown line) is currently ignored.


# make new filename from $1
inputpy="$1"
outputRmd="$2"
echo "Converting the $inputpy Python script into Rmd file format and writing it to $outputRmd file \n"

# setup outfile
touch $outputRmd
script_name=$(basename "${outputRmd%.*}")

printf "
---
title: $script_name
output: md_document
---
" >> $outputRmd

uninit=true
chunk=

# slurp file
while IFS= read -r line;
do
    # if we're currently in a code chunk
    if [ $chunk ]
    then
        # and hit either MD or a new chunk...
        if [[ $line =~ ^\#[\+\'] ]]
        then
	          # finish code chunk
	          printf '```\n' >> $outputRmd
	          chunk=""
        else
	          # otherwise leave code be
	          echo "$line" >> $outputRmd
	      fi
    fi

    # markdown line
    if [[ $line =~ ^\#\' ]]
    then
        # strip pound jawn
        echo "$line" | sed "s|#' *||" >> $outputRmd

    # code chunk beginning
    elif [[ $line =~ ^\#\+ ]]
    then
        # if this is the first chunk
        if [ $uninit ]
        then
            # slide in there and do some opts_chunk$set
            printf '\n```{r setup, include=T}\nknitr::opts_chunk$set(
                eval = TRUE, echo = TRUE, include=TRUE,
                fig.width = 5, fig.height = 5, dev="png",
                # fig.path= path/to/folder/with/all/figs,
                warning=TRUE, error=TRUE)\nlibrary(reticulate)\nuse_python("/stornext/System/data/tools/snakemake/snakemake-7.12.0/bin/python3")\n```\n' \
                >> $outputRmd
            uninit=
        fi

        # reformat to rmd python chunk
        #   going to great lengths to prepend a newline
        echo "$line" | sed -E 's|#\+ *(.*)|```{python \1}|' | \
            xargs -0 printf "\n%s" >> $outputRmd

        chunk=true
    fi
    
    	
done <$1

# If we ended the file in a code chunk, we'll know
if [ $chunk ]
then
    # in case file didn't end in newline
    echo "$line" >> $outputRmd
    printf '```\n' >>  $outputRmd
fi

echo
