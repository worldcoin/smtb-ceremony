## Prerequisites

- [Go](https://golang.org/doc/install)
- git

## Running the verification script

Place the .env file next to init_phase2.sh

```bash
chmod +x init_phase2.sh;
./init_phase2.sh <path_to_filename.ptau> <desired_power_of_tau>
```

Where <span style="color:red">desired_power_of_tau</span> is an integer that will download powersOfTau28_hez_final_15.ptau when given 15.

This script will upload the resulting artifacts to the bucket.
