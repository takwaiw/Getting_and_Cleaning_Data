Data Set Explanation
====================
The data set comes from this project: 
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, they had captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

Here are the data for the project: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

##Data sets in this repo

###Tidy data set: Average mean and standard deviation measurements for each Activity and for each Subject

* 'README.md': Explains how the functions in the 'run_analysis.R' script work and how the data is transformed.

* 'run_analysis.R': R script that transforms the project data into the required tidy data set.

* 'average_by_subject_activity.txt': CSV tidy data set that has the average mean and standard deviation measurements for each Activity and for each Subject. It is transformed from the source data set as follows:

##### Step 1: Merges the training and the test sets to create one data set.
1. Read the test data 'test/X_test.txt', 'test/y_test.txt', 'test/subject.txt' into separate data tables.
2. After reading X_test.txt, column names are assigned to each of the 561 features. It reads the column names from 'features.txt'.
3. After reading y_test.txt, column name "Activity" is set. Then, it replaces each value with the activity name from activity_labels.txt.
4. After reading subject_test.txt, column name "Subject" is set.
5. Combines the columns from subject_test, y_test, and X_test into one test data set.
6. Repeat steps 2 - 5 for the train data set. Combine the columns from subject_train, y_train, and X_train into one training data set.
7. Combine the rows from the  training data set and the test data set into one merged data set.

##### Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
1. Search for column names in the merged data set that contains '%mean()%' or '%std()%. 
2. Use this list of column names to subset the merged data set.
   
##### Step #3: Creates a second, independent tidy data set with the average of each variable each activity and each subject.
1. Use the aggregate(...) function to calculate mean for each variables in the data table from Step 2.
2. Write out the tidy data set to a CSV file 'average_by_subject_activity.txt'

    
### Human Activity Recognition Using Smartphones Data Set

* 'README.txt': Original readme from the project archive.

* 'features_info.txt': Shows information about the variables used on the feature vector.

* 'features.txt': List of all features.

* 'activity_labels.txt': Links the class labels with their activity name.

* 'train/X_train.txt': Training set.

* 'train/y_train.txt': Training labels.

* 'test/X_test.txt': Test set.

* 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

###Notes

* Features are normalized and bounded within [-1,1].
* Each feature vector is a row on the text file.
* The complete list of variables of each feature vector is available in 'features.txt'