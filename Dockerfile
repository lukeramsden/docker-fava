FROM lsiobase/alpine:3.11

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="lukeramsden"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	freetype-dev \
	g++ \
	gcc \
	lcms2-dev \
	libffi-dev \
	libpng-dev \
	libwebp-dev \
	libxml2-dev \
	libxslt-dev \
	linux-headers \
	openssl-dev \
	python3-dev && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \ 
        python3 && \
 echo "**** install pip packages ****" && \
 pip3 install --no-cache-dir --upgrade \
	pip && \
 pip3 install \
        fava \
        fava[excel] && \
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root/.cache \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
VOLUME /config
EXPOSE 5000
