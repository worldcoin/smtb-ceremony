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

In this list we mention all the contributors that have successfully contributed to the ceremony. The list is ordered by the order in which individuals contributed. To find the matching hashes of each contribution, please refer to the files in the `contribution_verification` folder. The files are named after the circuit mode and the batch size.

### Insertion mode batch size 10 SMTB circuit

1. [dcbuilder](https://github.com/dcbuild3r) (Tools for Humanity - TfH)

2. [dzejkop](https://github.com/Dzejkop) (TfH)

3. [atris](https://github.com/vacekj)

4. Nick Takacs (TfH)

5. [Marcin Kostrzewa](https://github.com/kustosz) (TfH-affiliated)

6. [Steven Smith](https://twitter.com/reldev) (TfH)

7. [Kobi Gurkan](https://github.com/kobigurk)

8. [0xKitsune](https://github.com/0xKitsune) (TfH)

9. [Yush G](https://github.com/Divide-By-0)

10. [Remco Bloemen](https://github.com/recmo) (Worldcoin Foundation)

11. [Thor Kamphefner](https://github.com/thor314)

12. [Yi Sun](https://github.com/yi-sun)

13. [Shumo Chu](https://github.com/stechu)

14. [Bartek Kiepuszewski](https://twitter.com/bkiepuszewski/)

15. [zellic](https://www.zellic.io/)

16. [justin drake](https://twitter.com/drakefjustin)

### Insertion mode batch size 100 SMTB circuit

1. [dcbuilder](https://github.com/dcbuild3r) (Tools for Humanity - TfH)

2. [dzejkop](https://github.com/Dzejkop) (TfH)

3. [atris](https://github.com/vacekj)

4. Nick Takacs (TfH)

5. [Marcin Kostrzewa](https://github.com/kustosz) (TfH-affiliated)

6. [Steven Smith](https://twitter.com/reldev) (TfH)

7. [Kobi Gurkan](https://github.com/kobigurk)

8. [0xKitsune](https://github.com/0xKitsune) (TfH)

9. [Yush G](https://github.com/Divide-By-0)

10. [Remco Bloemen](https://github.com/recmo) (Worldcoin Foundation)

11. [Thor Kamphefner](https://github.com/thor314)

12. [Yi Sun](https://github.com/yi-sun)

13. [Shumo Chu](https://github.com/stechu)

14. [Bartek Kiepuszewski](https://twitter.com/bkiepuszewski/)

15. [zellic](https://www.zellic.io/)

16. [justin drake](https://twitter.com/drakefjustin)

### Insertion mode batch size 600 SMTB circuit

1. [dcbuilder](https://github.com/dcbuild3r) (TfH)

2. [dzejkop](https://github.com/Dzejkop) (TfH)

3. [atris](https://github.com/vacekj)

4. Nick Takacs (TfH)

5. [Marcin Kostrzewa](https://github.com/kustosz) (TfH-affiliated)

6. [Steven Smith](https://twitter.com/reldev) (TfH)

7. [Kobi Gurkan](https://github.com/kobigurk)

8. [0xKitsune](https://github.com/0xKitsune) (TfH)

9. [Remco Bloemen](https://github.com/recmo) (Worldcoin Foundation)

### Insertion mode batch size 1200 SMTB circuit

1. [dcbuilder](https://github.com/dcbuild3r) (TfH)

2. [dzejkop](https://github.com/Dzejkop) (TfH)

3. [atris](https://github.com/vacekj)

4. Nick Takacs (TfH)

5. [Marcin Kostrzewa](https://github.com/kustosz) (TfH-affiliated)

6. [Steven Smith](https://twitter.com/reldev) (TfH)

7. [Kobi Gurkan](https://github.com/kobigurk)

8. [0xKitsune](https://github.com/0xKitsune) (TfH)

9. [Yush G](https://github.com/Divide-By-0)

10. [Remco Bloemen](https://github.com/recmo) (Worldcoin Foundation)

11. [Thor Kamphefner](https://github.com/thor314)

12. [Yi Sun](https://github.com/yi-sun)

13. [Shumo Chu](https://github.com/stechu)

14. [Bartek Kiepuszewski](https://twitter.com/bkiepuszewski/)

15. [zellic](https://www.zellic.io/)

16. [justin drake](https://twitter.com/drakefjustin)

17. [dcbuilder](https://github.com/dcbuild3r) (TfH) (2nd contribution)

### Deletion mode batch size 10 SMTB circuit

1. [dcbuilder](https://github.com/dcbuild3r) (TfH)

2. [dzejkop](https://github.com/Dzejkop) (TfH)

3. [atris](https://github.com/vacekj)

4. Nick Takacs (TfH)

5. [Marcin Kostrzewa](https://github.com/kustosz) (TfH-affiliated)

6. [Steven Smith](https://twitter.com/reldev) (TfH)

7. [Kobi Gurkan](https://github.com/kobigurk)

8. [0xKitsune](https://github.com/0xKitsune) (TfH)

9. [Yush G](https://github.com/Divide-By-0)

10. [Remco Bloemen](https://github.com/recmo) (Worldcoin Foundation)

11. [Thor Kamphefner](https://github.com/thor314)

12. [Yi Sun](https://github.com/yi-sun)

13. [Shumo Chu](https://github.com/stechu)

14. [Bartek Kiepuszewski](https://twitter.com/bkiepuszewski/)

15. [zellic](https://www.zellic.io/)

16. [justin drake](https://twitter.com/drakefjustin)

17. [dcbuilder](https://github.com/dcbuild3r) (TfH) (2nd contribution)

### Deletion mode batch size 100 SMTB circuit

1. [dcbuilder](https://github.com/dcbuild3r) (TfH)

2. [dzejkop](https://github.com/Dzejkop) (TfH)

3. [atris](https://github.com/vacekj)

4. Nick Takacs (TfH)

5. [Marcin Kostrzewa](https://github.com/kustosz) (TfH-affiliated)

6. [Steven Smith](https://twitter.com/reldev) (TfH)

7. [Kobi Gurkan](https://github.com/kobigurk)

8. [0xKitsune](https://github.com/0xKitsune) (TfH)

9. [Yush G](https://github.com/Divide-By-0)

10. [Remco Bloemen](https://github.com/recmo) (Worldcoin Foundation)

11. [Thor Kamphefner](https://github.com/thor314)

12. [Yi Sun](https://github.com/yi-sun)

13. [Shumo Chu](https://github.com/stechu)

14. [Bartek Kiepuszewski](https://twitter.com/bkiepuszewski/)

15. [zellic](https://www.zellic.io/)

16. [justin drake](https://twitter.com/drakefjustin)

17. [dcbuilder](https://github.com/dcbuild3r) (TfH) (2nd contribution)
