FROM docker:dind

RUN apk update && apk upgrade && \
    apk add --no-cache \
        bash \
        git \
        ca-certificates \
        curl \
        nodejs \
        npm 
RUN node --version && \
    npm --version

RUN npm install -g \
        conventional-changelog-conventionalcommits \
        semantic-release \
        @semantic-release/changelog \
        @semantic-release/commit-analyzer \
        @semantic-release/exec \
        @semantic-release/git \
        @semantic-release/gitlab \
        @semantic-release/npm \
        @semantic-release/release-notes-generator \


RUN rm -rf /var/cache/apk/*
