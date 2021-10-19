FROM docker:20.10.9

LABEL maintainer="Griefed <griefed@griefed.de>"

RUN \
  apk update && \
  apk upgrade && \
  apk add --no-cache \
    bash \
    git \
    ca-certificates \
    curl \
    nodejs-current \
    npm

RUN \
  echo "node version is: " && \
    node -v && \
  echo "npm version is: " && \
    npm -v && \
  echo "updating npm..." && \
  npm update -g && \
  npm install npm@latest -g && \
  echo "node version is: " && \
    node -v && \
  echo "npm version is: " && \
    npm -v && \
  npm install -g \
    conventional-changelog-conventionalcommits \
    semantic-release \
    @semantic-release/changelog \
    @semantic-release/commit-analyzer \
    @semantic-release/exec \
    @semantic-release/git \
    @semantic-release/gitlab \
    @semantic-release/npm \
    @semantic-release/release-notes-generator

RUN \
  rm -rf \
    /var/cache/apk/*
