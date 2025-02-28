
import boto3
import uuid
import os

def lambda_handler(event, context):
    # Retrieve the DynamoDB table name from environment variable
    table_name = os.environ['TABLE_NAME']
    
    # Initialize DynamoDB resource
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table(table_name)

    # Data to be inserted
    people = [
        { 'userid' : 'marivera', 'name' : 'Martha Rivera' },
        { 'userid' : 'nikkwolf', 'name' : 'Nikki Wolf' },
        { 'userid' : 'pasantos', 'name' : 'Paulo Santos' },
    ]

    # Batch write to insert data
    with table.batch_writer() as batch_writer:
        for person in people:
            item = {
                '_id'     : uuid.uuid4().hex,
                'Userid'  : person['userid'],
                'FullName': person['name']
            }
            print(f"> batch writing: {person['userid']}")
            batch_writer.put_item(Item=item)

    result = f"Success. Added {len(people)} people to {table_name}."
    
    return {'message': result}
