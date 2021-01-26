#!/bin/bash
# Set up kubeconfig and gcloud config, select right gcloud project, fetch kubernetes config
#
# Usage: setup.sh [CLIENT] [PROEJCT] [CLUSTER]
USAGE="Usage: setup.sh [CLIENT] [PROEJCT] [CLUSTER]"

CLIENT=$1
PROJECT=$2
CLUSTER=$3

if [[ -z "$CLIENT" ]]; then
  echo "CLIENT parameter is missing"
  echo ""
  echo "$USAGE"
  exit 1
elif [[ -z "$PROJECT" ]]; then
  echo "PROJECT parameter is missing"
  echo ""
  echo "$USAGE"
  exit 1
elif [[ -z "$CLUSTER" ]]; then
  echo "CLUSTER parameter is missing"
  echo ""
  echo "$USAGE"
  exit 1
fi

# Two folders needed for this script to store 1. gcloud config  and 2.kube(rnetes) config
GCLOUDDIR="${HOME}/.config/gcloud-${CLIENT}"
KUBEDIR="${HOME}/.config/kube-${CLIENT}"
mkdir -p ${GCLOUDDIR}
mkdir -p ${KUBEDIR}

RUNCMD="docker run --rm -v ${KUBEDIR}:/root/.kube -v ${GCLOUDDIR}:/root/.config --name ${CLIENT}-gcloud  braveops/cloud-sdk:v1"
RUNCMD_INTERACTIVE="docker run --rm -v ${KUBEDIR}:/root/.kube -v ${GCLOUDDIR}:/root/.config --name ${CLIENT}-gcloud -it braveops/cloud-sdk:v1"


# Log in to gcloud if it hasnt been done already
echo "Checking for active login..."
GCLOUD_AUTH=$(eval "$RUNCMD gcloud config list account --format 'value(core.account)'")
if [[ "$GCLOUD_AUTH" == "" ]]; then
  # login to gcloud and save credentials outside of the container
  echo "Log in with your email address and give permission to Google Cloud"
  eval "$RUNCMD_INTERACTIVE gcloud auth login"
fi

echo "Select Google Cloud project"
eval "$RUNCMD gcloud config set project ${PROJECT}"

echo "Fetching kubeconfig..."
GKE_REGION=$(eval "$RUNCMD gcloud container clusters list --format=\"value(location)\" --filter=\"name=$CLUSTER\"")
eval "$RUNCMD gcloud container clusters get-credentials --region ${GKE_REGION} ${CLUSTER} --project ${PROJECT}"

echo "Entering to the container..."
eval "$RUNCMD_INTERACTIVE /bin/zsh"
