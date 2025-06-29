#!/bin/bash

# Check if AWS CLI is not configured
if [ -z "$(aws configure get aws_access_key_id 2>/dev/null)" ] || [ -z "$(aws configure get aws_secret_access_key 2>/dev/null)" ]; then
    echo "AWS CLI is not configured. Run aws configure and try again."
fi

# Check Python installation
if command -v python3 &>/dev/null; then
    if ! pip3 show "boto3" >/dev/null 2>&1; then
        pip3 install boto3
    fi
else
    echo "Python 3 is not installed."
    echo "Please install Python 3 and try again."
fi

if [ -e "keys" ]; then
    source keys
fi

# check if keys are set
if [ -z "AWS_ACCESS_KEY_ID" ]; then
    echo "You forgot to set your AWS_ACCESS_KEY_ID"
elif [ -z "AWS_SECRET_ACCESS_KEY" ]; then
    echo "You forgot to set your AWS_SECRET_ACCESS_KEY"
fi 


# Check if an argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <contribution number>"
    exit 1
fi

# Check if the argument is a number
if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Error: Argument supplied for contribution number is not a number"
    exit 1
fi

# Fetch the number
contribution_number=$1

previous_contribution_number=$(expr $contribution_number - 1)

echo "The contribution number provided is: $contribution_number"

echo "The previous contribution number is: $previous_contribution_number"

echo "Generating S3 URLs for downloading the previous contribution files..."

download_insertion_b4385t30a="insertion_b4385/insertion_b4385t30c$previous_contribution_number.ph2_parts_aa"
download_insertion_b4385t30b="insertion_b4385/insertion_b4385t30c$previous_contribution_number.ph2_parts_ab"
download_insertion_b4385t30c="insertion_b4385/insertion_b4385t30c$previous_contribution_number.ph2_parts_ac"
download_insertion_b4385t30d="insertion_b4385/insertion_b4385t30c$previous_contribution_number.ph2_parts_ad"


upload_insertion_b4385t30a="insertion_b4385/insertion_b4385t30c$contribution_number.ph2_parts_aa"
upload_insertion_b4385t30b="insertion_b4385/insertion_b4385t30c$contribution_number.ph2_parts_ab"
upload_insertion_b4385t30c="insertion_b4385/insertion_b4385t30c$contribution_number.ph2_parts_ac"
upload_insertion_b4385t30d="insertion_b4385/insertion_b4385t30c$contribution_number.ph2_parts_ad"


url_pattern='https://[^[:space:]]*'

echo "Generating presigned S3 URLs for downloading and uploading files..."

# Generate the presigned URL for downloading the files from S3
download_insertion_b4385t30a_url=$(python3 upload.py $download_insertion_b4385t30a get | grep -o $url_pattern)
download_insertion_b4385t30b_url=$(python3 upload.py $download_insertion_b4385t30b get | grep -o $url_pattern)
download_insertion_b4385t30c_url=$(python3 upload.py $download_insertion_b4385t30c get | grep -o $url_pattern)
download_insertion_b4385t30d_url=$(python3 upload.py $download_insertion_b4385t30d get | grep -o $url_pattern)

# Generate the presigned URL for uploading the files to S3
upload_insertion_b4385t30a_url=$(python3 upload.py $upload_insertion_b4385t30a put | grep -o $url_pattern)
upload_insertion_b4385t30b_url=$(python3 upload.py $upload_insertion_b4385t30b put | grep -o $url_pattern)
upload_insertion_b4385t30c_url=$(python3 upload.py $upload_insertion_b4385t30c put | grep -o $url_pattern)
upload_insertion_b4385t30d_url=$(python3 upload.py $upload_insertion_b4385t30d put | grep -o $url_pattern)

# filename for contribution info
urls="contribution.env"

echo "Saving the URLs to $urls file..."

# Save the URLs as env vars to a file
output="# download urls
DOWNLOAD_INSERTION_B4385T30A='$download_insertion_b4385t30a_url'
DOWNLOAD_INSERTION_B4385T30B='$download_insertion_b4385t30b_url'
DOWNLOAD_INSERTION_B4385T30C='$download_insertion_b4385t30c_url'
DOWNLOAD_INSERTION_B4385T30D='$download_insertion_b4385t30d_url'

# upload urls
UPLOAD_INSERTION_B4385T30A='$upload_insertion_b4385t30a_url'
UPLOAD_INSERTION_B4385T30B='$upload_insertion_b4385t30b_url'
UPLOAD_INSERTION_B4385T30C='$upload_insertion_b4385t30c_url'
UPLOAD_INSERTION_B4385T30D='$upload_insertion_b4385t30d_url'

# metadata
CONTRIBUTION_NUMBER='$contribution_number'
PREVIOUS_CONTRIBUTION_NUMBER='$previous_contribution_number'
"

echo "$output" > $urls



