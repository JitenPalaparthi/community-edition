#!/bin/bash

# build kcp binary in temp dir
BUILD_DIR=$(mktemp -d)
echo "building in ${BUILD_DIR}"
pushd $BUILD_DIR
git clone --depth 1 --branch v0.3.16 https://github.com/kubernetes-sigs/cluster-api
pushd $BUILD_DIR/cluster-api
make managers
# is there a way to go back 2 locations in the stack without calling this twice?
popd && popd || exit 1

# create kcp binary and move to bin directory
cp -v ${BUILD_DIR}/cluster-api/bin/* bin/

# clean up temp dir
rm -rf ${BUILD_DIR}
