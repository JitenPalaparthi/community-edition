#!/bin/bash

CRD_DEST=$(pwd)/manifests/crds

GOPATH=$(go env GOPATH)
if [[ -x "${GOPATH}/bin/controller-gen" ]]
then
    version=$(${GOPATH}/bin/controller-gen --version | sed -e 's/Version: v0\.\(5\)\../\1/')
    if [[ $version -lt 5 ]]
    then
        echo "You should use at least version 0.5.0 of controller-gen" 
        exit 1
    fi
else
    echo "Installing 'controller-gen'"
    go get sigs.k8s.io/controller-tools/cmd/controller-gen
    go install sigs.k8s.io/controller-tools/cmd/controller-gen
fi

echo "Cloning Kubernetes 'crd-compatible-core-and-apps-types' branch into $(pwd)"
git clone --depth 1 --branch crd-compatible-core-and-apps-types git@github.com:kcp-dev/kubernetes.git

pushd kubernetes/staging/src/k8s.io/api > /dev/null

echo "Generating core/v1 CRDs"
${GOPATH}/bin/controller-gen crd:crdVersions=v1 paths=./core/v1 output:crd:dir=${CRD_DEST}/core output:stdout

echo "Removing unnecessary core/v1 resources"
rm $(ls ${CRD_DEST}/core/*.yaml | grep -v -E '.*(pods|secrets|nodes|endpoints|persistentvolumeclaims|persistentvolumes|podtemplates|replicationcontrollers|services)\.yaml')

echo "Adding the 'core' group as a suffix in the name of core/v1 CRDs "
sed -i -e 's/^\(  name: [^.]*\)\.$/\1.core/' ${CRD_DEST}/core/*.yaml

echo "Generating admissionregistration/v1 CRDs"
${GOPATH}/bin/controller-gen crd:crdVersions=v1 paths=./admissionregistration/v1 output:crd:dir=${CRD_DEST}/admissionregistration output:stdout

echo "Adding the 'admissionregistration' group as a suffix in the name of admissionregistration/v1 CRDs "
sed -i -e 's/^\(  name: [^.]*\)\.$/\1.admissionregistration/' ${CRD_DEST}/core/*.yaml
