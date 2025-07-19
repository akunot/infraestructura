FROM jenkins/jenkins:lts

USER root

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    php php-cli php-mbstring php-xml php-curl unzip \
    curl git apt-transport-https ca-certificates gnupg2 \
    software-properties-common lsb-release docker.io \
    && apt-get clean

# Instalar Docker Compose v2 (última versión estable al momento: 2.24.5)
RUN curl -SL https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Verificar instalación de docker-compose
RUN docker-compose --version

# Instalar Composer globalmente
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer --version

# Agregar usuario Jenkins al grupo Docker
RUN usermod -aG docker jenkins && \
    chown -R jenkins:jenkins /var/jenkins_home

USER jenkins
