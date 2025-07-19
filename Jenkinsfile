pipeline {
    agent any

    environment {
        FIREBASE_ENV = credentials('firebase-env-json')
    }

    stages {
        stage('Clonar proyecto principal') {
            steps {
                git credentialsId: 'github-token', url: 'https://github.com/akunot/proyecto-test', branch: 'main'
            }
        }

        stage('Copiar archivo env_json') {
            steps {
                sh '''
                    cp "$FIREBASE_ENV" Flask/Flask_microservice/.env_json
                '''
            }
        }

        stage('Construir contenedores') {
            steps {
                sh 'docker-compose build'
            }
        }

        stage('Levantar servicios') {
            steps {
                sh 'docker-compose up -d'
            }
        }

        stage('Instalar dependencias') {
            steps {
                sh '''
                docker-compose exec gateway composer install
                docker-compose exec email composer install
                docker-compose exec flask pip install -r requirements.txt
                '''
            }
        }

        stage('Ejecutar pruebas') {
            steps {
                sh '''
                docker-compose exec gateway php artisan test
                docker-compose exec email php artisan test
                '''
            }
        }
    }

    post {
        always {
            sh 'docker-compose down'
        }
    }
}
