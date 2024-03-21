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

# Download insertion file
echo "Downloading insertion files..."

baseUrl="https://semaphore-mtb-trusted-setup-ceremony.s3.amazonaws.com/insertion_b4385"
prefix="insertion_b4385t30c${PREVIOUS_CONTRIBUTION_NUMBER}.ph2"
suffix="_parts_a"

for part in {a..d}; do
  url="${baseUrl}/${prefix}${suffix}${part}"
  echo "Downloading part: ${part}..."
  curl --output "insertion_b4385t30c$PREVIOUS_CONTRIBUTION_NUMBER.ph2${suffix}${part}" "${url}"
done

parts=""

for part in {a..d}; do
  parts="${parts} insertion_b4385t30c$PREVIOUS_CONTRIBUTION_NUMBER.ph2${suffix}${part}"
done

cat ${parts} > "insertion_b4385t30c$PREVIOUS_CONTRIBUTION_NUMBER.ph2"

# perform the contribution
echo "Contributing to the max insertion batch size circuit..."

./semaphore-mtb-setup* p2c "insertion_b4385t30c${PREVIOUS_CONTRIBUTION_NUMBER}.ph2" insertion_b4385t30c${CONTRIBUTION_NUMBER}.ph2 > contribution.log

split -n 4 "insertion_b4385t30c$CONTRIBUTION_NUMBER.ph2" "insertion_b4385t30c$CONTRIBUTION_NUMBER.ph2_parts_"

# Upload all contribution files
echo "Uploading insertion files (the faster the internet the better)..."

curl -v -T "insertion_b4385t30c$CONTRIBUTION_NUMBER.ph2_parts_aa" "$UPLOAD_INSERTION_B4385T30A"
curl -v -T "insertion_b4385t30c$CONTRIBUTION_NUMBER.ph2_parts_ab" "$UPLOAD_INSERTION_B4385T30B"
curl -v -T "insertion_b4385t30c$CONTRIBUTION_NUMBER.ph2_parts_ac" "$UPLOAD_INSERTION_B4385T30C"
curl -v -T "insertion_b4385t30c$CONTRIBUTION_NUMBER.ph2_parts_ad" "$UPLOAD_INSERTION_B4385T30D"

echo "The contribution has completed successfully! Thank you for participating in the ceremony!"
