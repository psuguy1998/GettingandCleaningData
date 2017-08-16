
## The purpose of this project is to demonstrate your ability to collect, work with, 
## and clean a data set. The goal is to prepare tidy data that can be used for later 
## analysis. You will be graded by your peers on a series of yes/no questions related to 
## the project. You will be required to submit: 
## 1) a tidy data set as described below, 
## 2) a link to a Github repository with your script for performing the analysis, and 
## 3) a code book that describes the variables, the data, and any transformations or 
## work that you performed to clean up the data called CodeBook.md. You should also 
## include a README.md in the repo with your scripts. This repo explains how all of 
## the scripts work and how they are connected.

## One of the most exciting areas in all of data science right now is wearable computing
## - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing
## to develop the most advanced algorithms to attract new users. The data linked to from 
## the course website represent data collected from the accelerometers from the Samsung 
## Galaxy S smartphone. A full description is available at the site where the data was 
## obtained:  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Here are the data for the project:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## You should create one R script called run_analysis.R that does the following.
## * Merges the training and the test sets to create one data set.
## * Extracts only the measurements on the mean and standard deviation for each measurement.
## * Uses descriptive activity names to name the activities in the data set
## * Appropriately labels the data set with descriptive variable names.
## * From the data set in step 4, creates a second, independent tidy data set with 
##    the average of each variable for each activity and each subject.

## load libraries
library(dplyr)

## set location of data sets - put final forward slash on
test_location<-"GettingandCleaningData/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/"
train_location<-"GettingandCleaningData/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/"
features_location<-"GettingandCleaningData/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/"
activity_location<-"GettingandCleaningData/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/"

## set location of output file - put final forward slash on
output_location<-"GettingandCleaningData/"

## load data
x_test<-read.table(paste(test_location, "x_test.txt", sep=""), header=FALSE, stringsAsFactors=FALSE)
y_test<-read.table(paste(test_location, "y_test.txt", sep=""), header=FALSE, stringsAsFactors=FALSE)
subject_test<-read.table(paste(test_location, "subject_test.txt", sep=""), header=FALSE, stringsAsFactors=FALSE)

x_train<-read.table(paste(train_location, "x_train.txt", sep=""), header=FALSE, stringsAsFactors=FALSE)
y_train<-read.table(paste(train_location, "y_train.txt", sep=""), header=FALSE, stringsAsFactors=FALSE)
subject_train<-read.table(paste(train_location, "subject_train.txt", sep=""), header=FALSE, stringsAsFactors=FALSE)

features<-read.table(paste(features_location, "features.txt", sep=""), header=FALSE, stringsAsFactors = FALSE)
activity_labels<-read.table(paste(activity_location, "activity_labels.txt", sep=""), header=FALSE, stringsAsFactors = FALSE)


## bind subject, y, and x for each of test and train
test_data<-cbind(subject_test, y_test, x_test)
train_data<-cbind(subject_train, y_train, x_train)

## bind test and train data
merged_test_train<-rbind(test_data, train_data)

## changes column names to match: subject for subject vector, activity for activity vector, and second column of features datatable for remaining 561 columns
cols_names<-c("subject", "activity", features[,2])
colnames(merged_test_train)=cols_names

## get only the column names with mean or std - note that it appears to pull a few columnns that are angles, but included for completeness
mean_cols<-cols_names[grepl("[Mm][Ee][Aa][Nn]", cols_names)]
std_cols<-cols_names[grepl("[Ss][Tt][Dd]", cols_names)]

## subset the data for only columnsw with mean, std, and the first two columns
merged_test_train_sub<-merged_test_train[,colnames(merged_test_train) %in% mean_cols | colnames(merged_test_train) %in% std_cols | colnames(merged_test_train) %in% c("subject", "activity")]

## load activity labels
## add descriptive column names
colnames(activity_labels)<-c("activity", "label")
## replace values of activity with actitivy_labels$label
merged_test_train_sub$activity <- activity_labels$label[match(merged_test_train_sub$activity, activity_labels$activity)]


## clean up column names
colnames(merged_test_train_sub)<-gsub("^t", "Time", colnames(merged_test_train_sub))
colnames(merged_test_train_sub)<-gsub("^f", "Freq", colnames(merged_test_train_sub))
colnames(merged_test_train_sub)<-gsub("-", "", colnames(merged_test_train_sub))
colnames(merged_test_train_sub)<-gsub("[Mm]ean", "Mean", colnames(merged_test_train_sub))
colnames(merged_test_train_sub)<-gsub("\\(\\)", "", colnames(merged_test_train_sub))
colnames(merged_test_train_sub)<-gsub("[Ss]td", "Std", colnames(merged_test_train_sub))
colnames(merged_test_train_sub)<-gsub("tBody", "Body", colnames(merged_test_train_sub))


## summarize the data by the means of the variables - went with the tidy wide
summarized_tidy<-summarize_all(group_by(merged_test_train_sub, subject, activity), mean)

## write the data to a space separate text file
write.table(summarized_tidy, paste(output_location, "tidy_output.txt", sep=""), sep=" ", eol = "\n") 






