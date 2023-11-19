ARG         base=python:3.10.7-slim-bullseye

###

FROM        ${base} as dbt

ARG         dbt_core
ARG         dbt_bigquery

RUN         apt-get update && \
            apt-get install -y --no-install-recommends \
                make \
                build-essential \
                ca-certificates && \
            apt-get clean && \
            rm -rf \
                /var/lib/apt/lists/* \
                /tmp/* \
                /var/tmp/*

RUN         pip install \
                dbt-core==${dbt_core} \
                dbt-bigquery==${dbt_bigquery}

###

FROM        ${base}

ENV         PYTHONIOENCODING=utf-8
ENV         LANG=C.UTF-8

WORKDIR     /usr/app/dbt/
ENTRYPOINT  ["dbt"]

COPY        --from=dbt /usr/local/ /usr/local/
