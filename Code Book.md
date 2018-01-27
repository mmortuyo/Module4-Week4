Code Book
==========

## Pre-condition
Reminds the user to get a copy of the dataset from the given link

## Libraries
Load needed libraries for the run_analysis.R script

## Load data from files
* activity_labels : Description of activity IDs in y_test and y_train
* features : description(label) of each variables in x_test and x_train
* subject_test : subject IDs for test
* x_test : values of variables in test
* x_train : values of variables in train
* subject_train  : subject IDs for train
* y_test : activity ID in test
* y_train : activity ID in train

## Extract measurements on mean and standard deviation
Create a vector of only mean and std labels, then use the vector to subset dataSet.
* MeanStd : a vector of only mean and std labels extracted from 2nd column of features

## Load activity labels
* y_test, y_train : dataset has been properly labeled with corresponding activity label

## Bind all columns of each test and training set
*test_data : binds with the subject, x and y columns of test dataset
*train_data : binds with the subject, x and y columns of train dataset
 
## Merging test and training data
* dataSet : contains test and train dataset including subject, x and y with only measurements on mean and std variables

## Output tidy data
In this part, dataSet is melted to create tidy data. Finally output the data as "tidy_data.txt"
* baseData : melted tall and skinny dataSet
* tidy_data : baseData has means of each variable
 		: upon write.table() row.name was set to FALSE