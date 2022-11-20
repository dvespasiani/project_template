# Overview
I have created this template to facilitate setting up any research project and keep an up-to-date lab notebook. The idea is to have something that allows me to develop my code and then generating Rmarkdown reports without the need to re-write the code and use softwares like Rstudio to render the webpages. <br/>
Note that there are valid alternatives like [workflowr](https://github.com/workflowr/workflowr) which might be easier to use and to implement without too much coding knowledge. However, I think this gives me a bit more of flexibility (e.g.,integrating different programming languages and not just R) and that's why I decided to still create this repository.
## Content
I am listing here the important (or most useful) directories and what they are meant to contain. All the other ones contain info to generate a github webpage using [Jekyll](https://jekyllrb.com/), so I won't go into their specifics 
* `code/` contains all the scripts used in the project
* `bin/` contains a series of executables and scripts that I created to generate the report from the list of files contained in the `code/` dir 
* `utils/` contains some useful scripts that are used to parse the yaml file in the `config/` and create the report
* `config/` contains yaml and txt files with all directives for project and cluster configuration 

## Project set up
**NB1:** all codes in this repo are designed to work on the WEHI's Milton computer cluster <br/>
To set up your own project clone this repo and then copy it into your home dir in the cluster
1. Log in into cluster via `ssh vc7-shared` 
2. Navigate to your `$HOME/` and copy this repo in there
3. Create your `projectDir/`
4. To run an interactive session:
```
mv projectDir/bin/runInteractively.sh $HOME/ # make sure to make the script executable 
$HOME/runInteractively.sh -p projectDir/
``` 
The script will call the `projectDir/utils/parse_configyaml.py` which, in turn, will read in all the entries in the YAML files and export them into your environment. So if you need to change anything relatively to the cluster set up, e.g., the amount of memory or the time you need, look at the corresponding entries in the `config/cluster_config.yaml` file. Otherwise if you need to change anything as part of your project set up then do it in the `config/project_config.yaml`. 

5. Run `eval "$(cat $modules)"` to load all modules listed in the `config/modules.txt` file

Now you are ready to develop/improve your codes interactively. <br/>
**NB2:** In order to generate Rmd files automatically and directly from your scripts (i.e., without manually copying them into Rstudio) you'll need to remember to use a slightly different syntax to allow a correct conversion from R/py --> Rmd (see [Converting scripts to Rmd format](#converting-scripts-to-rmd-format)). <br/>
 
## Converting scripts to Rmd format
To generate a md report (I prefer this as it can be directly visualised on github) you need to run the `utils/create-report.sh` script. <br/>
The script is a wrapper for other small programs I wrote that will take any *.R or *.py file within the `code/` dir and first convert them into an Rmd file and then into a md file. 
## Publish report on github
Once you have all your markdown files in the `docs/` directory, you can visualise the final report in the github webpage associated to your own project. For example the final report for this project template can be found [at this link](https://dvespasiani.github.io/project_template/). Check [this post](https://mbounthavong.com/blog/2022/7/30/hosting-a-r-markdown-html-file-on-a-github-page) if you want to learn how to set up a webpage for your own project. <br/>

## 2 fix
Here's a (non-comprehensive) list of things **I still need to fix**:
* Rendering issues in the final webpage

## 2 do
Here's a (non-comprehensive) list of things **I still need to do**:
* Adding commands to launch `sbatch` scripts 
