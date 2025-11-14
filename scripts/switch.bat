@echo off
echo ================================
echo Cambiando trafico a VERSION GREEN
echo ================================

echo Deteniendo Nginx...
docker stop nginx
docker rm nginx

echo Reconstruyendo Nginx para Green...
cd nginx
copy /Y nginx-green.conf nginx.conf.tmp
docker build -f Dockerfile-green -t nginx-proxy-green .
del nginx.conf.tmp
cd ..

echo Iniciando Nginx apuntando a Green...
docker run -d --name nginx --network blue-green-network -p 8080:80 nginx-proxy-green

echo ================================
echo Trafico cambiado a VERSION GREEN
echo Accede a: http://localhost:8080
echo ================================
pause