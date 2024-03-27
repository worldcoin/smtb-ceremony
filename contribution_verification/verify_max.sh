#!/bin/bash
#
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

contribution_number=$1

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

# download last contribution files for all six circuits
echo "Downloading contributions"

curl --output insertion_b4385t30c${contribution_number}.ph2_parts_aa https://semaphore-mtb-trusted-setup-ceremony.s3.amazonaws.com/insertion_b4385/insertion_b4385t30c${contribution_number}.ph2_parts_aa
curl --output insertion_b4385t30c${contribution_number}.ph2_parts_ab https://semaphore-mtb-trusted-setup-ceremony.s3.amazonaws.com/insertion_b4385/insertion_b4385t30c${contribution_number}.ph2_parts_ab
curl --output insertion_b4385t30c${contribution_number}.ph2_parts_ac https://semaphore-mtb-trusted-setup-ceremony.s3.amazonaws.com/insertion_b4385/insertion_b4385t30c${contribution_number}.ph2_parts_ac
curl --output insertion_b4385t30c${contribution_number}.ph2_parts_ad https://semaphore-mtb-trusted-setup-ceremony.s3.amazonaws.com/insertion_b4385/insertion_b4385t30c${contribution_number}.ph2_parts_ad

cat insertion_b4385t30c${contribution_number}.ph2_parts_aa insertion_b4385t30c${contribution_number}.ph2_parts_ab insertion_b4385t30c${contribution_number}.ph2_parts_ac insertion_b4385t30c${contribution_number}.ph2_parts_ad> insertion_b4385t30c${contribution_number}.ph2

# download zeroeth contribution files for all six circuits
echo "Downloading zeroeth contribution files"

curl --output insertion_b4385t30c0.ph2 https://semaphore-mtb-trusted-setup-ceremony.s3.amazonaws.com/insertion_b4385/insertion_b4385t30c0.ph2

# verify the integrity of the contributions
echo "Verifying integrity of the contribution"

cd semaphore-mtb-setup
./semaphore-mtb-setup* p2v ../insertion_b4385t30c${contribution_number}.ph2 ../insertion_b4385t30c0.ph2

echo "You can check that the outputted hashes match the ones located in the text files in the contribution_verification folder."

echo "creating folders to host proving and verifying keys"

mkdir insertion_b4385

mv insertion_b4385t30c${contribution_number}.ph2 insertion_b4385

# Check if the gnark-contract-generator folder exists
if [ ! -d "gnark-contract-generator" ]; then
   git clone https://github.com/worldcoin/gnark-contract-generator.git
   cd gnark-contract-generator
   go build
   cd ..
fi

echo "generating proving and verifying key from the trusted setup files"

cd insertion_b4385
../semaphore-mtb-setup/semaphore-mtb-setup* key insertion_b4385t30c${contribution_number}.
../gnark-contract-generator/gnark-contract-generator* ps-vk --vk vk --out insertion_b4385t30_verifier.sol
cd ..
