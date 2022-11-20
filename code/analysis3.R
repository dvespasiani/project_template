#' ---
#' title: analysis3
#' output: 
#'   md_document:
#'         toc: true
#'         number_sections: true
#' ---

#' ## 1. Outline analysis 3

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
library(datasets)
data(iris)
summary(iris)

#' ### Second chunk: plot data

#+ chunk2
plot(iris)
