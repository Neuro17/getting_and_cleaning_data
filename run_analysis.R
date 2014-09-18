if(!file.exists("./data.zip")){
        url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        dest = "./data.zip"
        download.file(url = url, destfile = dest, method = "curl")
}
if(!file.exists("./UCI HAR Dataset/")){
        unzip("./data.zip", exdir = "./")
}

# collecting all the informations about test
rawTest <- read.table(file = "./UCI HAR Dataset//test//X_test.txt", header = F)
rawTest[,562] <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt", header = F)
rawTest[,563] <- read.table(file = "./UCI HAR Dataset/test/y_test.txt", header = F)

# collecting all the informations about test
rawTrain <- read.table(file = "./UCI HAR Dataset//train//X_train.txt", header = F)
rawTrain[,562] <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt", header = F)
rawTrain[,563] <- read.table(file = "./UCI HAR Dataset/train/y_train.txt", header = F)

# merging test and train
rawdata <- rbind(rawTrain, rawTest)

#naming columns
features <- read.table(file = "./UCI HAR Dataset/features.txt", header = F)
features$V2 <- gsub("[()]", "", features$V2)
features$V2 <- tolower(features$V2)
colnames(rawdata) <- c(as.character(features$V2), "subject", "activity")

#extracting only the measurements we want
col <- grep(pattern = "*mean*", x = colnames(rawdata))
col <- c(col, grep(pattern = "*std*", x = colnames(rawdata)), 562, 563)
rawdata <- rawdata[, col]

# Loading labels
activityLabels <- read.table(file = "./UCI HAR Dataset/activity_labels.txt", header = F)

#I substitute the number 1:6 with corresponding activity labels
for(i in 1:dim(activityLabels)[1]){
        rawdata$activity <- gsub(i, activityLabels[i,2], x = rawdata$activity)
}
#factor transformation
rawdata$subject <- as.factor(rawdata$subject)
rawdata$activity <- as.factor(rawdata$activity)

#tidy data
tidy <- aggregate(rawdata, by = list(activity = rawdata$activity, subject = rawdata$subject), FUN = mean)
#remove subject and activity columns
tidy <- tidy[, 1:88]
#output file
write.table(x = tidy, file = "tidy.txt", row.names = F)