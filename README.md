# gcd

This repository contains the run_analysis.R code that downloads, merges and does the data manipulations necessary to deliver a data set able to be used in posterior analysis tasks.

The script runs essentially in 5 blocks. 

First, the data is downloaded and saved in the computer that runs the script.

Second, the training and testing datasets are merged. The training data set was compounded by merging the X_train.txt and y_train.txt files given in the /UCI Har Dataset/train directory. The testing data set, by merging the X_test.txt and y_test.txt files given in the /UCI Har Dataset/test directory. The columns were renamed after the information given in /UCI Har Dataset/features.txt.

Third, the columns which refered to mean and standard deviation are selected, resulting in a subset with 80 columns.

After that, the values of the column "activity" were replaced by a more meaningful value corresponding the description of the activity coded in /UCI Har Dataset/activity_labels.txt. Besides this, a more meaningful name is used for the column referring to the activities. "y" is renamed to "activity".

Finally, a new data set is formatted, indicanting for each possible combination of activity and subject the average value of each measurement.


