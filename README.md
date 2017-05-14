# GettingAndCleaningDataAssignement
This git contains the required documents acc. to the Coursera Course Getting and Cleaning Data Assignement

You may find below a description of run_analysis.R script
The R script contains detailed comments inside a code, but a short description is included here as well in 
order to fulfill the requirements of the Assignement

# run_analysis.R readme descritpion

The script is divided into 4 main parts, which are
  1. Setting the working directory
  2. Loading the tables
  3. Manipulating the data
  4. Creating a new independent tidy data of averages

Each part in finer detail:

  1. Setting the working directory
  
  The script automatically sets the working directory to "D:/Balazs/Data Analysis/Assignement". I have saved
  the SAMSUNG data in this directory. This directory contains the following files and folders: "test", "train",
  "activity_labels.txt", "features.txt", "features_info.txt", "README.txt"
  If you wish to run my script, please ensure that you change this command to the directory where the above 
  files and folders are located.
  
  2. Loading the tables
  
  General Tables
  The script reads in with the help of read.delim() function the "activity_labes.txt" and the "features.txt"
  The activity_labels table is set to factor variables and some basic format is concluded / numbers are removed
  
  Training Dataset
  The script reads in with the help of read.delim() and read.table() the "y_train.txt", "x_train.txt" and 
  "subject_train.txt" files
  
  Testing Dataset 
  The script reads in with the help of read.delim() and read.table() the "y_test.txt", "x_test.txt" and 
  "subject_test.txt" files
  
  All the data contained in the directory "Inertial Signals" are omited and not read in. The assignement clearly
  states to only use Mean and Standard Deviation data later on and these files do not contain similar variables
  
  After all the data is read in, the script starts to merge them into one. The script processes the subject data
  as numeric variable and the activity data as factor variable. All other variables are numeric. First the activity
  and subject vectors are bind by row (merging the training and the testing data). The resulting dataframes are given
  names. ("Activity" and "Subject) In result we acquire "subject_final" and "activity_final" data frames. In a similar 
  manner we rbind() the "x_train" and "x_test" data to get "x_final". We ensure the coloumns are named acc. to the 
  features. The "subject_final", "activity_final" and "x_final" data frames are coloumn binded with cbind() resulting 
  the "NewDataset" containing the merged (test-train) data.
  
  3. Manipulating the data
  
  Searching through the variable names for "mean", "Mean" and "std" in order to select the variables containing information
  about various means and standard deviations. All other variables are dropped expect the "Subject" and "Activity" variables
  Afterwards the script ensures that descriptive names are generated from the existing one for each variable
  
  4. Creating a new, independent tidy Data of Averages
  
  The "AveragesData" data frame is created by assigning the "NewDataSet" to it. This new data frame is manipulated using
  the aggregate() function grouping the variables by Subject and by Activities and applying the mean() function for every
  variable in the data frame.
  Some additional formating is applied to ensure the names are descriptive and the Data frame does not contain any 
  unnecessary or duplicate information, thus keeping the data frame tidy.
  
