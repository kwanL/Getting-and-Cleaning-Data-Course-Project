
##  Download the data 
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./humanActivityUsingSmartphones.zip", method="curl") #url – The URL of the file to download. / destfile – Where the file should be saved (path with a file name).

## Unzip DataSet to /data directory
unzip(zipfile="./humanActivityUsingSmartphones.zip",exdir="./data")

## Load library 
library(dplyr)
library(data.table)
library(tidyr)

## Set files path 
dataPath <- "../Documents/data/UCIHARDataset"

## Read file and create data table 

## Read subject files
dataTrain <- read.table("../data/UCIHARDataset/train/subject_train.txt", header = FALSE)
dataTest <- read.table("../data/UCIHARDataset/test/subject_test.txt", header = FALSE)

yTrain <- read.table("../data/UCIHARDataset/train/Y_train.txt", header = FALSE)
yTest <- read.table("../data/UCIHARDataset/test/Y_test.txt", header = FALSE)

xTrain <- read.table("../data/UCIHARDataset/train/X_train.txt", header = FALSE)
xTest <- read.table("../data/UCIHARDataset/test/X_test.txt", header = FALSE)

## Merge data 
## 1. Merges the training and the test sets to create one data set.
mergeDataSubject <- rbind(dataTrain, dataTest)
mergeDataActivity<- rbind(yTrain, yTest)

## Merge data training and test files
meregeDataTable <- rbind(xTrain, xTest)

## Name variables according to feature 
dataFeatures <- tbl_df(read.table(file.path(dataPath, "features.txt")))
setnames(dataFeatures, names(dataFeatures), c("featureNum", "featureName"))
colnames(meregeDataTable) <- dataFeatures$featureName

## Column names for activity labels
activityLabels<- tbl_df(read.table(file.path(dataPath, "activity_labels.txt")))
setnames(activityLabels, names(activityLabels), c("activityNum","activityName"))

## Merge columns
mergeDataSubject<- cbind(mergeDataSubject, mergeDataActivity)
dataTable <- cbind(mergeDataSubject, meregeDataTable)
dataTable

##   Measurements of mean and standard deviation 
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## Read features.txt file
dataFeatures <- fread(file.path(dataPath, "features.txt"))

#subset measurement for the mean and std 
dataFeatures <- dataFeatures[grepl("mean\\(\\)|std\\(\\)", dataFeatures)]
dataFeatures <- dataFeatures[, paste0(mergeDataSubject, dataFeatures)]
head(dataFeatures)

select <- c(key(data), dataFeatures)
dt <- data[,select, with=FALSE]

##   Descriptive activity name
## 3. Uses descriptive activity names to name the activities in the data set
activityData <- fread(file.path(dataPath, "activity_labels.txt"))

## Label descriptive activity name
## 4. Appropriately labels the data set with descriptive variable names.
singleDataSet <- cbind(dataFeatures, activityData, mergeDataSubject)
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
write.table(dataTable, "newTidyDataSet.txt", row.name=FALSE)
