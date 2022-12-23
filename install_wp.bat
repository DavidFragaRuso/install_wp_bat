@echo off

:: Variables esenciales
:: Substituir los valores por los correctos segun el proyecto

SET DIR_NAME=wp_dev
SET DBNAME=wp_dev_db
set DBPREFIX=wpd_
SET DBUSER=root
SET DBPASS=root
SET WPTITLE="WordPress Development"
SET USER=d_fraga
SET EMAIL=david.fraga.bcn@gmail.com
SET USERPASS=1234

echo Install WordPress

::Crea el nuevo directorio en nuestro localhost
mkdir %DIR_NAME%

:: Entra al nuevo directorio
cd %DIR_NAME%

echo Download WordPress core

:: Descarga WordPress
call wp core download --locale=es_ES --force

:: Crea el archivo wp-config.php
call wp config create --dbname=%DBNAME% --dbuser=%DBUSER% --dbprefix=%DBPREFIX%

:: Crea la base de datos
call wp db create

:: Instala WordPress
call wp core install --url=localhost/%DIR_NAME% --title=%WPTITLE% --admin_user=%USER% --admin_password=%USERPASS% --admin_email=%EMAIL%

:: Borra el plugin Hello Dolly
call wp plugin delete hello

:: Instala Contact form 7
call wp plugin install contact-form-7 --activate

:: Crea contenido dummy
call curl http://loripsum.net/api/5 | wp post generate --post_content --count=50 --post_author=d_fraga

:: Para la ejecución para poder ver si hay errores
pause

:: Cierra la ventana de la terminal
:: :END