#Getting and Cleaning Data Project

#Objectives
The run_analysis.R script addresses the objectives of the project for this class. They are:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Processing steps description
The run_analysis.R script goes through the following processing steps.

Libraries are loaded. Two libraries are required to execute the script, magrittr and dplyr. The script will attempt to install the dplyr package so if it is not needed the user should select cancel.

A relative directory structure is assumed where the script is at the same directory level as the top level of the UCI dataset.

The processing is labeled with numerical steps as follows:
1.0: Training and test data common setup.
The features (variables) are common to both data sets and they are loaded here. The acitivity labels are also common and loaded.

2.0: Training set processing steps 
These steps include loading the training set, training labels, and training subjects. The feature names loaded previously are applied to the training set columns and the activity labels that were loaded are substituted for the numerical values. The training subjects and training activity column headers are changed to Subject and Activity, respectively. The last step combines the training subjects, labels, and training data into one data frame. This is a complete training data frame with all features. 

3.0: Test set processing steps
The processing steps for the test set is identical. It is a full set, like the training set, of subjects, activities, and feature data. 

4.0: Merging training and testing data sets
The training and test data are row combined into one large data set. 

5.0 Keep only features with mean() and std()
The final processing steps is to only keep features with these indicators included in the name. The result is a data frame with 10299 rows and 68 columns. There are 66 feature columns plus subject and activity.

6.0 Create a data set with average of each feature for each activity and user
This step creates the mean of each variable for each user and activity. It has 180 rows with the same 68 columns as above.

Running the script
To run the script, source run_analysis.R. All functionality required to meet the objectives are included. The required output tidy data set will be in meanbySubjectActivity.txt. The script will also read this file back in for viewing.

The script outputs the following messages for processing steps:

#Getting and Cleaning Data Project
Author: Roger

Loading required libraries.
Installing dplyr library: Hit cancel if already installed.
Directory structure is relative. Script assumes working directory set to one level above UCI HAR DATAset

1.0: training and test data common setup
   -Loading features
    -Loading activity labels
    
2.0: training data processing steps
    -Loading training dataset
    -Loading training labels
    -Loading training subjects
    -Applying feature names to training set
    -Changing training activity to meaningful names from activity labels file
    -Changing column names for subjects
    -Changing column names for activities
    -Combining subjects, training labels, and training set

3.0: test data processing steps
    -Loading test dataset
    -Loading test labels
    -Loading test subjects
    -Applying feature names to test set
    -Changing test activity to meaningful names from activity labels file
    -Changing column names for subjects
    -Changing column names for activities
    -Combining subjects, test labels, and test set

4.0: Merging training and test data sets

5.0: Creating data frame with only mean() and std() features
5.0: Creating data frame with only mean() and std() features

6.0 Creating table with average of each feature variable for each activity and user
    -Writing table to ./UCI HAR Dataset/meanbySubjectActivity.txt
    -Reading table and creating view

End of program


