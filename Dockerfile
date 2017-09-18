FROM alpine:3.6
LABEL maintainer="xorphitus@gmail.com"

RUN apk update && apk upgrade
RUN apk add curl

#
# Install Emacs
#
RUN apk add emacs

#
# Install cask
#
RUN apk add git python
RUN mkdir -p /app
RUN git clone https://github.com/cask/cask.git /app/cask
RUN apk del git

#
# Run cask instal
#
RUN mkdir -p /app/user
WORKDIR /app/user

ENV PATH /app/cask/bin:$PATH
COPY ./Cask /app/user/
RUN cask install
COPY . /app/user/

#
# Export environment variables that are read during startup
#
RUN mkdir -p /app/.profile.d/
RUN echo "export PATH=\"$PATH\"" > /app/.profile.d/path.sh

#
# Emulate the feature as describes above
#
COPY ./init.sh /init.sh
RUN chmod +x /init.sh
ENTRYPOINT ["/init.sh"]
