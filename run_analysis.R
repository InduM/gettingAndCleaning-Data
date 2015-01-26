
run_analysis<- function(directory)
{																	
	list_files <-list.files(directory,full.names=TRUE)		# listing all files in UCI HAR Dataset directory
	
	test_d = list_files[5]				              					# the test files directory
	train_d = list_files[6]									              # the train files directory

	train_files <-list.files( train_d,full.names=TRUE )		# contains list of files in test working directory
	test_files <-list.files(test_d,full.names=TRUE)  		  # contains list of files in train working directory
	
	split="/"                     												# assuming that the os is windows and path is seperated by /
	another_test = strsplit(test_d,split)				        	# splitting the path at the occurances of "/" and each level is stores 
															                          # as a character string in the character list
															
	another_test = c(do.call("cbind",another_test))	      # using strsplit converts vector to list . So,
	                                                      #changing back the list to vector 
	if(another_test[1] == test_d[1])        				  		#checking if it uses a windows/ mac operating system
	{
		split = "\\"	                    									# actually "\" , using extra slash for escape sequence
	
	}
								
	
	for( i in 1:length(test_files))
	{
		split_test = strsplit(test_files[i],split)			    # split the directory
		
		split_test = c(do.call("cbind",split_test))		  	  # using strsplit converts vector to list .
															                          # So, changing back the list to vector
		
		if( tail(split_test,1)==  "Inertial Signals" )		# excluding the Inertial Signals directory for this analysis
				break			
		
		split_test[length(split_test)] = 
		gsub("_test", "", tail(split_test,1), ignore.case = 
		FALSE, perl = FALSE,fixed = FALSE, useBytes = FALSE)
															                        # removing _test from the files so that it can be matched with 
															                        #the corresponding file in train by removing _train
		
		
		data = data.frame()
		data_final = data.frame()
		for( j in 1:length(train_files) )
		{
			split_train = strsplit(train_files[j],split)	# split the directory
		
			split_train = c(do.call("cbind",split_train))	# using strsplit converts vector to list . So, changing back the 
															#list to vector 

			split_train[length(split_train)] =
				gsub("_train", "", tail(split_train,1),
					ignore.case = FALSE, perl = FALSE,
					fixed = FALSE, useBytes = FALSE)
															                   # removing "_train" from the files ,so that it can be matched
															                   #with the corresponding file in test folder by removing _test
			
			if(tail(split_test,1) == tail(split_train,1) ) 	# comparing if the files names are the same 
			{
				data1 <- read.csv(test_files[i], header = TRUE)			#opening a  connection to i th test file
				data2 <- read.csv(train_files[j], header = TRUE)		#opening a  connection to j th train file
				
				for( k in 1:ncol(data1) )
				{
					colnames(data1)[k] <- colnames(data2)[k]			# renaming the columns of data2 i.e train so that rbind can be performed
				}
			
				
				data<- rbind(data1,data2) 								      # rowbinding
				if(i==2)
					data_final = data						
				if(i!=2)	
					data_final = cbind( data_final ,data)				#column binding,At the end of the iteration we get the rows and columns of
																		                  #data sets at test and train folders as one data set
			}	
		}	
	}
}	
