pipeline {
    agent any

    environment {
        COMPOSER_ALLOW_SUPERUSER = '1'
    }

    stages {
        stage('Clonar repositorio') {
            steps {
                git url: 'repo' , branch: 'main'
            }
        }

        stage('Instalar dependencias PHP') {
            steps {
                dir('backend') {
                    sh '''
                        echo "Instalando dependencias de PHP..."
                        composer install
                    '''
                }
            }
        }

        stage('Generar APP_KEY') {
            steps {
                dir('backend') {
                    sh '''
                        if [ ! -f .env ]; then
                            echo "Generando archivo .env..."
                            cp .env.example .env
                        fi

                        php artisan key:generate
                    '''
                }
            }
        }

        stage('Ejecutar pruebas') {
            steps {
                dir('backend') {
                    sh '''
                        echo "Ejecutando pruebas..."
                        php artisan test
                    '''
                }
            }
        }

        stage('Verificar versiones') {
            steps {
                sh '''
                    echo "PHP:"
                    php -v

                    echo "Composer:"
                    composer -V

                    echo "Node.js:"
                    node -v
                    npm -v
                '''
            }
        }
    }
}