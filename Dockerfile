FROM espressif/idf

RUN apt-get update && apt-get install -y dos2unix

COPY entrypoint.sh /opt/esp/entrypoint.sh
RUN dos2unix /opt/esp/entrypoint.sh

# RUN apt-get update &&  apt-get install -y dos2unix && dos2unix /opt/esp/entrypoint.sh && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/*
ENTRYPOINT [ "/opt/esp/entrypoint.sh" ]
CMD [ "/bin/bash" ]
