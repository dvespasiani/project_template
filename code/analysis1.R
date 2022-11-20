#' ---
#' title: analysis1
#' output: 
#'   md_document:
#'         toc: true
#'         number_sections: true
#' ---

#' ## 1. Outline analysis 1
#' This document contains examples on how to set up an R script and use `knitr::spin()` to convert it into an Rmd file. <br/>
#' Note that if you go down this path, you'd need to use a slightly different syntax in your R scripts. Check [here](https://bookdown.org/yihui/rmarkdown-cookbook/spin.html) and [here](https://rpubs.com/alobo/spintutorial) for an overview of the commands. <br/>
#' I intended to create this template in order to speed up report generation and code development at the same time 
#' without the need of having to manually copy your R scripts into an Rmd file at the end.
#' In this way, and by using the set of executable commands (see repo README) you should be able to automatically convert everything all at once <br/>


#+ setup, include=F
knitr::opts_chunk$set(
    eval = TRUE, echo = TRUE, include=TRUE,
    fig.width = 5, fig.height = 5, dev='png',
    # fig.path= path/to/folder/with/all/figs,
    warning=TRUE, error=TRUE
)

#' ### First chunk: show some data
#+ chunk1
library(data.table)
library(ggplot2)
head(mtcars)

#' ### Second chunk: plot data

#+ chunk2
ggplot(mtcars,aes(x=as.factor(cyl),y=mpg))+ 
    geom_boxplot() + 
    xlab('cyl') + 
    ylab('mpg')



















