@ECHO OFF

docker rm -f minio
docker run -d --name minio --rm -p 9000:9000 -e "MINIO_ACCESS_KEY=access_key" -e "MINIO_SECRET_KEY=secret_key" minio/minio server /data

ECHO.
ECHO Access Key:     access_key
ECHO Secret Key:     secret_key
ECHO Browser Access: http://docker-machine:9000/minio/
