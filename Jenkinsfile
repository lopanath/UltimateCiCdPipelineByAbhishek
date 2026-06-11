pipeline {
    agent {
          node {
              label 'docker-agent-jenkins-java-git-maven-docker'
              }
        }
  stages {
    stage('Checkout') {
      steps {
        sh 'echo passed'
        //git branch: 'main', url: 'https://github.com/iam-veeramalla/Jenkins-Zero-To-Hero.git'
      }
    }
    stage('Build and Test') {
      steps {
        sh 'ls -ltr'
        // build the project and create a JAR file
        sh 'mvn clean package'
      }
    }
//     stage('Static Code Analysis') {
//       environment {
//         SONAR_URL = "http://34.201.116.83:9000"
//       }
//       steps {
//         withCredentials([string(credentialsId: 'sonarqube', variable: 'SONAR_AUTH_TOKEN')]) {
//           sh 'cd java-maven-sonar-argocd-helm-k8s/spring-boot-app && mvn sonar:sonar -Dsonar.login=$SONAR_AUTH_TOKEN -Dsonar.host.url=${SONAR_URL}'
//         }
//       }
//     }
    stage('Verify Artifact') {
        steps {
            sh '''
                pwd
                ls -la target
            '''
        }
    }
    stage('Docker Debug') {
        steps {
            sh '''
                docker version
                docker info
                df -h
            '''
        }
    }
    stage('Build and Push Docker Image') {
      environment {
        DOCKER_IMAGE = "lopanath12345/ultimate-cicd:${BUILD_NUMBER}"
        // DOCKERFILE_LOCATION = "java-maven-sonar-argocd-helm-k8s/spring-boot-app/Dockerfile"
        REGISTRY_CREDENTIALS = credentials('docker_cred')
      }
      steps {
              withCredentials([usernamePassword(
                  credentialsId: 'docker_cred',
                  usernameVariable: 'DOCKER_USER',
                  passwordVariable: 'DOCKER_PASS'
              )]) {

                  sh '''
                      docker build -t ${DOCKER_IMAGE} .

                      echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

                      docker push ${DOCKER_IMAGE}
                  '''
              }
          }
    }
    stage('Update Deployment File') {
        environment {
            GIT_REPO_NAME = "UltimateCiCdPipelineByAbhishek"
            GIT_USER_NAME = "lopanath"
        }
        steps {
            withCredentials([string(credentialsId: 'github', variable: 'GITHUB_TOKEN')]) {
                sh '''
                    git config user.email "lopanath003@gmail.com"
                    git config user.name "lopanath"
                    BUILD_NUMBER=${BUILD_NUMBER}
                    sed -i "s/replaceImageTag/${BUILD_NUMBER}/g" UltimateCiCdPipelineByAbhishek-manifests/deployment.yml
                    git add UltimateCiCdPipelineByAbhishek-manifests/deployment.yml
                    git commit -m "Update deployment image to version ${BUILD_NUMBER}"
                    git push https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:master
                '''
            }
        }
    }
  }
}