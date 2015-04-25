
library(data.table)
library(dplyr)

unzip("activity_data.zip")

subject_testdata <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activity_testdata <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
features_testdata <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
subject_traindata <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activity_traindata <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
features_traindata <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
activity_labelsdata <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
feature_data <- read.table("UCI HAR Dataset/features.txt")

subject_data <- rbind(subject_traindata, subject_testdata)
activity_data <- rbind(activity_traindata, activity_testdata)
features_data <- rbind(features_traindata, features_testdata)

colnames(features_data) <- t(feature_data[2])
colnames(activity_data) <- "Activity"
colnames(subject_data) <- "Subject"

fulldata <- cbind(features_data,activity_data,subject_data)

columns_MeanStd <- grep(".*Mean.*|.*Std.*", names(fulldata), ignore.case=TRUE)
Columns <- c(columns_MeanStd, 562, 563)
dim(fulldata)

newdata <- fulldata[,Columns]
dim(newdata)

newdata$Activity <- as.character(newdata$Activity)
for (i in 1:6){
  newdata$Activity[newdata$Activity == i] <- as.character(activity_labelsdata[i,2])
}
names(newdata)
names(newdata)<-gsub("Acc", "Accelerometer", names(newdata))
names(newdata)<-gsub("Gyro", "Gyroscope", names(newdata))
names(newdata)<-gsub("BodyBody", "Body", names(newdata))
names(newdata)<-gsub("Mag", "Magnitude", names(newdata))
names(newdata)<-gsub("^t", "Time", names(newdata))
names(newdata)<-gsub("^f", "Frequency", names(newdata))
names(newdata)<-gsub("tBody", "TimeBody", names(newdata))
names(newdata)<-gsub("-mean()", "Mean", names(newdata), ignore.case = TRUE)
names(newdata)<-gsub("-std()", "STD", names(newdata), ignore.case = TRUE)
names(newdata)<-gsub("-freq()", "Frequency", names(newdata), ignore.case = TRUE)
names(newdata)<-gsub("angle", "Angle", names(newdata))
names(newdata)<-gsub("gravity", "Gravity", names(newdata))
names(newdata)
newdata$Subject <- as.factor(newdata$Subject)
newdata <- data.table(newdata)

tidydata <- aggregate(. ~Subject + Activity, newdata, mean)
tidydata <- tidydata[order(tidydata$Subject,tidydata$Activity),]
write.table(tidydata, file = "tidy.txt",sep="  ", row.names = FALSE)
