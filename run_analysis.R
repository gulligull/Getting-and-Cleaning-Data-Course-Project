
##### 1. Merge the training and the test sets to create one data set #####

### Download Data
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, "data.zip", method = "curl")

### Unzip Data File
unzip("data.zip", exdir = "./data")
# list files
list.files("./data", recursive = T)

### necessary files as described in README.txt are:
## values:
# 'train/X_train.txt': Training set.
# 'train/y_train.txt': Training labels.
# 'test/X_test.txt': Test set.
# 'test/y_test.txt': Test labels.
# 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
# 'test/subject_test.txt
## variable names:
# 'features.txt': List of all features.
# 'activity_labels.txt': Links the class labels with their activity name.

### read in necessary files
FeaturesTrain <- read.table(file.path("data/UCI HAR Dataset", "train", "X_train.txt"))
ActivityTrain <- read.table(file.path("data/UCI HAR Dataset", "train", "y_train.txt"))
FeaturesTest <- read.table(file.path("data/UCI HAR Dataset", "test", "x_test.txt"))
ActivityTest <- read.table(file.path("data/UCI HAR Dataset", "test", "y_test.txt"))
SubjectTrain <- read.table(file.path("data/UCI HAR Dataset", "train", "subject_train.txt"))
SubjectTest <- read.table(file.path("data/UCI HAR Dataset", "test", "subject_test.txt"))
NamesFeatures <- read.table(file.path("data/UCI HAR Dataset", "features.txt"))
LabelsActivity <- read.table(file.path("data/UCI HAR Dataset", "activity_labels.txt"))

### merge Features, Activity, and Subject data sets
Features <- rbind(FeaturesTrain, FeaturesTest)
Activity <- rbind(ActivityTrain, ActivityTest)
Subject <- rbind(SubjectTrain, SubjectTest)

### name sub data sets
## name Features
# variable names for "Features" is found in "NamesFeatures$V2"
names(Features) <- NamesFeatures$V2
## name Activity
names(Activity) <- "Activity"
## name Subject
names(Subject) <- "Subject"

### merge everything together to create one dataset
fulldata <- cbind(Subject, Activity, Features)


##### 2. Extract only the measurements on the mean and standard deviation for each measurement #####

### explore how/where to find mean and std
str(fulldata)
#-> mean and std are found in variable names in the from of e.g. "tBodyAccJerk-mean()-X" or tBodyAccJerk-std()-X 
#-> we need to search for mean and std strings in variable names and select those

### select columns including the strings "mean" or "std"
# we ignore upper/lower case
selectms <- grep(".*mean.*|.*std.*", names(fulldata), ignore.case=T)
# now we can subset our fulldata using the found matches
# make sure to keep the subject and activity variables
subsetdata <- fulldata[,c(1,2,selectms)]


##### 3. Use descriptive activity names to name the activities in the data set #####
# we will use the labels from "activity_labels.txt" stored in LabelsActivity
subsetdata$Activity <- setNames(LabelsActivity$V2, LabelsActivity$V1)[as.character(unlist(subsetdata$Activity))]


##### 4. Appropriately label the data set with descriptive variable names #####
### infos on abbreviations is found in the features_info.txt
# 't' = time
# 'f' = frequency
# 'Acc' = accelerometer
# 'Gyro' = gyroscope
# 'Mag' = magnitude
### additionally we are changinging the following: 
# 'BodyBody' = Body (remove the duplicate)
# '-mean' = Mean
# '-std' = Std
# 'angle' = Angle
# 'gravity' = Gravity

names(subsetdata) <- gsub("^t", "Time", names(subsetdata))
names(subsetdata) <- gsub("^f", "Frequency", names(subsetdata))
names(subsetdata) <- gsub("Acc", "Accelerometer", names(subsetdata))
names(subsetdata) <- gsub("Gyro", "Gyroscope", names(subsetdata))
names(subsetdata) <- gsub("Mag", "Magnitude", names(subsetdata))
names(subsetdata) <- gsub("BodyBody", "Body", names(subsetdata))
names(subsetdata) <- gsub("-mean", "Mean", names(subsetdata))
names(subsetdata) <- gsub("-std", "Std", names(subsetdata))
names(subsetdata) <- gsub("angle", "Angle", names(subsetdata))
names(subsetdata) <- gsub("gravity", "Gravity", names(subsetdata))


##### 5. From the data set in step 4, create a second, independent tidy data set with the 
#average of each variable for each activity and each subject #####
tidyData <- aggregate(. ~Subject + Activity, subsetdata, mean)






