
##  Download the data 
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./humanActivityUsingSmartphones.zip", method="curl") #url - The URL of the file to download. / destfile - Where the file should be saved (path with a file name).


## Unzip DataSet to /data directory
unzip(zipfile="./humanActivityUsingSmartphones.zip",exdir="./data")


## Load library 
library(dplyr)
library(data.table)
library(tidyr)


## Set files path 
dataPath <- "C:/Users/kwan/Documents/data/data/UCIHARDataset"


## Read file and create data table 

## Read subject files
dataSubjectTrain <- tbl_df(read.table(file.path(dataPath, "train", "subject_train.txt")))
dataSubjectTest  <- tbl_df(read.table(file.path(dataPath, "test" , "subject_test.txt")))


## Read activity files
yDataActivityTrain <- tbl_df(read.table(file.path(dataPath, "train", "Y_train.txt")))
yDataActivityTest  <- tbl_df(read.table(file.path(dataPath, "test" , "Y_test.txt" )))


## Read data files
xDataTrain <- tbl_df(read.table(file.path(dataPath, "train", "X_train.txt" )))
xDataTest  <- tbl_df(read.table(file.path(dataPath, "test" , "X_test.txt" )))


## Merge data 
## 1. Merges the training and the test sets to create one data set.
mergeDataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
setnames(mergeDataSubject, "mergeData", "subject")

mergeDataActivity<- rbind(yDataActivityTrain, yDataActivityTest)
setnames(mergeDataActivity, "mergeData", "activityNum")

## Merge data training and test files
dataTable <- rbind(xDataTrain, xDataTest)

## Name variables according to feature 
dataFeatures <- tbl_df(read.table(file.path(dataPath, "features.txt")))
setnames(dataFeatures, names(dataFeatures), c("featureNum", "featureName"))
colnames(dataTable) <- dataFeatures$featureName


## Column names for activity labels
activityLabels<- tbl_df(read.table(file.path(dataPath, "activity_labels.txt")))
setnames(activityLabels, names(activityLabels), c("activityNum","activityName"))


## Merge columns
mergeDataSubject<- cbind(mergeDataSubject, mergedataActivity)
dataTable <- cbind(mergeDataSubject, dataTable)
dataTable


##   Measurements of mean and standard deviation 
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## Read features.txt file
dataFeatures <- fread(file.path(dataPath, "features.txt"))
setNames(dataFeatures, names(dataFeatures), c("featureNum", "featureName"))


#subset measurement for the mean and std 
dataFeatures <- dataFeatures[grepl("mean\\(\\)|std\\(\\)", dataFeatures)]


dataFeatures <- dataFeatures[, paste0(mergeData, dataFeatures)]
head(dataFeatures)


select <- c(key(data), dataFeatures)
dt <- data[,select, with=FALSE]


##   Descriptive activity name
## 3. Uses descriptive activity names to name the activities in the data set
activityData <- fread(file.path(dataPath, "activity_labels.txt"))
setnames(activityData, names(activityData), c("activityNum", "activityName"))


## Label descriptive activity name
## 4. Appropriately labels the data set with descriptive variable names.
singleDataSet <- cbind(dataFeatures, activityData, mergeData)
names(singleDataSet) <- make.names(names(singleDataSet))
names(singleDataSet) <- gsub('ACC', "Acceleration", names(singleDataSet))
names(singleDataSet) <- gsub('GyroJerk', "AngularAcceleration", named(singleDataSet))
names(singleDataSet) <- gsub('Gyro', "AngularSpeed", names(singleDataSet))
names(singleDataSet) <- gsub('Mag', "Magnitude", names(singleDataSet))
names(singleDataSet) <- gsub('^t', "TimeDomain", names(singleDataSet))
names(singleDataSet) <- gsub('^f', "FrequencyDomain", names(singleDataSet))
names(singleDataSet) <- gsub('\\.mean', ".Mean", names(singleDataSet))
names(singleDataSet) <- gsub('\\.std', ".StandardDeviation", names(singleDataSet))
names(singleDataSet) <- gsub('Freq\\', "Frequency.", names(singleDataSet))
names(singleDataSet) <- gsub('Freq$', "Frequency", names(singleDataSet))

View(singleDataSet)


##  Create second tidy data set
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Create a data set with the average of each var for each activity and each subject
setkey(singleDataSet)

## Make codebook
knit("newTidyDataSet.Rmd", output = "newTidyDataSet.md", encoding = "ISO8859-1", quit = TRUE)
markdownToHTML("newTidyDataSet.md", "newTidyDataSet.html")

