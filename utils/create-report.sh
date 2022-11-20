#!/bin/bash
## Script use to wrap up all the other programs and, with a single command, creating your report
## Use function to decide whether to force converting all the scripts again or just a subset you specify or only those not in sync between the code and docs dir\

projectDir="${baseDir}/${project}"
codeDir="${baseDir}${project}/code"
docsDir="${baseDir}${project}/docs"


usage(){
   echo ""
   echo "Usage: $0 -a <all scripts> -f <file>"
   echo -e "\t-a force creating the report from ALL FILES in the code dir"
   echo -e "\t-f specify just the name the script you want to convert"
   echo ""
   exit 1 # Exit script after printing help
}

## set this to false so that if you call the -a flag (see below) then it will mean to render all the scripts in the code directory
parse_all=false

while getopts ":af:" opt; do
    case "${opt}" in
        a) 
            parse_all=true
            ;;
        f) 
            f=${OPTARG}
            ;;
        *)
            echo "invalid command $OPTARG"
            ;;
        ?) 
            usage 
            ;; # Print helpFunction
    esac
done
shift $((OPTIND -1))


cd $projectDir

# if/else statement depending if you want to parse all files or not
if [ "$parse_all" = true ]; then
    echo
    echo "Creating the report for all files in the ${codeDir} dir "
    echo
    echo "Converting all R files"
    echo
    Rscript ./bin/convert2Rmd.R 
    
    pyscripts=`ls -1 ${codeDir}/*.py 2>/dev/null | wc -l` # count how many py scripts there are in the code dir
    
    if [ $pyscripts != 0 ]; then 
    echo "There are $pyscripts *.py scripts in the code dir ... converting them as well"
    
        for f in ${codeDir}/*.py; do
        ./bin/knitr-spin-py.sh $f
        done
    else 
    echo "No *.py scripts in code dir, proceeding with report generation"
    fi 

    echo "Done with converting all the scripts in the $codeDir"
    echo
    echo "Here is the list of all new .Rmd files"
    echo
    ls $codeDir/*.Rmd | xargs -n 1 basename
    echo 
    echo "I will now move them to the $docsDir dir..."
    echo
    ./bin/update-docs-dir.sh
    echo
    echo "and then render the Rmd files into md format for the final report"
    Rscript ./bin/renderRmd.R 
    echo

else
    echo
    echo "Creating the report only for the ${f} file"
    echo

    file=$(basename -- "$f")
    fextension="${file##*.}"
    fname="${file%.*}"

    # Check if you have specified an .R or .py file
    if [[ $f == *'.R' ]] ; then 
        Rscript ./bin/convert2Rmd.R -f $f
        else 
        ./bin/knitr-spin-py.sh $f
    fi

    echo "Finished converting $f"
    echo
    echo "Here is the list of all new .Rmd files"
    echo
    ls $codeDir/*.Rmd | xargs -n 1 basename
    echo 
    echo "I am moving the corresponding .Rmd file into the $docsDir dir"
    ./bin/update-docs-dir.sh
    echo
    echo "Creating the ${fname}.md file for the final report"
    echo
    Rscript ./bin/renderRmd.R -f $docsDir/${fname}.Rmd
    echo

fi

echo "Finished converting the scripts, here's the content of docs directory"
echo
ls $docsDir/* | xargs -n 1 basename
echo
