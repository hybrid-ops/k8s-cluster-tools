#!/bin/bash

if [[ -z "${AWS_ACCESS_KEY_ID}" ]] || [[ -z "${AWS_SECRET_ACCESS_KEY}" ]] || [[ -z "${AWS_DEFAULT_REGION}" ]] || [[ -z "${AWS_DEFAULT_OUTPUT}" ]]; then
   echo -e "Please set the following variables:"
   echo -e "AWS_ACCESS_KEY_ID\nAWS_SECRET_ACCESS_KEY\nAWS_DEFAULT_REGION\nAWS_DEFAULT_OUTPUT"
   exit 1
fi

usage () {
   echo -e "Usage: eks-connect.sh -c|--cluster <CLUSTER> -z|--zone <ZONE>\n"
   echo -e "Example:\n eks-connect.sh -c eks-cluster-13q2 -z us-east-2\n"
}

if [ $# -eq 0 ]; then
    usage
    exit 1
fi

for arg in "$@"
do
    case $arg in
        -c|--cluster)
        CLUSTER="$2"
        shift
        shift
        ;;
        -z|--zone)
        ZONE="$2"
        shift
        shift
        ;;
        -h|--help)
        usage
        exit
        ;;
    esac
done

if [ -z ${CLUSTER+x} ] || [ -z ${ZONE+x} ]; then
   usage
   exit 1
fi

AWS_DEFAULT_REGION=$ZONE
aws eks update-kubeconfig --name $CLUSTER

kubectl cluster-info
