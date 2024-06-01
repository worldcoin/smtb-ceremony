For a contributor, only relevant file in this repo is `contribute.sh`. If you're one, safely ignore the rest.

## Prerequisites

- [Go](https://golang.org/doc/install)
- git

## Performing a Contribution

Each contributor will receive a `contribution.env` file which will contain a signed URL to be used by the contribution script to upload resulting artifacts to the bucket. After placing that file next to `contribute.sh`:

```bash
chmod +x contribute.sh; ./contribute.sh;
```
