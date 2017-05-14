##  ---  Getting and Cleaning Data Course Project  ---  ##

##  --- 1. Setting the working dyrectory
  setwd("D:/Balazs/Data Analysis/Assignement")

##  --- 2. Loading the Tables
  ##  --- GENERAL TABLES
  ##  --- Activity Labels
  activity_labels <- read.delim("activity_labels.txt",stringsAsFactors = TRUE, header = FALSE,
                                col.names = "Activity")
    ##  --- Creating a factor vector out of the Activity Labels
  activity_labels <- factor(activity_labels[,1])
    ##  --- Droping the numbers in the beginning
  activity_labels <- gsub(pattern = "[0-9] ", replacement = "", x = activity_labels)
  
  ##  --- Features
  features <- read.delim("features.txt",stringsAsFactors = FALSE, header = FALSE, col.names = 
                           "Features")
  ##  --- GENERAL TABLES ---------------------------------------------------------------------------
  
  ##  --- TRAINING DATASET
  ##  --- Y
  y_train <- read.delim("./train/y_train.txt",header = FALSE, col.names =  "Y train")
  
  ##  --- Subject Data
  subject_train <- read.delim("./train/subject_train.txt",header = FALSE, col.names = 
                              "Subject Train Data")

  ##  --- X
  x_train <- read.table("./train/x_train.txt", header = FALSE, stringsAsFactors = FALSE, dec =
                          ".", sep = "")
  ##  --- TRAINING DATASET ------------------------------------------------------------------
  
  ##  --- TESTING DATASET
  ##  --- Y
  y_test <- read.delim("./test/y_test.txt",header = FALSE, col.names =  "Y test")
  
  ##  --- Subject Data
  subject_test<- read.delim("./test/subject_test.txt",header = FALSE, col.names = 
                                "Subject Test Data")
  
  ##  --- X
  x_test <- read.table("./test/x_test.txt", header = FALSE, stringsAsFactors = FALSE, dec =
                          ".", sep = "")
  ##  --- TESTING DATASET --------------------------------------------------------------------------

  ## --- Merging the activity_labels and y_train/y_test data
  activity_train <- as.factor(activity_labels[y_train[,1]])
  activity_test <- as.factor(activity_labels[y_test[,1]])
  
  ## --- Combining the 2 vectors into one / Adding an NA in between
  activity_final <- factor(c(as.character(activity_train),as.character(activity_test)))
  
  ## --- Creating a data frame and naming the variable
  activity_final <- as.data.frame(activity_final)
  names(activity_final) <- "Activity"
  
  ## --- Combining the Subject Train and Test Data / naming the Data
  names(subject_train) <- "Subject"
  names(subject_test) <- "Subject"
  
  ## --- Combining the data sets
  subject_final <- rbind(subject_train,subject_test)
  
  ## --- Setting the data frame to numeric
  subject_final[,1] <- as.numeric(subject_final[,1])
  
  ## --- Working the x_train and x_test data frames / Combining them
  
  ## --- Naming the testing and training data sets
  names(x_train) <- t.data.frame(features)
  names(x_test) <- t.data.frame(features)
  
  ## --- Combining the data sets
  x_final <- rbind(x_train,x_test)
  
  ## --- Bringing everything together
  NewDataSet <- cbind(subject_final,activity_final,x_final)

## --- Loading the tables ------------------------------------------------------------------------
    
## --- 3. Manipulating the data
  
  ## --- Creating the vector to hold the names of the NewDataSet Coloumns
  NameVect <- names(NewDataSet)
  
  ## --- Getting the Needed Coloums(Mean, Std)
  NeededNames <- c(grep("mean",NameVect),grep("Mean",NameVect),grep("std",NameVect))
  ## --- Sorting the resulting Coloumns
  NeededNames <- sort(x = NeededNames)
  
  ## --- Adjusting the New Data Set acc. to the Needed Names
  NewDataSet <- cbind(Subject = NewDataSet[,1],Activity = NewDataSet[,2], 
                       NewDataSet[,NeededNames[]])
  
  ## --- Reshaping the coloumn names to making them descriptive
  ## --- Droping the numbers in the beginning
  names(NewDataSet) <- gsub(pattern = "[0-9]* ", replacement = "", x = names(NewDataSet))
  ## --- Formating the names further
  names(NewDataSet) <- gsub(pattern = "^t",replacement = "",x = names(NewDataSet))
  names(NewDataSet) <- gsub(pattern = "Freq", replacement = "Frequency ", names(NewDataSet))
  names(NewDataSet) <- gsub(pattern = "^f", replacement = "Frequency Domain Signal ", x = names(NewDataSet))
  names(NewDataSet) <- gsub(pattern = "Body", replacement = "Body ", names(NewDataSet))
  names(NewDataSet) <- gsub(pattern = "Acc", replacement = "Acceleration ", names(NewDataSet))
  names(NewDataSet) <- gsub(pattern = "Gravity", replacement = "Gravity ", names(NewDataSet))
  names(NewDataSet) <- gsub(pattern = "-mean()", replacement = "Mean ", names(NewDataSet))
  names(NewDataSet) <- gsub(pattern = "\\(\\)-X", replacement = "in 'X' direction ", names(NewDataSet))
  names(NewDataSet) <- gsub(pattern = "\\(\\)-Y", replacement = "in 'Y' direction ", names(NewDataSet))
  names(NewDataSet) <- gsub(pattern = "\\(\\)-Z", replacement = "in 'Z' direction ", names(NewDataSet))
  names(NewDataSet) <- gsub(pattern = "-std", replacement = "Standard Deviation ", names(NewDataSet))
  names(NewDataSet) <- gsub(pattern = "Gyro", replacement = "Gyroscope ", names(NewDataSet))
  names(NewDataSet) <- gsub(pattern = "Jerk", replacement = "Jerk Signal ", names(NewDataSet))
  names(NewDataSet) <- gsub(pattern = "Mag", replacement = "Magnitude ", names(NewDataSet))
  names(NewDataSet) <- gsub(pattern = "Body Body", replacement = "Body ", names(NewDataSet))
  names(NewDataSet) <- gsub(pattern = "angle", replacement = "Angle ", names(NewDataSet))
  names(NewDataSet) <- gsub(pattern = "\\(t", replacement = "", names(NewDataSet))
  names(NewDataSet) <- gsub(pattern = ",gravity", replacement = " Gravity ", names(NewDataSet))
  names(NewDataSet) <- gsub(pattern = "Mean\\) Gravity Mean", replacement = " Gravity Mean ", names(NewDataSet))
  names(NewDataSet) <- gsub(pattern = "Mean Gravity Mean", replacement = " Gravity Mean ", names(NewDataSet))
  names(NewDataSet) <- gsub(pattern = "\\(\\)", replacement = "", names(NewDataSet))
  names(NewDataSet) <- gsub(pattern = " \\)", replacement = "", names(NewDataSet))
  
## --- Manipulating the data ----------------------------------------------------------------------------
  
## --- 4. Creating a new, independent tidy Data of Averages
  
  AveragesData <- NewDataSet
  
  ## --- Changing the class of the subject coloumn into factors
  AveragesData$Subject <- as.factor(AveragesData$Subject)
  
  ## --- Aggregating the data by Subject and Activity
  AveragesData <- aggregate(AveragesData,list(GroupBySubject = AveragesData$Subject,GroupByActivity = 
                            AveragesData$Activity),mean, na.rm = TRUE)
  
  ## --- Deleting the NA coloumns
  AveragesData <- AveragesData[,-(3:4)]
  
  ## --- Adjusting the first 2 coloumn name
  names(AveragesData) <- gsub(pattern = "GroupBy", replacement = "Group By ", names(AveragesData))
  
  
  
  
  
  
  