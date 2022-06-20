
## Sobre el proyecto 

Es una api sencilla sin frameworks php. la estructura de carpetas es 

base : archivo con funciones generales que se usan en el programa.
include : archivos de conexiones y parametros de la base de datos.
v1 : archivo para construir la estructura de datos del reporte de ordenes
view : archivos html para la vista del reporte de ordenes

Orders.php : archivo para ejecutar consultas SQL
Services.php : archivo inicial




## Sobre la base de datos

1)Se realizó en MYSQL mediante PDO , cambiar los parametros de configuración en el directorio : include/Parameters.php.

2)En el directorio principal se esta dejando el script SQL de la base de datos con nombre api.sql

3)Verificar si esta habilitada la extension pdo_mysql en el php.ini de su servidor.

## Para consumir la api

Debes enviar un json como el siguiente ejemplo :

la clave token es un identificador que lo uso para restringir su uso ,revisar la tabla TOKENS de la base de datos

{
  "token":"49319d1dbd60d6a141640d44a2d665edf5b0b1bb",
  
  "data": {

   "cod_employee":"c001"
   }
   
    
 }

 El endpoint en localhost seria : http://localhost/choho/Services.php , testear mediante algun programa tipo POSTMAN.


## Sobre la vista del reporte 

En el archivo que se encuentra en view/js/orders.js , la variable server = 'http://localhost/choho/'; que se encuentra en la cabecera cambiarla de ser necesario si modifica el endpoint.


Para ver el reporte ir a http://localhost/choho/view/index.php.


## Anexos

Se adjunta un documento Resultados.docx con las imagenes de los resultados. 