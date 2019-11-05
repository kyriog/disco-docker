ARG PYTHON_VERSION
FROM python:${PYTHON_VERSION}-alpine

ARG BUILD_DISCO_COMMIT
ENV DISCO_COMMIT $BUILD_DISCO_COMMIT
RUN apk add --no-cache --virtual .build-deps \
        gcc \
        libc-dev \
        git \
    && PYTHONDONTWRITEBYTECODE=1 pip install --no-cache-dir git+https://github.com/b1naryth1ef/disco.git@${BUILD_DISCO_COMMIT} \
    && apk del .build-deps

ENV DISCO_TOKEN ""

WORKDIR /disco

COPY ./docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["python","-m","disco.cli","--run-bot"]
