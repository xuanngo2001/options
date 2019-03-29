#!/bin/bash
set -e
# Description: Return a valid date from a holiday.
#   Update holidays.txt

input_date=$1

holiday_file=holidays.txt

valid_input_date=$(cat "${holiday_file}" | grep -v "^#" | grep "${input_date}" | cut -d '|' -f2 | xargs)

if [ -z "${valid_input_date}" ]; then
    echo "${input_date}"
else
    echo "${valid_input_date}"
fi