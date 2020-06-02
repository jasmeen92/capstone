pipeline {
	agent any
	stages {
		stage('Lint HTML') {
			steps {
				sh 'tidy -q -e *.html'
			}
		}
		
		stage('Build Docker Image') {
			steps {
				withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
					sh '''
						docker build -t jasmeen92/webapp:$BUILD_ID .
					'''
				}
			}
		}

		stage('Push Image To Dockerhub') {
			steps {
				withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
					sh '''
						docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
						docker push jasmeen92/webapp:$BUILD_ID
					'''
				}
			}
		}

		stage('Set current kubectl context') {
			steps {
				withAWS(region:'us-east-2', credentials:'jenkins') {
					sh '''
						aws eks --region us-east-2 update-kubeconfig --name quad
                                                kubectl config use-context arn:aws:eks:us-east-2:925716863138:cluster/quad 
					'''
				}
			}
		}

                stage('deploy the service') {
                        steps {
                                withAWS(region:'us-east-2', credentials:'jenkins') {
                                        sh '''
                                                kubectl apply -f ./blue-green-service.json
                                        '''
                                }
                        }
                }

		stage('Create blue container') {
			steps {
				withAWS(region:'us-east-2', credentials:'jenkins') {
					sh '''
						kubectl run blueimage --image=jasmeen92/webapp:$BUILD_ID --port=80
					'''
				}
			}
		}

	        stage('get service url') {
                        steps {
                                withAWS(region:'us-east-2', credentials:'jenkins') {
                                        sh '''
                                                kubectl get services
                                        '''
                                }
                        }
                }
	}
}
