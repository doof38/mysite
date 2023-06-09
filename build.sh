#!/usr/bin/env sh

#!/usr/bin/env bash
# exit on error
set -o errexit
pip install --upgrade pip
#pip install --upgrade python
# update all packages
pip --disable-pip-version-check list --outdated --format=json | python -c "import json, sys; print('\n'.join([x['name'] for x in json.load(sys.stdin)]))"
pip install git+https://git.disroot.org/pranav/django-todoapi git+https://git.disroot.org/pranav/django-todo gunicorn

python manage.py collectstatic --no-input
python manage.py migrate
