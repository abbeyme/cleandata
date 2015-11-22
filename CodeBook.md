---
title: "Codebook template"
author: "writetoAbbey"
date: "22/11/2011"
output:
  html_document:
    keep_md: yes
---

## Project Description
This project demonstrate the ability to collect and clean data set using the Human Activity Recognition Using Smartphones Data Set from 
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

##Study design and data processing



###Collection of the original raw data
The raw data set was collected during some experiments that were carried out with a group of 30 volunteers within an age bracket of 19-48 years. They performed a protocol of activities composed of six basic activities: three static postures (standing, sitting, lying) and three dynamic activities (walking, walking downstairs and walking upstairs). The experiment also included postural transitions that occurred between the static postures. These are: stand-to-sit, sit-to-stand, sit-to-lie, lie-to-sit, stand-to-lie, and lie-to-stand. All the participants were wearing a smartphone (Samsung Galaxy S II) on the waist during the experiment execution. We captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz using the embedded accelerometer and gyroscope of the device. The experiments were video-recorded to label the data manually. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of 561 features was obtained by calculating variables from the time and frequency domain. More detail on the data set can be found in [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

##Creating the tidy datafile

###Guide to create the tidy data file
Description on how to create the tidy data file
1. download the data
2. The xTrain and xTest data set are merged 
3. Features (86) associated with only Mean and std measurements (as seen from the features name in features.txt file) were extracted 
4. A descriptive name was given to columns of the data set 
5. The subject and activityLabel were also added to the data set
6. A final data set showing the average of each variable for each activity and each subject is done here

