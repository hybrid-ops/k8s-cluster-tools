#!/bin/bash

##
## Argument processing
##
usage () {
  echo "Usage: gke-connect.sh -s|--serviceacct SERVICEACCT -k|--keyfile KEYFILE -c|--cluster CLUSTER -z|--zone ZONE -h|--help"
  echo "Example:"
  echo "gke-connect.sh -s bod-env@oceanic-guard-191815.iam.gserviceaccount.com -k ~/gke-service-key-file.json.json -c gks-cluster-13 -z us-central1-c"
}

getProject() {
 
  local SACCT=$1
  local TEMP1=$(echo $SACCT | awk -F @ '{print $2}')
  local PROJ=$(echo $TEMP1 | awk -F '.iam' '{print $1}')
  echo "$PROJ"
}

if [ $# -eq 0 ]; then
    usage
    exit 1
fi

for arg in "$@"
do
    case $arg in
        -s|--serviceacct)
        SERVICEACCT="$2" 
        shift
        shift
        ;;
        -k|--keyfile)
        KEYFILE="$2"
        shift
        shift
        ;;
        -z|--zone)
        ZONE="$2"
        shift
        shift
        ;;
        -c|--cluster)
        CLUSTER="$2"
        shift
        shift
        ;;
        -h|--help)
        usage
        exit 
        ;;
    esac
done

# Check if all the variables are defined
if [ -z ${SERVICEACCT+x} ] || [ -z ${KEYFILE+x} ] || [ -z ${ZONE+x} ] || [ -z ${CLUSTER+x} ]; then
   usage
   exit 1
fi

##
## Main
##

PROJECT=$(getProject $SERVICEACCT)
echo $PROJECT

# Connect to gcloud
COMMAND="gcloud auth activate-service-account ${SERVICEACCT} --key-file ${KEYFILE}"
#$COMMAND

# Connect to the cluster
COMMAND="gcloud container clusters get-credentials ${CLUSTER} --zone ${ZONE} --project ${PROJECT}"
#$COMMAND

COMMAND="kubectl cluster-info"
#$COMMAND

