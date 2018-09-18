# Coursera Getting and cleaning data course project week 4 

# Collect data information and download files if doesn't exist in work directory

fileName <- "UCIdata.zip"
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- "UCI HAR Dataset"

        if(!file.exists(fileName)){
                download.file(url,fileName, mode = "wb") 
}

        if(!file.exists(dir)){
                unzip("UCIdata.zip", files = NULL, exdir=".")
}


# Reading Data

stest <- read.table("UCI HAR Dataset/test/subject_test.txt")
strain <- read.table("UCI HAR Dataset/train/subject_train.txt")
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")  

# 1. Merges the training and the test sets to create one data set.

dataset <- rbind(xtrain, xtest)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

meanstd <- grep("mean()|std()", features[, 2]) 
dataset <- dataset[,meanstd]

# 3 and 4. Uses descriptive activity names to name the activities in the data set. Appropriately labels the data set with descriptive activity names.

# A serie of modifications in names with gsub, tolower functions to better organize information. 

subject <- rbind(strain, stest)
names(subject) <- 'subject'
activity <- rbind(ytrain, ytest)
names(activity) <- 'activity'
cleanfeaturenames <- gsub("[()]", "", tolower(features[,2]))
cleanfeaturenames <- gsub("-", "", cleanfeaturenames)
names(dataset) <- cleanfeaturenames[meanstd]
dataset <- cbind(subject,activity, dataset)
actgroup <- factor(dataset$activity)
levels (actgroup) <- gsub ("_upstairs", "up", tolower(labels[,2]))
levels (actgroup) <- gsub ("_downstairs", "down", levels(actgroup))
dataset$activity <- actgroup


# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# check to install reshape2 package

        if (!"reshape2" %in% installed.packages()) {
                install.packages("reshape2")
}
        library("reshape2")

basedata <- melt(dataset,(id.vars=c("subject","activity")))
dataset2 <- dcast(basedata, subject + activity ~ variable, mean)
names(dataset2)[-c(1:2)] <- paste("[mean of]" , names(dataset2)[-c(1:2)] )
write.table(dataset2, "tidy_data.txt", sep = ",")

