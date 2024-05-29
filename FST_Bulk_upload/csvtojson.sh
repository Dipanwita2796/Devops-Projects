#!/bin/bash

input=$1
## takes the input parameter
[ -z $1 ] && echo "CSV file not found" && exit 1

##checks for input file. 2nd and 3rd && parts are checked only if the value of first part is 0

[ ! -e $input ] && echo "couldn't find $1" && exit 1
## checks for input file

read first_line < $input         ## read command reads the first line
index=0                 
attributes=`echo $first_line | awk -F, {'print NF'}`
lines=`cat $input | wc -l`      ## -l: count lines

while [ $index -lt $attributes ]
do
        head_array[$index]=$(echo $first_line | awk -v x=$(($index + 1)) -F"," '{print $x}')
        index=$(($index+1))
done


## creating the json file
ix=0
echo "{"
while [ $ix -lt $lines ]
do
        read each_line
		final_line=$(echo $each_line| awk -F'"' -v OFS='' '{ for (i=2; i<=NF; i+=2) gsub(",", "@", $i) } 1')
        if [ $ix -ne 0 ]; then
                d=0
                echo -n "{"
                while [ $d -lt $attributes ]
                do
                        each_element=$(echo $final_line | awk -v y=$(($d + 1)) -F"," '{print $y}')
						each_element_mod=$(echo $each_element | sed -e 's/ /_/g')
						if [ -z "$each_element_mod" ]
						then
							each_element1="-"
						else
							each_element1=$(echo $each_element_mod)
						fi
                        if [ $d -ne $(($attributes-1)) ]; then
                                echo -n ${head_array[$d]}":"$each_element1","
                        else
                                echo -n ${head_array[$d]}":"$each_element1
                        fi
                        d=$(($d+1))
                done
                if [ $ix -eq $(($lines-1)) ]; then
                        echo "}"
                else
                        echo "},"
                fi
        fi
        ix=$(($ix+1))
done < $input
echo "}"