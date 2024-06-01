## Prerequisites

- [Go](https://golang.org/doc/install)
- git

## Running the verification script

Takes as input the latest phase2 contribution.

```bash
chmod +x extract_keys.sh;
./extract_keys.sh ptau_file phase2Evaluations r1cs_file latest_contribution
```

- <span style="color:red">ptau_file</span> is the ptau file that was used to initialize the whole phase2 ceremony.
- <span style="color:red">phase2Evaluations</span> file is outputted by Gnark when phase2 was initialized.
- <span style="color:red">r1cs_file</span> is outputted by Gnark
- <span style="color:red">latest_contribution</span> can either be a path to the latest .ph2 file from the contributions, or it can be an integer representing which contribution it is. In the latter, script attempts to download the contribution file corresponding to this integer.
