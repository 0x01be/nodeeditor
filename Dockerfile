FROM alpine as build

RUN apk add --no-cache --virtual nodeeditor-build-dependencies \
    git \
    build-base \
    cmake \
    qt5-qtbase-dev \
    qt5-qttools-dev \
    catch2

ENV NODEEDITOR_REVISION master
RUN git clone --depth 1 --branch ${NODEEDITOR_REVISION} https://github.com/paceholder/nodeeditor.git /nodeeditor
WORKDIR /nodeeditor/build
RUN cmake \
    -DCMAKE_INSTALL_PREFIX=/opt/nodeeditor \
    ..
RUN make
RUN make install

