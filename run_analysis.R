library(dplyr)


url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(url,destfile = "Dataset.zip")

unzip(zipfile="Dataset.zip")
list.files()


path<-"./UCI HAR Dataset"
listfiles<-list.files(path,recursive = TRUE)

#Reading training tables - xtrain / ytrain, subject train
xtrain <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)
ytrain <- read.table(file.path(path, "train", "y_train.txt"),header = FALSE)
subject_train <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)
#Reading the testing tables
xtest <- read.table(file.path(path, "test", "X_test.txt"),header = FALSE)
ytest <- read.table(file.path(path, "test", "y_test.txt"),header = FALSE)
subject_test <- read.table(file.path(path, "test", "subject_test.txt"),header = FALSE)
#Read the features data
features <- read.table(file.path(path, "features.txt"),header = FALSE)
#Read activity labels data
activity_labels <- read.table(file.path(path, "activity_labels.txt"),header = FALSE)

# the columns are not tagged and there is no easy way to interpret the data
colnames(xtest)<-features[,2]
colnames(subject_test) <- "subject_id"
colnames(ytest) <- "activity_id"

colnames(xtrain)<-features[,2]
colnames(subject_train) <- "subject_id"
colnames(ytrain) <- "activity_id"

colnames(activity_labels) <- c('activity_id','activity_type')

#uptil now the data sets have been created with the right coloumn names

#now doing the tasks required by the question

# 1. Merge the training and the test sets to create one data set.
#Merging the train and test data
#Create the main data table merging both table
oneset <- rbind(cbind(ytrain, subject_train, xtrain), cbind(ytest, subject_test, xtest))


# 2. Extract only the measurements on the mean and standard deviation for each measurement
col_names <- colnames(oneset)
#get a subset of all the mean and standard deviation
#keeping the activity_id and subject_id
mean_and_std <- (grepl("activity_id" , col_names) | grepl("subject_id" , col_names) | 
                    grepl("mean.." , col_names) | grepl("std.." , col_names))

mean_std_set<-oneset[,mean_and_std==TRUE]


# 3.Use descriptive activity names to name the activities in the data set
# merge the new set with activity labels
labelled_set<-merge(mean_std_set, activity_labels, by='activity_id')


# 4.Appropriately label the data set with descriptive variable names.
names(labelled_set)<-gsub("^t", "time", names(labelled_set))
names(labelled_set)<-gsub("^f", "frequency", names(labelled_set))
names(labelled_set)<-gsub("Acc", "Accelerometer", names(labelled_set))
names(labelled_set)<-gsub("Gyro", "Gyroscope", names(labelled_set))
names(labelled_set)<-gsub("Mag", "Magnitude", names(labelled_set))



# 5.creates a second, independent tidy data set with the average 
#   of each variable for each activity and each subject.
final_data<- labelled_set %>% group_by(activity_id, subject_id) %>%
    summarise(across(everything(),mean))

#create a table file
write.table(final_data, file = "FinalTidySet.txt", row.name=FALSE)

#end of program


