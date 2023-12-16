# Contributors Guide

## How to contribute

### Requirements

- Go
- Git
- \> 100 GiB RAM
- Good connectivity, ideally gigabit internet (to upload and download files fast to s3)
- The more cores the better (shorter contribution time)
- \> 100 GiB storage

### Details

Each contributor will receive a `contribution.env` file from the trusted setup coordinator which will contained all the presigned URLs and necessary metadata to run the contribution script. The contribution script will download `semaphore-mtb-setup`, download all the right files from AWS S3 storage using presigned urls, perform a phase 2 contribution for each circuit and lastly upload the files back to S3 once it's done.

> ![NOTE]
> Please install Go in order to perform the contribution. ([link](https://go.dev/doc/install))

In order to contribute, the given participant will receive a `contribution.env` file from the coordinator of the ceremony. After that all that is needed to run is:

```bash
chmod +x contribute.sh
./contribute.sh
```

## List of contributors

### Insertion mode batch size 10 SMTB circuit

1. dc

2. dzejkop

3. atris

4. nick

5. marcin

6. steven

7. kobi

8. daniel

9. Aayush

10. remco

11. thor

12. yi sun

13. shumo

14. Bartek

15. zellic

16. justin drake

- contribution hash: ``
- generated file: `insertion_b10t30c01.ph2`

### Insertion mode batch size 100 SMTB circuit

- contribution hash: ``
- generated file: `insertion_b100t30c01.ph2`

### Insertion mode batch size 600 SMTB circuit

- contribution hash: ``
- generated file: `insertion_b600t30c01.ph2`

### Insertion mode batch size 1200 SMTB circuit

- contribution hash: ``
- generated file: `insertion_b1200t30c01.ph2`

### Deletion mode batch size 10 SMTB circuit

- contribution hash: ``
- generated file: `deletion_b10t30c01.ph2`

### Deletion mode batch size 100 SMTB circuit

- contribution hash: ``
- generated file: `deletion_b100t30c01.ph2`
