# Project template

# Table of Contents
- [Project template](#project-template)
- [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Content](#content)
  - [Project set up](#project-set-up)
    - [Code developing](#code-developing)
    - [Writing scripts](#writing-scripts)
  - [Report generation](#report-generation)
    - [Publish report on github](#publish-report-on-github)
  - [Improvements](#improvements)
## Overview
This repo contains a template that could be used for any data-analysis research projects. At the moment it allows to convert any raw R and/or Python scripts into Markdown files without the need of (re)writing your code in Rmarkdown. Morever, converted markdown files can be directly published into a project-associated website to facilitate reproducibility, data sharing and report generation. <br/>

Note that there are valid alternatives like [workflowr](https://github.com/workflowr/workflowr) which could also be used. However, I am personally developing this template aiming to:
1. Make it more customizable and more automated
2. Easily convert scripts in programming langauges other than R
3. Avoid the need of relying on Rmarkdown and Rstudio 

## Content
Here's an overview of the content of the main folders:
* `code/` contains all the raw scripts used in your own project
* `bin/` contains a series of scripts created to convert the raw scripts into markdown files
* `config/` contains the files with all info necessary to configure your own project
All the other directories contain files and data necessary to publish the markdown files in a github webpage associated with your project. 
##  Project set up
Here I am assuming you are working on a computer cluster. In this case, to set up your own project you need to:
1. Clone this repo to your desired destination
2. Rename the repo with your own project name
3. Change the entries in the `config/project_config.yaml file`
**Importantly:** This repo is designed to work on SLURM and, in particular, on the WEHI's Milton computer cluster. In order to use this project template for your own research you firstly need to set up your own I/O directories:
```
baseDir:  path/to/your/home/dir/where/you/store/all/your/files
project:  <same-project-name-of-your-repo>
tmp_dir: path/to/your/tmp/dir/where/you/store/all/tmp/files
```
Similarly, if you are developing your code in other job workload managers or you want to use different SLURM resources such as partition, memory usage and time, then you'll have to change the corresponding entries (still in the `config/project_config.yaml file`) such as:
```
mem:  <integer-with-the-amount-of-mem-in-Mb-to-request>
partition:  <slurm-partition-where-to-run-the-job>
time: <integer-with-the-amount-of-time-in-min-to-request>
```
If you need to change the list of modules to load when running an interactive session ([see code developing below](#code-developing)) as well as to activate your own python virtual environment (if you have one) then modify the `config/modules.txt` file accordingly. Lastly, to ensure that all of your raw scripts containing your analyses will be converted into markdown files you need to add their names (without extensions) as a list in the corresponding entries:
```
rscripts: [list,with,names,of,all,your,R,scripts]
pyscripts: [list,with,names,of,all,your,py,scripts]
```

### Code developing
Once you have configured your project, to start developing your code on a SLURM interactive session, you will need to run the following commands: 
```
chmod +x run-interactively.sh  ## to make sure the script is executable 
mv ./run-interactively.sh ../  ## move the run-interactively.sh script outside the project dir (for convenience)
cd ../ 
./run-interactively.sh -p <project_template> ## change this to whatever name you assigned to your project directory
eval "$(cat $modules)" ## this will load all modules listed in the modules.txt file
``` 
Now you should be all set to start developing your scripts.
### Writing scripts

To allow for an automatic conversion of any raw python and/or R scripts into Markdown (md), you'll need to remember to use a slightly different syntax. For a detailed explanation on how to write your code you can check:
* [this post](https://deanattali.com/2015/03/24/knitrs-best-hidden-gem-spin/)
* [this page of the Rmarkdown Cookbook](https://bookdown.org/yihui/rmarkdown-cookbook/spin.html)
  
which will show you what to include in your R scripts in order to automatically include chunks, text and comments. Basically:
1. Any line starting with `#+` will be interpreted as a knitr chunk header
2. Any line starting with `#'` will be rendered as markdown text
   
---
## Report generation

Once you are happy with all your analyses and you want to just convert all your scripts into Markdown files, you will have to go to your project home directory and run the following:
```
snakemake --cores 1 -s create-report.smk
```
This will start a [snakemake workflow](https://snakemake.readthedocs.io/en/stable/) process that will read all files in the `code/` directory and use the scripts located in the `bin/` direcrtory to convert them into the markdown format. The newly generated markdown files will be located in the `pages/` directory.


### Publish report on github
Once you have all your markdown files in the `pages/` directory, you can visualise, or share, the final report in the github webpage linked to your own project. For example, the webpage associated to this project template can be found [at this link](https://dvespasiani.github.io/project_template/). To create a webpage I am using [Jekyll](https://jekyllrb.com/) and the [Beautiful Jekyll](https://beautifuljekyll.com/) as a template. [Check this post](https://mbounthavong.com/blog/2022/7/30/hosting-a-r-markdown-html-file-on-a-github-page) if you want to learn more on how to set up a webpage for your own project.

---

## Improvements
Here's a (non-comprehensive) list of things **I still need to fix and/or do**:
* Adding commands to launch `sbatch` scripts 
* Improving layout final website
* Automatically add new markdown files as pages into the final website
* Improving `bin/knit-spin-py.sh` script