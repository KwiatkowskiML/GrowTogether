docker build -t grow .
docker run -dp 80:80 -e PORT=80 grow