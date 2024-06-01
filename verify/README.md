## Prerequisites

- [Go](https://golang.org/doc/install)
- git

## Running the verification script

```bash
chmod +x verify.sh;
./verify.sh contribution_number
```

Where <span style="color:red">contribution_number</span> is an integer > 0 representing the contribution to be verified. This will download that contribution and the previous contribution, both of which are necessary for integrity verification.

Output is textual in the console.
