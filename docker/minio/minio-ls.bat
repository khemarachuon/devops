@ECHO OFF

ECHO docker run -e "MC_HOSTS_s3=http://access_key:secret_key@172.17.0.2:9000" minio/mc ls s3/
docker run -e "MC_HOSTS_s3=http://access_key:secret_key@172.17.0.2:9000" minio/mc ls s3/
