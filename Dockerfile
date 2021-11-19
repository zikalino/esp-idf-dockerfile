FROM espressif/idf

RUN apt-get update && apt-get install -y dos2unix
RUN apt-get -y install ruby
RUN apt-get -y install libbsd-dev
RUN apt-get -y install fish
RUN apt-get -y install zsh
RUN apt-get -y install shellcheck

# install additional python modules needed by tests:
# - pexpect
# - coverage
RUN ["bash",  "-c", ". /opt/esp/idf/export.sh && pip install pexpect coverage"]

COPY entrypoint.sh /opt/esp/entrypoint.sh
RUN dos2unix /opt/esp/entrypoint.sh

# RUN apt-get update &&  apt-get install -y dos2unix && dos2unix /opt/esp/entrypoint.sh && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/*
ENTRYPOINT [ "/opt/esp/entrypoint.sh" ]
CMD [ "/bin/bash" ]
