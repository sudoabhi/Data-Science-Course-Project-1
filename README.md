## Getting-and-Cleaning-Data-Week-4 Course Project

This repo was created to finish the project for week 4 of Getting and Cleaning Data Coursera course.

Firstly, I downloaded and unzipped the data file into my R working directory.
Secondly, I wrote a script that creates a tidy dataset
Finally, executed R source code to generate tidy data file.
Data description
The variables in the data X are sensor signals measured with waist-mounted smartphone from 30 subjects. The variable in the data Y indicates activity type the subjects performed during recording.

### Code explanation
Most of the code has been commented for proper understanding.
The code combined training dataset and test dataset, and extracted partial variables like mean and standard deviation finally created another dataset with the averages of each variable for each activity.

### New dataset
The new generated dataset contained variables calculated based on the mean and standard deviation. Each row of the dataset is an average of each activity type for all subjects.

### The code was written based on the instruction of this assignment
Read training and test dataset into R environment. Read variable names into R envrionment. Read subject index into R environment. Cleaned the dataset. Assigned Proper variable names.

1. Merges the training and the test sets to create one data set. Use command rbind and cbind to combine training and test set
2. Extracts only the measurements on the mean and standard deviation for each measurement. Use grep command to get column indexes for variable name contains "mean()" or "std()"
3. Uses descriptive activity names to name the activities in the data set. Merged the  new set obtained from step 2 with activity labels by the 'activity_id' to create a new dataset
4. Appropriately labels the data set with descriptive variable names. Give the selected descriptive names to variable columns
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. Used pipeline command to create a new tidy dataset with command group_by and summarize it with using across in dplyr package

