pipeline {
	agent any

	environment {
    	DOCKER_CREDENTIALS = credentials('docker-credentials')
        DOCKER_IMAGE = "${DOCKER_CREDENTIALS_USR}/petclinic"
	}

	
  
	stages {
		stage('Build docker') {
			steps {
		    	script{
					sh "git checkout main"
					sh "cd spring-petclinic"
		            def builtImage = docker.build(DOCKER_IMAGE)
		        }
			}
		}

		/*
		stage('Test') {
			steps {
				sh "docker run -td --env AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} --env AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} --env AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION} --env REPEAT_TIME_SECONDS=${REPEAT_TIME_SECONDS} --name test-container-${env.BUILD_NUMBER} ${DOCKER_IMAGE}"
				script{

					sleep time: 5, unit: 'SECONDS'
				    	def containerStatus = sh(script: "docker inspect -f '{{.State.Status}}' test-container-${env.BUILD_NUMBER}", returnStdout: true).trim()
				    	echo "Container state: ${containerStatus}"

			        	sh "docker logs test-container-${env.BUILD_NUMBER}"
		            	
					if (containerStatus != "running") {					
				        	error "An error occured on the last attempt to run the container of image working-ec2"
					}
				}
			}
		}
		*/
		
		stage('Deploy') {
			steps {
				script{
					def currentBuildImage = "${DOCKER_IMAGE}:${env.BUILD_NUMBER}"
					sh "docker tag ${DOCKER_IMAGE} ${currentBuildImage}"
					docker.withRegistry('https://index.docker.io/v1/', 'docker-credentials') {
						sh "docker push ${DOCKER_IMAGE}"
						sh "docker push ${currentBuildImage}"
					}
					echo 'The pipeline worked succesfully'
				}
			}	
		}

	}
	post { 
		always { 
	        cleanWs()
	    }
	}	
}