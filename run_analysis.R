
# a) Initialise

        print("initialise, set working directory and library packages")
        setwd("D:/Users/GOMMERBORN/datasciencecoursera/Smartphone") #all data is stored in folder, the working directory
        #library(plyr)
        #library(data.table)

# b) Get source data

        print("get source data")
        
        # b.1) Measurements of variables
        x_train <- read.table("x_train.txt")
        x_test <- read.table("x_test.txt")
        
        # b.2) Activities
        y_train <- read.table("y_train.txt")
        y_test <- read.table("y_test.txt")
        
        # b.3) Subjects
        subject_train <- read.table("subject_train.txt")
        subject_test <- read.table("subject_test.txt")

        # b.4) activity names
        activity_names <- read.table("activity_labels.txt")
        
# c)    Compile source data components

        print("Compile source data components")
        
        # b.1) Measurements of variables
        
        ## Merge the training and the test sets to create one data set
        x_total <- rbind(x_train, x_test) 
        
        ## Extract the measurements on the mean and standard deviation for each measurement
        all_variables <- read.table("features.txt")
        mean_std_variables <- all_variables[grep("-mean|:-std", all_variables[, 2]),]
        mean_std_subset <- x_total[,mean_std_variables[,1]]

        ## Appropriately label the data set with descriptive variable names
        colnames(mean_std_subset) <- mean_std_variables[,2]
        
        # b.2) Activities

        ## Merge the training and the test sets to create one data set
        y_total <- rbind(y_train, y_test)

        ## Apply descriptive activity names to name the activities in the data set.
        y_total[, 1] <- activities_names[y_total[, 1], 2] 
        # This replace the id's in the y-total column (assessed by [,1]) with the corresponding 
        # activity description in activity labels table (assessed by [,2])
                # y_total       activity_names
                #       1       1            WALKING
                #       2       2   WALKING_UPSTAIRS
                #       3       3 WALKING_DOWNSTAIRS

        colnames(y_total) <- "activity"
        
        # b.3) Subjects (persons)

        ## Merge the training and the test sets to create one data set
        subject_total <- rbind(subject_train, subject_test)

        colnames(subject_total) <- "subject"

# c)    Assemble source data components to one source data set        

        print("Assemble source data components to one source data set")
        
        ## Merge the training and the test sets to create one data set
        data_set <- cbind(y_total, subject_total, mean_std_subset)
        
# d)    Create data product
        
        print("Create data product")
        
        ## Create a second, independent tidy data set with the average of each variable for each activity and each subject.

        # Used data.table as it is known as fast.
        # .SD parameter locks the columns of the data table which are not part in the "by" parameter", so you get
        # all columns next ot activity and subject. Use SDcols parameter to only apply the mean on specified columns.
        dt_data_set <- data.table(data_set)
        mean_dt_data_set <- dt_data_set[,lapply(.SD, function(x) mean(x)), by=list(activity, subject)]
        # Ordering done, but strictly seen not required
        mean_dt_data_set <- mean_dt_data_set[order(mean_dt_data_set$activity, mean_dt_data_set$subject, decreasing=FALSE), ]   
        
# 5)    Output
        
        print("Write out put text file")
        
        ## Output data product with txt file created with write.table() using row.name=FALSE
        write.table(mean_dt_data_set, "mean_dt_data_set.txt", row.name=FALSE)
        
# 6)    Close
        print("Finished, file (mean_dt_data_set.txt) written to working directory")