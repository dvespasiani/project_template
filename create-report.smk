import os
import itertools
import glob

##================##
## config params  ##
##================##
configfile: "config/project_config.yaml"

##================##
##    I/O dirs    ##
##================##
project_config = config['project_config']
project_name = project_config['project']
code_dir = project_config['code']
pages_dir = project_config['pages']
bin_dir = project_config['bin']
logs_dir = project_config['logs']


##==================================##
##  Scripts to render in md format  ##
##==================================##
scripts = config['scripts']
rscripts = scripts['rscripts']
pyscripts = scripts['pyscripts']

##================##
##  All targets   ##
##================##
rule all:
    input:
        ## Convert R scripts to md
        expand(code_dir + "{rscripts}.R", rscripts = rscripts),
        expand(pages_dir + "{rscripts}.md", rscripts = rscripts),

        ## Convert Python scripts to md
        expand(code_dir + "{pyscripts}.py", pyscripts = pyscripts),
        expand(pages_dir + "{pyscripts}.md", pyscripts = pyscripts),


rule R2md:
    input:
        code_dir + "{rscripts}.R"
    output:
        pages_dir + "{rscripts}.md"
    log:
        logs_dir + 'R2md/' + "{rscripts}-md-conversion.log"
    script:
        "./bin/convertR2md.R"


rule py2Rmd:
    input:
        code_dir + "{pyscripts}.py"
    output:
        temp(pages_dir + "{pyscripts}.Rmd")
    log:
        logs_dir + 'py2md/' + "{pyscripts}-Rmd-conversion.log"
    shell:
        "./bin/knitr-spin-py.sh {input} {output}"

rule Rmd2md:
    input:
        rules.py2Rmd.output
    output:
        pages_dir + "{pyscripts}.md"
    log:
        logs_dir + 'py2md/' + "{pyscripts}-md-conversion.log"
    script:
        "./bin/renderRmd.R"
