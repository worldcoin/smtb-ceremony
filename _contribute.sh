#!/bin/bash

# Check if Go is installed
if ! command -v go &>/dev/null; then
    echo "Go is not installed."
    echo "Please install Go and try again -> https://go.dev/doc/install"
    exit 1
fi

# Clone 
if [ ! -d "semaphore-mtb-setup" ]; then
    git clone https://github.com/irfanbozkurt/semaphore-mtb-setup.git
    cd semaphore-mtb-setup
    go build
    cd ..
fi

# check if s3_urls file exists
if [ -e "contribution.env" ]; then
    source contribution.env
else
    echo "contribution.env file does not exist. Ask the coordinator to give you the file by running generate_s3_urls.sh and try again."
    exit 1
fi

cd semaphore-mtb-setup

# Download all contribution files
echo "Downloading contribution files, they are large, this will take a while depending on your internet connection speed (gigabit speed recommended)..."

# Download insertion files
echo "Downloading insertion files..."
curl --output "insertion_b10t30c$PREVIOUS_CONTRIBUTION_NUMBER.ph2" "$DOWNLOAD_INSERTION_B10T30"

# perform the contribution
echo "Contributing OS randomness to the ceremony..."

./semaphore-mtb-setup* p2c deletion_b10t30c$PREVIOUS_CONTRIBUTION_NUMBER.ph2 deletion_b10t30c$CONTRIBUTION_NUMBER.ph2

# Upload all contribution files
echo "Uploading insertion files"

curl -v -T "insertion_b10t30c$CONTRIBUTION_NUMBER.ph2" "$UPLOAD_INSERTION_B10T30"

echo "The contribution has completed successfully! Thank you for participating in the ceremony!"
