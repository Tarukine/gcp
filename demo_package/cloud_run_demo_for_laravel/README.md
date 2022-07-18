# Summary
In this hands-on, we will deploy a container image of Laravel to Cloud Run.


# STEPS

## Set Env
    export REGION="asia-northeast1"
    export ZONE="asia-northeast1-b"
    export REPOSITORY="demo-reporitory"
    export FORMAT="docker"
    export LOCATION="$REGION"
    export SERVICE_NAME="laravel-demo-service"
    export TAG="v0.0.1"


## Artifact Registｒy
### Create Artifact Registry
    gcloud artifacts repositories create $REPOSITORY \
        --repository-format=$FORMAT \
        --location=$REGION
### Check Artifact Registry path（Copy paths after location）
    gcloud artifacts repositories describe $REPOSITORY \
        --location=$REGION |grep name
### Export Artifact Registry path 
    export AR_PATH="${add ar path}"


## Container Image
###　clone demo application code
    git clone https://github.com/Tarukine/gcp.git
    cd gcp/demo_package/cloud_run_demo_for_laravel/
### Build Docker image
    docker build -t $AR_PATH/$SERVICE_NAME:$TAG .
### Authenticate Artifact Registry
    gcloud auth configure-docker \
        asia-northeast1-docker.pkg.dev
## Push container image to Artifact Registry 
    docker push $AR_PATH/$SERVICE_NAME:$TAG


## Cloud Run 
### Deploy application to Cloud Run
gcloud run deploy $SERVICE_NAME \
             --platform=managed \
             --region=$REGION \
             --platform managed \
             --image=$AR_PATH/$SERVICE_NAME:$TAG


## Note

### init
    docker stop $(docker ps -aq) && \
    docker rm $(docker ps -aq) && \
    docker rmi -f $(docker images -aq)
### GCE
#### Create GCE 
    export VM_NAME="demo-vm"
    gcloud compute instances create $VM_NAME \
    --zone=$ZONE \
    --machine-type=e2-micro \
    --image=projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20220610
#### SSH GCE
    gcloud compute ssh $VM_NAME \
        --zone $ZONE
### Install Docker 
#### Update apt package
    sudo apt update
#### Install Package
    sudo apt install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common
#### Install the official Docker GPG public key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#### Add repository (stable)
    sudo add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"
#### Update apt package
    sudo apt update
### Install the latest version
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io

## Debug
    docker pull tarukine/demo-repository:v0.0.1
    docker tag tarukine/demo-repository:v0.0.1 $AR_PATH/$SERVICE_NAME:$TAG
    docker push $AR_PATH/$SERVICE_NAME:$TAG