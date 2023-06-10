#!/usr/bin/bash

#!/usr/bin/env bash
# exit on error
set -o errexit
pip install --upgrade pip
#pip install --upgrade python
# update all packages
pip --disable-pip-version-check list --outdated --format=json | python -c "import json, sys; print('\n'.join([x['name'] for x in json.load(sys.stdin)]))"
pip install git+https://git.disroot.org/pranav/django-todoapi git+https://git.disroot.org/pranav/django-todo gunicorn whitenoise[brotli]

django-admin startproject newsite
cd newsite/newsite
cat settings.py
echo 'INSTALLED_APPS+=["todo","todoapi"]' >>settings.py
echo 'ALLOWED_HOSTS+=["mulearn-internship.onrender.com"]' >>settings.py
cat > urls.py <<<"EOF"
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path("admin/", admin.site.urls),
    path("todo/", include("todo.urls")),
    path("todoapi/", include("todoapi.urls")),
]
EOF
cd ..

#python manage.py collectstatic --no-input
python manage.py migrate
