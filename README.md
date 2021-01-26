# Google cloudsdk for Braveops clients

A small wrapper around the official cloudsdk alpine container. The purpose of this container is to quickly setup an environment to access your resources. 
Once the setup has executed succesfully you will access your Kubernetes cluster from within the container.


# Usage

Clone the repo

    git clone https://github.com/braveops-io/cloudsdk-braveops.git
    cd cloudsdk-braveops

Run setup script

    ./setup.sh [CLIENT] [PROJECT] [CLUSTER]


