print("Getting and Cleaning Data Project")
print("Author: Roger")
print("---")

#Libraries
print("Loading required libraries.")
print("Installing dplyr library: Hit cancel if already installed.")
install.packages('dplyr')
library(dplyr)
library(magrittr)

#Variables
print("Directory structure is relative. Script assumes working directory set to one level above UCI HAR DATAset")
print("---")

# 1.0 SETUP NEEDED FOR BOTH TRAINING AND TEST SETS
print("1.0: training and test data common setup")
# 1.1 LOAD FEATURE NAMES
print("    -Loading features")
features <- read.csv("./UCI HAR Dataset/features.txt", sep = ' ', header = FALSE)
# 1.2 LOAD ACTIVITY LABELS
print("    -Loading activity labels")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)

# 2.0 TRAINING SET PROCESSING STEPS
print("---")
print("2.0: training data processing steps")
# 2.1 Load training dataset
print("    -Loading training dataset")
trainset <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
# 2.2 Load training labels
print("    -Loading training labels")
trainlabels <- read.csv("./UCI HAR Dataset/train/y_train.txt", sep = ' ', header = FALSE)
# 2.3 Load subjects
print("    -Loading training subjects")
trainsubjects <- read.csv("./UCI HAR Dataset/train/subject_train.txt", sep = ' ', header = FALSE)
# 2.4 Apply Feature Names to Training Set
print("    -Applying feature names to training set")
colnames(trainset) <- features[[2]]
# 2.5 Change training activity to meaningful names
print("    -Changing training activity to meaningful names from activity labels file")
trainlabels[trainlabels==1] <- as.character(activity_labels[1,2]) #walking
trainlabels[trainlabels==2] <- as.character(activity_labels[2,2]) #walking_upstairs
trainlabels[trainlabels==3] <- as.character(activity_labels[3,2]) #walking_downstairs
trainlabels[trainlabels==4] <- as.character(activity_labels[4,2]) #sitting
trainlabels[trainlabels==5] <- as.character(activity_labels[5,2]) #standing
trainlabels[trainlabels==6] <- as.character(activity_labels[6,2]) #laying
# 2.6 Change column name for subjects
print("    -Changing column names for subjects")
names(trainsubjects)[names(trainsubjects)=="V1"] <- "Subject"
# 2.7 Change column name for activities
print("    -Changing column names for activities")
names(trainlabels)[names(trainlabels)=="V1"] <- "Activity"
# 2.8 Insert activity labels into training data set
print("    -Combining subjects, training labels, and training set")
trainsetcomb <- cbind(trainsubjects,trainlabels, trainset)


# 3.0 TEST SET
print("---")
print("3.0: test data processing steps")
# 3.1 Load test dataset
print("    -Loading test dataset")
testset <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
# 3.2 Load test labels
print("    -Loading test labels")
testlabels <- read.csv("./UCI HAR Dataset/test/y_test.txt", sep = ' ', header = FALSE)
#testlabels <- read.csv(file.path(dataDir, "./test/y_test.txt"), sep = ' ', header = FALSE)
# 3.3 Load subjects
print("    -Loading test subjects")
testsubjects <- read.csv("./UCI HAR Dataset/test/subject_test.txt", sep = ' ', header = FALSE)
# 3.4 Apply Feature Names to Test Set
print("    -Applying feature names to test set")
colnames(testset) <- features[[2]]
# 3.5 Change test activity to meaningful names
print("    -Changing test activity to meaningful names from activity labels file")
testlabels[testlabels==1] <- as.character(activity_labels[1,2]) #walking
testlabels[testlabels==2] <- as.character(activity_labels[2,2]) #walking_upstairs
testlabels[testlabels==3] <- as.character(activity_labels[3,2]) #walking_downstairs
testlabels[testlabels==4] <- as.character(activity_labels[4,2]) #sitting
testlabels[testlabels==5] <- as.character(activity_labels[5,2]) #standing
testlabels[testlabels==6] <- as.character(activity_labels[6,2]) #laying
# 3.6 Change column name for subjects
print("    -Changing column names for subjects")
names(testsubjects)[names(testsubjects)=="V1"] <- "Subject"
# 3.7 Change column name for activities
print("    -Changing column names for activities")
names(testlabels)[names(testlabels)=="V1"] <- "Activity"
# 3.8 Insert activity labels into test data set
print("    -Combining subjects, test labels, and test set")
testsetcomb <- cbind(testsubjects, testlabels, testset)


# 4.0 MERGE TRAIN AND TEST SETS
print("---")
print("4.0: Merging training and test data sets")
merged_train_test <- rbind(trainsetcomb, testsetcomb)


# 5.0 KEEP ONLY FEATURES THAT ARE MEAN ("mean()") AND STD DEVIATION ("std()")
print("---")
print("5.0: Creating data frame with only mean() and std() features")
final_df <- cbind(merged_train_test$Subject,merged_train_test$Activity)
colnames(final_df) <- list("Subject", "Activity")
for (cnt in 3:ncol(merged_train_test)) {
  next_name <- colnames(merged_train_test[cnt])
  if  (any(grepl("mean\\(\\)", next_name))) {
    final_df <- cbind(final_df, merged_train_test[cnt])
  }
  else if (any(grepl("std\\(\\)", next_name))) {
    final_df <- cbind(final_df, merged_train_test[cnt])
  }
}


# 6.0 Question 5 - create data set with average of each variable for each activity and subject
print("---")
print("6.0 Creating table with average of each feature variable for each activity and user")
print("    -Writing table to ./UCI HAR Dataset/meanbySubjectActivity.txt")
final_df %>% group_by(Subject, Activity) %>% summarise_each(funs(mean)) %>% arrange(Subject, Activity) %>% write.table("./UCI HAR Dataset/meanbySubjectActivity.txt", row.names = FALSE)
# To read in and view the data
print("    -Reading table and creating view")
datain <- read.table("./UCI HAR Dataset/meanbySubjectActivity.txt", header = TRUE) 
View(datain)

print("---")
print("End of program")
