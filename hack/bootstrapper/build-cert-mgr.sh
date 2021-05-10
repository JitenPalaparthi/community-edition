#!/bin/bash

# build cert-manager binary in temp dir
BUILD_DIR=$(mktemp -d)
echo "building in ${BUILD_DIR}"
pushd $BUILD_DIR
git clone --depth 1 --branch v1.3.1 https://github.com/jetstack/cert-manager
pushd $BUILD_DIR/cert-manager
# build just the controller binary
make controller
make webhook
make cainjector
# is there a way to go back 2 locations in the stack without calling this twice?
popd && popd || exit 1

cp -v ${BUILD_DIR}/cert-manager/bazel-out/k8-fastbuild-ST-4c64f0b3d5c7/bin/cmd/controller/controller_/controller bin/cert-manager
chmod +w bin/cert-manager

cp -v ${BUILD_DIR}/cert-manager/bazel-out/k8-fastbuild-ST-4c64f0b3d5c7/bin/cmd/webhook/webhook_/webhook bin/cert-manager-webhook
chmod +w bin/cert-manager-webhook

cp -v ${BUILD_DIR}/cert-manager/bazel-out/k8-fastbuild-ST-4c64f0b3d5c7/bin/cmd/cainjector/cainjector_/cainjector bin/cert-manager-cainjector
chmod +w bin/cert-manager-cainjector

# clean up temp dir
rm -rf ${BUILD_DIR}
