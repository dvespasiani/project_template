# Project template
---
# Table of Contents
- [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Content](#content)
  - [Project set up](#project-set-up)
    - [Running interactive sessions](#running-interactive-sessions)
  - [Writing scripts](#writing-scripts)
  - [Report generation](#report-generation)
  - [Publish report on github](#publish-report-on-github)
  - [2 fix](#2-fix)
  - [2 do](#2-do)
## Overview
This repo contains a template for any data-analysis research projects. At the moment it allows to convert any raw R and/or Python scripts into Markdown files without the need of (re)writing your code in Rmarkdown. Morever, converted markdown files can be published into the project-associated website to facilitate reproducibility, data sharing and report generation. <br/>

Note that there are valid alternatives like [workflowr](https://github.com/workflowr/workflowr) which could also be used. However, I am developing this template aiming to:
1. Make it more customizable 
2. Easily convert scripts in programming langauges other than R
3. Avoid the need of relying on Rmarkdown and Rstudio 

## Content
Here's an overview of the content of the main folders:
* `code/` contains all the raw scripts used in the project
* `bin/` contains a series of scripts created to convert the raw scripts into markdown files
* `config/` contains the files with all info necessary to configure your project
All the other directories contain files and data necessary to publish the markdown files in a github webpage associated with your project. The website is created using [Jekyll](https://jekyllrb.com/) and the [Beautiful Jekyll template](https://beautifuljekyll.com/).
##  Project set up
**Importantly:** This repo is designed to work on SLURM and, in particular, on the WEHI's Milton computer cluster. If you want to change the set of I/O directories and/or the commands to run jobs or sessions on the cluster then you will need to modify the `config/project_config.yaml` file.

To set up your own project clone this repo to your desired destination. 
### Running interactive sessions
If you want to set up an interactive session to develop your code then run the folllowing commands:
```
chmod +x run-interactively.sh  ## to make sure the script is executable 
mv ./run-interactively.sh ../  ## move the run-interactively.sh script outside the project dir (for convenience)
cd ../ 
./run-interactively.sh -p <project_template> ## change this to whatever your project directory is
eval "$(cat $modules)" ## this will load all modules listed in the modules.txt file
``` 

The script will parse all the entries in the `config/project_config.yaml` file and export them into your environment. If you need to change anything like the project I/O directories, the interactive session parameters etc.. then look at the corresponding entries in the `config/project_config.yaml` file. If you instead need to change the list of modules you want to load then modify the `config/modules.txt` file.

## Writing scripts
In order to generate md files automatically and directly from the raw R/py scripts and directly (i.e., without the intermediate Rstudio copy-paste-and-modify step) you'll need only to use a slightly different syntax to allow a correct conversion between file formats (see [Converting scripts to Rmd format](#converting-scripts-to-rmd-format) for a detailed explanation). <br/>

## Report generation
Once you are happy with all your analyses and you want to just convert all your scripts into Markdown files, you will have to go to your project home directory and run the following:
```
snakemake --cores 2 -s create-report.smk

```
This will start a snakemake workflow process that will read all files in the `code/` directory and use the scripts located in the `bin/` direcrtory to convert them into md files.
## Publish report on github
Once you have all your markdown files in the `pages/` directory, you can visualise the final report in the github webpage associated to your own project. For example the final report for this project template can be found [at this link](https://dvespasiani.github.io/project_template/). Check [this post](https://mbounthavong.com/blog/2022/7/30/hosting-a-r-markdown-html-file-on-a-github-page) if you want to learn how to set up a webpage for your own project. <br/>

## 2 fix
Here's a (non-comprehensive) list of things **I still need to fix**:

## 2 do
Here's a (non-comprehensive) list of things **I still need to do**:
* Adding commands to launch `sbatch` scripts 
* Improving layout final website
* Improve this README