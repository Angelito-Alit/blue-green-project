@echo off
echo ================================
echo Desplegando VERSION GREEN
echo ================================

echo Construyendo imagen Green...
cd green
docker build -t green-app .
cd ..

echo Iniciando contenedor Green...
docker run -d --name green --network blue-green-network green-app

echo ================================
echo VERSION GREEN lista (sin trafico aun)
echo Para cambiar el trafico ejecuta: switch.bat
echo ================================
pause