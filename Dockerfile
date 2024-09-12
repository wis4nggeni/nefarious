# define pre-built frontend app to extract from
ARG tag=latest
FROM lardbit/nefarious:frontend-$tag as frontend

FROM python:3.10.15-bullseye

EXPOSE 80

# add app source
ADD src /app

# copy frontend app from existing image into static assets
COPY --from=frontend /staticassets/ /app/staticassets

# add entrypoints
ADD entrypoint*.sh /app/

WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive

# install app dependencies, build app and remove dev dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    authbind \
    libatlas-base-dev libhdf5-dev libavutil-dev libswresample-dev libavcodec-dev libavformat-dev libswscale-dev \
    && mkdir -p /nefarious-db \
    && python -m venv /env \
    && /env/bin/pip install -U pip \
    && /env/bin/pip install --no-cache-dir --only-binary :all: --extra-index-url https://www.piwheels.org/simple -r requirements.txt \
    && /env/bin/python manage.py collectstatic --no-input \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && true

ENTRYPOINT ["/app/entrypoint.sh"]
