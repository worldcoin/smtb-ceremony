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

previous_contribution_number=$contribution_number

echo "The contribution number provided is: $contribution_number"

download_insertion_b10t30="insertion_b10/insertion_b10t30c$contribution_number.ph2"
download_insertion_b100t30="insertion_b100/insertion_b100t30c$contribution_number.ph2"
download_insertion_b600t30="insertion_b600/insertion_b600t30c$contribution_number.ph2"
download_insertion_b1200t30a="insertion_b1200/insertion_b1200t30c$contribution_number.ph2_parts_aa"
download_insertion_b1200t30b="insertion_b1200/insertion_b1200t30c$contribution_number.ph2_parts_ab"
download_deletion_b10t30="deletion_b10/deletion_b10t30c$contribution_number.ph2"
download_deletion_b100t30="deletion_b100/deletion_b100t30c$contribution_number.ph2"

((contribution_number++))

upload_insertion_b10t30="insertion_b10/insertion_b10t30c$contribution_number.ph2"
upload_insertion_b100t30="insertion_b100/insertion_b100t30c$contribution_number.ph2"
upload_insertion_b600t30="insertion_b600/insertion_b600t30c$contribution_number.ph2"
upload_insertion_b1200t30a="insertion_b1200/insertion_b1200t30c$contribution_number.ph2_parts_aa"
upload_insertion_b1200t30b="insertion_b1200/insertion_b1200t30c$contribution_number.ph2_parts_ab"
upload_deletion_b10t30="deletion_b10/deletion_b10t30c$contribution_number.ph2"
upload_deletion_b100t30="deletion_b100/deletion_b100t30c$contribution_number.ph2"

url_pattern='https://[^[:space:]]*'

echo "Generating presigned S3 URLs for downloading and uploading files..."

# Generate the presigned URL for downloading the files from S3
download_insertion_b10t30_url=$(python3 upload.py $download_insertion_b10t30 get | grep -o $url_pattern) 
download_insertion_b100t30_url=$(python3 upload.py $download_insertion_b100t30 get | grep -o $url_pattern)
download_insertion_b600t30_url=$(python3 upload.py $download_insertion_b600t30 get | grep -o $url_pattern)
download_insertion_b1200t30a_url=$(python3 upload.py $download_insertion_b1200t30a get | grep -o $url_pattern)
download_insertion_b1200t30b_url=$(python3 upload.py $download_insertion_b1200t30b get | grep -o $url_pattern)
download_deletion_b10t30_url=$(python3 upload.py $download_deletion_b10t30 get | grep -o $url_pattern)
download_deletion_b100t30_url=$(python3 upload.py $download_deletion_b100t30 get | grep -o $url_pattern)

# Generate the presigned URL for uploading the files to S3
upload_insertion_b10t30_url=$(python3 upload.py $upload_insertion_b10t30 put | grep -o $url_pattern)
upload_insertion_b100t30_url=$(python3 upload.py $upload_insertion_b100t30 put | grep -o $url_pattern)
upload_insertion_b600t30_url=$(python3 upload.py $upload_insertion_b600t30 put | grep -o $url_pattern)
upload_insertion_b1200t30a_url=$(python3 upload.py $upload_insertion_b1200t30a put | grep -o $url_pattern)
upload_insertion_b1200t30b_url=$(python3 upload.py $upload_insertion_b1200t30b put | grep -o $url_pattern)
upload_deletion_b10t30_url=$(python3 upload.py $upload_deletion_b10t30 put | grep -o $url_pattern)
upload_deletion_b100t30_url=$(python3 upload.py $upload_deletion_b100t30 put | grep -o $url_pattern)

# filename for contribution info
urls="contribution.env"

echo "Saving the URLs to $urls file..."

# Save the URLs as env vars to a file
output="# download urls
DOWNLOAD_INSERTION_B10T30='$download_insertion_b10t30_url'
DOWNLOAD_INSERTION_B100T30='$download_insertion_b100t30_url'
DOWNLOAD_INSERTION_B600T30='$download_insertion_b600t30_url'
DOWNLOAD_INSERTION_B1200T30A='$download_insertion_b1200t30a_url'
DOWNLOAD_INSERTION_B1200T30B='$download_insertion_b1200t30b_url'
DOWNLOAD_DELETION_B10T30='$download_deletion_b10t30_url'
DOWNLOAD_DELETION_B100T30='$download_deletion_b100t30_url'
# upload urls
UPLOAD_INSERTION_B10T30='$upload_insertion_b10t30_url'
UPLOAD_INSERTION_B100T30='$upload_insertion_b100t30_url'
UPLOAD_INSERTION_B600T30='$upload_insertion_b600t30_url'
UPLOAD_INSERTION_B1200T30A='$upload_insertion_b1200t30a_url'
UPLOAD_INSERTION_B1200T30B='$upload_insertion_b1200t30b_url'
UPLOAD_DELETION_B10T30='$upload_deletion_b10t30_url'
UPLOAD_DELETION_B100T30='$upload_deletion_b100t30_url'
# metadata
CONTRIBUTION_NUMBER='$contribution_number'
PREVIOUS_CONTRIBUTION_NUMBER='$previous_contribution_number'
"

echo "$output" > $urls



