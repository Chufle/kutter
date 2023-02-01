# Make directory ".\infrastructure\build" for zip packed source files for lambda functions
New-Item -Path C:\Users\Daniel\Documents\AWS-Projects\kutter\infrastructure\build -ItemType directory

# make zip for lambda function photo_checkin.py
Compress-Archive -Path C:\Users\Daniel\Documents\AWS-Projects\kutter\photo_checkin\src\* -DestinationPath C:\Users\Daniel\Documents\AWS-Projects\kutter\infrastructure\build\photo_checkin.zip -Force

# make zip for lambda function list_objects.py
Compress-Archive -Path C:\Users\Daniel\Documents\AWS-Projects\kutter\list_objects\src\* -DestinationPath C:\Users\Daniel\Documents\AWS-Projects\kutter\infrastructure\build\list_objects.zip -Force

# make zip for lambda function get_object.py
Compress-Archive -Path C:\Users\Daniel\Documents\AWS-Projects\kutter\get_object\src\* -DestinationPath C:\Users\Daniel\Documents\AWS-Projects\kutter\infrastructure\build\get_object.zip -Force

# make zip for lambda function search_objects.py
Compress-Archive -Path C:\Users\Daniel\Documents\AWS-Projects\kutter\search_objects\src\* -DestinationPath C:\Users\Daniel\Documents\AWS-Projects\kutter\infrastructure\build\search_objects.zip -Force

# make zip for lambda function news_crawler.py
Compress-Archive -Path C:\Users\Daniel\Documents\AWS-Projects\kutter\news_crawler\src\* -DestinationPath C:\Users\Daniel\Documents\AWS-Projects\kutter\infrastructure\build\news_crawler.zip -Force

# make zip for lambda function put_project_object.py
Compress-Archive -Path C:\Users\Daniel\Documents\AWS-Projects\kutter\put_project_object\src\* -DestinationPath C:\Users\Daniel\Documents\AWS-Projects\kutter\infrastructure\build\put_project_object.zip -Force

# make zip for lambda layer for function new_crawler.py
Set-Location -Path C:\Users\Daniel\Documents\AWS-Projects\kutter\requests_layer
python3 -m venv .venv
.\.venv\Scripts\activate
mkdir .python
pip install -r requirements.txt -t .python
Compress-Archive .python\* C:\Users\Daniel\Documents\AWS-Projects\kutter\infrastructure\build\requests_layer.zip -Force
Set-Location -Path C:\Users\Daniel\Documents\AWS-Projects\kutter\infrastructure\scripts
