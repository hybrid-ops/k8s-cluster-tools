#!/bin/bash

##
## Argument processing
##
usage () {
  echo "Usage: aks-connect.sh -r|--resourcegroup RG -a|--appid APPID -t|--tenant TENANT -p|--password PASS -c|--cluster CLUSTER -h|--help\n"
  echo "Example:\n"
  echo "aks-connect.sh -r bod-env -a 514bd913-b415-48f2-b3e8-cd5845cd6tb0 -t 90ef2ccc-9053-40b9-9518-cc8935f62f7f -p 8f1e3795-54aa-454f-a72e-c794d0713bc8 -c aks-green13-dev\n"
}

if [ $# -eq 0 ]; then
    usage
    exit 1
fi

for arg in "$@"
do
    case $arg in
        -r|--resourcegroup)
        RG="$2"
        shift
        shift
        ;;
        -a|--appid)
        APPID="$2"
        shift
        shift
        ;;
        -t|--tenant)
        TENANT="$2"
        shift
        shift
        ;;
        -p|--password)
        PASSWORD="$2"
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
if [ -z ${RG+x} ] || [ -z ${APPID+x} ] || [ -z ${TENANT+x} ] || [ -z ${PASSWORD+x} ] || [ -z ${CLUSTER+x} ]; then
   usage
   exit 1
fi

##
## Main
##

# Connect to Azure
COMMAND="az login --service-principal -u ${APPID} --password ${PASSWORD} --tenant ${TENANT}"
$COMMAND

# Connect to the cluster
COMMAND="az aks get-credentials --resource-group ${RG} --name ${CLUSTER}"
$COMMAND

