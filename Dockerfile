FROM crystallang/crystal:1.0.0

RUN apt-get update \
  && apt-get install -y libc6-dev libevent-dev libpcre2-dev libpcre3-dev libpng-dev libssl1.0-dev libyaml-dev zlib1g-dev tmux curl


# Install node, yarn and dependencies
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash - \
  && apt-get install -y nodejs

RUN apt-get update && apt-get install -y cmake build-essential libssl-dev libreadline-dev libxml2-dev libcurl4-openssl-dev software-properties-common libffi-dev

RUN npm install --global yarn

# Install Postgres Client Libraries
RUN apt-get install -y postgresql-common libpq-dev postgresql-client


RUN git clone https://github.com/luckyframework/lucky_cli \
  && cd lucky_cli \
  && git checkout v0.27.0 \
  && shards install \
  && crystal build src/lucky.cr \
  && mv lucky /usr/local/bin \
  && cd .. \
  && rm -rf ./lucky_cli


# Install overmind

RUN curl -LO https://github.com/DarthSim/overmind/releases/download/v2.2.0/overmind-v2.2.0-linux-386.gz \
  && gunzip overmind-v2.2.0-linux-386.gz \
  && chmod +x overmind-v2.2.0-linux-386 \
  && mv overmind-v2.2.0-linux-386 /usr/local/bin/overmind

# Install chrome & chromedriver for Lucky Flow

RUN apt-get update && \
    apt-get install -y gnupg wget curl unzip --no-install-recommends && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list && \
    apt-get update -y && \
    apt-get install -y google-chrome-stable && \
    CHROMEVER=$(google-chrome --product-version | grep -o "[^\.]*\.[^\.]*\.[^\.]*") && \
    DRIVERVER=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROMEVER") && \
    wget -q --continue -P /chromedriver "http://chromedriver.storage.googleapis.com/$DRIVERVER/chromedriver_linux64.zip" && \
    unzip /chromedriver/chromedriver* -d /chromedriver
#
# Put Chromedriver into the PATH
ENV PATH /chromedriver:$PATH

WORKDIR /app

EXPOSE 5000
CMD ["lucky", "-v"]
