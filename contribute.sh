#!/bin/bash

# Check if Go is installed
if ! command -v go &>/dev/null; then
    echo "Go is not installed."
    echo "Please install Go and try again."
    exit 1
fi

# Check if the semaphore-mtb-setup folder exists
if [ ! -d "semaphore-mtb-setup" ]; then
    git clone https://github.com/worldcoin/semaphore-mtb-setup.git
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
echo "Downloading all contribution files, they are large, this will take a while depending on your internet connection speed (gigabit speed recommended)..."

# Download insertion files
echo "Downloading insertion files..."
curl --output "insertion_b10t30c$PREVIOUS_CONTRIBUTION_NUMBER.ph2" "$DOWNLOAD_INSERTION_B10T30"
curl --output "insertion_b100t30c$PREVIOUS_CONTRIBUTION_NUMBER.ph2" "$DOWNLOAD_INSERTION_B100T30"
curl --output "insertion_b600t30c$PREVIOUS_CONTRIBUTION_NUMBER.ph2" "$DOWNLOAD_INSERTION_B600T30"
curl --output "insertion_b1000t30c$PREVIOUS_CONTRIBUTION_NUMBER.ph2" "$DOWNLOAD_INSERTION_B1000T30"

# Download deletion files
echo "Downloading deletion files..."
curl --output "deletion_b10t30c$PREVIOUS_CONTRIBUTION_NUMBER.ph2" "$DOWNLOAD_DELETION_B10T30"
curl --output "deletion_b100t30c$PREVIOUS_CONTRIBUTION_NUMBER.ph2" "$DOWNLOAD_DELETION_B100T30"

# perform the contribution
echo "Contributing OS randomness to the ceremony..."

echo "Contributing to insertion circuits trusted setup (will take a long time, variable on hardware specs)..."

./semaphore-mtb-setup p2c insertion_b10t30c$PREVIOUS_CONTRIBUTION_NUMBER.ph2 insertion_b10t30c$CONTRIBUTION_NUMBER.ph2
./semaphore-mtb-setup p2c insertion_b100t30c$PREVIOUS_CONTRIBUTION_NUMBER.ph2 insertion_b100t30c$CONTRIBUTION_NUMBER.ph2
./semaphore-mtb-setup p2c insertion_b600t30c$PREVIOUS_CONTRIBUTION_NUMBER.ph2 insertion_b600t30c$CONTRIBUTION_NUMBER.ph2
./semaphore-mtb-setup p2c insertion_b1000t30c$PREVIOUS_CONTRIBUTION_NUMBER.ph2 insertion_b1000t30c$CONTRIBUTION_NUMBER.ph2

echo "Contributing to deletion circuits trusted setup (should take less, only two small circuits)..."

./semaphore-mtb-setup p2c deletion_b10t30c$PREVIOUS_CONTRIBUTION_NUMBER.ph2 deletion_b10t30c$CONTRIBUTION_NUMBER.ph2
./semaphore-mtb-setup p2c deletion_b100t30c$PREVIOUS_CONTRIBUTION_NUMBER.ph2 deletion_b100t30c$CONTRIBUTION_NUMBER.ph2

# Upload all contribution files
echo "Uploading insertion files (the faster the internet the better)..."

curl -v -T "insertion_b10t30c$CONTRIBUTION_NUMBER.ph2" "$UPLOAD_INSERTION_B10T30"
curl -v -T "insertion_b100t30c$CONTRIBUTION_NUMBER.ph2" "$UPLOAD_INSERTION_B100T30"
curl -v -T "insertion_b600t30c$CONTRIBUTION_NUMBER.ph2" "$UPLOAD_INSERTION_B600T30"
curl -v -T "insertion_b1000t30c$CONTRIBUTION_NUMBER.ph2" "$UPLOAD_INSERTION_B1000T30"

echo "Uploading deletion files..."

curl -v -T "deletion_b10t30c$CONTRIBUTION_NUMBER.ph2" "$UPLOAD_DELETION_B10T30"
curl -v -T "deletion_b100t30c$CONTRIBUTION_NUMBER.ph2" "$UPLOAD_DELETION_B100T30"
