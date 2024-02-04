ARG         base=

###

FROM        ${base} as dbt

ARG         package=
ARG         package_version=
ARG         core_version=

RUN         apt-get update && \
            apt-get install -y --no-install-recommends \
                make \
                build-essential \
                ca-certificates

RUN         pip install \
                dbt-core==${core_version} \
                ${package}==${package_version}

###

FROM        ${base}

ENV         PYTHONIOENCODING=utf-8
ENV         LANG=C.UTF-8

WORKDIR     /usr/app/dbt/
ENTRYPOINT  ["dbt"]

COPY        --from=dbt /usr/local/ /usr/local/
