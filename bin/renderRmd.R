#!/usr/bin/env Rscript
## This script parses one Rmd file at the time and converts it into an Markdown (md) format

library(knitr)
library(rmarkdown)
library(ezknitr)

inputRmd = unlist(snakemake@input[[1]])
outputMd = unlist(snakemake@output[[1]])
fig_dir = gsub('\\..*','',basename(inputRmd))

cat('Reading the', inputRmd,'file and converting it to Md format \n')

convertedMd <- ezknit(
    file = basename(inputRmd), 
    wd = dirname(inputRmd),
    fig_dir = fig_dir,  
    params = list(),
    verbose = FALSE, 
    chunk_opts = list(tidy = FALSE), 
    keep_md = TRUE,
    keep_html = F
)

cat('Done with Md conversion \n')