FROM alpine:3

RUN apk add --no-cache python3 py3-pip eudev

RUN apk add --no-cache android-tools --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing

RUN pip3 install pure-python-adb
RUN pip3 install pyudev

COPY ./bin /adb-scripter/bin
COPY ./config /adb-scripter/config
COPY ./src /adb-scripter/src


CMD /adb-scripter/bin/adb-scripter