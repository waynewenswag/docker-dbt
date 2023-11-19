ARG         base=alpine

###

FROM        ${base} as build

ARG         repo=
ARG         version=
ARG         download_url=${version:+https://github.com/${repo}/archive/refs/tags/v${version}.tar.gz}

RUN         apk add --no-cache --virtual .build-deps \
                build-base && \
            wget -O - ${download_url} | tar xz

###

FROM        ${base}

COPY        --from=build /usr/local/bin /usr/local/bin
COPY        --from=build /usr/local/include /usr/local/include
COPY        --from=build /usr/local/lib /usr/local/lib
COPY        --from=build /usr/local/share /usr/local/share
