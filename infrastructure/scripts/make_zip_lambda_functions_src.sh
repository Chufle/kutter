# make zip for lambda function photo_checkin.py
mkdir ../../infrastructure/build

cd ../../photo_checkin/src
zip -r ../../infrastructure/build/photo_checkin.zip .

# make zip for lambda function get_objects.py
cd ../../get_objects/src
zip -r ../../infrastructure/build/get_objects.zip .
cd ../..