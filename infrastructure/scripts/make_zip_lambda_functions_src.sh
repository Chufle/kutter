# make zip for lambda function photo_checkin.py
mkdir ../../infrastructure/build

cd ../../photo_checkin/src
zip -r ../../infrastructure/build/photo_checkin.zip .

# make zip for lambda function list_objects.py
cd ../../list_objects/src
zip -r ../../infrastructure/build/list_objects.zip .

# make zip for lambda function get_object.py
cd ../../get_object/src
zip -r ../../infrastructure/build/get_object.zip .

# make zip for lambda function search_objects.py
cd ../../search_objects/src
zip -r ../../infrastructure/build/search_objects.zip .
cd ../..
