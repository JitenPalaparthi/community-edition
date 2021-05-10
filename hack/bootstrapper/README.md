# Bootstrapper

This is an experimental implementation of a minimal bootstrapping approach. See
[the design doc](../../docs/designs/minimal-bootstrapper.md) for details.

## Setup

1. Create the binaries

    ```sh
    make build
    ```

    > This puts all necessary binaries in `$(pwd)/bin`.

1. Verify kcp, cert-manager, and capi binaries exist.

    ```sh
    $ ls -lh bin
    total 360M
    -rwxr-xr-x 1 josh josh 59M May 10 16:03 cert-manager
    -rwxr-xr-x 1 josh josh 43M May 10 16:03 cert-manager-cainjector
    -rwxr-xr-x 1 josh josh 46M May 10 16:03 cert-manager-webhook
    -rwxr-xr-x 1 josh josh 78M May 10 16:01 kcp
    -rwxr-xr-x 1 josh josh 43M May 10 16:03 kubeadm-bootstrap-manager
    -rwxr-xr-x 1 josh josh 48M May 10 16:03 kubeadm-control-plane-manager
    -rwxr-xr-x 1 josh josh 45M May 10 16:03 manager 
    ```

1. If you've previously run `kcp`, be sure to clear the cache.

    ```sh
    rm -rv .kcp
    ```

    > this contains etcd data and a kubeconfig.


1. Start kcp.

    ```sh
    ./bin/kcp start
    ```

1. Start cert-manager binaries.

    ```sh
    ./start-cert-mgr-webhook.sh
    ./start-cert-mgr-cain.sh
    ./start-cert-mgr.sh
    ```

    > Note the host name put inside of the webhook configurations
    `manifests/cert-manager.yaml`. You may need to update `/etc/hosts` to make
    this routable.

1. Inject CRDs

    ```sh
    ./add-types.sh
    ```

1. Now you can interact with the API server.

    ```sh
    kubectl --kubeconfig=./.kcp/data/admin.kubeconfig api-resources
    ```

## Optional: CRD Gen

The following steps are not necessary. They are just to document how the CRDs
were generated and committed to this repo.

1. Generate CRDs

    `kcp` ships with some basic APIs. We need to include some more to make our
    binaries work.

    ```sh
    make gen-crds 
    ```

    > This puts all generated CRDs in `$(pwd)/manifests/crds`.

1. Add the following annotation to the following files.

    annotation:

    ```yaml
    api-approved.kubernetes.io: https://github.com/kubernetes/kubernetes/pull/78458
    ```
    
    files:

    * `manifests/crds/admissionregistration/admissionregistration.k8s.io_mutatingwebhookconfigurations.yaml`
    * `manifests/crds/admissionregistration/admissionregistration.k8s.io_validatingwebhookconfigurations.yaml`

    > See https://github.com/kubernetes/enhancements/pull/1111 to understand
    why.
