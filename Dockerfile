FROM jenkins/jenkins:lts

USER root

# Instalar PHP y extensiones
RUN apt-get update && apt-get install -y \
    php php-cli php-mbstring php-xml php-curl unzip curl git

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Instalar Node.js y npm (ej. Node 18)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Dar permisos al usuario jenkins
RUN chown -R jenkins:jenkins /var/jenkins_home

USER jenkins
