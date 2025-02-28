import boto3
import os

def lambda_handler(event, context):
    table_name = os.environ['TABLE_NAME']
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table(table_name)

    # Scan the table (consider using Query for better performance with large tables)
    response = table.scan()

    return {
        'statusCode': 200,
        'body': response['Items']
    }
