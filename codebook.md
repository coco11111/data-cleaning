Name the file as "run_analysis.R".

1.Merges the training and the test sets to create one data set: 

(1)For the test data set: 

a. Read the data set of "test/subject_test.txt" and store it in the data set "subject_test", then rename the column as "subject".

b. Read the data set of "/test/X_test.txt" and store it in the data set "x_test".

c. Read the data set of "/test/y_test.txt" and store it in the data set "y_test", then rename the column as "y".

d. Column bind the above columns and store is in data set of "test".

(2) For the training data set, do the above steps of a-d in the "train/..." folder and sotre it in data set "train".

(3) Merge the data set of "test" and "train" and put them in the data set of "data0".
  
2.Extracts only the measurements on the mean and standard deviation for each measurement.

In a for loop going through each column names, find out the mean and standard deviation keywords: "mean\\(\\)" or "std\\(\\)", and store the wanted columns in the data set of "data". 

For the convenience of the later process, read the "/features.txt" and pick up the column names we need and store them in the data set of "names".


3.Uses descriptive activity names to name the activities in the data set.

In "data", rename each row in the "y" column according to the "activity_labels.txt".

4.Appropriately labels the data set with descriptive variable names.

a. Rename the "data": the first column is named "subject", and the second colunm "activity". The rest of the columns would be names according to the second column of the data set of "names".

b. Since there are some abbreviations in the "names", find them and replace with full names.

5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Use the ddply function in the plyr library to do the calculation and store the result in the data set of "data_final"

6.Output the result into a txt file.
