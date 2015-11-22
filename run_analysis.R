



#1. Merges the training and the test sets to create one data set.

## read all required data 

xTrain <- read.table("/home/ahmed/Documents/OldDOcs/gettingcleaningdata/project/UCI HAR Dataset/train/X_train.txt")  

yTrain <-read.table("/home/ahmed/Documents/OldDOcs/gettingcleaningdata/project/UCI HAR Dataset/train/y_train.txt")  

subjTrain <- read.table("/home/ahmed/Documents/OldDOcs/gettingcleaningdata/project/UCI HAR Dataset/train/subject_train.txt")

xTest <- read.table("/home/ahmed/Documents/OldDOcs/gettingcleaningdata/project/UCI HAR Dataset/test/X_test.txt")  

yTest <- read.table("/home/ahmed/Documents/OldDOcs/gettingcleaningdata/project/UCI HAR Dataset/test/y_test.txt")  

subjTest <- read.table("/home/ahmed/Documents/OldDOcs/gettingcleaningdata/project/UCI HAR Dataset/test/subject_test.txt")

features <- read.table("/home/ahmed/Documents/OldDOcs/gettingcleaningdata/project/UCI HAR Dataset/features.txt")

features <- read.table("/home/ahmed/Documents/OldDOcs/gettingcleaningdata/project/UCI HAR Dataset/features.txt")

activity <- read.table("/home/ahmed/Documents/OldDOcs/gettingcleaningdata/project/UCI HAR Dataset/activity_labels.txt")


# merge  xTrain and xTest data set
xData <- rbind(xTrain,xTest)



## Extract features associated with only Mean and std measurements

# Extract indices of features associated with only Mean measurements
featuresMean<-grep("mean",features$V2, value=FALSE, ignore.case = TRUE) 

#  Extract indices  of features  associated with only std measurements
featuresStd<-grep("std",features$V2, value=FALSE, ignore.case = TRUE) 

# Extract columns with only mean and std measurements
oldindex<-c(featuresMean, featuresStd)
xData<-xData[, oldindex]

## Give a descriptive name to variables
 #  extraxct the variable names from the features data set using the previously obtained indices and convert to character
oldName<-features$V2[oldindex]

# remove (  from the names
oldName<- gsub("\\(", "", oldName)
# remove ")" from the names
oldName <- gsub("\\)", "", oldName)
# remove "," from the names
oldName <- gsub("\\,", "", oldName)
#
newName <- gsub("-", "", oldName)
# Assign the names to the columun of dataset
names(xData)<-newName

# Merge subject_train and subject_test data set
subject <- rbind(subjTrain,subjTest)

# merge subject with xData

xData$subject <- unname(subject$V1)

## Link activity to label inorder to Uses descriptive activity names to name the activities in the data set

# First set the levels for activity factor
activity$V2<- factor(activity$V2, levels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING" ))
relevel(activity$V2,ref="WALKING")

# load plyr library
library(plyr)
# link activity to y label for Training set

#yTrainLabel <- merge(yTrain, activity, by ="V1", sort = FALSE) # this try to put all label into contiguous lines which is will disorganized the obeservations numbers not 

yTrainLabel <- join(yTrain, activity, by ="V1") 

# link activity to y label for Testing set
yTestLabel <- join(yTest, activity, by = "V1") 

# Merge the yTrainLabel and the yTestLabel
yLabel<-rbind(yTrainLabel,yTestLabel)



# Add yLabel to  xData to form the whole data set 

xData$activityLabel <- unname(yLabel$V2)

# The average of each variable for each activity and each subject is done here

finalData <- xData %>% group_by(subject,activityLabel) %>% summarise_each(funs(mean))



write.table(finalData, file= "tidyData.txt", row.name=FALSE)


yy<-read.table("tidyData.txt", header= TRUE, fill =TRUE)
