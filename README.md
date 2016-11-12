# Getting and Cleaning Data
#Course Project 
You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# Data Sources 
Dataset

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


Full Description of the Dataset

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


Dataset Name 

Human Activity Recognition Using Smartphones Dataset Version 1.0


#Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.



#Transformations details
The transformation include 5 parts which are

1. Merges the training and the test sets in order to create a one data set.
2. Once done merge, extra the measurements on the mean and standard deviation only for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Lables the data set witht an appropriate descriptive variable names.
5. From the data set being label in step 4, creates a second, independent tidy data set with average of each variable for each activity and each subject. 


#How run_analysis.r implements/run the transformation steps

1. use libraries
2. Load test and train data set
3. Load features and activity lables
4. Extract mean and standard deviation columns names and data.
5. process the train and test data. 
6. Merge train and test data into single data set. 
