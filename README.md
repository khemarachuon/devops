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
6. Install [Miniconda](https://chocolatey.org/packages/miniconda3)

```
choco install -y miniconda3
```
  Set the system environment variables
```
SETX /M CONDA_HOME=C:\tools\miniconda3
SETX /M PATH=%PATH$:%CONDA_HOME%\Scripts:%CONDA_HOME%
```
  Create virtual environment
```
conda create --name py37 python=3.7 --yes
```
  Upgrade packages
```
pip install --upgrade pip setuptools
```
7. Install [Visual Studio 2017 Build Tools](https://chocolatey.org/packages/visualstudio2017buildtools)

```
choco install -y choco install visualstudio2017buildtools
```
8. Install [VirtualBox](https://chocolatey.org/packages/virtualbox)

```
choco install -y virtualbox
```
9. Install [Docker Toolbox](https://chocolatey.org/packages/docker-toolbox)

```
choco install -y docker-toolbox
docker-machine create --driver virtualbox default
```
10. Set system environment variables

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
11. Install [Minikube](https://chocolatey.org/packages/Minikube)

```
choco install -y minikube
```
12. Install [Minishift](https://chocolatey.org/packages/minishift)

```
choco install -y minishift
```
  Configure minishift
```
minishift config set vm-driver virtualbox
```
13. Install [LocalStack](https://pypi.org/project/localstack)

```
pip install coverage===4.0.3 urllib3===1.22 localstack
```
14. Configure git identity

```
git config --global user.name "Khemara Chuon"
git config --global user.email 44907753+khemarachuon@users.noreply.github.com
```
