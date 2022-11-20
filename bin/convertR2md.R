#!/usr/bin/env Rscript
## this script parses one R file at the time and converts it into an Rmd format


library(knitr)
library(ezknitr)
library(rmarkdown)

inputR = unlist(snakemake@input[[1]])
outputRmd = unlist(snakemake@output[[1]]) 
out_dir = paste(dirname(outputRmd),'/',sep='')

cat('Reading the', inputR,'file and converting it to md format \n')

convertedRmd <- ezspin(
    file = inputR, 
    out_dir = out_dir, 
    # out_suffix, 
    verbose = T, 
    chunk_opts = list(tidy = FALSE), 
    keep_rmd = F,
    keep_md = T, 
    keep_html = F
)

cat('Done with md conversion \n')
