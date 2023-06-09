#!/usr/bin/env sh

#!/usr/bin/env bash
# exit on error
set -o errexit

pip install git+https://git.disroot.org/pranav/django-todo{,api} gunicorn

python manage.py collectstatic --no-input
python manage.py migrate
