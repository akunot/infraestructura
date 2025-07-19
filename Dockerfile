FROM jenkins/jenkins:lts

USER root

# Instalar PHP y extensiones necesarias para Laravel
RUN apt-get update && apt-get install -y \
    php php-cli php-mbstring php-xml php-curl unzip curl git apt-transport-https ca-certificates gnupg2 software-properties-common lsb-release

# Instalar Docker CLI
RUN apt-get install -y docker.io

# Instalar Docker Compose v2 manualmente
RUN curl -SL https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Agrega jenkins al grupo de Docker
RUN usermod -aG docker jenkins

# Dar permisos al usuario jenkins
RUN chown -R jenkins:jenkins /var/jenkins_home

USER root
