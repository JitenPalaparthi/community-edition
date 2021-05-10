#!/bin/bash

# build kcp binary in temp dir
BUILD_DIR=$(mktemp -d)
echo "building in ${BUILD_DIR}"
pushd $BUILD_DIR
git clone https://github.com/kcp-dev/kcp
pushd $BUILD_DIR/kcp
go build -ldflags "-X k8s.io/client-go/pkg/version.gitVersion=$(git describe --abbrev=8 --dirty --always)" -o bin/kcp ./cmd/kcp
# is there a way to go back 2 locations in the stack without calling this twice?
popd && popd || exit 1

# create kcp binary and move to bin directory
cp -v ${BUILD_DIR}/kcp/bin/kcp bin/

# clean up temp dir
rm -rf ${BUILD_DIR}
