@ECHO OFF

ECHO Cleanup stopped containers
FOR /F %%I IN ('docker ps -a -q') DO docker rm %%~I

ECHO Cleanup dangling images
docker image prune -f

ECHO DONE