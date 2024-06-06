pipeline {
    agent any

    environment {
        PATH = "$PATH:/var/lib/jenkins/.local/bin"
        CHROME_BIN = '/usr/bin/google-chrome'
        CHROMEDRIVER_BIN = '/usr/bin/chromedriver'
    }

    stages {
//         stage('Install Dependencies') {
//             steps {
//                 script {
//                     // Install Python dependencies
//                     sh '''
//                     pip install --user robotframework-seleniumlibrary
//                     pip install --user robotframework-imaplibrary2
//                     pip install --user pyclip
//                     sudo apt-get update
//                     sudo apt-get install -y xclip || sudo apt-get install -y xsel
//                     '''
//                 }
//             }
//         }


        stage('Test') {
            steps {
                script {
                   sh "robot --outputdir Results/04-06-2024 --timestampoutputs TestCases/lumateTest.robot"
                }
            }
        }
    }

    post {
        always {
            emailext body: "Your build result is \$currentBuild.currentResult", subject: 'Result of build demo job', to: 'ridham.chavda@acldigital.com'
        }
    }
}
