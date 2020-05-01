#!/bin/bash

##
## Argument processing
##

IBMCLOUDURL=cloud.ibm.com
GROUP=Default

getClusterID() {
   local NAME=$1
   local ID=$(ibmcloud ks cluster get --cluster iks-cluster-02 | grep ID | awk '{ print $2}' | sed '2d')
   echo "$ID"
}

usage () {
  echo "Usage: iks-connect.sh -r|--region REGION -c|--cluster CLUSTERNAME -a|--apikey APIKEY -h|--help"
  echo "Example:"
  echo "iks-connect.sh -r us-south -a lkYH-xQyC8Ozuq2cRhzuHEzgnnwT_g_U7X7wareltqyO -c bof7t1nd0v9ba1d06psg"
}

if [ $# -eq 0 ]; then
    usage
    exit 1
fi

for arg in "$@"
do
    case $arg in
        -r|--region)
        REGION="$2"
        shift
        shift
        ;;
        -a|--apikey)
        APIKEY="$2"
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
if [ -z ${REGION+x} ] || [ -z ${APIKEY+x} ] || [ -z ${CLUSTER+x} ]; then
   usage
   exit 1
fi

##
## Main
##

CLUSTERID=$(getClusterID $CLUSTER)

# Connect to Azure
COMMAND="ibmcloud login -a ${IBMCLOUDURL} -r ${REGION} -g ${GROUP} --apikey ${APIKEY}"
$COMMAND

# Connect to the cluster
COMMAND="ibmcloud ks cluster config --cluster ${CLUSTERID}"
$COMMAND

COMMAND="kubectl cluster-info"
$COMMAND
