# README

API de Datos Sismológicos
Este proyecto es una aplicación Ruby on Rails diseñada para obtener y persistir datos sismológicos desde el sitio USGS, y exponer estos datos a través de una API REST. La aplicación incluye una tarea para recopilar datos y dos endpoints para consultar y modificar estos datos.

Para ejecutar la aplicación, sigue estos pasos:

Clona el repositorio.
Instala las dependencias con bundle install.
Configura la base de datos en config/database.yml.
Ejecuta las migraciones con rails db:migrate.
Inicia la aplicación con rails server.
Uso
Para interactuar con la API, utiliza los siguientes comandos curl:

# Obtener lista de features
curl --location --request GET 'http://127.0.0.1:3000/earthquakes' \
--header 'Content-Type: application/json'
'

curl --location --request GET 'http://127.0.0.1:3000/earthquakes/2' \
--header 'Content-Type: application/json' \
--data '{
    "body": "Prueba de comentario"
}
'

# Crear un comentario
curl --location 'http://127.0.0.1:3000/earthquakes/2/comments' \
--header 'Content-Type: application/json' \
--data '{
    "body": "Prueba de comentario"
}
'
* ...
#   s i s m o - a p i 
 
 