# Semaphore Merkle Tree Batcher (semaphore-mtb) trusted setup ceremony

This repo contains the transcript of trusted setup ceremony for [Semaphore Merkle Tree Batcher](https://github.com/worldcoin/semaphore-mtb). Please see that repo for details.

If you want to read up more on what is a trusted setup and why it is a requirement for [zkSNARKs](https://zkhack.dev/2023/07/27/getting-started-in-zk/) (zero-knowledge proofs) that are non-universal like [groth16](https://eprint.iacr.org/2016/260) which is the proof system powering Semaphore and World ID, read:

- [Understanding Trusted Setups: A Guide - Panther Protocol](https://blog.pantherprotocol.io/a-guide-to-understanding-trusted-setups/#:~:text=A%20trusted%20setup%20is%20a,similar%20cryptographic%20protocols%20rely%20on.)
- [How do trusted setups work? - Vitalik Buterin](https://vitalik.ca/general/2022/03/14/trustedsetup.html)
- [On-Chain Trusted Setup Ceremony - a16z crypto](https://a16zcrypto.com/posts/article/on-chain-trusted-setup-ceremony/#section--1)
- [BGM17](https://eprint.iacr.org/2017/1050.pdf)

### Ceremony Specification

For the phase 1 contribution (a.k.a powers of tau ceremony) we are using the [Perpetual Powers of Tau ceremony](https://github.com/privacy-scaling-explorations/perpetualpowersoftau) (up to the 54th contribution) through the AWS S3 hosted bucket in the [snarkjs repo README](https://github.com/iden3/snarkjs/blob/master/README.md#7-prepare-phase-2). We built a [deserializer](https://github.com/worldcoin/ptau-deserializer) from the `.ptau` format into the `.ph1` format used by gnark and initialized a phase 2 using a fork ([semaphore-mtb-setup](https://github.com/worldcoin/semaphore-mtb-setup)) of a ceremony coordinator wrapper on top of gnark built by the [zkbnb team](https://github.com/bnb-chain/zkbnb-setup).

### Production

Deployed [`semaphore-mtb`](https://github.com/worldcoin/semaphore-mtb/) verifier contracts and their corresponding verifying keys can be found here:

- Batch size 10, tree depth 30: [Etherscan](https://etherscan.io/address/0x6e37bAB9d23bd8Bdb42b773C58ae43C6De43A590#code)
- Batch size 100, tree depth 30: [Etherscan](https://etherscan.io/address/0x03ad26786469c1F12595B0309d151FE928db6c4D#code)
- Batch size 1000, tree depth 30: [Etherscan](https://etherscan.io/address/0xf07d3efadD82A1F0b4C5Cc3476806d9a170147Ba#code)

### List of contributors

The list of participants in the trusted setup used in semaphore-mtb in production can be found in the [CONTRIBUTORS.md file](./CONTRIBUTORS.md).

### Verifying the ceremony

The trust assumptions of a trusted setup ceremony is that as long as 1 of the n participants is honest, the setup is secure. In this case, we have 14 participants and we can verify that the ceremony was performed correctly by checking that the verifying key generated in the ceremony is the same as the one used in the production contracts. If you want to check that 14 individuals did indeed contribute to the ceremony, you can check the [list of contributors](#list-of-contributors) above and verify that the contribution hashes match the ones in this [Github issue](https://github.com/worldcoin/smtb-ceremony/issues/2) where contributors posted their contributions from their own accounts.

We can verify the keys generated in this ceremony are being used in the production contracts we see above by following the rest of this section.

Download the contribution files (26.258 GB total) of the ceremony from AWS and verify the hashes match the ones that contributors have committed to publicly [here](https://github.com/worldcoin/smtb-ceremony/issues/2):

- [`b10t30c0.ph2 (50.6MB)`](https://wld-shareable-data-us-east-1.s3.amazonaws.com/b10t30c0.ph2)
- [`b10t30c14.ph2 (50.6MB)`](https://wld-shareable-data-us-east-1.s3.amazonaws.com/b10t30c14.ph2)
- [`evals10 (74.6MB)`](https://wld-shareable-data-us-east-1.s3.amazonaws.com/evals10)
- [`srs10.lag (160.MB)`](https://wld-shareable-data-us-east-1.s3.amazonaws.com/srs10.lag)
- [`b100t30c0.ph2 (419.2MB)`](https://wld-shareable-data-us-east-1.s3.amazonaws.com/b100t30c0.ph2)
- [`b100t30c14.ph2 (419.2MB)`](https://wld-shareable-data-us-east-1.s3.amazonaws.com/b100t30c14.ph2)
- [`evals100 (684.6MB)`](https://wld-shareable-data-us-east-1.s3.amazonaws.com/evals100)
- [`srs100.lag (1.3GB)`](https://wld-shareable-data-us-east-1.s3.amazonaws.com/srs100.lag)
- [`b1000t30c0.ph2 (3.5GB)`](https://wld-shareable-data-us-east-1.s3.amazonaws.com/b1000t30c0.ph2)
- [`b1000t30c14.ph2 (3.5GB)`](https://wld-shareable-data-us-east-1.s3.amazonaws.com/b1000t30c14.ph2)
- [`evals1000 (6.1GB)`](https://wld-shareable-data-us-east-1.s3.amazonaws.com/evals1000)
- [`srs1000.lag (10.0GB)`](https://wld-shareable-data-us-east-1.s3.amazonaws.com/srs1000.lag)

Create a directory for each different batch size like so:

```bash
mkdir b10 b100 b1000
```

Move the files into their respective directories:

```bash
# b10
mv b10t30c0.ph2 b10/
mv b10t30c14.ph2 b10/
mv evals10 b10/evals
mv srs10.lag b10/srs.lag
# b100
mv b100t30c0.ph2 b100/
mv b100t30c14.ph2 b100/
mv evals100 b100/evals
mv srs100.lag b100/srs.lag
# b1000
mv b1000t30c0.ph2 b1000/
mv b1000t30c14.ph2 b1000/
mv evals1000 b1000/evals
mv srs1000.lag b1000/srs.lag
```

Verify the hashes match using `semaphore-mtb-setup`:

Download [`semaphore-mtb-setup`](https://github.com/worldcoin/semaphore-mtb-setup).

> [!NOTE]
> You need [git](https://git-scm.com/) and the Go language [installed](https://golang.org/doc/install) to build the tool.

```bash
git clone https://github.com/worldcoin/semaphore-mtb-setup
cd semaphore-mtb-setup && go build -v
# copy the executable into each respective directory
cp semaphore-mtb-setup ../b10
cp semaphore-mtb-setup ../b100
cp semaphore-mtb-setup ../b1000
```

Run trusted setup ceremony coordinator tool verification command on the trusted setup output files.

```bash
cd ../b10
./semaphore-mtb-setup p2v b10t30c14.ph2 b10t30c0.ph2
cd ../b100
./semaphore-mtb-setup p2v b100t30c14.ph2 b100t30c0.ph2
cd ../b1000
./semaphore-mtb-setup p2v b1000t30c14.ph2 b1000t30c0.ph2
```

After we verify everything went correctly we extract the proving and verifying keys from the setup using the following commands:

> [!IMPORTANT]
> In order to run the `key` command we need the respective `evals` and `srs.lag` files we downloaded above to exist in the directory we execute `semaphore-mtb-setup` from. The commands below are quite computationally expensive and will run for a while

```bash
cd ../b10
./semaphore-mtb-setup key b10t30c14.ph2
cd ../b100
./semaphore-mtb-setup key b100t30c14.ph2
cd ../b1000
./semaphore-mtb-setup key b1000t30c14.ph2
```

This command will generate the `pk` (proving key) and `vk` (verification key) files respectively.

The proving key (`pk` file) is used inside of the [`semaphore-mtb`](https://github.com/worldcoin/semaphore-mtb) service which is running `gnark` and there is no straightforward way to verify that the production deployment of the service is using the proving key generated in this ceremony. However, we can infer that the correct proving key is being used because it would be computationally infeasible to generate a valid proof for the on-chain verifiers otherwise.

### Verifying the verifier contracts using `semaphore-mtb`

Dowload `semaphore-mtb`, checkout the right branch, and build the tool:

```bash
git clone https://github.com/worldcoin/semaphore-mtb
cd semaphore-mtb
git checkout dcbuid3r/import-mpc-phase2
go build -v
```

### Testing semaphore-mtb end-to-end

Now that we have `pk` and `vk` files for each circuit from previous steps, let's generate a `semaphore-mtb` gnark proving system, generate some test parameters, generate a proof and test whether they verify!

Now let's generate the gnark proving systems from each of the respective `vk` and `pk` pairs:

```bash
# Clone and build semaphore-mtb, then:
./gnark-mbu import-setup --batch-size 10 --tree-depth 30 --pk ../b10/pk --vk ../b10/vk --output ../b10/ps
./gnark-mbu import-setup --batch-size 100 --tree-depth 30 --pk ../b100/pk --vk ../b100/vk --output ../b100/ps
./gnark-mbu import-setup --batch-size 1000 --tree-depth 30 --pk ../b1000/pk --vk ../b1000/vk --output ../b1000/ps
```

`ps` is the proving system represented as a file which we'll now use to generate sample proofs for test input parameters:

![](https://hackmd.io/_uploads/rkCJU17Y2.png)

Next let's generate some test parameters and generate a sample proof using our new `ps` proof systems and write it as json to a file:

```bash
./gnark-mbu gen-test-params --batch-size 10 --tree-depth 30 > ../b10/params.json
cat ../b10/params.json | ./gnark-mbu prove --keys-file ../b10/ps > ../b10/proof10.json
./gnark-mbu gen-test-params --batch-size 100 --tree-depth 30 > ../b100/params.json
cat ../b100/params.json | ./gnark-mbu prove --keys-file ../b100/ps > ../b100/proof100.json
./gnark-mbu gen-test-params --batch-size 1000 --tree-depth 30 > ../b1000/params.json
cat ../b1000/params.json | ./gnark-mbu prove --keys-file ../b1000/ps > ../b1000/proof1000.json
```

And the last step is to verify the proof!

> Install [yq](https://github.com/mikefarah/yq/#install) to help with parsing json

```bash
# grab the input hash from the params.json using yq
yq e ".inputHash" ../b10/params.json
# verify proof
cat ../b10/proof10.json | ./gnark-mbu verify --input-hash <INPUT_HASH> --keys-file ../b10/ps
yq e ".inputHash" ../b100/params.json
cat ../b100/proof100.json | ./gnark-mbu verify --input-hash <INPUT_HASH> --keys-file ../b100/ps
yq e ".inputHash" ../b100/params.json
cat ../b1000/proof100.json | ./gnark-mbu verify --input-hash <INPUT_HASH> --keys-file ../b1000/ps
```

![](https://hackmd.io/_uploads/SJs55lmKn.png)

And the last step to verify the production deployment is to generate Solidity verifier contracts generated using our `ps` system. Using `semaphore-mtb` run:

```bash
./gnark-mbu export-solidity --keys-file ../b10/ps --output ../b10/verifier.sol
./gnark-mbu export-solidity --keys-file ../b100/ps --output ../b100/verifier.sol
./gnark-mbu export-solidity --keys-file ../b1000/ps --output ../b1000/verifier.sol
```

Now that you have the verifier contracts, you can verify that the bytecode of the `verifier.sol` contracts generated locally match the contracts deployed in production that can be found below when using the right `solc` compiler version and compilation parameters, these details can be found on the Etherscan verification page for each contract:

- Batch size 10, tree depth 30: [Etherscan](https://etherscan.io/address/0x6e37bAB9d23bd8Bdb42b773C58ae43C6De43A590#code)
- Batch size 100, tree depth 30: [Etherscan](https://etherscan.io/address/0x03ad26786469c1F12595B0309d151FE928db6c4D#code)
- Batch size 1000, tree depth 30: [Etherscan](https://etherscan.io/address/0xf07d3efadD82A1F0b4C5Cc3476806d9a170147Ba#code)

The key can be checked under the `verifyingKey()` internal function of the contract where we see the variables `alfa1`, `beta2`, `gamma2`, and `delta2` which correspond to the verifying keys generated above for each respective contract.

### System used for running the trusted setup ceremony

[AWS m5.16xlarge](https://aws.amazon.com/ec2/instance-types/m5/) instance

- 256 GiB RAM
- 64 cores
- 500 GiB Volume

### Pre-Contribution

The chain of commands that has been performed before the first contribution.

```bash
git clone https://github.com/worldcoin/semaphore-mtb-setup
git clone https://github.com/worldcoin/semaphore-mtb
```

Download the trusted setup ceremony coordinator tool and the powers of tau files.

```bash
cd semaphore-mtb-setup && go build -v

# Download Powers of Tau files for each respective circuit
wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_20.ptau
mv powersOfTau28_hez_final_20.ptau 20.ptau

wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_23.ptau
mv powersOfTau28_hez_final_23.ptau 23.ptau

wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_26.ptau
mv powersOfTau28_hez_final_26.ptau 26.ptau

# Convert .ptau format into .ph1
./semaphore-mtb-setup p1i 20.ptau 20.ph1
./semaphore-mtb-setup p1i 23.ptau 23.ph1
./semaphore-mtb-setup p1i 26.ptau 26.ph1

# go up a folder
cd ../
```

Generate r1cs representation of the necessary sizes of the Semaphore Merkle Tree Batcher (SMTB):

- Tree depth: 30, Batch size: 10
  - constraints: 725439
  - powers of Tau needed: 20
- Tree depth: 30, Batch size: 100
  - constraints: 6305289
  - powers of Tau needed: 23
- Tree depth: 30, Batch size: 1000
  - constraints: 60375789
  - powers of Tau needed: 26

```bash
cd semaphore-mtb && go build -v

# requires quite a bit of compute
./gnark-mbu r1cs --batch-size 10 --tree-depth 30 --output b10t30.r1cs
./gnark-mbu r1cs --batch-size 100 --tree-depth 30 --output b100t30.r1cs
./gnark-mbu r1cs --batch-size 1000 --tree-depth 30 --output b1000t30.r1cs

# move the r1cs files into the coordinator folder
mv b10t30.r1cs b100t30.r1cs b1000t30.r1cs ../semaphore-mtb-setup/

# go up a folder
cd ../
```

Initialize the phase 2 of the setup (the slowest process):

```bash
# make folders for each phase 2
mkdir b10 b100 b1000

cd semaphore-mtb-setup

# initialize each respective phase2
./semaphore-mtb-setup p2n 20.ph1 b10t30.r1cs b10t30c0.ph2

mv b10t30c0.ph2 srs.lag evals ../b10/

./semaphore-mtb-setup p2n 23.ph1 b100t30.r1cs b100t30c0.ph2

mv b100t30c0.ph2 srs.lag evals ../b100/

./semaphore-mtb-setup p2n 26.ph1 b1000t30.r1cs b1000t30c0.ph2

mv b1000t30c0.ph2 srs.lag evals ../b1000/
```

### The Contribution Process

#### Requirements

- Go (using 1.20.5)
- Git
- \> 16 GiB RAM
- Good connectivity (to upload and download files fast to s3)
- The more cores the better (shorter contribution time)
- \> 10 GiB storage

#### Steps

Download the corresponding files for contributions (presigned AWS S3 bucket urls)

Contribution time (on aws m5.16xlarge 256GiB RAM <4GB used - the more cores the better):
b10: 5-10sec (50MB file)
b100: < 5 min (419MB file)
b1000: 20-30 min (3.5GB file)

You will receive pre-signed URLs from [dcbuilder.eth](https://twitter.com/DCbuild3r) for a GET request of a .ph2 file off of AWS S3 of the form:

> https://<S3_BUCKET>.s3.amazonaws.com/<FILENAME>?AWSAccessKeyId=<ACCESS_KEY_ID>&Signature=<SIGNATURE>&Expires=<EXPIRY_TIME>

Submit a GET request using:

```bash
curl --output b10t30cXX.ph2 <PRESIGNED_URL>
curl --output b100t30cXX.ph2 <PRESIGNED_URL>
curl --output b1000t30cXX.ph2 <PRESIGNED_URL>
```

where XX is the current contribution number.

Download and build the [`semaphore-mtb-setup`](https://github.com/worldcoin/semaphore-mtb-setup) coordinator tool to perform the contribution:

```bash
git clone https://github.com/worldcoin/semaphore-mtb-setup
cd semaphore-mtb-setup
go build -v
```

Perform the contribution for each individual .ph2 file and increase the XX counter by one. Each command will output a contribution hash, please copy each of these down into a file of the format `<NAME/PSEUDONYM>_CONTRIBUTION.txt` and prepend each value with the corresponding batch size of the .ph2 file you contributed to (b10, b100 or b1000). Please also share via a message what NAME or PSEUDONYM you selected since it is required to generate a pre-signed S3 upload URL.

```bash
./semaphore-mtb-setup p2c b10t30cXX.ph2 b10t30c(XX + 1).ph2
```

```bash
./semaphore-mtb-setup p2c b100t30cXX.ph2 b100t30c(XX + 1).ph2
```

```bash
./semaphore-mtb-setup p2c b100t30cXX.ph2 b100t30c(XX + 1).ph2
```

You will also receive pre-signed URLs to upload your contribution to the S3 bucket, after your contributions are done and you have the output files, upload them using the following commands:

```bash
curl -v -T b10t30c(XX + 1).ph2 <PRESIGNED_URL>
curl -v -T b100t30c(XX + 1).ph2 <PRESIGNED_URL>
curl -v -T b1000t30c(XX + 1).ph2 <PRESIGNED_URL>
curl -v -T <NAME/PSEUDONYM>_CONTRIBUTION.txt <PRESIGNED_URL>
```

> NOTE: if your file is above 5GiB (shouldn't ever get to that) the request will fail. If that happens, please reach out.

Congratulations! You have successfully contributed to our phase 2 trusted setup ceremony!

### Ceremony integrity check

Now that the ceremony is done, we need to verify that all contributions were performed correctly and that `semaphore-mtb-setup` integrity tests pass. To do so we run:

```bash
./semaphore-mtb-setup p2v b10t30c14.ph2 b10t30c0.ph2
./semaphore-mtb-setup p2v b100t30c14.ph2 b10t30c0.ph2
./semaphore-mtb-setup p2v b1000t30c14.ph2 b10t30c0.ph2
```

The zeroeth contribution (c0) is the file that is generated after initializing the phase 2 from the phase 1 like described in the **pre-contribution** section. We ran these integrity tests and all passed!

![](https://hackmd.io/_uploads/ryKHuRfYh.png)

![](https://hackmd.io/_uploads/BJxnrORft2.png)

![](https://hackmd.io/_uploads/rkl8O0fFh.png)

### Extracting proving and verifying keys

After we verify everything went correctly we extract the proving and verifying keys from the setup using the following commands:

```bash
./semaphore-mtb-setup key b10t30c14.ph2
./semaphore-mtb-setup key b100t30c14.ph2
./semaphore-mtb-setup key b1000t30c14.ph2
```

> Note: In order to run the `key` command we need the respective `evals` and `srs.lag` files we generated in the **pre-contribution phase** to in the directory we execute `semaphore-mtb-setup` from.

The output of these commands are going to be `pk` and `vk` files for each respective circuit.

### Testing semaphore-mtb end-to-end

Now that we have `pk` and `vk` files for each circuit, let's generate a `semaphore-mtb` gnark proving system, generate some test parameters, generate a proof and test whether they verify!

Now let's generate the gnark proving systems from each of the respective `vk` and `pk` pairs:

```bash
# Clone and build semaphore-mtb, then:
./gnark-mbu import-setup --batch-size 10 --tree-depth 30 --pk ../b10/pk --vk ../b10/vk --output ../b10/ps
./gnark-mbu import-setup --batch-size 100 --tree-depth 30 --pk ../b100/pk --vk ../b100/vk --output ../b100/ps
./gnark-mbu import-setup --batch-size 1000 --tree-depth 30 --pk ../b1000/pk --vk ../b1000/vk --output ../b1000/ps
```

`ps` is the proving system represented as a file which we'll now use to generate sample proofs for test input parameters:

![](https://hackmd.io/_uploads/rkCJU17Y2.png)

Next let's generate some test parameters and generate a sample proof using our new `ps` proof systems and write it as json to a file:

```bash
./gnark-mbu gen-test-params --batch-size 10 --tree-depth 30 > ../b10/params.json
cat ../b10/params.json | ./gnark-mbu prove --keys-file ../b10/ps > ../b10/proof10.json
./gnark-mbu gen-test-params --batch-size 100 --tree-depth 30 > ../b100/params.json
cat ../b100/params.json | ./gnark-mbu prove --keys-file ../b100/ps > ../b100/proof100.json
./gnark-mbu gen-test-params --batch-size 1000 --tree-depth 30 > ../b1000/params.json
cat ../b1000/params.json | ./gnark-mbu prove --keys-file ../b1000/ps > ../b1000/proof1000.json
```

And the last step is to verify the proof!

> Install [yq](https://github.com/mikefarah/yq/#install) to help with parsing json

```bash
# grab the input hash from the params.json using yq
yq e ".inputHash" ../b10/params.json
# verify proof
cat ../b10/proof10.json | ./gnark-mbu verify --input-hash <INPUT_HASH> --keys-file ../b10/ps
yq e ".inputHash" ../b100/params.json
cat ../b100/proof100.json | ./gnark-mbu verify --input-hash <INPUT_HASH> --keys-file ../b100/ps
yq e ".inputHash" ../b100/params.json
cat ../b1000/proof100.json | ./gnark-mbu verify --input-hash <INPUT_HASH> --keys-file ../b1000/ps
```

![](https://hackmd.io/_uploads/SJs55lmKn.png)

And the last step before deploying to production is to generate Solidity verifier contracts for these gnark groth16 proofs. Using `semaphore-mtb` run:

```bash
./gnark-mbu export-solidity --keys-file ../b10/ps --output ../b10/verifier.sol
./gnark-mbu export-solidity --keys-file ../b100/ps --output ../b100/verifier.sol
./gnark-mbu export-solidity --keys-file ../b1000/ps --output ../b1000/verifier.sol
```

And we are ready to go into production!

### Fin
