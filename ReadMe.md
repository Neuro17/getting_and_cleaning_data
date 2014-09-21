---
title: "Getting and celaning data"
author: "Biagio Chirico"
date: "21/09/2014"
output: html_document
---

#Getting and cleaning data

##Introduction
This is my work for the course project of _gettin and cleaning data_ on coursera.

#About the data
Data are divided in train and test datasets and for each of those there are three files that are useful for this assignment. They are `subject` , `y` and `X`.
The goal is merge train and test datasets with all features.

#About the script
The script called `run_analysis.R` is fully reproducible. 

- Initally it provides to download and extract data, if necessary.
- It merge for each of test and train two colums that are the `y` variable and `subject_train`, after that it merge datasets together.
- Next step is extract the columns about mean and standard deviation (`mean` and `std`)
- finally it creates `tidy.txt` file that contains an aggregation of data by `acticity` and `subject`

# About the codebook
Codebook explains the transformation performed on variables