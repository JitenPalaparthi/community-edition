## Installing and Managing Packages

With a cluster bootstrapped, you're ready to configure and install packages to the cluster.

1. Make sure your `kubectl` context is set to the workload cluster.

    ```sh
    kubectl config use-context ${GUEST_CLUSTER_NAME}-admin@${GUEST_CLUSTER_NAME}
    ```

1. Install the TCE package repository.

    ```sh
    tanzu package repository install --default
    ```

   > By installing the TCE package repository, kapp-controller will make multiple packages available in the cluster.

1. List the available packages.

    ```sh
    tanzu package list

    NAME                 VERSION          DESCRIPTION
    cert-manager         1.1.0-vmware0
    contour-operator     1.11.0-vmware0
    fluent-bit           1.7.2-vmware0
    gatekeeper           3.2.3-vmware0
    grafana              7.4.3-vmware0
    knative-serving      0.21.0-vmware0
    prometheus           2.25.0-vmware0
    velero               1.5.2-vmware0
    ```

1. [Optional]: Download the configuration for a package.

   ```sh
   tanzu package configure fluent-bit

   Looking up config for package: fluent-bit:
   Values files saved to fluent-bit-values.yaml. Configure this file before installing the package.
   ```

1. [Optional]: Alter the values files.

   ```sh
   vim fluent-bit-values.yaml
   ```

1. Install the package to the cluster.

    ```sh
    tanzu package install fluent-bit --config fluent-bit-values.yaml

   Looking up package to install: fluent-bit:
   Installed package in default/fluent-bit:1.7.2-vmware0
   ```

   > The `--config` flag is optional based on whether you customized the configuration file from the previous steps.

1. Verify fluent-bit is installed in the cluster.

    ```sh
    kubectl -n fluent-bit get all
    pod/fluent-bit-hgtc2   1/1     Running   0          27m
    pod/fluent-bit-j6jdj   1/1     Running   0          27m

    NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
    daemonset.apps/fluent-bit   2         2         2       2            2           <none>          27m
    ```

1. For troubleshooting, you can view `InstalledPackage` and `App` objects in the cluster.

    ```sh
    kubectl get installedpackage,apps --all-namespaces

    NAMESPACE         NAME                    DESCRIPTION           SINCE-DEPLOY   AGE
    default           gatekeeper              Reconcile succeeded   13s            16s
    kapp-controller   tce-main.tanzu.vmware   Reconcile succeeded   17s            2m
    tkg-system        antrea                  Reconcile succeeded   116s           19h
    tkg-system        metrics-server          Reconcile succeeded   2m10s          19h
    ```

If you're interested in how this package model works from a server-side and client-side perspective, please read our
[Tanzu Add-on Management design doc](./designs/tanzu-addon-management.md).
