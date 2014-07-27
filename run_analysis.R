# Course project: Getting and Cleaning Data
# Author: Tak Wai Wong
# Submission date: 7/27/2014
#
# Function summaries:
#   readData(...)       - Read the data sets, and clean them up.
#   getMean_Std(...)    - Extract mean and standard deviation from the data set
#   run_analysis()      - Run this main function.


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
    
    ###
    # Read and clean up X_ data set.
    # 
    # Read the column data as numeric type. Otherwise, the column 
    # data may be read in as factor levels, which messes up numeric 
    # computation. X_*.txt has 561 features so explicitly specify
    # the numeric type for 561 columns.
    X <- read.table(file_X, colClasses = c(rep("numeric", 561)))
    
    # Read the descriptive feature names from features.txt
    X_features <- read.table("features.txt")
    # Set the columns in X data set with descriptive names from 
    # features.txt
    colnames(X) <- unlist(X_features[2])    
    
    ###
    # Read and clean up y_* data set.
    #
    # y_ data set only has one column, which is the activity ID.
    y <- read.table(file_y)
    # The mapping from activity ID -> activity label is in the 
    # activity_labels.txt file.
    y_labels <- read.table("activity_labels.txt")
    # Add descriptive column name.
    colnames(y) <- c("Activity")
    # Update the y values with the activity labels as factors.
    y$Activity <- factor(y$Activity, levels = unlist(y_labels[1]), labels = unlist(y_labels[2]))
    
    ###
    # Read and clean up subject_* data set.
    #
    #
    subject <- read.table(file_subject)
    # Add descriptive column name.
    colnames(subject) <- c("Subject")
    
    # Returns the merged data set that cbind(subject_*, y_*, X_*)
    #   together.
    output <- cbind(subject, y, X)
    return(output)
}

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
    
    # Load the sqldf library to help identify relevant
    # columns to extract. The relevant column names have
    # this name pattern: %mean()% or %std()%.
    library(sqldf)
    columns <- data.frame(colnames(dataTable))
    colnames(columns) <- c("ColumnName")
    sql_colNames <- sqldf("select * from columns where 
                          ColumnName = 'Subject' or ColumnName = 'Activity' or
                          ColumnName like '%mean()%' or ColumnName like '%std()%'")
    
    # Now select the mean() and std() columns from the dataTable
    # Subsetting requires a character vector. Convert the column names from 
    # sqldf into a character vector.
    mean_std_cols <- as.character(unlist(sql_colNames))
    mean_std <- dataTable[mean_std_cols]
    return(mean_std)
}

run_analysis <- function()
{
    ### Begin #1
    # 1. Merges the training and the test sets to create one data set.
    ###
    
    # Read the test data into a merged data table.
    testSet <- readData("test/X_test.txt", "test/y_test.txt", "test/subject_test.txt")
    # Read the train data into a merged data table.
    trainingSet <- readData("train/X_train.txt", "train/y_train.txt", "train/subject_train.txt")
    # Merge the test and training data into one data set.
    mergedData <- rbind(trainingSet, testSet)
    # Write out table for debugging.
    # write.table(mergedData, "merged_train_test_data.csv", sep = ",", col.names = TRUE, row.names = FALSE)    
    ### End #1
    
    ### Begin #2
    # 2. Extracts only the measurements on the mean and standard deviation for each measurement.
    ###
    mean_std <- getMean_Std(mergedData)
    # Write out table for debugging.
    # write.table(mean_std, "mean_std_measurements.csv", sep = ",", col.names = TRUE, row.names = FALSE)
    
    ### End #2
    
    ### Begin #3
    # 3. Uses descriptive activity names to name the activities in the data set
    ###
    # Done in the readData(...) function.
    ### End #3
    
    ### Begin #4
    # 4. Appropriately labels the data set with descriptive variable names.
    ###
    # Done in the readData(...) function.
    ### End #4
    
    ### Begin #5
    # 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    ###
    
    # Column 1 and column 2 are Subject, and Activity. Skip them from being aggregated because they are 
    # the pivot columns, and not the measurements for mean calculation.
    # Hence, subsetting from 3:end_of_dim_column.
    aggData <- aggregate(mean_std[3:dim(mean_std)[2]], FUN = mean, by = list(mean_std$Subject, mean_std$Activity))
    # Give Group 1 and Group 2 friendlier names.
    colnames(aggData)[1] <- "Subject"
    colnames(aggData)[2] <- "Activity"
    # Write out the tidy data set.
    write.table(aggData, "average_by_subject_activity.txt", sep = ",", col.names = TRUE, row.names = FALSE)
    
    ### End #5   
    
}