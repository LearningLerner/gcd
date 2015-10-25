
# getting data from web
wwws <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

dest_f <- "./HARUSmartphone.zip"

if(!file.exists(dest_f)){
  print("Downloading .zip ...")
  download.file(wwws, destfile = dest_f, method="wget")
}else{
  print(paste(dest_f, " already exists."))
}

# unzipping
unzip(dest_f)

##############################
# 1 merging training and testing data sets

# merging x and y training
train_x <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_data_set <- cbind(train_x, train_y)

dim(train_x);dim(train_y);dim(train_data_set)

# merging x and y testing
test_x <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_data_set <- cbind(test_x, test_y)

dim(test_x);dim(test_y);dim(test_data_set)

# merging training and testing data sets
data_set <- as.data.frame(rbind(train_data_set, test_data_set))

# naming the columns
features <- read.table("./UCI HAR Dataset/features.txt")
names(data_set) <- features[,2]
colnames(data_set)[562] <- "y"


##############################
# 2 Extracting only the measurements on the mean and sd for each measurement

idx <- grep("mean|std", features[,2])
sub_data_set <- data_set[,c(idx, 562)]


##############################
# 3 Using descriptive activity names to name the activities in the data set

luActivity <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("id", "label"))

y <- sub_data_set$y
sub_data_set_y_meaningful <- sub_data_set
sub_data_set_y_meaningful$y <- luActivity[y,2]


##############################
# 4 Appropriately labels the data set with descriptive variable names
colnames(sub_data_set_y_meaningful)[80] <- "activity"
names(sub_data_set_y_meaningful)


##############################
# 5 2nd data set with the average of each variable for each activity and each subject

require(dplyr)
sds <- sub_data_set_y_meaningful

# adding subjects
subjects_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subjects_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subjects <- rbind(subjects_train, subjects_test)

sds_with_subjects <- cbind(sds, subjects)
colnames(sds_with_subjects)[81] <- "subject"

ds_avg <- aggregate(. ~ activity + subject, sds_with_subjects, mean)
dest_f_new_ds <- "new_data_set.txt"
write.table(ds_avg, dest_f_new_ds, row.names = FALSE)
