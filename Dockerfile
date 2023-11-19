ARG         base=python:3.10.7-slim-bullseye

###

FROM        ${base} as dbt

ARG         dbt_core=1.7.2
ARG         dbt_bigquery=1.7.2

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
