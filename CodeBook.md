==================================================================
Getting and Cleaning Data Course Project Codebook
==================================================================
Emilio Lamas Garcia
Repository: https://github.com/emiliolamas93/Getting-and-Cleaning-Data-Course-Project
==================================================================

run_analysis.R Description.

Download files:

	- The files have been downloaded from the following link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
	- This link has the data collected from the accelerometers from the Samsung Galaxy S smartphone.

Assign variables:

	- features: from the file features.txt, which has the list of all features
	- activities: from the file activity_labels, which links the class labels with their activity name
	- train_x: from the file X_train.txt, which contains training set
	- train_y: from the file y_train.txt, which contains training labels
	- train_subject: from the file subject_train.txt, which contains the subject who performed the activity for each window sample
	- test_x: from the file X_test.txt, which contains training set
	- test_y: from the file y_test.txt, which contains training labels
	- test_subject: from the file subject_test.txt, which contains the subject who performed the activity for each window sample

Merging data:
	
	- xdata: merge data from train_x with test_x using the function rbind
	- ydata: merge data from train_y with test_y using the function rbind
	- subdata: merge data from train_subject with test_subject using the function rbind

Extracts only the measurements on the mean and standard deviation for each measurement:

	- xdataset1: Get the mean and standrad deviation from the features variable with the grep function, replacing the numbers in the xdata variable

Uses descriptive activity names to name the activities in the data set:

	- ydata1: numbers in ydata replaced with the activities variable data.

Appropriately labels the data set with descriptive variable names:

	- mergeddata: Merge the data of the variables subdata, ydata1 and xdata1 with the function cbind
	- Change the column names with the function gsub in order to have an understandable and tidy.
	- All changes are assign to the same data frame mergeddata.

Creates second independent tidy Data Set:

	- New tidy data set named tidyds, using group_by and summarise_all functions in order to get the average of each variable for each activity and each subject.
	- Create a new file called Tidydata.txt with the output of the script.
