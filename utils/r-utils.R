## list here all the main variables and functions used my scripts
## if any of these are used more than once in different scripts then they will be sourced from here
##=============##
##  LIBRARIES  ##
##=============##
## list here all libraries common to all scripts
library(yaml) 
library(data.table)
library(dplyr)
library(magrittr)
library(R.utils)
library(stringr)
library(ggplot2)
library(ggpubr)

##=============##
##   Options   ##
##=============##
options(width=150)

## PARSE CONFIG ARGS
project_config <- read_yaml('./config/project_config.yaml')

##=============##
## DIRECTORIES ##
##=============##
base_dir = project_config$project_config$baseDir 
project_name = project_config$project_config$project 
project_dir = paste(base_dir,'/',project_name,'/',sep='')
tmp_dir = project_config$project_config$tmp_dir
data_dir = paste(project_dir,project_config$project_config$data,sep='')
out_dir = paste(project_dir,project_config$project_config$outdir,sep='')
logs_dir = paste(project_dir,project_config$project_config$logs,sep='')
code_dir = paste(project_dir,project_config$project_config$code,sep='')
bin_dir = paste(project_dir,project_config$project_config$bin,sep='')

## setwd for all R scripts
setwd(project_dir)
