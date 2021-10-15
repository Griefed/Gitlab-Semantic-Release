### [2.0.2](https://git.griefed.de/prosper/gitlab-semantic-release/compare/2.0.1...2.0.2) (2021-10-15)


### 🦊 CI/CD

* Update ci-cd image to 1.0.2 ([a8b3995](https://git.griefed.de/prosper/gitlab-semantic-release/commit/a8b3995d33e1dd82d91d1b0b75567de6b0c38a33))


### 🛠 Fixes

* Update nodejs and npm ([bd98362](https://git.griefed.de/prosper/gitlab-semantic-release/commit/bd9836221912da4a02834a9a46cf1361b2ae7deb))

### [2.0.1](https://git.griefed.de/prosper/gitlab-semantic-release/compare/2.0.0...2.0.1) (2021-10-15)


### 🦊 CI/CD

* Switch image to gitlab-ci-cd which provides for all jobs ([76e5e80](https://git.griefed.de/prosper/gitlab-semantic-release/commit/76e5e80c01d574e7f336546f69756e598edddfd9))


### 🛠 Fixes

* use stable as baseimage as latest no longer has armv7 images ([a726424](https://git.griefed.de/prosper/gitlab-semantic-release/commit/a72642468660b163e822ce55fa4a41c5ca20ec11))


### Other

* Add GitLab issue templates ([a94f292](https://git.griefed.de/prosper/gitlab-semantic-release/commit/a94f2929cf7a17af5b0da4a53afc5ea1e7f31387))
* **deps:** update griefed/gitlab-ci-cd docker tag to v1.0.1 ([779ecf6](https://git.griefed.de/prosper/gitlab-semantic-release/commit/779ecf66ee606223cb59d6a4ad03fcddfa2b5723))

## [2.0.0](https://git.griefed.de/prosper/gitlab-semantic-release/compare/1.1.3...2.0.0) (2021-07-09)


### 📔 Docs

* Include example config files for GitLab-Runner, gitlab-ci and releaserc ([a99fc5f](https://git.griefed.de/prosper/gitlab-semantic-release/commit/a99fc5ff3d534e5e3da6708d938b078e8b8c299f))


### 🦊 CI/CD

* Create release on GitHub after tag mirror from GitLab ([1b15596](https://git.griefed.de/prosper/gitlab-semantic-release/commit/1b155960d9d0e124f1b509cd834a115c4ac6e7f4))
* Fix "breaking" type ([4fda30f](https://git.griefed.de/prosper/gitlab-semantic-release/commit/4fda30f417545f6705c808c7da2f0af66e02d456))
* Move Docker build for GitHub container registry to GitLab ([02477c9](https://git.griefed.de/prosper/gitlab-semantic-release/commit/02477c97fa9cc3f6877194122778c5f4fec5e385))
* Remove from.cache in docker test job. Refactor build to use cache from develop tag. ([43dbca1](https://git.griefed.de/prosper/gitlab-semantic-release/commit/43dbca18dd09df478fb02ccc7962d7a85ce9ee86))
* Switch images to DockerHub ([6b47c5c](https://git.griefed.de/prosper/gitlab-semantic-release/commit/6b47c5c655cc722c41e4c7b2ffbc9aaadb9f6217))
* Test self-hosted Dependabot ([79a77a8](https://git.griefed.de/prosper/gitlab-semantic-release/commit/79a77a869bd5376915efaaf7b0384f0736eb9f43))


### Other

* Inform users/visitors about move to GitLab ([56f1b38](https://git.griefed.de/prosper/gitlab-semantic-release/commit/56f1b38eee686ddd11d25e778b4cdeb96c6feb1c))
* Update gitlab-ci template in README ([fca424d](https://git.griefed.de/prosper/gitlab-semantic-release/commit/fca424d4700f260d4e55f612c3f1b6841d6f5fa0))

### [1.1.3](https://git.griefed.de/prosper/gitlab-semantic-release/compare/1.1.2...1.1.3) (2021-06-16)


### 🦊 CI/CD

* Equalize releasercs ([8134492](https://git.griefed.de/prosper/gitlab-semantic-release/commit/8134492ed96ed40bfadd6aa96cd53a83c0f5c471))
* Restrict test stage to exclude releases and tags ([cd4dd0d](https://git.griefed.de/prosper/gitlab-semantic-release/commit/cd4dd0d9d3313f88253ee114da716e3387809508))
* Update gitlab-ci with results from docker-with-buildx ([7ce778e](https://git.griefed.de/prosper/gitlab-semantic-release/commit/7ce778ece93ce6d10b4f00ea825d07dc36a0279c))
* Update releaserc with results from docker-with-buildx ([66dc6a8](https://git.griefed.de/prosper/gitlab-semantic-release/commit/66dc6a8a5e789b1b0657f767f9058790d85d3605))


### 🛠 Fixes

* Remove male gender symbol from changelog because why tf was it there in the first place ([0b03136](https://git.griefed.de/prosper/gitlab-semantic-release/commit/0b031361845372608fd3b53c68736384c2059abf))


### Other

* Add gitignore ([502cdc6](https://git.griefed.de/prosper/gitlab-semantic-release/commit/502cdc6778c0618344066bc68b86b8e4e0321454))
* Add label to Dockerfile ([3df3120](https://git.griefed.de/prosper/gitlab-semantic-release/commit/3df31203bfece5a3e56173018024a8d1340c68f2))

### [1.1.2](https://git.griefed.de/prosper/gitlab-semantic-release/compare/1.1.1...1.1.2) (2021-06-15)


### Bug Fixes

* Hopefully fix config options being empty ([4ea9ee8](https://git.griefed.de/prosper/gitlab-semantic-release/commit/4ea9ee8faeca544e7c05de57e3be1fe7f2139962))
* Repair Dockerfile. I'm blind and stupid. ([9647913](https://git.griefed.de/prosper/gitlab-semantic-release/commit/9647913edb74b6ab05d0eca1ab023fe8081f6fc5))


### Reverts

* Well then, guess no gitlab-config via Dockerfile ([cae0436](https://git.griefed.de/prosper/gitlab-semantic-release/commit/cae0436be6727ff2968a283152859460df585836))

### [1.1.1](https://gitlab.com/ujlbu4/gitlab-semantic-release/compare/1.1.0...1.1.1) (2020-08-28)


### Bug Fixes

* disable success/fail jobs ([298fb05](https://gitlab.com/ujlbu4/gitlab-semantic-release/commit/298fb055b6b2729fa8b263e51939e66261098be2))

## [1.1.0](https://gitlab.com/ujlbu4/gitlab-semantic-release/compare/1.0.0...1.1.0) (2020-08-28)


### Features

* add notifications ([92da5cd](https://gitlab.com/ujlbu4/gitlab-semantic-release/commit/92da5cdf3efaf6189bd90d5f30370ca2fb5b44d2))

## [1.0.0](https://gitlab.com/ujlbu4/gitlab-semantic-release/compare/...1.0.0) (2020-08-28)


### Bug Fixes

* fake release (test release) ([e8599cb](https://gitlab.com/ujlbu4/gitlab-semantic-release/commit/e8599cbed61aa5cf289a75fed710ce3d0ddff0f1))
