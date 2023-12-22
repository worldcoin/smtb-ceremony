# Trusted setup verification guide

This guide will walk you through how to verify the integrity of the trusted setup ceremony for Worldcoin's [Semaphore Merkle Tree Batcher](https://gihub.com/worldcoin/semaphore-mtb) circuits which power [World ID contracts](https://github.com/worldcoin/world-id-contracts). For more context you can refer to this [video](https://www.youtube.com/watch?v=aM04_FB89Mg) which explains how different components of the World ID architecture relate to each other.

## Prerequisites

In order to verify the integrity of the trusted setup you will need to install the following tools:

- [Go](https://golang.org/doc/install)
- [wget](https://www.gnu.org/software/wget/) (or similar tool to download files from the internet)
- Ram >= 16GB
- Disk space >= 100GB

## Running the verification script

Running `verify.sh` will download all the necessary files from AWS S3 storage using presigned URLs, verify the integrity of the trusted setup, generate Solidity verifier contracts and you can then check the contracts against the production contracts deployed on the Ethereum mainnet for World ID.

```bash
cd contribution_verification
chmod +x verify.sh
./verify.sh
```

### List of production World ID verifier contracts

TODO:
