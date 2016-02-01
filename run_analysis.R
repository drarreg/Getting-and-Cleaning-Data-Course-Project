## Read in the 3 raw TEST data files
xtest <- read.delim("X_test.txt", header = FALSE, sep="")
ytest <- read.delim("y_test.txt", header = FALSE, sep="")
subjecttest <- read.delim("subject_test.txt", header = FALSE, sep="")

## Read in the 3 raw TRAIN data files
xtrain <- read.delim("X_train.txt", header = FALSE, sep="")
ytrain <- read.delim("y_train.txt", header = FALSE, sep="")
subjecttrain <- read.delim("subject_train.txt", header = FALSE, sep="")

## Combine the 3 TEST data files into a complete TEST data table
full_test_table <- cbind(xtest, ytest, subjecttest)

## Combine the 3 TRAIN data files into a complete TRAIN data table
full_train_table <- cbind(xtrain, ytrain, subjecttrain)

## Merge the complete TRAIN and TEST tables
combined_table <- rbind(full_train_table,full_test_table)

## Add column names for combined_table
headers_extra_columns <- matrix(c(562,563,"Label","Subject"), nrow=2, ncol=2)
headers_extra_columns <- as.data.frame(headers_extra_columns)
features <- read.delim("features.txt",header=FALSE,sep="")
col_names_combined_table <- rbind(features,headers_extra_columns)
colnames(combined_table) <- col_names_combined_table$V2

## Extract and truncate data with only columns containing "mean" and "std" and the last 2 columns
col_with_mean_and_std <- c(grep("mean",colnames(combined_table)),grep("std",colnames(combined_table)))
extracted_combined_table <- combined_table[,c(col_with_mean_and_std,562,563)]

## Change the activity labels into descriptive activity names
activity.label <- read.delim("activity_labels.txt", header = FALSE, sep="")
extracted_combined_table$Label <- as.character(extracted_combined_table$Label)
activity_label_lookup <- c("1"="WALKING", "2"="WALKING_UPSTAIRS", "3"="WALKING_DOWNSTAIRS", "4" = "SITTING", "5"="STANDING", "6" = "LAYING")
extracted_combined_table$Label <- activity_label_lookup[extracted_combined_table$Label]

## Label data set with more descriptive variable names
colnames(extracted_combined_table) <- gsub("-X"," -X Axis", colnames(extracted_combined_table))
colnames(extracted_combined_table) <- gsub("-Y"," -Y Axis", colnames(extracted_combined_table))
colnames(extracted_combined_table) <- gsub("-Z"," -Z Axis", colnames(extracted_combined_table))
colnames(extracted_combined_table) <- gsub("fBody","Freq of Body", colnames(extracted_combined_table))
colnames(extracted_combined_table) <- gsub("tBody","Time of Body", colnames(extracted_combined_table))
colnames(extracted_combined_table) <- gsub("-mean()"," - Mean", colnames(extracted_combined_table))
colnames(extracted_combined_table) <- gsub("-meanFreq()"," - Mean Freq", colnames(extracted_combined_table))
colnames(extracted_combined_table) <- gsub("-std()"," Standard Deviation", colnames(extracted_combined_table))

## Use dplyr to summarise data by Subject then by Activity
new_summarised_data <- extracted_combined_table %>%
group_by(Subject,Label) %>%
summarise_each(funs(mean))

print(new_summarised_data)

write.table(new_summarised_data, file="Tidy Data Set.txt", row.names = FALSE)