#!/bin/bash
#
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
echo "Downloading last contribution files for all six circuits..."
wget https://semaphore-mtb-trusted-setup-ceremony.s3.amazonaws.com/deletion_b10/deletion_b10t30c16.ph2
wget https://semaphore-mtb-trusted-setup-ceremony.s3.amazonaws.com/deletion_b100/deletion_b100t30c16.ph2
wget https://semaphore-mtb-trusted-setup-ceremony.s3.amazonaws.com/insertion_b10/insertion_b10t30c16.ph2
wget https://semaphore-mtb-trusted-setup-ceremony.s3.amazonaws.com/insertion_b100/insertion_b100t30c16.ph2
#wget https://semaphore-mtb-trusted-setup-ceremony.s3.amazonaws.com/insertion_b600/insertion_b600t30c16.ph2
wget https://semaphore-mtb-trusted-setup-ceremony.s3.amazonaws.com/insertion_b1200/insertion_b1200t30c16.ph2_parts_aa
wget https://semaphore-mtb-trusted-setup-ceremony.s3.amazonaws.com/insertion_b1200/insertion_b1200t30c16.ph2_parts_ab

cat insertion_b1200t30c16.ph2_parts_aa insertion_b1200t30c16.ph2_parts_ab > insertion_b1200t30c16.ph2

# download zeroeth contribution files for all six circuits
echo "Downloading zeroeth contribution files for all six circuits..."

wget https://semaphore-mtb-trusted-setup-ceremony.s3.amazonaws.com/deletion_b10/deletion_b10t30c0.ph2
wget https://semaphore-mtb-trusted-setup-ceremony.s3.amazonaws.com/deletion_b100/deletion_b100t30c0.ph2
wget https://semaphore-mtb-trusted-setup-ceremony.s3.amazonaws.com/insertion_b10/insertion_b10t30c0.ph2
wget https://semaphore-mtb-trusted-setup-ceremony.s3.amazonaws.com/insertion_b100/insertion_b100t30c0.ph2
#wget https://semaphore-mtb-trusted-setup-ceremony.s3.amazonaws.com/insertion_b600/insertion_b600t30c0.ph2
wget https://semaphore-mtb-trusted-setup-ceremony.s3.amazonaws.com/insertion_b1200/insertion_b1200t30c0.ph2

# verify the integrity of the contributions
echo "Verifying integrity of the contributions..."

cd semaphore-mtb-setup
./semaphore-mtb-setup* p2v ../deletion_b10t30c16.ph2 ../deletion_b10t30c0.ph2
./semaphore-mtb-setup* p2v ../deletion_b100t30c16.ph2 ../deletion_b100t30c0.ph2
./semaphore-mtb-setup* p2v ../insertion_b10t30c16.ph2 ../insertion_b10t30c0.ph2
./semaphore-mtb-setup* p2v ../insertion_b100t30c16.ph2 ../insertion_b100t30c0.ph2
#./semaphore-mtb-setup* p2v ../insertion_b600t30c16.ph2 ../insertion_b600t30c0.ph2
./semaphore-mtb-setup* p2v ../insertion_b1200t30c16.ph2 ../insertion_b1200t30c0.ph2

echo "You can check that the outputted hashes match the ones located in the text files in the contribution_verification folder."

echo "creating folders to host proving and verifying keys"

mkdir deletion_b10
mkdir deletion_b100
mkdir insertion_b10
mkdir insertion_b100
mkdir insertion_b600
mkdir insertion_b1200

mv deletion_b10t30c16.ph2 deletion_b10
mv deletion_b100t30c16.ph2 deletion_b100
mv insertion_b10t30c16.ph2 insertion_b10
mv insertion_b100t30c16.ph2 insertion_b100
#mv insertion_b600t30c16.ph2 insertion_b600
mv insertion_b1200t30c16.ph2 insertion_b1200

# Check if the gnark-contract-generator folder exists
if [ ! -d "gnark-contract-generator" ]; then
   git clone https://github.com/worldcoin/gnark-contract-generator.git
   cd gnark-contract-generator
   go build
   cd ..
fi

echo "generating proving and verifying key from the trusted setup files"

cd deletion_b10
../semaphore-mtb-setup/semaphore-mtb-setup* key deletion_b10t30c16.ph2
../gnark-contract-generator/gnark-contract-generator* ps-vk --vk vk --out deletion_b10t30_verifier.sol
cd ..
cd deletion_b100
../semaphore-mtb-setup/semaphore-mtb-setup* key deletion_b100t30c16.ph2
../gnark-contract-generator/gnark-contract-generator* ps-vk --vk vk --out deletion_b100t30_verifier.sol
cd ..
cd insertion_b10
../semaphore-mtb-setup/semaphore-mtb-setup* key insertion_b10t30c16.ph2
../gnark-contract-generator/gnark-contract-generator* ps-vk --vk vk --out insertion_b10t30_verifier.sol
cd ..
cd insertion_b100
../semaphore-mtb-setup/semaphore-mtb-setup* key insertion_b100t30c16.ph2
../gnark-contract-generator/gnark-contract-generator* ps-vk --vk vk --out insertion_b100t30_verifier.sol
cd ..
#cd insertion_b600
#../semaphore-mtb-setup/semaphore-mtb-setup* key insertion_b600t30c16.ph2
#../gnark-contract-generator/gnark-contract-generator* ps-vk --vk vk --out insertion_b600t30_verifier.sol
#cd ..
cd insertion_b1200
../semaphore-mtb-setup/semaphore-mtb-setup* key insertion_b1200t30c16.
../gnark-contract-generator/gnark-contract-generator* ps-vk --vk vk --out insertion_b1200t30_verifier.sol
cd ..
