#' ---
#' title: analysis2
#' output: 
#'   md_document:
#'         toc: true
#'         number_sections: true
#' ---

#' ## 1. Outline analysis 2
#' This document contains instead an example on how to set up a python script and the use `knitr::spin()` for converting it into an Rmd file. <br/>
#' Remember to add the 2 lines below (from the [reticulate package](https://rstudio.github.io/reticulate/index.html)) to each python script to ensure its conversion to Rmd and then md.
#' NB: you can find which interpreter you are using by running `py_config()`

#' ### First chunk: show some data
#+ chunk1
import pandas as pd
from sklearn import datasets
import matplotlib.pyplot as plt

iris = datasets.load_iris()
iris_df = pd.DataFrame(data=iris.data, columns=iris.feature_names)
iris_df.head()

x_index = 0
y_index = 1

#' ### Second chunk: plot data
#+ chunk2
formatter = plt.FuncFormatter(lambda i, *args: iris.target_names[int(i)])

plt.figure(figsize=(5, 4))
plt.scatter(iris.data[:, x_index], iris.data[:, y_index], c=iris.target)
plt.colorbar(ticks=[0, 1, 2], format=formatter)
plt.xlabel(iris.feature_names[x_index])
plt.ylabel(iris.feature_names[y_index])

plt.tight_layout()
plt.show()

