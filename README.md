# Semaphore Merkle Tree Batcher (semaphore-mtb) trusted setup ceremony

This repo contains the transcript of trusted setup ceremony for [Semaphore Merkle Tree Batcher](https://github.com/worldcoin/semaphore-mtb). Please see that repo for details.

If you want to read up more on what is a trusted setup and why it is a requirement for [zkSNARKs](https://zkhack.dev/2023/07/27/getting-started-in-zk/) (zero-knowledge proofs) that are non-universal like [groth16](https://eprint.iacr.org/2016/260) which is the proof system powering Semaphore and World ID, read:

- [Understanding Trusted Setups: A Guide - Panther Protocol](https://blog.pantherprotocol.io/a-guide-to-understanding-trusted-setups/#:~:text=A%20trusted%20setup%20is%20a,similar%20cryptographic%20protocols%20rely%20on.)
- [How do trusted setups work? - Vitalik Buterin](https://vitalik.ca/general/2022/03/14/trustedsetup.html)
- [On-Chain Trusted Setup Ceremony - a16z crypto](https://a16zcrypto.com/posts/article/on-chain-trusted-setup-ceremony/#section--1)
- [BGM17](https://eprint.iacr.org/2017/1050.pdf)

### Ceremony Specification

For the phase 1 contribution (a.k.a powers of tau ceremony) we are using the [Perpetual Powers of Tau ceremony](https://github.com/privacy-scaling-explorations/perpetualpowersoftau). We built a [deserializer](https://github.com/worldcoin/ptau-deserializer) from the `.ptau` format into the `.ph1` format used by gnark and initialized a phase 2 using a fork ([semaphore-mtb-setup](https://github.com/worldcoin/semaphore-mtb-setup)) of a ceremony coordinator wrapper on top of gnark built by the [zkbnb team](https://github.com/bnb-chain/zkbnb-setup).

### How to perform and verify the integrity of the trusted setup

Follow the instructions in the [GUIDE.md file](./GUIDE.md) to perform and verify the integrity of the trusted setup.

### How to contribute

Check out the [CONTRIBUTORS.md file](./CONTRIBUTORS.md) for details on how to contribute.
