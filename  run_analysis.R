library(tidyr)
library(dplyr)

# Read the needed files
activity_labels <- read.table("activity_labels.txt", header=F, stringsAsFactors = F)
colnames(activity_labels) <- c("activity.index", "activity.name")
features <- read.table("features.txt", header=F, stringsAsFactors = F)
colnames(features) <- c("feature.index", "feature.name")

train_subject <- read.table("./train/subject_train.txt", header=F)
train_x <- read.table("./train/X_train.txt", header=F)
train_y <- read.table("./train/y_train.txt", header=F)

test_subject <- read.table("./test/subject_test.txt", header=F)
test_x <- read.table("./test/X_test.txt", header=F)
test_y <- read.table("./test/y_test.txt", header=F)

# Combine several information to one, for train and test
# The group ("train" or "test") information is useless in this project,
# but I think it is a good habit to keep the group information
train <- cbind("train", train_subject, train_y, train_x)
test <- cbind("test", test_subject, test_y, test_x)

# 4. Appropriately labels the data set with descriptive variable names
colnames(train) <- c("group", "subject.index", "activity.index", features$feature.name)
colnames(test) <- c("group", "subject.index", "activity.index", features$feature.name)

# 1. Merges the training and the test sets to create one data set
dataset <- rbind(train, test)
#rm(train_subject, train_x, train_y, test_subject, test_x, test_y)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement
msd <- features[grep("mean|std", features$feature.name), 1]
col_index <- c(1:3, 3+msd)
dataset.msd <- dataset[ , col_index]

# 3. Uses descriptive activity names to name the activities in the data set
dataset.msd.activity <- inner_join(activity_labels, dataset.msd)

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject
dataset.wanted <- select(dataset.msd.activity, -activity.index, -group)
dataset.result <- aggregate(dataset.wanted[, -(1:2)], by=list(dataset.wanted$activity.name, dataset.wanted$subject.index), FUN=mean)
colnames(dataset.result)[1:2] <- c("activity", "subject")
write.table(dataset.result, file="project_result.txt", row.names=F)
