def get_s3_object(event):
    bucket = ()
    file_name = ()
    creation_date = ()
    return bucket, file_name, creation_date

def create_db_object_id():
    object_id = ()
    return object_id

def put_db_object(bucket, file_name, creation_date, object_id):

def handler(event, context):     
    bucket, file_name, creation_date = get_s3_object(event)
    object_id = create_db_object_id()
    put_db_object(bucket, file_name, creation_date, object_id)
