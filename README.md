# Proyecto CI-GitHub-2024-1

Este proyecto contiene un código fuente de una aplicación web que será contenerizada utilizando Docker. A continuación se describe el proceso para contenerizar la aplicación y automatizarlo con GitHub Actions.

## Estructura del Proyecto

El proyecto tiene la siguiente estructura de archivos y directorios:


```
├── Dockerfile
├── README.md
├── images/
├── node_modules/
├── package-lock.json
├── package.json
├── public/
├── src/
└── yarn.lock
```


## Contenerización del Proyecto

Se creará un archivo Dockerfile en el directorio del proyecto para contenerizar la aplicación. El Dockerfile contendrá las siguientes instrucciones:

```Dockerfile
# Utiliza la imagen base de Node.js
FROM node:latest

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos de tu proyecto al directorio de trabajo del contenedor
COPY . /app/

# Instala las dependencias del proyecto
RUN npm install

# Expone el puerto 3000 para acceder a la aplicación desde fuera del contenedor
EXPOSE 3000

# Define el comando para iniciar la aplicación
CMD ["npm", "start"]

```


## Automatización con GitHub Actions


Se utilizará GitHub Actions para automatizar el proceso de contenerización y despliegue de la aplicación. A continuación se muestra el archivo YAML de configuración de GitHub Actions:

```
name: Docker Image CI

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:

  build:

    runs-on: ubuntu-latest

    steps:
    - name: Checkout
      uses: actions/checkout@v2 # Specify the version of the checkout action
    
    - name: Build the Docker image
      run: docker build . --file Dockerfile -t ventana1901/rick-and-morty:${{ github.run_number }}
      # Use github.run_number to tag the Docker image with a unique identifier
    
    - name: Docker Login
      uses: docker/login-action@v2
      with:
        username: ${{ secrets.DOCKER_USERNAME }}
        password: ${{ secrets.DOCKER_PASSWORD }}

    - name: Push into Docker-hub
      run: docker push ventana1901/rick-and-morty:${{ github.run_number }}
      # Use github.run_number to reference the same tag used during build
```

Este archivo YAML configura un flujo de trabajo de GitHub Actions que se activa en cada push o pull request en la rama main. Realiza los siguientes pasos:

- Realiza el checkout del código fuente.
- Construye la imagen Docker utilizando el Dockerfile presente en el directorio del proyecto.
- Inicia sesión en Docker Hub utilizando las credenciales proporcionadas como secretos en el repositorio.
- Sube la imagen Docker construida a Docker Hub etiquetándola con un identificador único generado por GitHub Actions.

Con estos pasos, la aplicación se conteneriza automáticamente y la imagen se empuja a Docker Hub listo para su despliegue

Autor

- [Daniel Ramirez](https://github.com/DanielRamirez1901)