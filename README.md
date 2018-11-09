# Setup Windows development environment
1. Open a command prompt with administrator privileges
2. Install [Chocolatey](https://chocolatey.org/docs/installation)

```
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```
3. Install [OpenJDK](https://chocolatey.org/packages/openjdk)

```
choco install -y openjdk
```
4. Install [Maven](https://chocolatey.org/packages/maven)

```
choco install -y maven
```
5. Install [Eclipse](https://chocolatey.org/packages/eclipse)

```
choco install -y eclipse
```
6. Install [VirtualBox](https://chocolatey.org/packages/virtualbox)

```
choco install -y virtualbox
```
7. Install [Docker Toolbox](https://chocolatey.org/packages/docker-toolbox)

```
choco install -y docker-toolbox
docker-machine create --driver virtualbox default
```
8. Set system environment variables

  Print environment variables needed to connect to the default docker machine.
```
docker-machine env default
```
  Set the system environment variables using the values obtained from the previous step
```
SETX /M DOCKER_TLS_VERIFY=true
SETX /M DOCKER_HOST=tcp://<ip>:2376
SETX /M DOCKER_CERT_PATH=%HOMEDRIVE%%HOMEPATH%\.docker\machine\machines\default
SETX /M DOCKER_MACHINE_NAME=default
SETX /M COMPOSE_CONVERT_WINDOWS_PATHS=true
```
9. Install [Minikube](https://chocolatey.org/packages/Minikube)

```
choco install -y minikube
```
