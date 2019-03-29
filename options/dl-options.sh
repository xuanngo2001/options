#!/bin/bash
set -e
# Description: Download option webpages.
script_name=$(basename "${0}")


symbol=$1
num_weeks=$2
day_of_week=$3

# Error handling.
    cmd_msg=$(printf "%s \n%s \n " \
                    "  e.g.: ./${script_name} symbol num_of_weeks dayOfweek" \
                    "  e.g.: ./${script_name} %5EVIX 8 Wed" \
            )
    if [ -z "${symbol}" ]; then
        echo "Error: Symbol is required. Aborted!"
        echo "${cmd_msg}"
        exit 1;
    fi

    if [ -z "${num_weeks}" ]; then
        echo "Error: Number of weeks is required. Aborted!"
        echo "${cmd_msg}"
        exit 1;
    fi

    if [ -z "${day_of_week}" ]; then
        echo "Error: Expired day of week is required. Aborted!"
        echo "${cmd_msg}"
        exit 1;
    fi

# Download
	for ((i=1; i <= ${num_weeks} ; i++)); do
        
        expired_date=$(date -d "+${i} weeks ${day_of_week}" +"%Y-%m-%d")
        expired_date=$(./dl-option--get-valid-date-from-holiday.sh "${expired_date}")
        ./dl-option--dl-page.sh "${symbol}" "${expired_date}"
		let position+=1 # Same as 'i=i+1
	done
