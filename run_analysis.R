## Download the data

library(plyr)
library(dplyr)
library(tidyr)
library(data.table)


## Get files

if(!file.exists("./data")){dir.create("./data")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./data/getdata_projectfiles_UCI HAR Dataset.zip", method = "curl" )

unzip("./data/getdata_projectfiles_UCI HAR Dataset.zip", exdir = "./data")



## Merges the training and the test sets to create one data set.

features <- read.csv("./data/UCI HAR Dataset/features.txt", col.names = c("num","functions"), sep = " ", header = FALSE)
  
activities <- read.csv("./data/UCI HAR Dataset/activity_labels.txt", col.names = c("id","activity"),sep = " ", header = FALSE)


## Train Data


train_x <- read.table("./data/UCI HAR Dataset/train/X_train.txt")

train_y <- read.csv("./data/UCI HAR Dataset/train/y_train.txt", sep= " ", header =FALSE)

train_subject <- read.csv("./data/UCI HAR Dataset/train/subject_train.txt", sep = " ", header = FALSE)


## Test Data

test_x <- read.table("./data/UCI HAR Dataset/test/X_test.txt")

test_y <- read.csv("./data/UCI HAR Dataset/test/y_test.txt", sep= " ", header =FALSE)

test_subject <- read.csv("./data/UCI HAR Dataset/test/subject_test.txt", sep = " ", header = FALSE)

## Merging data

xdata <- rbind(train_x, test_x)

dim(xdata)

ydata <- rbind(train_y, test_y)

dim(ydata)

subdata <- rbind(train_subject, test_subject)

dim(subdata)

names(subdata) <- "Subject"

## Extracts only the measurements on the mean and standard deviation for each measurement.

xdataset1 <- xdata[,grep("-(mean|std)\\(\\)", features[,2])]

names(xdataset1) <- features[grep("-(mean|std)\\(\\)", features[, 2]), 2] 

dim(xdataset1)

View(xdataset1)

## Uses descriptive activity names to name the activities in the data set

ydata1 <- ydata

ydata1[,1] <- activities[ydata[,1],2]

names(ydata1) <- "Activities"

View(ydata1)

## Appropriately labels the data set with descriptive variable names.

##ydata1
##xdataset1
##subdata

mergeddata <- cbind(subdata,ydata1,xdataset1)

head(mergeddata)

dim(mergeddata)

names(mergeddata) <- gsub("Acc", "Accelerometer", names(mergeddata), ignore.case = TRUE)
names(mergeddata) <- gsub("^t", "Time", names(mergeddata))
names(mergeddata) <- gsub("^f", "Frequency", names(mergeddata))
names(mergeddata) <- gsub("Mag", "Magnitude", names(mergeddata), ignore.case = TRUE)
names(mergeddata) <- gsub("-mean()", "mean", names(mergeddata), ignore.case = TRUE)
names(mergeddata) <- gsub("-std()", "std", names(mergeddata), ignore.case = TRUE)
names(mergeddata) <- gsub("Gyro", "Gyroscope", names(mergeddata), ignore.case = TRUE)
names(mergeddata) <- gsub("BodyBody", "Body", names(mergeddata), ignore.case = TRUE)
names(mergeddata) <- gsub("-freq()", "Frequency", names(mergeddata), ignore.case = TRUE)


## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidyds <- mergeddata %>%
  group_by(Subject, Activities) %>%
  summarise_all(list(mean = mean))

View(tidyds)

write.table(tidyds, file = "Tidydata.txt", row.names = FALSE)