#!/bin/bash

team='CP4MCM'
k8s_version='1.14'
node_type='m5.large'
nodes='1'
Usage='demo'
Usage_desc='BoD Demo - Do Not Delete'
Review_freq='half'


if [[ -z "${AWS_ACCESS_KEY_ID}" ]] || [[ -z "${AWS_SECRET_ACCESS_KEY}" ]] || [[ -z "${AWS_DEFAULT_REGION}" ]] || [[ -z "${AWS_DEFAULT_OUTPUT}" ]]; then
   echo -e "Please set the following variables:"
   echo -e "AWS_ACCESS_KEY_ID\nAWS_SECRET_ACCESS_KEY\nAWS_DEFAULT_REGION\nAWS_DEFAULT_OUTPUT"
   exit 1
fi

usage () {
   echo -e "Usage: create-eks.sh -c|--cluster <CLUSTER> -r|--region <REGION> -o|--owner <email>\n"
   echo -e "Example:\n create-eks.sh -c eks-cluster-13q2 -r us-east-2 -o griffitj@us.ibm.com\n"
}

if [ $# -eq 0 ]; then
    usage
    exit 1
fi

for arg in "$@"
do
    case $arg in
        -c|--cluster)
        cluster="$2"
        shift
        shift
        ;;
        -r|--region)
        region="$2"
        shift
        shift
        ;;
        -o| --owner)
        owner="$2"
        shift
        shift
        ;;
        -h|--help)
        usage
        exit
        ;;
    esac
done

if [ -z ${cluster+x} ] || [ -z ${region+x} ] || [ -z ${owner+x} ]; then
   usage
   exit 1
fi

eksctl create cluster \
--name ${cluster} \
--region ${region} \
--tags "owner=${owner},team=${team},cluster=${cluster},Usage=${Usage},Usage_desc=${Usage_desc},Review_freq=${Review_freq}" \
--version ${k8s_version} \
--node-type ${node_type} \
--nodes ${nodes}
