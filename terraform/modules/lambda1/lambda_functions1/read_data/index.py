import boto3
import os
import json  # <-- Add this line to import the json module

def lambda_handler(event, context):
    table_name = os.environ['TABLE_NAME']
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table(table_name)

    # Scan the table
    response = table.scan()

    # Return the correct format for AWS_PROXY integration
    return {
        'statusCode': 200,
        'body': json.dumps(response['Items']),  # Use json.dumps to convert the list into a JSON string
        'headers': {
            'Content-Type': 'application/json'
        }
    }
