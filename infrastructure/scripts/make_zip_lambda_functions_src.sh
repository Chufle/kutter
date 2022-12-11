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

# make zip for lambda function news_crawler.py
cd ../../news_crawler/src
zip -r ../../infrastructure/build/news_crawler.zip .

# make zip for lambda layer for function new_crawler.py
cd ../../requests_layer
python3 -m venv .venv
source .venv/bin/activate
mkdir .python
pip install -r requirements.txt -t .python
zip -r ../infrastructure/build/requests_layer.zip .python
cd ../..
