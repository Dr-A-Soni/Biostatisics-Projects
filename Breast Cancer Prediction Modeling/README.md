# Breast Cancer Prediction Modeling

## Overview

This project builds a **Logistic Regression Model** in R to classify breast cancer as either **Malignant** or **Benign** using the *Breast Cancer Wisconsin Diagnostic Dataset* available from kaggle here https://www.kaggle.com/datasets/uciml/breast-cancer-wisconsin-data?resource=download.

## Steps

1. Import packages

2. Load dataset

3. Explore and preprocess data (label encoding, scaling)

4. Split into train/test sets

5. Build Logistic Regression Model

6. Evaluate using the confusion matrix and ROC-AUC

## Repo Structure

-`Data/` -> Dataset

-`Scripts/` -> R Script (`model_build.R`)

-`Report/` -> R Markdown + knitted HTML report

-`README.md` -> Project Overview

## Requirements

R version >= 4.0

Packages Used: `tidyverse`, `caret`, `pROC`, `rio`

Install all dependencies using: pacman::p_load()

