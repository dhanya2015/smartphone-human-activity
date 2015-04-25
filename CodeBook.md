---
title: "CodeBook"
author: "dhanya2015"
date: "Friday, April 24, 2015"
output: html_document
keep_md: true
---

# GETTING AND CLEANING DATA-ASSIGNMENT 1



## HUMAN ACTIVITY RECOGNITION USING SMARTPHONES

This code book describes variables, data and transformations which is done to clean the data

## Information about Data

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Data include:

Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
Triaxial Angular velocity from the gyroscope.
A 561-feature vector with time and frequency domain variables.
Its activity label.
An identifier of the subject who carried out the experiment.

The dataset includes the following files:

'features_info.txt': Shows information about the variables used on the feature vector.
'features.txt': List of all features.
'activity_labels.txt': Links the class labels with their activity name.
'train/X_train.txt': Training set.
'train/y_train.txt': Training labels.
'test/X_test.txt': Test set.
'test/y_test.txt': Test labels.
'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

## Variables

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). These signals were used to estimate variables of the feature vector for each pattern:'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The set of variables that were estimated from these signals are: 
mean(): Mean value
std(): Standard deviation

## Transformations

### Unzip the file


```r
unzip(zipfile="activity_data.zip")
```

The data set is stored in the UCI HAR Dataset/ directory.




### Load the data

The data is loaded using read.table.


```r
subject_testdata <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activity_testdata <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
features_testdata <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
subject_traindata <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activity_traindata <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
features_traindata <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
activity_labelsdata <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
feature_data <- read.table("UCI HAR Dataset/features.txt")
```

### Merging test and training sets to create one data set

The test and train sets are merged into fulldata.


```r
subject_data <- rbind(subject_traindata, subject_testdata)
activity_data <- rbind(activity_traindata, activity_testdata)
features_data <- rbind(features_traindata, features_testdata)

colnames(features_data) <- t(feature_data[2])
colnames(activity_data) <- "Activity"
colnames(subject_data) <- "Subject"

fulldata <- cbind(features_data,activity_data,subject_data)
```

### Extracting the measurements on the mean and standard deviation for each measurement. 

mean() and sd() are used against fullData for each measurements.


```r
columns_MeanStd <- grep(".*Mean.*|.*Std.*", names(fulldata), ignore.case=TRUE)
Columns <- c(columns_MeanStd, 562, 563)
dim(fulldata)
```

```
## [1] 10299   563
```

```r
newdata <- fulldata[,Columns]
dim(newdata)
```

```
## [1] 10299    88
```

### Descriptive activity names to name the activities in the data set

The activity field in newdata is numeric type and it is changed to character type to accept the activity names. The activity names are added and the variables are factored.


```r
newdata$Activity <- as.character(newdata$Activity)
for (i in 1:6){
  newdata$Activity[newdata$Activity == i] <- as.character(activity_labelsdata[i,2])
}
```

### Label the data set with descriptive variable names

It is necessary to merge the columns  to the test and train dataset. Naming of the activity and subject columns should be done. The data frames are labelled using features.txt with descriptive variable names.


```r
names(newdata)
```

```
##  [1] "tBodyAcc-mean()-X"                   
##  [2] "tBodyAcc-mean()-Y"                   
##  [3] "tBodyAcc-mean()-Z"                   
##  [4] "tBodyAcc-std()-X"                    
##  [5] "tBodyAcc-std()-Y"                    
##  [6] "tBodyAcc-std()-Z"                    
##  [7] "tGravityAcc-mean()-X"                
##  [8] "tGravityAcc-mean()-Y"                
##  [9] "tGravityAcc-mean()-Z"                
## [10] "tGravityAcc-std()-X"                 
## [11] "tGravityAcc-std()-Y"                 
## [12] "tGravityAcc-std()-Z"                 
## [13] "tBodyAccJerk-mean()-X"               
## [14] "tBodyAccJerk-mean()-Y"               
## [15] "tBodyAccJerk-mean()-Z"               
## [16] "tBodyAccJerk-std()-X"                
## [17] "tBodyAccJerk-std()-Y"                
## [18] "tBodyAccJerk-std()-Z"                
## [19] "tBodyGyro-mean()-X"                  
## [20] "tBodyGyro-mean()-Y"                  
## [21] "tBodyGyro-mean()-Z"                  
## [22] "tBodyGyro-std()-X"                   
## [23] "tBodyGyro-std()-Y"                   
## [24] "tBodyGyro-std()-Z"                   
## [25] "tBodyGyroJerk-mean()-X"              
## [26] "tBodyGyroJerk-mean()-Y"              
## [27] "tBodyGyroJerk-mean()-Z"              
## [28] "tBodyGyroJerk-std()-X"               
## [29] "tBodyGyroJerk-std()-Y"               
## [30] "tBodyGyroJerk-std()-Z"               
## [31] "tBodyAccMag-mean()"                  
## [32] "tBodyAccMag-std()"                   
## [33] "tGravityAccMag-mean()"               
## [34] "tGravityAccMag-std()"                
## [35] "tBodyAccJerkMag-mean()"              
## [36] "tBodyAccJerkMag-std()"               
## [37] "tBodyGyroMag-mean()"                 
## [38] "tBodyGyroMag-std()"                  
## [39] "tBodyGyroJerkMag-mean()"             
## [40] "tBodyGyroJerkMag-std()"              
## [41] "fBodyAcc-mean()-X"                   
## [42] "fBodyAcc-mean()-Y"                   
## [43] "fBodyAcc-mean()-Z"                   
## [44] "fBodyAcc-std()-X"                    
## [45] "fBodyAcc-std()-Y"                    
## [46] "fBodyAcc-std()-Z"                    
## [47] "fBodyAcc-meanFreq()-X"               
## [48] "fBodyAcc-meanFreq()-Y"               
## [49] "fBodyAcc-meanFreq()-Z"               
## [50] "fBodyAccJerk-mean()-X"               
## [51] "fBodyAccJerk-mean()-Y"               
## [52] "fBodyAccJerk-mean()-Z"               
## [53] "fBodyAccJerk-std()-X"                
## [54] "fBodyAccJerk-std()-Y"                
## [55] "fBodyAccJerk-std()-Z"                
## [56] "fBodyAccJerk-meanFreq()-X"           
## [57] "fBodyAccJerk-meanFreq()-Y"           
## [58] "fBodyAccJerk-meanFreq()-Z"           
## [59] "fBodyGyro-mean()-X"                  
## [60] "fBodyGyro-mean()-Y"                  
## [61] "fBodyGyro-mean()-Z"                  
## [62] "fBodyGyro-std()-X"                   
## [63] "fBodyGyro-std()-Y"                   
## [64] "fBodyGyro-std()-Z"                   
## [65] "fBodyGyro-meanFreq()-X"              
## [66] "fBodyGyro-meanFreq()-Y"              
## [67] "fBodyGyro-meanFreq()-Z"              
## [68] "fBodyAccMag-mean()"                  
## [69] "fBodyAccMag-std()"                   
## [70] "fBodyAccMag-meanFreq()"              
## [71] "fBodyBodyAccJerkMag-mean()"          
## [72] "fBodyBodyAccJerkMag-std()"           
## [73] "fBodyBodyAccJerkMag-meanFreq()"      
## [74] "fBodyBodyGyroMag-mean()"             
## [75] "fBodyBodyGyroMag-std()"              
## [76] "fBodyBodyGyroMag-meanFreq()"         
## [77] "fBodyBodyGyroJerkMag-mean()"         
## [78] "fBodyBodyGyroJerkMag-std()"          
## [79] "fBodyBodyGyroJerkMag-meanFreq()"     
## [80] "angle(tBodyAccMean,gravity)"         
## [81] "angle(tBodyAccJerkMean),gravityMean)"
## [82] "angle(tBodyGyroMean,gravityMean)"    
## [83] "angle(tBodyGyroJerkMean,gravityMean)"
## [84] "angle(X,gravityMean)"                
## [85] "angle(Y,gravityMean)"                
## [86] "angle(Z,gravityMean)"                
## [87] "Activity"                            
## [88] "Subject"
```

```r
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
```

```
##  [1] "TimeBodyAccelerometerMean()-X"                    
##  [2] "TimeBodyAccelerometerMean()-Y"                    
##  [3] "TimeBodyAccelerometerMean()-Z"                    
##  [4] "TimeBodyAccelerometerSTD()-X"                     
##  [5] "TimeBodyAccelerometerSTD()-Y"                     
##  [6] "TimeBodyAccelerometerSTD()-Z"                     
##  [7] "TimeGravityAccelerometerMean()-X"                 
##  [8] "TimeGravityAccelerometerMean()-Y"                 
##  [9] "TimeGravityAccelerometerMean()-Z"                 
## [10] "TimeGravityAccelerometerSTD()-X"                  
## [11] "TimeGravityAccelerometerSTD()-Y"                  
## [12] "TimeGravityAccelerometerSTD()-Z"                  
## [13] "TimeBodyAccelerometerJerkMean()-X"                
## [14] "TimeBodyAccelerometerJerkMean()-Y"                
## [15] "TimeBodyAccelerometerJerkMean()-Z"                
## [16] "TimeBodyAccelerometerJerkSTD()-X"                 
## [17] "TimeBodyAccelerometerJerkSTD()-Y"                 
## [18] "TimeBodyAccelerometerJerkSTD()-Z"                 
## [19] "TimeBodyGyroscopeMean()-X"                        
## [20] "TimeBodyGyroscopeMean()-Y"                        
## [21] "TimeBodyGyroscopeMean()-Z"                        
## [22] "TimeBodyGyroscopeSTD()-X"                         
## [23] "TimeBodyGyroscopeSTD()-Y"                         
## [24] "TimeBodyGyroscopeSTD()-Z"                         
## [25] "TimeBodyGyroscopeJerkMean()-X"                    
## [26] "TimeBodyGyroscopeJerkMean()-Y"                    
## [27] "TimeBodyGyroscopeJerkMean()-Z"                    
## [28] "TimeBodyGyroscopeJerkSTD()-X"                     
## [29] "TimeBodyGyroscopeJerkSTD()-Y"                     
## [30] "TimeBodyGyroscopeJerkSTD()-Z"                     
## [31] "TimeBodyAccelerometerMagnitudeMean()"             
## [32] "TimeBodyAccelerometerMagnitudeSTD()"              
## [33] "TimeGravityAccelerometerMagnitudeMean()"          
## [34] "TimeGravityAccelerometerMagnitudeSTD()"           
## [35] "TimeBodyAccelerometerJerkMagnitudeMean()"         
## [36] "TimeBodyAccelerometerJerkMagnitudeSTD()"          
## [37] "TimeBodyGyroscopeMagnitudeMean()"                 
## [38] "TimeBodyGyroscopeMagnitudeSTD()"                  
## [39] "TimeBodyGyroscopeJerkMagnitudeMean()"             
## [40] "TimeBodyGyroscopeJerkMagnitudeSTD()"              
## [41] "FrequencyBodyAccelerometerMean()-X"               
## [42] "FrequencyBodyAccelerometerMean()-Y"               
## [43] "FrequencyBodyAccelerometerMean()-Z"               
## [44] "FrequencyBodyAccelerometerSTD()-X"                
## [45] "FrequencyBodyAccelerometerSTD()-Y"                
## [46] "FrequencyBodyAccelerometerSTD()-Z"                
## [47] "FrequencyBodyAccelerometerMeanFreq()-X"           
## [48] "FrequencyBodyAccelerometerMeanFreq()-Y"           
## [49] "FrequencyBodyAccelerometerMeanFreq()-Z"           
## [50] "FrequencyBodyAccelerometerJerkMean()-X"           
## [51] "FrequencyBodyAccelerometerJerkMean()-Y"           
## [52] "FrequencyBodyAccelerometerJerkMean()-Z"           
## [53] "FrequencyBodyAccelerometerJerkSTD()-X"            
## [54] "FrequencyBodyAccelerometerJerkSTD()-Y"            
## [55] "FrequencyBodyAccelerometerJerkSTD()-Z"            
## [56] "FrequencyBodyAccelerometerJerkMeanFreq()-X"       
## [57] "FrequencyBodyAccelerometerJerkMeanFreq()-Y"       
## [58] "FrequencyBodyAccelerometerJerkMeanFreq()-Z"       
## [59] "FrequencyBodyGyroscopeMean()-X"                   
## [60] "FrequencyBodyGyroscopeMean()-Y"                   
## [61] "FrequencyBodyGyroscopeMean()-Z"                   
## [62] "FrequencyBodyGyroscopeSTD()-X"                    
## [63] "FrequencyBodyGyroscopeSTD()-Y"                    
## [64] "FrequencyBodyGyroscopeSTD()-Z"                    
## [65] "FrequencyBodyGyroscopeMeanFreq()-X"               
## [66] "FrequencyBodyGyroscopeMeanFreq()-Y"               
## [67] "FrequencyBodyGyroscopeMeanFreq()-Z"               
## [68] "FrequencyBodyAccelerometerMagnitudeMean()"        
## [69] "FrequencyBodyAccelerometerMagnitudeSTD()"         
## [70] "FrequencyBodyAccelerometerMagnitudeMeanFreq()"    
## [71] "FrequencyBodyAccelerometerJerkMagnitudeMean()"    
## [72] "FrequencyBodyAccelerometerJerkMagnitudeSTD()"     
## [73] "FrequencyBodyAccelerometerJerkMagnitudeMeanFreq()"
## [74] "FrequencyBodyGyroscopeMagnitudeMean()"            
## [75] "FrequencyBodyGyroscopeMagnitudeSTD()"             
## [76] "FrequencyBodyGyroscopeMagnitudeMeanFreq()"        
## [77] "FrequencyBodyGyroscopeJerkMagnitudeMean()"        
## [78] "FrequencyBodyGyroscopeJerkMagnitudeSTD()"         
## [79] "FrequencyBodyGyroscopeJerkMagnitudeMeanFreq()"    
## [80] "Angle(TimeBodyAccelerometerMean,Gravity)"         
## [81] "Angle(TimeBodyAccelerometerJerkMean),GravityMean)"
## [82] "Angle(TimeBodyGyroscopeMean,GravityMean)"         
## [83] "Angle(TimeBodyGyroscopeJerkMean,GravityMean)"     
## [84] "Angle(X,GravityMean)"                             
## [85] "Angle(Y,GravityMean)"                             
## [86] "Angle(Z,GravityMean)"                             
## [87] "Activity"                                         
## [88] "Subject"
```

### Creating a second, independent tidy data set

The independent tidy data set is created with the average of each variable for each activity and each subject. Data table is formed by taking the combination of average of each variable for each activity and each subject. The obtained tidy dataset is saved in tidy.txt file.




```r
newdata$Subject <- as.factor(newdata$Subject)
newdata <- data.table(newdata)

tidydata <- aggregate(. ~Subject + Activity, newdata, mean)
tidydata <- tidydata[order(tidydata$Subject,tidydata$Activity),]
write.table(tidydata, file = "tidy.txt",sep="  ", row.names = FALSE)
```
