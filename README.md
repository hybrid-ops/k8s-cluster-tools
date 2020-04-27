# k8s-cluster-tools
Scripts and tools for creating and connecting to *KS clusters like GKS

## Pre-reqs
To use any of these tools below you will need permissions and access to that provider.
In addition, you will need the provider's CLI installed on your boot node.  

## EKS scripts
The following scripts will help you create a new EKS cluster and connect to the EKS cluster. 

*Requirements:*
- Defined AWS variables
- `aws` CLI
- `eksctl` CLI
- AWS authenticator

*Scripts:*
- create-eks.sh : Create an EKS cluster
- eks-connect.sh: Connect to an EKS cluster 

## GKE scripts (TODO)
The following script will help you create a new GKE cluster and connect to the GKE cluster. 

*Requirements:*
- `gcloud`
- GKE service key file for authentication (`gke-service-key-file.json`)

*Scripts:*
- create-gke.sh : Create an GKE cluster
- gke-connect.sh: Connect to an GKE cluster

## AKS scripts (TODO)
- create-aks.sh : Create an AKS cluster
- aks-connect.sh: Connect to an AKS cluster

## IKS scripts (TODO)
- create-iks.sh : Create an IKS cluster
- iks-connect.sh: Connect to an IKS cluster

## ROKS scripts (TODO)
- create-roks.sh : Create an ROKS cluster
- roks-connect.sh: Connect to an ROKS cluster
