#!/bin/bash

totalline(){
	sum=0
	for file in `ls *.[ch]`
	do
    	lines=`awk 'END{ print NR; }' ./$file`
    let "sum+=lines"
	done
	echo "totalline:$sum" >> ./output_info/statics.txt
}

recurrence(){
	cd $1
	for file in `ls`
	do
		if [ -d $file ]
			then
			recurrence $file
		elif [ $file == "test.sh" ]
			then
			make clean
			rm -rf klee* output_info result.txt
			make
			./$file
			totalline
			pwd | awk -F"/" '{ printf("name:%s\n",$NF); }' >> ./output_info/statics.txt
			sleep 1
			rm -rf klee*
			make clean
		fi
	done

	cd ..
}

recurrence "."
