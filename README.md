# gettingAndCleaning-Data

We get the location of UCI HAR Dataset and list all the files/folders in it using list.files().
We obsereve that the files are listed first and then the folders are listed. The path of the test and train directores are stored.

The files in the test and train directories are listed. We determine if the subdirectories are seperated by "/" or "\".
And split the path at the appropriate slash and store the results in a list.The last element of the list is comapred with the corresponding element in test/train folder.

The Inertial Signal folder is not considered according to the question.

The rows are joined using rbind.The columns names of one among the two data frames is renamed ,so that rbind operation can be applied.Then cbind is applied to join the different data frames.

In the end we obtain a single data frame which has all the elements from the test and train folders
