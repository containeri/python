ARG PYTHON_VERSION="3.13"
FROM python:${PYTHON_VERSION}-slim AS python-base

ARG UBUNTU_STREAM="stable"
FROM ubuntu AS python-installer

RUN <<-EOT 
    apt-get update
    apt-get install -y --no-install-recommends ca-certificates libgdbm6 libncursesw6 libreadline8 libsqlite3-0 libssl3 netbase openssl readline-common
    rm -rf /var/lib/apt/lists/*
EOT

COPY --from=python-base /usr/local /usr/local

FROM scratch AS python
COPY --from=python-installer / /

CMD [ "python3" ]