FROM docker:dind

# we use docker image as base image cause we need docker and nod
# it's simplier to install node in docker neither docker in node
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

COPY daemon.json /etc/docker/daemon.json

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
        semantic-release-slack-bot

RUN rm -rf /var/cache/apk/*