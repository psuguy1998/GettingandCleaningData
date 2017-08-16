# README.md

## Getting and Cleaning Data Assginment

This repository conaints the peer-reviwed assignment for the above course.  The 


There are four files in this repository:

* tidy_output.txt - output of tidy data wide
* run_analysis.R - script file containing R code to convert original data to tidy_output.txt
* Code_Book_Getting_and_Cleaning_Data_Assignment.txt - code book containing further information about the variables
* README.md - this markdown file explaining the analysis process

## ORIGINAL SOURCE FILES:
The original data for this analysis (Human Activity Recognition Using Smartphones Dataset) was pulled from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 

Further information about the experiment is available at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

## ORIGINAL SOURCE FILE LOCATION: 
In the script, there are variable names for the locations of the data files and output file, so the original data can be please where convient

## SCRIPT:
The script takes 8 files from the original source files:

* x_test.txt - a 561 vector with time and frequency domain variables for test set of data
* y_test.txt - activity id (1 through 6) for test set of data
* subject_test.txt - subject id (1 through 30) for test set of data
* x_train.txt - a 561 vector with time and frequency domain variables for train set of data
* y_train.txt - activity id (1 through 6) for train set of data
* subject_train.txt - subject id (1 through 30) for train set of data
* features.txt - list of variables of data collected
* activity_labels.txt - labels for activities

The script does the following:

1. Loads the appropriate libraries (dplyr 0.7.2 was used)
2. Sets variables for the input and output file locations
3. Loads the source data
4. Column binds the test data together (subject_test, x_test, y_test)
5. Column binds the train data together (subject_train, x_train, y_train)
6. Merges the test and train data together to form one combined data set
7. Renames the columns of the merged data set
8. Subsets the merged data set to only include those columns with Mean or Std in their name plus the identifiers for subject and activity
9. Cleans up the column names to be more readable
10.Summarizes the data to create a tidy data wide set that has one subject, one, activity, and the mean of each of the other columns in each row
11.Writes the data to tidy_output.txt, a space separate text file

The script was created in R version 3.4.0.

## ORIGINAL EXPERIMENT (Copied from Source Readme)

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.









