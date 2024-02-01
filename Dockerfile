ARG         base=python:3.12.0-slim-bookworm

###

FROM        ${base} as dbt

ARG         core_version=
ARG         bigquery_version=
ARG         clickhouse_version=

RUN         apt-get update && \
            apt-get install -y --no-install-recommends \
                make \
                build-essential \
                ca-certificates

RUN         pip install \
                dbt-core==${ core_version } \
                dbt-bigquery==${ bigquery_version } \
                dbt-clickhouse==${ clickhouse_version }

###

FROM        ${base}

ENV         PYTHONIOENCODING=utf-8
ENV         LANG=C.UTF-8

WORKDIR     /usr/app/dbt/
ENTRYPOINT  ["dbt"]

COPY        --from=dbt /usr/local/ /usr/local/
