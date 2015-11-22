
##  Introduction
This file explain the code in the run_analysis file  to carry out the project on collecting and cleaning data set to create a tidy data set. The procudure is as follows

### The follwing codes read all required data set :

<!-- -->
xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")  

yTrain <-read.table("./project/UCI HAR Dataset/train/y_train.txt")  

subjTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")  

yTest <- read.table("./UCI HAR Dataset/test/y_test.txt")  

subjTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

features <- read.table("./UCI HAR Dataset/features.txt")

features <- read.table("./UCI HAR Dataset/features.txt")

activity <- read.table("./UCI HAR Dataset/activity_labels.txt")


### The xTrain and xTest data set are merged 

      xData <- rbind(xTrain,xTest)


### Extract features associated with only Mean and std measurements

1.  Extract indices of features associated with only Mean measurements
    
    featuresMean<-grep("mean",features$V2, value=FALSE, ignore.case = TRUE) 

2.  Extract indices  of features  associated with only std measurements
    
    featuresStd<-grep("std",features$V2, value=FALSE, ignore.case = TRUE) 

3.  Extract columns with only mean and std measurements
     
     oldindex<-c(featuresMean, featuresStd)
    
      xData<-xData[, oldindex]

### The following lines of code give a descriptive name to variables
1.  Extract the variable names from the features data set using the previously obtained indices and convert to character

    oldName<-features$V2[oldindex]
    
2.  remove (  from the names

    oldName<- gsub("\\(", "", oldName)
    
3.  remove ")" from the names

    oldName <- gsub("\\)", "", oldName)
4.  remove "," from the names

  oldName <- gsub("\\,", "", oldName)
  
5.  Finally form the new variable name

    newName <- gsub("-", "", oldName)
    
#### Assign the names to the column of dataset

     names(xData)<-newName

### Merge subject_train and subject_test data set

    subject <- rbind(subjTrain,subjTest)

###   Add subject to xData

     xData$subject <- unname(subject$V1)

#### Next link the activity to label inorder to Uses descriptive activity names to name the activities in the data set

1.  First set the levels for activity factor
    
  activity$V2 <- factor(activity$V2,levels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING" ))

  relevel(activity$V2,ref="WALKING")

2.  link activity to y label for Training set

    library(plyr)
     yTrainLabel <- join(yTrain, activity, by ="V1") 

3.  link activity to y label for Testing set

   yTestLabel <- join(yTest, activity, by = "V1") 

4.  Merge the yTrainLabel and the yTestLabel

    yLabel<-rbind(yTrainLabel,yTestLabel)

### Add yLabel to  xData to form the required tidy data set 
xData$activityLabel <- unname(yLabel$V2)

#### Finally the average of each variable for each activity and each subject is done here

finalData <- xData %>% group_by(subject,activityLabel) %>% summarise_each(funs(mean))


### The data is written to the file "tidyData.txt"
  
   write.table(finalData, file= "tidyData.txt", row.name=FALSE)



