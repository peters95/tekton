# TEKTON ARTIFACTORY DEMO

## Installing Tekton into K8s

Install Tekton Pipelines into a new Kubernetes cluster with the following command:

````bash
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
````

Monitor it has come up successfully with the below command:

````bash
kubectl get pods --namespace tekton-pipelines --watch  
````

Install Tekton CLI (Mac OSX):

````bash
brew tap tektoncd/tools   
brew install tektoncd/tools/tektoncd-cli
````

## Demo 1 Hello world

Run the Hello world task:

````bash
cd hello-world 
tkn task start --filename HelloWorldTask.yaml
````

And then view the logs w/ the below command:

````bash
tkn taskrun logs $(tkn taskrun list | grep -v 'NAME' | cut -f1 -d ' ') -f -n default
````

## Demo 2 Build Docker image and push to registry

### Step 1: Create docker private repo secret for Artifactory in Kubernetes

````bash
kubectl create secret docker-registry regcred \
  --docker-server=<DOCKER_SERVER> \
  --docker-username=<USERNAME> \
  --docker-password=<API_KEY> \
  --docker-email=<EMAIL>
````


| Field         | Description             |
----------------|-------------------------|
| DOCKER_SERVER | Artifactory Server Url  |
| USERNAME      | Artifactory User ID     |
| API_KEY       | Artifactory User API Key|
| EMAIL         | Artifactory User Email  |


### Step 2: Run Tekton Pipeline To Build and Push Image to Artifactory

Deploy all resources:
````bash
kubectl apply -f docker-build
````

Check on your pipeline status:
````bash
tkn pipelinerun list
````

View the logs:
````bash
tkn pipelinerun logs $(tkn pipelinerun list | grep -v 'NAME' | cut -f1 -d ' ') -f -n default
````

