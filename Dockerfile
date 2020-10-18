FROM 0x01be/nodeeditor:build as build

FROM 0x01be/xpra

COPY --from=build /opt/nodeeditor/ /opt/nodeeditor/

USER root
RUN apk add --no-cache --virtual nodeeditor-runtime-dependencies \
    qt5-qtbase \
    qt5-qttools \
    mesa-dri-swrast

COPY --from=build /nodeeditor/build/bin/ /opt/nodeeditor/bin/
COPY --from=build /opt/nodeeditor/lib64/* /usr/lib/
COPY --from=build /opt/nodeeditor/include/* /usr/include/

USER xpra

ENV PATH ${PATH}:/opt/nodeeditor/bin/

ENV COMMAND calculator

