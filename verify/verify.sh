#!/bin/bash

$bucket_name="phase2-ceremony-files"

# Check if Go is installed
if ! command -v go &>/dev/null; then
   echo "Go is not installed."
   echo "Please install Go and try again."
   exit 1
fi

# Check if git is installed
if ! git --version 2>&1 >/dev/null ; then 
   echo "Git is not installed."
   echo "Please install Git and try again."
   exit 1
fi

# Check provided contribution number
if ! [[ "$1" =~ ^[0-9]+$ ]] || (( $1 > 0 )); then
    echo "Error: Contribution number must be an integer > 0"
    echo "You provided: $1"
    exit 1
fi
$contribution_to_verify="output_$1.ph2"
$minus_one=$(($contribution_to_verify - 1))
$previous_contribution="output_$minus_one.ph2"

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

# Download the two contributions
echo "Downloading the artifacts..."
(curl --output $contribution_to_verify https://$bucket_name.s3.amazonaws.com/$contribution_to_verify &)
(curl --output $previous_contribution https://$bucket_name.s3.amazonaws.com/$previous_contribution &)
wait
echo ""

# Verify
echo "Verifying the contribution"
./gnark-phase2-mpc-wrapper-executable p2v $contribution_to_verify $previous_contribution
echo ""

# Ask the user if they want to delete the artifacts
echo "Process done. Delete the artifacts? (y/n)"
read answer
if [ "$answer" = "y" ]; then
    rm gnark-phase2-mpc-wrapper-executable $contribution_to_verify $previous_contribution
fi
