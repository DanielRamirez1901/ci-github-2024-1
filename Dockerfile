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