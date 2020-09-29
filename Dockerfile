ARG ARCH=
FROM ${ARCH}debian

#FROM ubuntu:20.04

RUN apt-get update -qq && apt-get install -y -qq python3 python3-pip supervisor android-tools-adb

RUN pip3 install pure-python-adb
RUN pip3 install pyudev

COPY ./bin /adb-scripter/bin
COPY ./config /adb-scripter/config
COPY ./src /adb-scripter/src

COPY ./config/supervisord.conf /etc/supervisord.conf




CMD /usr/bin/supervisord -c /etc/supervisord.conf
