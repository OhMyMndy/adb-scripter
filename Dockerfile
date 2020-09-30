ARG ARCH=
FROM ${ARCH}debian

RUN apt-get update -qq \
    && apt-get install -y -qq  --no-install-recommends python3-setuptools python3 python3-pip supervisor android-tools-adb udev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install pure-python-adb
RUN pip3 install pyudev

COPY ./bin /adb-scripter/bin
COPY ./config /adb-scripter/config
COPY ./src /adb-scripter/src

COPY ./config/supervisord.conf /etc/supervisord.conf


ENV PYTHONUNBUFFERED=True
CMD /usr/bin/supervisord -n -c /etc/supervisord.conf
