##### Fork of https://gitlab.com/mlonn/gitlab-semantic-release -> git.griefed.de -> github.com/Griefed

[[_TOC_]]

# Setup 

:warning: **Requires CI/CD variable `GITLAB_TOKEN` with personal-access-token (read/write permision to registry and repository).**

:warning: **Requires CI/CD variable `DOCKERHUB_USER` with lowercase username of the Dockerhub repository owner where the image will be pushed to.**

:warning: **Requires CI/CD variable `DOCKERHUB_REPO` with lowercase name of the Dockerhub repository where the image will be pushed to.**

:warning: **Requires CI/CD variable `DOCKERHUB_TOKEN` with personal-access-token to Docherhub.**

Currently it's doing:
- bump up semantic version (major/minor/patch) according commit [prefixes](https://github.com/angular/angular.js/blob/master/DEVELOPERS.md#type)
- create tag with release version
- create release for new tag
- update [CHANGELOG.md](CHANGELOG.md) with release notes generated from commits
- commit & push all above steps

# Example setup files

## GitLab Runner config.toml
Example config.toml for a GitLab-Runner which works with a dockerized GitLab and multiarch Docker images using buildx:

```toml
concurrent = 1
check_interval = 0

[session_server]
  session_timeout = 1800

[[runners]]
  name = "Runner-One"
  url = "https://url.to.your.gitlab"
  token = "token_generated_by_runner_registration"
  executor = "docker"
  environment = ["DOCKER_TLS_CERTDIR="]
  [runners.custom_build_dir]
  [runners.cache]
    [runners.cache.s3]
    [runners.cache.gcs]
    [runners.cache.azure]
  [runners.docker]
    tls_verify = false
    image = "ubuntu:20.04"
    privileged = true
    disable_entrypoint_overwrite = false
    oom_kill_disable = false
    disable_cache = false
    cache_dir = "/cache"
    volumes = ["/var/run/docker.sock:/var/run/docker.sock", "/cache"]
    shm_size = 0
```

## GitLab .gitlab-ci.yml
Example of a GitLab CI comosed of three stages: test, release and build

```yml
stages:
  - test
  - release
  - build

test docker:
  stage: test
  image: griefed/docker-with-buildx:latest
  services:
    - name: docker:dind
      alias: docker
  variables:
    project_name: $CI_PROJECT_NAME
    SEMANTIC_RELEASE_PACKAGE: $CI_PROJECT_NAME
  before_script:
    - docker login -u "$DOCKERHUB_USER" -p "$DOCKERHUB_TOKEN" docker.io
    - docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD" $CI_REGISTRY
    - docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
    - docker buildx create --use --name mybuilder
  script:
    - docker buildx build
      --push
      --platform linux/amd64,linux/arm/v7,linux/arm64
      --tag "$CI_REGISTRY_IMAGE:develop"
      --tag "index.docker.io/$DOCKERHUB_USER/$DOCKERHUB_REPO:develop" .
  except:
    refs:
      - tags
    variables:
      - $CI_COMMIT_TITLE =~ /^RELEASE:.+$/

release:
  needs: ['test docker']
  stage: release
  image: griefed/gitlab-semantic-release:latest
  services:
    - name: docker:dind
      alias: docker
  variables:
    project_name: $CI_PROJECT_NAME
    SEMANTIC_RELEASE_PACKAGE: $CI_PROJECT_NAME
  script:
    - npx semantic-release
  only:
    - master
  except:
    refs:
      - tags
    variables:
      - $CI_COMMIT_TITLE =~ /^RELEASE:.+$/

build:
  stage: build
  image: griefed/docker-with-buildx:latest
  services:
    - name: docker:dind
      alias: docker
  variables:
    project_name: $CI_PROJECT_NAME
    SEMANTIC_RELEASE_PACKAGE: $CI_PROJECT_NAME
  before_script:
    - docker login -u "$DOCKERHUB_USER" -p "$DOCKERHUB_TOKEN" docker.io
    - docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD" $CI_REGISTRY
    - docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
    - docker buildx create --use --name mybuilder
  script:
    - docker pull "$CI_REGISTRY_IMAGE:develop"
    - docker buildx build
      --push
      --platform linux/amd64,linux/arm/v7,linux/arm64
      --cache-from "$CI_REGISTRY_IMAGE:develop"
      --tag "$CI_REGISTRY_IMAGE:latest"
      --tag "index.docker.io/$DOCKERHUB_USER/$DOCKERHUB_REPO:$CI_COMMIT_TAG"
      --tag "index.docker.io/$DOCKERHUB_USER/$DOCKERHUB_REPO:latest" .
  only:
    - tags
```

## Semantic-Release .releaserc.yml
Example config for changelog, tag and release generating config file using conventional commits.

```yml
branches: ['master','main']
ci: true
debug: true
dryRun: false
tagFormat: '${version}'

# Global plugin options (will be passed to all plugins)
preset: 'conventionalcommits'
gitlabUrl: 'https://url.to.your.gitlab' # your gitlab url

# Responsible for verifying conditions necessary to proceed with the release:
# configuration is correct, authentication token are valid, etc...
verifyConditions:
  - '@semantic-release/changelog'
  - '@semantic-release/git'
  - '@semantic-release/gitlab'

# Responsible for determining the type of the next release (major, minor or patch).
# If multiple plugins with a analyzeCommits step are defined, the release type will be
# the highest one among plugins output.
# Look details at: https://github.com/semantic-release/commit-analyzer#configuration
analyzeCommits:
  - path: '@semantic-release/commit-analyzer'
    releaseRules:
      - breaking: true
        release: major
      - type: build     # Changes that affect the build system or external dependencies
        release: patch
      - type: chore     # Other changes that don't modify src or test files
        release: false
      - type: ci        # Changes to our CI configuration files and scripts
        release: false
      - type: docs      # Documentation only changes
        release: false
      - type: feat      # A new feature
        release: minor
      - type: fix       # A bug fix
        release: patch
      - type: perf      # A code change that improves performance
        release: patch
      - type: refactor  # A code change that neither fixes a bug nor adds a feature
        release: false
      - type: revert    # Reverts a previous commit
        release: patch
      - type: style     # Changes that do not affect the meaning of the code
        release: false
      - type: test      # Adding missing tests or correcting existing tests
        release: false

# Responsible for generating the content of the release note.
# If multiple plugins with a generateNotes step are defined,
# the release notes will be the result of the concatenation of each plugin output.
generateNotes:
  - path: '@semantic-release/release-notes-generator'
    writerOpts:
      groupBy: 'type'
      commitGroupsSort: 'title'
      commitsSort: 'header'
    linkCompare: true
    linkReferences: true
    presetConfig:
      types:  # looks like it only works with 'conventionalcommits' preset
        - type: 'build'
          section: '🦊 CI/CD'
          hidden: false
        - type: 'chore'
          section: 'Other'
          hidden: false
        - type: 'ci'
          section: '🦊 CI/CD'
          hidden: false
        - type: 'docs'
          section: '📔 Docs'
          hidden: false
        - type: 'example'
          section: '📝 Examples'
          hidden: false
        - type: 'feat'
          section: '🚀 Features'
          hidden: false
        - type: 'fix'
          section: '🛠 Fixes'
          hidden: false
        - type: 'perf'
          section: '⏩ Performance'
        - type: 'refactor'
          section: ':scissors: Refactor'
          hidden: false
        - type: 'revert'
          section: '👀 Reverts'
        - type: 'style'
          section: '💈 Style'
        - type: 'test'
          section: '🧪 Tests'
          hidden: false

# Responsible for preparing the release, for example creating or updating files
# such as package.json, CHANGELOG.md, documentation or compiled assets
# and pushing a commit.
prepare:
  # - path: '@semantic-release/exec'
  #   # Execute shell command to set package version
  #   cmd: './deployment/version-plaintext-set.sh ${nextRelease.version}'
  # - path: '@semantic-release/exec'
  #   cmd: './deployment/version-oas-set.sh ${nextRelease.version} openapi.yaml'
  # - path: '@semantic-release/exec'
  #   verifyReleaseCmd: "echo ${nextRelease.version} > VERSION.txt"
  - path: '@semantic-release/changelog'
    # Create or update the changelog file in the local project repository
  - path: '@semantic-release/git'
    # Push a release commit and tag, including configurable files
    message: 'RELEASE: ${nextRelease.version}'
    assets: ['CHANGELOG.md']

# Responsible for publishing the release.
publish:
  - path: '@semantic-release/gitlab'
    # Publish a GitLab release
    #  (https://docs.gitlab.com/ce/user/project/releases/index.html#add-release-notes-to-git-tags)

success: false

fail: false
```
