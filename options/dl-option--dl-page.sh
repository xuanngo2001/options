#!/bin/bash
set -e
# Description: Download option webpage date.
script_name=$(basename "${0}")


symbol=$1
expire_date=$2

# Error handling.
    cmd_msg=$(printf "%s \n%s \n " \
                    "  e.g.: ./${script_name} symbol expired_date" \
                    "  e.g.: ./${script_name} %5EVIX 2019-04-10" \
            )
    if [ -z "${symbol}" ]; then
        echo "Error: Symbol is required. Aborted!"
        echo "${cmd_msg}"
        exit 1;
    fi

    if [ -z "${expire_date}" ]; then
        echo "Error: Expired date is required. Aborted!"
        echo "${cmd_msg}"
        exit 1;
    fi

# Construct URL.
    timestamp=$(date -d "${expire_date} -4 hours" +'%s')
    url="https://finance.yahoo.com/quote/${symbol}/options?p=${symbol}&date=${timestamp}"

# Construct output_filename.
    base_dir=optionprices
        mkdir -p "${base_dir}"
    
    # If Sat or Sun, then set to Fri.
    date_string=$(date +"%Y-%m-%d")
    day_of_week=$(date +%u)
    if [ "${day_of_week}" -eq 6 ] || ["${day_of_week}" -eq 7 ]; then
        date_string=$(date -d "last Friday" +"%Y-%m-%d")
    fi
    
    output_filename=${base_dir}/$(echo "${symbol}" | sed 's/%5E//')_${expire_date}__${date_string}.html

# Download.
    echo "Download ${url}"
    echo "  => ./${output_filename}"
#    wget -q "${url}" -O "${output_filename}"