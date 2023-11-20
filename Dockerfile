ARG         base=python:3.10.7-slim-bullseye

###

FROM        ${base} as dbt

ARG         version=

RUN         apt-get update && \
            apt-get install -y --no-install-recommends \
                make \
                build-essential \
                ca-certificates

RUN         pip install \
                dbt-core==${version} \
                dbt-bigquery==${version}

###

FROM        ${base}

ENV         PYTHONIOENCODING=utf-8
ENV         LANG=C.UTF-8

WORKDIR     /usr/app/dbt/
ENTRYPOINT  ["dbt"]

COPY        --from=dbt /usr/local/ /usr/local/
