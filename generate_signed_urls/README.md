This is for the coordinator and has nothing to do with contributors.

Replace the `<BUCKET_NAME>` variable with the name of the S3 bucket where you want to store the files.

You also need to create a `keys` file where you need to write your write your `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`. After you are done you can upload the files with the following commands:

```bash
source keys; python generate_upload_url.py contributor_number;
```

This will output a .env file with a signed URL that will be used by the link holder to upload their contribution with name `contribution_<span style="color:red">contributor_number</span>.ph2`.
