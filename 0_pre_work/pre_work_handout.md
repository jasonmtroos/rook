---
title: "Data visualisation, web scraping, and text analysis in R: Pre-work"
author: "J.M.T. Roos"
date: 'Last updated: 2018-05-14 10:52:49'
output: 
  html_document: 
    theme: paper
    highlight: pygments
    keep_md: yes
editor_options: 
  chunk_output_type: console
---



Welcome to the Data visualisation, web scraping, and text analysis in R course offered by EGSH. Because we have more material to cover than we have time together, you will need to do a few things before our first meeting.

## Familiarity with R

You should have prior experience with writing code in the [R programming language](https://www.r-project.org/). Although you do not need to be an expert in R, this course is not an introduction to programming, and I will assume you understand the basics of R, such as expressions, functions, conditional statements, loops, etc.

If you are not particularly comfortable writing code in R, or perhaps just generally unsure about your level of preparedness, it is important that you practice writing code in R so that you can get the most out of the course. A few resources that might help:
 
* I created a series of R tutorials for my MSc course "Marketing Analytics." Please [download the tutorials](http://www.jasonmtroos.com/assets/media/teaching/course_assignments_and_data.zip), unzip them, and follow along (reading and coding as you go). You do not need to be familiar with all of the material in these tutorials---in fact, we will cover much of this material as part of the class---but at the same time, the material in these tutorials shouldn't be entirely alien to you. A good test is whether you already know everything in Assignment 1, plus how to write basic statements using the `if`, `for`, and `function` statements in R (which are not covered in Assignment 1, but are important for our course). If you know all of that, and can comprehend the material in the later assignments (even if it is unfamiliar), then you are probably in fine shape for the course.
* Additional resources for learning R can be found at [this web page I put together](http://www.jasonmtroos.com/learning-r/).



## Software

You need to have the following programs installed on whichever laptop you will bring to the course sessions: 

- [git](https://git-scm.com)
- [R](https://cloud.r-project.org/)   
- [RTools](https://cran.r-project.org/bin/windows/Rtools/) (Windows only) 
    - Be sure that you install this to your local hard drive, and not to a network share
- [RStudio](https://www.rstudio.com)

Instructions for each of these follow.

#### Git

Git is a program for keeping track of changes you make to your code over time.

Install git on your computer if you do not already have it. You can download git from https://git-scm.com/downloads and find detailed installation instructions at [https://git-scm.com/book/en/v2/Getting-Started-Installing-Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git). 


#### R and RStudio

RStudio provides an integrated development environment (IDE) for writing and executing scripts written in R.

Install R on your computer if you do not already have it installed. You can download R from [https://cloud.r-project.org/](https://cloud.r-project.org/). If you are working on a Windows computer, you should also install [RTools](https://cran.r-project.org/bin/windows/Rtools/).

If you have an older version of R on your computer, now is a good time to upgrade to the latest version. As of the time of writing, the current version of R is 3.5.0. To see the version on your computer, execute the following code in the R Console (or R Studio if already installed):


```r
version$version.string
```


Install RStudio on your computer if you do not already have it. You can download RStudio from [https://www.rstudio.com/products/rstudio/download/](https://www.rstudio.com/products/rstudio/download/). Note that RStudio offers both commercial and free versions; you should install the free version.


**Note:** Jason is running  R version 3.5.0 (2018-04-23) Joy in Playing and RStudio 1.1.447 at the time of writing.



#### R Packages

Open an R console and execute the following:

```r
install.packages('devtools', dependencies = TRUE)
install.packages('tidyverse', dependencies = TRUE)
install.packages('Hmisc', dependencies = TRUE)
install.packages('tm', dependencies = TRUE)
install.packages('twitteR', dependencies = TRUE)
install.packages('lda', dependencies = TRUE)
```

Windows users will want to execute the following R code *after* they have installed the `devtools` package and installed RTools. Open RStudio and type the following into the R Console, then hit Enter.


```r
devtools::setup_rtools()
```

OS X users may need to install the XCode command-line tool chain, by opening a Terminal window and executing the following command:


```bash
xcode-select --install
```



## GitHub account

We will use [GitHub](https://github.com/) to share code and data. Please sign up for an account at https://github.com/ if you do not already have one.

After you have created a GitHub account, you need to do a little bit of configuration:

* Start a new **terminal** (OS X) or **bash** (Linux) or **git-bash** (Windows) session
* Execute the following commands, substituting your information
* **Note:** Use the email address associated with your **GitHub** account


```bash
git config --global user.name "Your Name"
git config --global user.email "yourname@example.com"
```

* OS X users might need to issue the following commands as well


```bash
git credential-osxkeychain
git config --global credential.helper osxkeychain
```

## Even more things you can do!

The following needs to be done prior to Session 3. Given the short time frame for this course, it is advised that you complete as much of this now as you can (be sure to review the technical material just prior to Session 3, though). 

#### Twitter

* Follow [this tutorial](http://bigcomputing.blogspot.nl/2016/02/the-twitter-r-package-by-jeff-gentry-is.html) which provides detailed instructions for setting up programmatic access to Twitter. 
* Specifically, do the following (but follow the detailed instructions in the tutorial):
    1. `install.packages('twitteR', dependencies = TRUE)`
    2. [Create a Twitter account](http://twitter.com/signup) if you do not already have one
    3. Visit the [Twitter apps](https://apps.twitter.com) site and create a new app
    4. Create and record the four variables needed to access the Twitter API, and insert them into the code below to verify everything is working without error. You will need these four values for Session 3.
    

```r
library(twitteR)
setup_twitter_oauth("your_consumer_key", "your_consumer_secret", "your_access_token", "your_access_secret")
searchTwitter(searchString = '#hashtag', n = 100,
  lang = 'en', since = NULL, until = NULL, locale = NULL,
  geocode = NULL, sinceID = NULL, maxID = NULL, 
  resultType = 'recent', retryOnRateLimit = 120)
```

#### HTML

* [Review or learn the basics of HTML](https://www.w3schools.com/html/html_intro.asp)
* [Play this game](http://flukeout.github.io) to learn CSS
* Install [SelectorGadget](https://chrome.google.com/webstore/detail/selectorgadget/mhjhnkcfbdhnjickkkdbjoemdmbfginb/related) for Chrome and try it, or else do a lot of playing around with "Inspect Element" in your favorite browser
* Skim [this Wikipedia article about CGI query strings](https://en.wikipedia.org/wiki/Query_string) so that you have a sense of why I might infer that if this page generates page 1 of data: `http://some-site.com/show_data?page=1`, then this page: `http://some-site.com/show_data?page=2` will probably generate page 2.

#### The `tm` package

* Read and follow (type along with) this tutorial:

```r
vignette('tm', package = 'tm')
```
(or https://cran.r-project.org/web/packages/tm/vignettes/tm.pdf if that doesn't work...)


#### Concepts behind sentiment analysis

* Skim pp 1--7 of [Gonçalves, et al. "A Benchmark Comparison of State-of-the-Practice Sentiment Analysis Methods." arXiv preprint arXiv:1512.01818 (2015). http://arxiv.org/pdf/1512.01818.pdf](http://arxiv.org/pdf/1512.01818.pdf)


