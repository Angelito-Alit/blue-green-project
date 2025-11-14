@echo off
echo ================================
echo Desplegando VERSION BLUE
echo ================================

echo Deteniendo contenedores antiguos...
docker stop blue 2>nul
docker stop green 2>nul
docker stop nginx 2>nul
docker rm blue 2>nul
docker rm green 2>nul
docker rm nginx 2>nul

echo Creando red Docker...
docker network create blue-green-network 2>nul

echo Construyendo imagen Blue...
cd ..\blue
docker build -t blue-app .

echo Iniciando contenedor Blue...
docker run -d --name blue --network blue-green-network blue-app

echo Esperando que Blue inicie...
timeout /t 3 /nobreak

echo Verificando que Blue este corriendo...
docker ps | findstr blue

echo Construyendo imagen Nginx (Blue)...
cd ..\nginx
docker build -t nginx-proxy .

echo Iniciando Nginx apuntando a Blue...
docker run -d --name nginx --network blue-green-network -p 8080:80 nginx-proxy

echo Esperando que Nginx inicie...
timeout /t 3 /nobreak

echo ================================
echo Verificando contenedores...
docker ps

echo ================================
echo VERSION BLUE desplegada en http://localhost:8080
echo ================================
pause