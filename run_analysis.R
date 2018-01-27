## You should create one R script called run_analysis.R that does the following.
## 
## Task 1. Merges the training and the test sets to create one data set.
## Task 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## Task 3. Uses descriptive activity names to name the activities in the data set
## Task 4. Appropriately labels the data set with descriptive variable names.
## Task 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Pre-condition: Dataset should be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ;
##   extract the compressed file at current directory; a folder 'UCI HAR Dataset' will then appear containing the test and training sets, and activity labels as well as its features

## Load needed libraries
library(data.table)
library(reshape2)

## Load activity_labels data; with 6 tuples 
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

## Load features data; with 561 tuples
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

## Load test data : subject_test, X_test and y_test
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

## Load train data : subject_train, X_train and y_train
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

## Extracting measurements on mean and standard deviation for each measurement
MeanStd <- grep("mean|std", features)
names(x_test) = features
names(x_train) = features
x_test <- x_test[,MeanStd]
x_train <- x_train[,MeanStd]

## Load activity labels
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

### Binding all columns of each test set and training set
test_data <- cbind(as.data.table(subject_test), x_test, y_test)
train_data <- cbind(as.data.table(subject_train), x_train, y_train)

## Merging test and training data
dataSet <- rbind(test_data,train_data)
id_labels = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(dataSet), id_labels)

## Creating a second, independent tidy data set with the average of each variable for each activity and each subject
baseData = melt(dataSet, id = id_labels, measure.vars = data_labels)
# Apply mean function to dataset using dcast function
tidy_data = dcast(baseData , subject + Activity_Label ~ variable, mean)
write.table(tidy_data, file = "./tidy_data.txt", sep = ",", row.name=FALSE)


