This guide will walk you through the process of performing a trusted setup for [semaphore-mtb](https://github.com/worldcoin/semaphore-mtb) (SMTB). There are two main types of circuits for which you can perform a trusted setup: merkle tree insertion and deletion circuits. Each of these circuits is parametrized by the batch size and the tree depth. Each different parametrization will generate a different r1cs file which will represent the constraints of our circuits for which we will have to do a trusted setup for.

In the case of the World ID tree we will be working on a merkle tree of depth 30, the batch sizes the [signup-sequencer](https://github.com/worldcoin/signup-sequencer) will support are:

- Insertion
  - 10
  - 100
  - 600
  - 1000
- Deletion
  - 10
  - 100

### Phase 1

In order to perform the trusted setup we will need a CLI tool which will perform the contribution. Since each trusted setup for groth16 circuits over the BN254 curve has 2 phases, 1 which is universal and 1 which is circuit-specific, it makes sense to re-use an existing phase 1. In our case we will use the [Perpetual Powers of Tau ceremony](https://github.com/privacy-scaling-explorations/perpetualpowersoftau) (PPOT) files from the latest contributor (currently Aayush Gupta).

Since semaphore-mtb circuits are written using the [gnark library](https://github.com/consensys/gnark) we will first need to deserialize the ptau files generated from PPOT using snarkjs into something gnark can interpret using [ptau-deserializer](https://github.com/worldcoin/ptau-deserializer). In order to figure out which files to deserialize we need to create our SMTB r1cs circuits for the right parameters in order to figure out how many constraints each of our circuits has. Once we have done this, we will select the powers of tau files corresponding to the circuit size.

We first need to generate all the respective r1cs files to figure out how many constraints our circuits will have. Using [semaphore-mtb](https://github.com/worldcoin/semaphore-mtb) we can generate the r1cs file with the following command (don't forget to copy the number of constraints of each circuits, will be needed in the next step):

```bash
git clone https://github.com/worldcoin/semaphore-mtb.git
cd semaphore-stb && go build
./gnark-mbu r1cs --mode {insertion/deletion} --batch-size <BATCH_SIZE> --tree-depth 30 --output <MODE>_b<BATCH_SIZE>t30.r1cs
```

Here are all the .r1cs files we need:

- insertion_b10t30.r1cs
- insertion_b100t30.r1cs
- insertion_b600t30.r1cs
- insertion_b1000t30.r1cs
- deletion_b10t30.r1cs
- deletion_b100t30.r1cs

> [!IMPORTANT]
> The Powers of Tau of the files we select for each circuit need to satisfy the following equation:
> 2^{POWERS_OF_TAU} >= CIRCUIT CONSTRAINTS

Once we have downloaded the .ptau files from [perpetualpowersoftau](https://github.com/privacy-scaling-explorations/perpetualpowersoftau), we select the right .ptau files according to the equation above and we start converting them into .ph1 files which we will use for the circuit-specific phase 2 of the ceremony.

```bash
git clone https://github.com/worldcoin/ptau-deserializer.git
cd ptau-deserializer && go build
go run main.go convert --input <CEREMONY>.ptau --output <CEREMONY>.ph1
```

After running this step, we should have the following files:

- insertion_b10t30.ph1
- insertion_b100t30.ph1
- insertion_b600t30.ph1
- insertion_b1000t30.ph1
- deletion_b10t30.ph1
- deletion_b100t30.ph1

### Phase 2 Initialization

Now that we have all the r1cs and ph1 files we can initialize the phase 2 using the [semaphore-mtb-setup](https://github.com/worldcoin/semaphore-mtb-setup) CLI tool.

We can initialize the phase 2 by running the following commands:

```bash
git clone https://github.com/worldcoin/semaphore-mtb-setup.git
# move all the ph1 and r1cs files into the setup repository
mv semaphore-mtb/*.r1cs semaphore-mtb/*.ph1 semaphore-mtb-setup
cd semaphore-mtb-setup && go build
# the name of the phase2 file should cointain c0 at the end indicating it is the seed phase 2 file with no contributions
./semaphore-mtb-setup p2n <MODE>_b<BATCH_SIZE>t30.ph1 <MODE>_b<BATCH_SIZE>t30.ph1 <MODE>_b<BATCH_SIZE>t30.r1cs <MODE>_b<BATCH_SIZE>t30c0.ph2
```

Once we have all these files, we need to back up the r1cs and ph2 files to a bucket on AWS S3. In this repo you can find an `upload.py` file where you need to replace the `<BUCKET_NAME>` variable with the name of the S3 bucket where you want to store the files. You also need to create a `keys` file where you need to write your write your `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`. After you are done you can upload the files with the following commands:

- Install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) toolkit in order to configure access to the desired bucket. Don't forget to create an [IAM](https://aws.amazon.com/iam/) user and give the correct permissions and access to the S3 bucket(s) you need.

```bash
# prepare AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY beforehand
aws configure
```

```bash
source keys
# for each circuit phase 2 and r1cs file
python upload.py put <MODE>_b<BATCH_SIZE>t30c0.ph2
# the command above will spit out a <PRESIGNED_URL>
curl -v -T <PH2FILE>.ph2 <PRESIGNED_URL>
```

This concludes all the steps for the initalization of the phase 2 of the trusted setup ceremony.

### Phase 2 contributions

#### Generating URLS

We need to generate temporary keys our contributors can use to get presigned URLs for sending their GET and PUT requests to AWS to either download or upload the necessary phase 2 files. Using `generate_s3_urls.sh` we can generate the necessary files for any given contributor using the following commands:

Requirements:

- Python3
- boto3 (pip package)
- aws configure (step above)
- `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` env vars set

```bash
chmod +x generate_s3_urls.sh
# use 0 for the first contribution
./generate_s3_urls.sh <contribution_number>
```

### Contribution

Each contributor will receive a `contribution.env` file which will contain all the presigned URLs and necessary metadata to run the contribution script. The contribution script will download `semaphore-mtb-setup`, download all the right files from AWS S3 storage using the presigned urls, perform a phase 2 contribution for each circuit and lastly upload the files back to S3 once it's done.

> [!NOTE]
> Please install Go in order to perform the contribution. ([link](https://go.dev/doc/install))

In order to contribute, the given participant will receive a `contribution.env` file from the coordinator of the ceremony. After that all that is needed to run is:

```bash
chmod +x contribute.sh
./contribute.sh
```

### Verify contributions happened correctly

Run the verification command for the last contribution file of each circuit:

```bash
# for each circuit
./semaphore-mtb-setup p2v <last_contribution_file.ph2> <zeroeth_contribution_file.ph2>
```

If every command verifies successfully, then we can proceed to the final setup steps.

### Extracting proving system out of the phase 2 files

After we verify everything went correctly we extract the proving and verifying keys from the setup using the following commands:

> [!IMPORTANT]
> In order to run the `key` command we need the respective `evals` and `srs.lag` files we downloaded above to exist in the directory we execute `semaphore-mtb-setup` from. The commands below are quite computationally expensive and will run for a while.

```bash
mkdir insertionb10
mkdir insertionb100
mkdir insertionb600
mkdir insertionb1000
mkdir deletionb10
mkdir deletionb100
# for every phase 2 contribution file
mv <last_contribution_file.ph2> <corresponding_directory_mode_batch_size>/
cd <corresponding_directory_mode_batch_size>/
../semaphore-mtb-setup key <last_contribution_file.ph2>

# at the end go back to root project dir
cd ..
```

This command will generate the `pk` (proving key) and `vk` (verification key) files respectively.

The proving key (`pk` file) is used inside of the [`semaphore-mtb`](https://github.com/worldcoin/semaphore-mtb) service which is running `gnark` and there is no straightforward way to verify that the production deployment of the service is using the proving key generated in this ceremony unless you run your own sequencer (WIP). However, we can infer that the correct proving key is being used because it would be computationally infeasible to generate a valid proof for the on-chain verifiers otherwise.

> [!NOTE]
> Please install Go in order to generate the proving system files. ([link](https://go.dev/doc/install))

Dowload `semaphore-mtb` and build the tool:

```bash
git clone https://github.com/worldcoin/semaphore-mtb
cd semaphore-mtb
go build -v
```

Now that we have `pk` and `vk` files for each circuit from previous steps, let's generate `semaphore-mtb` gnark proving systems, generate some test parameters, generate a proof and test whether they verify!

Now let's generate the gnark proving systems from each of the respective `vk` and `pk` pairs:

```bash
# For each pk and vk pair in each folder
./gnark-mbu import-setup --mode <deletion/insertion> --batch-size <BATCH_SIZE> --tree-depth <TREE_DEPTH> --pk <PK_PATH> --vk <VK_PATH>  --output <PS_PATH>
```

`ps` is the proving system represented as a file which we'll now use to generate sample proofs for test input parameters.

### Verifying proving system was created correctly

Next let's generate some test parameters and generate a sample proof using our new `ps` proof systems and write it as json to a file:

```bash
# for each circuit ps file
./gnark-mbu gen-test-params --mode <insertion/deletion> --batch-size <BATCH_SIZE> --tree-depth <TREE_DEPTH> <corresponding_directory_mode_batch_size>/params.json \
cat corresponding_directory_mode_batch_size/params.json | ./gnark-mbu prove --mode <insertion/deletion> --keys-file <PS_PATH> > <corresponding_directory_mode_batch_size>/proof.json
```

And the last verification step is to verify the proof!

> [!NOTE]
> Install [yq](https://github.com/mikefarah/yq/#install) to help with parsing json

```bash
# Grab the input hash from the params.json using yq
yq e ".inputHash" <corresponding_directory_mode_batch_size>/params.json
# verify proof
cat <corresponding_directory_mode_batch_sizep>/proof.json | ./gnark-mbu verify --input-hash <INPUT_HASH> --keys-file <corresponding_directory_mode_batch_size>/ps
```

### Export solidity contracts

In order to generate production EVM verifier contracts (Solidity) for our respective ZK proving systems using `semaphore-mtb` we will run the following:

```bash
# for each mode and batch size combination
./gnark-mbu export-solidity --keys-file <PS_PATH> --output <corresponding_directory_mode_batch_size>/verifier.sol
```

> [!IMPORTANT]
> Don't forget to verify the deployments of these contracts on Etherscan using `forge verify-contract` or manually via the Etherscan verification API or verification UI.

### Backup all important files to S3

For each different mode and batch size combination that we want, we need to upload these files to S3 using `upload.py`'s `put` commands to generate the presigned URL and with `curl -v -T` to upload the files:

- srs.lag
- evals
- ps
- verifier.sol
