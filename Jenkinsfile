pipeline{
    agent any
    stages
    {
        stage ("Checkout From SCM")
        {
            steps
            {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/yakhub4881/CI-CD-1.git']]])
            }
        }
        stage ("Build Docker Image")
        {
            steps{
                sh 'docker build -t myimage:v1.$BUILD_ID .'
            }
        }
        stage ("Push Image To DockerHub")
        {
            steps{
                withCredentials([string(credentialsId: 'DockerPasswd', variable: 'DockerPasswd')]) {
                sh "docker login -u yakhub4881 -p ${DockerPasswd}"
                sh 'docker tag myimage:v1.$BUILD_ID yakhub4881/myimage:v1.$BUILD_ID'
                sh 'docker tag myimage:v1.$BUILD_ID yakhub4881/myimage:latest'
                sh 'docker push yakhub4881/myimage:v1.$BUILD_ID'
                sh 'docker push yakhub4881/myimage:latest'
                 }
            }
        }
        stage ("Deploy Container On Webapp Server")
        {
            steps{
                sshagent(['SSH-ID']) {
                sh 'ssh -o StrictHostKeyChecking=no centos@172.31.36.184 docker run -itd --name nginxcontainer -p 9000:80 yakkhub4881/myimage'
                 }
            }
        }
    }
}