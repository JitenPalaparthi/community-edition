:: Copyright 2021 VMware Tanzu Community Edition contributors. All Rights Reserved.
:: SPDX-License-Identifier: Apache-2.0
@echo off
setlocal
set file=%USERPROFILE%\.config\tanzu\tkg\config.yaml
set maxbytesize=10
echo This patch is to resolve  x509: certificate signed by unknown authority issue
if not exist %file% (
echo config.yaml file not found, hence creating it.
echo "">%file%
)
FOR /F "usebackq" %%A IN ('%file%') DO set size=%%~zA

if %size% LSS %maxbytesize% (
:: echo.File is ^< %maxbytesize% bytes
echo updating config.yaml file
echo release:>%file%
echo    version:>>%file%
echo TKG_CUSTOM_IMAGE_REPOSITORY_SKIP_TLS_VERIFY: true>>%file%
) else (
    echo All looks fine.No need to apply the patch!.
)