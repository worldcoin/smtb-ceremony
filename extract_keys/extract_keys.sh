#!/bin/bash

$bucket_name="phase2-ceremony-files"

# Check the ptau file
if [ -z "$1" ]; then
    echo "Error: Ptau file must be provided as the first argument"
    exit 1
fi
ptau_file="$1"
if [ ! -f "$ptau_file" ]; then
    echo "Error: The file '$ptau_file' does not exist"
    exit 1
fi

# Check the phase2Evaluations file
if [ -z "$2" ]; then
    echo "Error: phase2 evaluations file must be provided as the second argument"
    exit 1
fi
phase2Evaluations="$2"
if [ ! -f "$phase2Evaluations" ]; then
    echo "Error: The file '$phase2Evaluations' does not exist"
    exit 1
fi

# Check the r1cs file
if [ -z "$3" ]; then
    echo "Error: r1cs file must be provided as the third argument"
    exit 1
fi
r1cs="$3"
if [ ! -f "$r1cs" ]; then
    echo "Error: The file '$r1cs' does not exist"
    exit 1
fi

# Check the ph2 file
# This input can be an integer or a file path. Download if it's an integer. 
if [ -z "$4" ]; then
    echo "Error: Last contribution must be provided as the fourth argument"
    exit 1
fi
latest_contribution="$4"
if [[ $latest_contribution =~ ^[0-9]+$ ]]; then
    echo "Downloading corresponding contribution file from the bucket"
    $latest_contribution="output_$4.ph2"
    curl --output $latest_contribution https://$bucket_name.s3.amazonaws.com/$latest_contribution
    echo ""
fi
if [ ! -f "$latest_contribution" ]; then
    echo "Error: The file '$latest_contribution' does not exist"
    exit 1
fi

# Check if gnark-phase2-mpc-wrapper executable exists
# Pull and build if not so
if [ ! -f "gnark-phase2-mpc-wrapper-executable" ]; then
    git clone https://github.com/irfanbozkurt/gnark-phase2-mpc-wrapper.git
    cd gnark-phase2-mpc-wrapper
    go mod tidy
    go build
    cd ..
    mv gnark-phase2-mpc-wrapper/gnark-phase2-mpc-wrapper ./gnark-phase2-mpc-wrapper-executable
    rm -rf gnark-phase2-mpc-wrapper
fi

# Extract pkey and vkey
echo "Extracting pkey and vkey"
./gnark-phase2-mpc-wrapper-executable extract-keys $ptau_file $latest_contribution $phase2Evaluations $r1cs
echo ""
