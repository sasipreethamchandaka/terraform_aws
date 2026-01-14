def lambda_handler(event, context):
    return {
        "statusCode": 400,
        "body": "Hello from Lambda uploaded via S3 using Terraform!"
    }