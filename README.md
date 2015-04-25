# Getting and Cleaning data

This repository includes

       README.md
       CodeBook.md
       run_analysis.R
       tidy.txt

## Data

The data set "Human Activity Recognition Using Smartphones" has been taken from UCI.

## Work

The data set is stored in the UCI HAR Dataset/ directory. 
The data is loaded using read.table.
Script is in run_analysis.R file

run_analysis.R includes the scripts showing the transformations:

      Merges the training and the test sets to create one data set.
      Extracts only the measurements on the mean and standard deviation for each measurement.
      Uses descriptive activity names to name the activities in the data set
      Appropriately labels the data set with descriptive variable names.
      Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Output

A tidy data set is created which is shown in tidy.txt file. The independent tidy data set is created with the average of each variable for each activity and each subject. Data table is formed by taking the combination of average of each variable for each activity and each subject. The obtained tidy dataset is saved in tidy.txt file.

A CodeBook is written that describes the variables, the data, and the work that has been performed to clean up the data.
