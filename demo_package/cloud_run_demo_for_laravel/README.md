## init
    docker rm $(docker ps -aq) && \
    docker rmi -f $(docker images -aq)

# Set Env
    export REGION="asia-northeast1"
    export ZONE="asia-northeast1-b"
    export REPOSITORY="demo-reporitory"
    export FORMAT="docker"
    export LOCATION="$REGION"
    export VM_NAME="demo-vm"
    export NAME="laravel-demo-servicce"
    export TAG="20220717"

# Artifact Registoy
## Create Artifact Registory
    gcloud artifacts repositories create $REPOSITORY \
        --repository-format=$FORMAT \
        --location=$REGION
## Check AR path
    gcloud artifacts repositories describe $REPOSITORY \
        --location=$REGION |grep name
## Export AR path 
    export AR_PATH="${add ar path}"

# GCE
## Create GCE 
    gcloud compute instances create $VM_NAME \
    --zone=$ZONE \
    --machine-type=e2-micro \
    --image=projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20220610
# SSH GCE
    gcloud compute ssh $VM_NAME \
        --zone $ZONE

# Container Image(Operate within the GCE console)
##　clone demo application code
    git clone

docker build -t $AR_PATH/$NAME:$TAG .
# docker run -d $AR_PATH/$NAME:$TAG
docker push $AR_PATH/$NAME:$TAG


gcloud run deploy $NAME \
             --platform=managed \
             --region=$REGION \
             --image=$AR_PATH/$NAME:$TAG
