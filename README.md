This is a mocked up demo of what the user experience of the ploigos step runner could be.

# Installing in CodeReady Workspaces

```
crwctl workspace:create -f Devfile
```

Build and publish the images:
```
buildah bud -t ploigos-toolbox . && podman push ploigos-toolbox quay.io/<<<< Your Repository >>>>/ploigos-toolbox

ploigos-workspace/
buildah bud -t ploigos-workspace:0.2 && podman push ploigos-workspace:0.2 quay.io/<<<< Your Repository >>>>/ploigos-workspace

```

# Installing Locally
The mocking aliases some conosole commands. To install:
```
source ./bin/install
```

To uninstall and get your real commands back:
```
source ./bin/uninstall
```

# Running Locally
```
podman run --rm -it --volume=$(pwd):/working:Z ploigos-toolbox /bin/bas
```

# Demoing SonarQube Locally

```
podman run --name=sonar -it -p 9000:9000 sonarqube:9.1.0-community
psr quality
```
