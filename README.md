
Example how to bump up release version using [semantic-release](https://github.com/semantic-release/semantic-release)


##### Setup 

All setting you cand find in [.releaserc.yml](.releaserc.yml) file

:warning:  Make notice to put in ci/cd variables `GITLAB_TOKEN` secret (masked) variable with personal-access-token which is have read/write permision to registry and repository

Currently it's doing next things:
- bump up semantic version (major/minor/patch) according commit [prefixes](https://github.com/angular/angular.js/blob/master/DEVELOPERS.md#type)
- create git tag with release version
- create [release](https://gitlab.com/ujlbu4/gitlab-semantic-release/-/releases) in gitlab
- update [CHANGELOG.md](CHANGELOG.md) with release notes wich was generated from commits
- commit & push all above steps back to git

At's possible to setup
- update custom file with release version (ie)
- send slack/mattermost notifications