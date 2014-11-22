ASSIGNMENT:
Assignment requires the below to be done:

You should create one R script called run_analysis.R that does the following:
1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement. 
3) Uses descriptive activity names to name the activities in the data set.
4) Appropriately labels the data set with descriptive variable names. 
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable For each activity and each subject.
to upload your data set as a txt file, ...
6) created with write.table() using row.name=FALSE.
       
ASSUMPTIONS:
1. For task 1 the university means "append" and not "merge" as merge in R does something different.
2. The above task list indicated what needs to be done, and does not necessarily represents a programme structure. This assumptions holds as the comments in the following thread: 

DATA STRUCTURE:
The data delivered by UCI (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 
is separated by data to train a to-be statistical model and data to test this to-be statistical model. 

The x data files (train and test) contain the measurements, represented by variables, combined in occurrences (rows).
The y data files (train and test) contain the activity id's for each measurement.
The subject data files (train and test) contain the person id's for each measurement; these are the persons who's smartphone recorded the measures. 
The activity labels data file contains the activity labels matching with the y data file activity id's

Key for the solution is that the x-,y- and subject data match by row by row. 
This means each row number of x-data corresponds with the same row number of y-data and with the same row number of subject-data.
This allows for compiling data components until they are ready for assembly in to the end data set. 
This implies that the below programme does not create the one data set in the first step, but this creation process is splitted 
over the first 3 procedures. This improves maintenance as it allows to ease append data to the data set, 
by adding data set components to the final data set.
    
The script follows a general accepted programme structure (init, input, process/transform, output, close)

a) Initialise
b) Get source data
c) Compile source data components (per component performs (if relevant): 
        c.1) Consolidate source data
        c.2) Subset source data
        c.3) Apply descriptive labels
d) Assemble source data components to source data set
e) Create data product
f) Output data product
g) Close

Where relevant, comments refer to the above list of assignment tasks with "##"

INSTRUCTIONS TO RUN THE SCRIPT: 
Store all data in folder "Smartphone"