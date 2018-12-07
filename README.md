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
9. Add host entry

```
SET NEWLINE=^& echo.
SET DOCKER_HOST_IP=^& docker-machine ip default
FIND /C /I "docker-machine" %WINDIR%\system32\drivers\etc\hosts
IF %ERRORLEVEL% NEQ 0 ECHO %NEWLINE%^%DOCKER_HOST_IP% docker-machine >> %WINDIR%\System32\drivers\etc\hosts
```
10. Install [Minikube](https://chocolatey.org/packages/Minikube)

```
choco install -y minikube
```
11. Configure git identity

```
git config --global user.name "Khemara Chuon"
git config --global user.email 44907753+khemarachuon@users.noreply.github.com
git config --global core.autocrlf false
```

# Startup Windows development environment
1. Start docker-machine

```
docker-machine start
```
2. Start minikube

```
minikube start
```

# Shutdown Windows development environment
1. Stop minikube

```
minikube stop
```
2. Stop docker-machine

```
docker-machine stop
```

# Cleanup containers and images
1. Cleanup stopped containers

```
FOR /F %I IN ('docker ps -a -q') DO docker rm %~I
```
2. Cleanup dangling images

```
docker image prune -f
```
