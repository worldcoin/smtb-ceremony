import argparse
import logging
import boto3

bucket_name = '<BUCKET_NAME>'
logger = logging.getLogger(__name__)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument(
        'contribution_number', 
        type=int, 
        help="Expected contribution number as an integer."
    )
    args = parser.parse_args()

    file_name = f"contribution_{args.contribution_number}.ph2"
    url = boto3.client('s3').generate_presigned_url(
        ClientMethod='put_object',
        Params={'Bucket': bucket_name, 'Key': file_name},
        ExpiresIn=86_400
    )
    print("-"*50)
    print()
    print(url)
    print()
    print("-"*50)
