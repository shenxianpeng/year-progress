#!/bin/bash

##############################################
# get passed days and whole days of the year #
##############################################
today=$(date +'%e %b')
start_of_this_year='01 Jan'
end_of_this_year='31 Dec'

date_diff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    days=$(( (d1 - d2) / 86400 ))
    echo $days
}

year_pass_days=$( date_diff "$today" "$start_of_this_year" )
whole_year_days=$( date_diff "$end_of_this_year" "$start_of_this_year" )

##############################################################
# get the percent of passed year, and generate progress bar. #
##############################################################
# this also works. but some OS may not exist dc command
# progress_of_this_year=$(echo 2k $year_pass_days $whole_year_days /p | dc)
progress_of_this_year=$(echo $(( 100 * $year_pass_days / $whole_year_days )) | sed 's/..$/.&/')
tmp_percent=$(echo "scale=4; $year_pass_days / $whole_year_days" | bc)
percent_of_this_year=$(echo "scale=2; ($tmp_percent * 100)/1" | bc)

bar_capacity=30
tmp=$(echo "$progress_of_this_year * $bar_capacity" | bc)

# remove two digits behind the decimal point
passed_progress_bar_index=${tmp%.*}
left_progress_bar_index=$(echo "30 - $passed_progress_bar_index" | bc)


#########################
# generate progress bar #
#########################
left_bar_str="█"
for (( i=1; i <= $passed_progress_bar_index; i++ ))
do
    new_left_bar+="${left_bar_str}"
done

right_bar_str="_"
for (( i=1; i <= $left_progress_bar_index; i++ ))
do
    new_right_bar+="${right_bar_str}"
done

whole_bar="{ $new_left_bar$new_right_bar } $percent_of_this_year %"

############################################
# update new content to the readme.md file #
############################################
update_time=$(date '+%Y-%m-%d %H:%M:%S')

README="### Hi there 👋\n\n⏳ Year progress $whole_bar\n\n⏰ Updated on $update_time with Shell.\n\n![build](https://github.com/shenxianpeng/shenxianpeng/workflows/build/badge.svg)"

echo "" > README.md
echo -e $README >> README.md