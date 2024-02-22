ARG         base=

###

FROM        ${base} as dbt

ARG         version=
ARG         bq_version=
ARG         ch_version=

RUN         apt-get update && \
            apt-get install -y --no-install-recommends \
                make \
                build-essential \
                ca-certificates

RUN         pip install \
                dbt-core==${version} \
                dbt-bigquery==${bq_version} \
                dbt-clickhouse==${ch_version} \
                ${extras}

###

FROM        ${base}

ENV         PYTHONIOENCODING=utf-8
ENV         LANG=C.UTF-8

WORKDIR     /usr/app/dbt/
ENTRYPOINT  ["dbt"]
CMD         ["-v"]

COPY        --from=dbt /usr/local/ /usr/local/
