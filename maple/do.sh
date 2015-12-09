#!/bin/bash

getmemory(){
	sleep 0.01
	for file in `ls /proc/`
	do
		if [ -d /proc/$file ]
			then
			cmd=`awk '{ print $1; }' /proc/${file}/comm`
			if [ $cmd == "maple" ]
				then
				temp=`awk -F" " '{ print ($2-$3)*4; }' /proc/${file}/statm`
				mem=0
				while [[ -n $temp ]]
				do
					if [ $temp -gt $mem ]
						then
						mem=$temp
					fi
					temp=`awk -F" " '{ print ($2-$3)*4; }' /proc/${file}/statm`
				done
				sleep 0.5
				echo " $mem" >> ${all}/DATE.txt
				break
			fi
		fi
	done
}

getmaple(){
	lines=`awk 'END{ print NR; }' ./result.txt`
	awk -F" " '{ if( NR == '$lines'-6 ){ printf("%s%s%s ",$3,$4,$5); } else if( NR >= '$lines'-4 ){ printf("%s ",$3); } }' ./result.txt >> ${all}/DATE.txt
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
			make
			for((i=0;i<30;i++))
			do 
				j=`expr $i % 3`
				if [ $j -eq 0 ]	
					then 			
					rm coverage iroot.db memo.db pct.histo sinfo.db sinst.db stat.out test.histo result.txt
				fi
				getmemory &
				./$file
				pwd | awk -F"/" '{ printf("%s ",$NF); }' >> ${all}/DATE.txt
				getmaple
				sleep 1

			done
		fi
	done

	cd ..
}

all=$PWD
rm ${all}/DATE.txt
recurrence "."
