############################
#create one R script called run_analysis.R that does the following.

#1.Merges the training and the test sets to create one data set.
#2.Extracts only the measurements on the mean and standard deviation for each measurement.
#3.Uses descriptive activity names to name the activities in the data set
#4.Appropriately labels the data set with descriptive variable names.
#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



setwd("E:/r/Getting and Cleaning Data/project")
library(plyr)
#1.Merges the training and the test sets to create one data set.
#read the test data
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",header = FALSE)
names(subject_test) <- "subject"
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt",header = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt",header = FALSE, colClasses = "character")
names(y_test) <- "y"
test <- cbind(subject_test,y_test,x_test)
#read the train data
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",header = FALSE)
names(subject_train) <- "subject"
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt",header = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt",header = FALSE, colClasses = "character")
names(y_train) <- "y"
train <- cbind(subject_train,y_train,x_train)
#merge the data into one dataset named "data"
data0 <- rbind(test,train)
#read the 561 activity names
names_activity <- read.table("./UCI HAR Dataset/features.txt",header = FALSE,colClasses = "character")


#2.Extracts only the measurements on the mean and standard deviation for each measurement.
data <- data0[,1:2]
names <- data.frame()
for( i in 1:nrow(names_activity)){
  if(grepl("mean\\(\\)",names_activity[i,2])||grepl("std\\(\\)",names_activity[i,2])){
    data <- cbind(data,data0[,i+2])
    names <- rbind(names,names_activity[i,])
  }
}


#3.Uses descriptive activity names to name the activities in the data set
#data[,2] <- as.character(data[,2])
for(i in 1:nrow(data0)){
  if(data[i,2] == "1") 
    data[i,2] <- "WALKING"
  if(data[i,2] == "2") 
    data[i,2] <- "WALKING_UPSTAIRS"
  if(data[i,2] == "3") 
    data[i,2] <- "WALKING_DOWNSTAIRS"
  if(data[i,2] == "4") 
    data[i,2] <- "SITTING"
  if(data[i,2] == "5") 
    data[i,2] <- "STANDING"
  if(data[i,2] == "6") 
    data[i,2] <- "LAYING"
}



#4.Appropriately labels the data set with descriptive variable names.
#name the columns according to the features.txt file
colnames(data) <- c("subject","activity",names[,2])
#lable the column names with descriptive variable names
names(data) <- gsub("^t","Time",names(data))
names(data) <- gsub("Acc","Acceleration",names(data))
names(data) <- gsub("mean\\(\\)","Mean",names(data))
names(data) <- gsub("std\\(\\)","Std",names(data))
names(data) <- gsub("^f","Frequency",names(data))
names(data) <- gsub("Mag","Magnitude",names(data))

#5.From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
data_final<- ddply(data, c("subject","activity"), numcolwise(mean))

#output
#write.csv(data_final,"run_analysis.csv", row.names = FALSE)
write.table(data_final,"data_final.txt",row.names = FALSE)
