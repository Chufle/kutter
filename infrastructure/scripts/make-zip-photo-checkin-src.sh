# make zip for lambda function photo_checkin.py
mkdir ../../infrastructure/build

cd ../../photo-checkin/src
zip -r ../../infrastructure/build/photo_checkin.zip .
cd ../..