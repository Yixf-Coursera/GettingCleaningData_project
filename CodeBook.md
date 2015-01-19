## Experimental design and background
Please refer to [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Raw data
"UCI HAR Dataset.zip" contains four files and two folders. Please refer to the "README.txt" file for more information about the raw data.

## Goals
Create one R script called "run_analysis.R" that does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Processing steps
1. The two columns of "activity_labels.txt" and "features.txt" are renamed to *index* and *name* for activity and feature, respectively. 
2. The subject, y and x are combined by columns for train and test, respectively.
3. Labels the datasets with descriptive variable names, for **Goal 4**.
4. The train and test dataset are combinded by rows, for **Goal 1**.
5. Use `grep("mean|std", ...)` for **Goal 2**.
6. Join (`inner_join`) activity labels with dataset, for **Goal 3**.
7. Compute the average of each variable for each aativity and each subject, and rename the first two column names to descriptive names, for **Goal 5**.
8. Use `write.table` with `rown.names=FALSE` to create the txt file which is named to "project_result.txt" for **uploading**.
