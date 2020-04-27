#!/bin/bash
service_account='bod-env@oceanic-guard-191815.iam.gserviceaccount.com'
k8s_version='1.14'
project='oceanic-guard-191815'
nodes='1'
machine_type='n1-standard-2'

usage () {
   echo -e "Usage: create_gke.sh -c|--cluster <CLUSTER> -z|--ZONE <ZONE> -k|--keyfile <PATH-to-KEYFILE>\n"
   echo -e "Example:\n create_gke.sh -c gke-green13-dev -z us-central1 -k /root/gke-service-key-file.json.json\n"
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
        -z|--zone)
        zone="$2"
        shift
        shift
        ;;
        -k| --keyfile)
        keyfile="$2"
        shift
        shift
        ;;
        -h|--help)
        usage
        exit
        ;;
    esac
done

if [ -z ${cluster+x} ] || [ -z ${zone+x} ] || [ -z ${keyfile+x} ]; then
   usage
   exit 1
fi

gcloud auth activate-service-account ${service_account} --key-file ${keyfile}

gcloud container clusters create ${cluster} --zone ${zone} --num-nodes ${nodes} --machine-type ${machine_type}
