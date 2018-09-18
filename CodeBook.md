
# Code Book for : run_analysis.R - 18/09/2018

This script will check if the data file is present in your working directory. If not, will download and unzip the file. Same for reshape2 package used in writting a tidy data.

It is part of a coursera course project and the goal is to clean data set and make changes in five steps. 

## 1. Merges the training and the test sets to create one data set:

Read data, assign objects and merge in dataset:

	stest : subject IDs for test
	strain : subject IDs for train
	xtest : values of variables in test
	xtrain : values of variables in train
	xtest : activity ID in test
	ytrain : activity ID in train
	labels : Description of activity IDs in ytest and ytrain
	features : description(label) of each variables in xtest and xtrain

	dataset : bind of xtrain and xtest

## 2. Extracts only the measurements on the mean and standard deviation for each measurement

	meanstd : only mean and std labels extracted with grep function from 2nd column of features
	dataset : dataset of mean and std variables

## 3 and 4. Uses descriptive activity names to name the activities in the data set. Appropriately labels the data set with descriptive activity names.

Step 3 and 4 is for change the names in features and labels. Gsub for substitute and tolower function to lower case.
    
	cleanfeaturenames : a vector of "clean" feature names
	subject : bind of strain and stest
	activity : bind of ytrain and ytest
	actgroup : factored activity column of dataset

## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The dataset is melted to create tidy data. It will also add [mean of] to each column labels for better description. 

	basedata : melted tall and skinny dataset
	dataset2 : casete basedata which has means of each variables
	"tidy_data.txt" file is created.
