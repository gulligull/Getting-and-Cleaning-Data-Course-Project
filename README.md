# Getting-and-Cleaning-Data-Course-Project

This Github Repo contains the following file:
* run_analysis.R: R code that (when run) allows answering the assignment questions. The final output is a file called "tidyData"
* CodeBook.md: Codebook for the r code with descriptions of the variables, etc.

To answer the questions of the assignment simply run the R code. The code is annotated and variables are detailed further in the Codebook.


In summary the R code in the file run_analysis.R dows the following:
* Download the input data and unzip the downloaded file in the working directory
* Read in the required files for the project assignment
* Create one data set containing training and test sets (ANSWER TO Q1)
* Extract only the measurements on the mean and standard deviation for each measurement (ANSWER TO Q2)
* Label activities descriptively (ANSWER TO Q3)
* Appropriately label the data set with descriptive and easy to read variable names (ANSWER TO Q4)
* Generate a tidy data set with the average of each variable for each activity and each subject (ANSWER TO Q5)
