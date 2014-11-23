#ASSIGNMENT
Assignment requires the below to be done:

"Create one R script called run_analysis.R that does the following:
*1) Merges the training and the test sets to create one data set.
*2) Extracts only the measurements on the mean and standard deviation for each measurement. 
*3) Uses descriptive activity names to name the activities in the data set.
*4) Appropriately labels the data set with descriptive variable names. 
*5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable For each activity and each subject.

and

*6) to upload your data set as a txt file, created with write.table() using row.name=FALSE."
       
#ASSUMPTIONS
The above task list indicates what needs to be done, and does not necessarily represents a programme structure. See also thread https://class.coursera.org/getdata-009/forum/thread?thread_id=58.

"David HoodCommunity TA� 10 days ago 

The really important bit is 5 has to come after the rest, because you are getting the data ready for 5 from the earlier section. The order of 2-4 isn't too critical. For example if you are using dply you pretty much have to do some fixing up on the variable names early on or it is going to complain about the duplicate names. If you are selecting out the columns with grep, you could (in theory) do the selecting out then fix up the names later on. But providing everything is sorted out by the end of 4 I wouldn't be worried.
"

#DATA STRUCTURE

Source data comprises: the files x-train, x-test, y-train, y-test, subject-train, subject-test, activity-labels, features.
 
The data delivered by UCI (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) is separated by data to train a to-be statistical model and by data to test this to-be statistical model. The script uses the below data file from above data set:

*X data files (train and test) contain the measurements, represented by variables, combined in occurrences (rows).
*y data files (train and test) contain the activity id's for each measurement.
*subject data files (train and test) contain the person id's for each measurement; these are the persons who's smartphone recorded the measures. 
*Activity labels data file contains the activity labels matching with the y data file activity id's
*Features data file contains the list of variables for measurements were taken.

#SOLUTION

Key for the solution is that the x-,y- and subject data match by row by row. This means, each row number of x-data corresponds with the same row number of y-data and with the same row number of subject-data. This allows for compiling data components until they are ready for assembly in to the end data set. This in turn implies that the below programme does not create the so called "one data set" in the first step, but this creation process is splitted over the first 3 procedures. This improves maintenance as it allows to ease append data to the data set, by adding data set components to the final data set.
    
The script follows a general accepted programme structure (init, input, process/transform, output, close)

*a) Initialise
*b) Get source data
*c) Compile source data components. This part perfoms per component (measurements, activities and subjects) certain transformations wherer elevant: 
        **c.1) Consolidate source data
        **c.2) Subset source data
        **c.3) Apply descriptive labels
*d) Assemble source data components to source data set
*e) Create data product
*f) Output data product
*g) Close

The script extracts the variables which really represent a mean and not just all the variables with the string "mean" in the name. For example, 
561 angle(Z,gravityMean)
 is not a mean. Variables that represent a real mean typically contain the string "-mean" in the variable name.

The script uses data.table functionality to calculate the mean of the variables. The help of data.table/EXAMPLES provides the usage: "DT[,lapply(.SD,sum),by=x]  # apply through columns by group". It is known as being fast, but the main advantage on top of performance is the fact that you can add variables without the need to change this piece of code. Because the .SD argument dynamically takes the columns which are not included in the "by" parameter all variables except activity and subject are taken into account for mean calculation.


In addition the .SD argument
Where relevant, comments refer to the above list of assignment tasks with "##"

Specific attention  To apply the mean function on specific columns, the SDcols parameter


# INSTRUCTIONS TO RUN THE SCRIPT: 

*adapt set working directory statement in initialise procedure