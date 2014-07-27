Getting and Cleaning Data
=========================

Coursera course on the Data Science specialization track: **Getting and Cleaning Data**. This repo contains the programming assignment files.

Course project: Getting and Cleaning Data

Author: Tak Wai Wong

Submission date: 7/27/2014


##Function Summary
* run_analysis()      - Run this main function.
* readData(...)       - Read the data sets, and clean them up.
* getMean_Std(...)    - Extract mean and standard deviation from the data set


```r
run_analysis <- function()
{
    ### Step 1: Merges the training and the test sets to create one data set.
    # 
    # Read the test data by calling:
    #     readData('test/X_test.txt', 'test/y_test.txt', 'test/subject.txt')
	# The readData function does the following: 
	#	* Read the  data from X, y, and subject into 3 separate data tables.
	#	* Use the labels in 'features.txt' to name the 561 columns for X table. 
	#	* Set the column name for y to 'Activity'. Then, it replaces each value 
    #     with the activity name from 'activity_labels.txt'.
	#
    # Read the train data by calling:
    #     readData('train/X_train.txt', 'train/y_train.txt', and 'train/subject_train.txt')
    # 
	# Merge the test and training data into one data set.
	#
    ### End #1
    
    ### Step #2: Extracts only the measurements on the mean and standard deviation for each 
    #            measurement.
    # Search for column names in the merged data set that contains '%mean()%' or '%std()%. 
	# Use this list of column names to subset the merged data set.
    ### End #2
    
    ### Step #3: Creates a second, independent tidy data set with the average of each variable
    #            for each activity and each subject.
    # Use the aggregate(...) function to calculate mean for each variables in the data table 
    # from Step #2.
    # Write out the tidy data set to a CSV file 'average_by_subject_activity.txt'
    ### End #3
}
```

```r
readData <- function(file_X, file_y, file_subject)
{
    # Purpose: Read the data files X_*, y_*, and subject_*. Then
    # merge data from the three files into one data set.
    #
    # Input parameters:
    #   file_X: subdirectory/X_*.txt file that contains the 561
    #           feature vectors.
    #   file_y: subdirectory/y_*.txt file that contains the 
    #           activity labels.
    #   file_subject: subdirectory/subject_*.txt file that 
    #           contains the subjects that performed the
    #           activities.
    #   
    # After reading X_*.txt, column names are assigned to each of
    # the 561 features. It reads the column names from 
    # features.txt.
    #
	# After reading y_*.txt, column name "Activity" is set.
    # Then, it replaces each value with the activity name
    # from activity_labels.txt.
	#
    # After reading subject_*.txt, column name "Subject" is 
    # set.
    #
    # Output:
    #   Returns the merged data set that cbind(subject_*, y_*, X_*)
    #   together.
}
```

```r
getMean_Std <- function(dataTable)
{

    # Purpose: Extract the mean and standard deviation
    # columns from the data set.
    #
    # Input parameters:
    #   dataTable: Table to extract columns from.
    # Output:
    #   Returns a table with columns that has mean and standard
    #   deviation measurements only.
}
```