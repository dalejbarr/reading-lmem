--- 
title: "Workshop on linear mixed-effects models"
author: "Dale J. Barr"
date: "2022-07-18"
site: bookdown::bookdown_site
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apa
csl: include/apa.csl
link-citations: yes
description: "Workshop at University of Reading, July 20-21, 2022."
url: "https://dalejbarr.github.io/reading-lmem"
github-repo: "dalejbarr/reading-lmem"
---



# Workshop Overview {-}

*Dale J. Barr*

**University of Reading, July 20-21, 2022**

## Workshop goals {-}

The goal of this workshop is to provide a foundational understanding of the use of mixed-effects models in the analysis of data from typical psychology experiments. Mixed-effects models are a type of linear regression model that estimate a 'mix' of fixed and random effects—thus, the course focuses on providing an understanding of how to represent different types of experimental designs using regression. 

Two pre-requisites for the workshop are: (1) basic understanding of linear regression and (2) some familiarity with the R statistical programming environment (https://cran.r-project.org). 

Please have R and RStudio installed on your laptop prior to the start of the workshop, including the packages **`{tidyverse}`** and **`lme4`**. You can find help on installation [in the Appendix](installing-and-configuring-rrstudio.html).

While it will be possible to understand the conceptual content of the workshop without knowing R, there will be interactive exercises that require understanding of the fundamentals of R programming. For beginners, it is recommended that you work through [the introductory materials in the Appendix](coding-in-r-with-the-rstudio-ide.html).

## Workshop plan {-}

- *Day 1* (Wednesday, July 20): **Linear regression**
  - general linear model
  - multiple regression
  - interactions
  - modeling trends (polynomial, generalized additive mixed models)

- *Day 2* (Thursday, July 21): **Mixed-effects modeling**
  - variance-covariance matrices
  - walkthrough of the `sleepstudy` data
  - specifying the random-effects structure
  - going further:
    - dealing with autocorrelation
    - Generalized Linear Mixed Models (GLMMs) and
    - Generalized Additive Mixed Models (GAMMs)

## Notes on these materials {-}

These materials comprise an **interactive textbook**. Each "chapter" contains embedded exercises as well as web applications to help participants better understand the content. The interactive content will only work if you access this material through a web browser. Printing out the material is not recommended. 

It would be good to keep a local copy of these materials in case the website eventually disappears. You can [download an offline version](reading-lmem.zip){target="_download"} of these materials. It contains the current snapshot. Because things may change while the workshop is ongoing, it would be best to wait until the end of the workshop before downloading a permanent version.

Once you've downloaded the archive, just extract the files, locate the file `index.html` in the `docs` directory, and open this file using a web browser.

You are free to re-use and modify the material in this textbook for your own purposes, with the stipulation that you cite the original work. Please note additional terms of the [Creative Commons CC-BY-SA 4.0 license](https://creativecommons.org/licenses/by-sa/4.0/) governing re-use of this material.

The book was built using the R [**`bookdown`**](https://bookdown.org) package. The source files are available at [github](https://github.com/dalejbarr/basel-longitudinal).

## Found an issue? {-}

If you find errors or typos, have questions or suggestions, please file an issue at <https://github.com/dalejbarr/basel-longitudinal/issues>. Thanks!
