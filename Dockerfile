FROM python:3.9-slim-bullseye

EXPOSE 8000 2222

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONPATH=/usr/local/lib/python3.9

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Update system and pip dependencies
COPY requirements /tmp/requirements
RUN /bin/sh -c '''apt-get update && \
                  apt-get -y upgrade && \
                  pip install --upgrade pip && \
                  pip install -r /tmp/requirements/base.txt && \
                  apt-get autoremove -y && apt-get autoclean -y'''

WORKDIR /opt/code
COPY . /opt/code

# Collectstatic
RUN python manage.py collectstatic --noinput

# Switching to a non-root user
RUN useradd -m demouser && chown -R demouser /opt/code
USER demouser

CMD ["./bin/init.sh"]

