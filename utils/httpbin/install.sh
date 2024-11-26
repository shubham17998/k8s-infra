#!/bin/bash
## Usage: ./install.sh [kubeconfig]

if [ $# -ge 1 ] ; then
  export KUBECONFIG=$1
fi

NS=httpbin
kubectl create ns $NS

function installing_httpbin() {
  kubectl label ns $NS istio-injection=enabled --overwrite

  kubectl -n $NS apply -f svc.yaml
  kubectl -n $NS apply -f deployment.yaml
  kubectl -n $NS apply -f deployment-busybox-curl.yaml
  kubectl -n $NS apply -f vs.yaml
  return 0
}

# set commands for error handling.
set -e
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errtrace  # trace ERR through 'time command' and other functions
set -o pipefail  # trace ERR through pipes
installing_httpbin  # calling function