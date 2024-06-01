#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: No input .ph2 file provided"
    exit 1
fi

ph2_input_file="$1"
if [ ! -f "$ph2_input_file" ]; then
    echo "Error: The file '$ph2_input_file' does not exist"
    exit 1
fi

if [ ! -f "setup" ]; then
    echo "Pulling and building semaphore-phase2-setup"
    git clone https://github.com/irfanbozkurt/semaphore-phase2-setup.git
    cd semaphore-phase2-setup
    go build
    cd ..
    mv semaphore-phase2-setup/semaphore-phase2-setup ./setup
    rm -rf semaphore-phase2-setup
    echo ""
fi

if [ -n "$2" ]; then
    output_file="$2"
else
    output_file="output.ph2"
fi

echo "Performing a contribution"
./setup p2c "$ph2_input_file" "$output_file"
echo ""

rm setup

