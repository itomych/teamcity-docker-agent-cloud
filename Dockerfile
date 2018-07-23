FROM mikhailmerkulov/teamcity-docker-agent-compose

LABEL maintainer "Mikhail Merkulov <mikhail.m@itomy.ch>"
RUN add-apt-repository ppa:jonathonf/python-3.6

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y python3.6 && \
    apt-get install -y tzdata locales python3-pip curl unzip groff make wget && \
    pip3 install --no-cache-dir --upgrade pip

RUN pip install awsebcli
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"&& \
    unzip awscli-bundle.zip && \
    ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

ADD https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest /usr/local/bin/ecs-cli

RUN chmod 555 /usr/local/bin/ecs-cli

# delete cache and tmp files
RUN apt-get clean && \
  apt-get autoclean && \
  rm -rf /var/cache/* && \
  rm -rf /tmp/* && \
  rm -rf /var/tmp/* && \
  rm -rf /var/lib/apt/lists/* && \
  # make some useful symlinks that are expected to exis
  cd /
