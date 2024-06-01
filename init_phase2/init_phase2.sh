#!/bin/bash

r1cs_file=$1

if [ -z "$r1cs_file" ]; then
    echo "Error: No .r1cs file provided"
    exit 1
fi

if [ ! -f "$r1cs_file" ]; then
    echo "Error: File $r1cs_file does not exist"
    exit 1
fi

# Check given power of tau
if ! [[ "$2" =~ ^[0-9]+$ ]] || (( $2 < 10 )) || (($2 > 28)); then
    echo "Error: Power of tau must be a number >= 10 and <= 28"
    echo "You entered \$2"
    exit 1
fi
# Check if the phase1 ceremony file exists
if [ ! -f "$2.ptau" ]; then
    echo "Downloading phase1 ceremony for 2^$2"
    curl --output $2.ptau https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_$2.ptau
    echo ""
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

echo "Initializing phase2 ceremony"
./gnark-phase2-mpc-wrapper-executable p2n $2.ptau $r1cs_file output_0.ph2
echo ""

rm gnark-phase2-mpc-wrapper-executable
