## Fork of https://gitlab.com/mlonn/gitlab-semantic-release -> git.griefed.de -> github.com/Griefed

### Setup 

All settings can be found in the [.releaserc.yml-file](.releaserc.yml)

:warning:  Requires CI/CD variable `GITLAB_TOKEN` with personal-access-token (read/write permision to registry and repository).

Currently it's doing:
- bump up semantic version (major/minor/patch) according commit [prefixes](https://github.com/angular/angular.js/blob/master/DEVELOPERS.md#type)
- create git tag with release version
- create [release](https://gitlab.com/ujlbu4/gitlab-semantic-release/-/releases) in gitlab
- update [CHANGELOG.md](CHANGELOG.md) with release notes wich was generated from commits
- commit & push all above steps back to git
