# Getting-and-Cleaning-Data-Course-Project
Course Project Submission

How the Script Works 
=================
The submitted script first reads the 3 raw TEST data files and 3 raw TRAIN data files into R.

Then, it combines the 3 TEST data files into a complete TEST data table and the 3 TRAIN data files into a complete TRAIN data table

We then merge the complete TRAIN and TEST tables into 1 complete table.

Next, column names are added to the combined_table using the Features.txt file.

Then, extraction is performed to onl retain data with only columns containing "mean" and "std" and the last 2 columns for activity and subject.

The activity labels are also relabelled into descriptive activity names. The remaining variables are also relabelled with more descriptive variable names.

Finally, dplyr is used to summarise data by Subject then by Activity:
new_summarised_data <- extracted_combined_table %>%
group_by(Subject,Label) %>%
summarise_each(funs(mean))

The tidy table is then printed:
print(new_summarised_data)

The tidy table is written to file for uploading.
write.table(new_summarised_data, file="Tidy Data Set.txt", row.names = FALSE)

Outline of Variables
=================
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 


Code Book
=================
These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

Time of BodyAcc-XYZ
Time of GravityAcc-XYZ
Time of BodyAccJerk-XYZ
Time of BodyGyro-XYZ
Time of BodyGyroJerk-XYZ
Time of BodyAccMag
Time of GravityAccMag
Time of BodyAccJerkMag
Time of BodyGyroMag
Time of BodyGyroJerkMag
Freq of BodyAcc-XYZ
Freq of BodyAccJerk-XYZ
Freq of BodyGyro-XYZ
Freq of BodyAccMag
Freq of BodyAccJerkMag
Freq of BodyGyroMag
Freq of BodyGyroJerkMag
gravityMean
Time of BodyAccMean
Time of BodyAccJerkMean
Time of BodyGyroMean
Time of BodyGyroJerkMean

The set of variables that were estimated from these signals are: 

mean(): Mean value
Standard Deviation(): Standard deviation