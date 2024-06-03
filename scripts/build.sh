#!/bin/bash

set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

# Inputs and build configurations
INSTALLBUILDER="${INSTALLBUILDER:?missing value for INSTALLBUILDER}"
BITNAMI_STACKS_WITH_DISABLED_REDIRECTIONS=("wordpressmultisite")
LETSENCRYPT_TOS_URL="https://letsencrypt.org/documents/LE-SA-v1.3-September-21-2022.pdf"
LEGO_VERSION="$(cat LEGO_VERSION)"
VERSION="$(cat VERSION)"

# Calculate VERSION_ID
VERSION_REGEXP="^([0-9]+)\.([0-9]+)\.([0-9]+)$"
MAJOR_VERSION="$(sed -E "s/${VERSION_REGEXP}/\1/" <<< "$VERSION")"
MINOR_VERSION="$(sed -E "s/${VERSION_REGEXP}/\2/" <<< "$VERSION")"
PATCH_VERSION="$(sed -E "s/${VERSION_REGEXP}/\3/" <<< "$VERSION")"
VERSION_ID="$(printf '%d%02d%02d' "$MAJOR_VERSION" "$MINOR_VERSION" "$PATCH_VERSION")"

for arch in amd64 arm64; do
    INSTALLBUILDER_TARGET="linux-$([[ "$arch" = "amd64" ]] && echo "x64" || echo "$arch")"

    # Re-create the output directory
    rm -rf "output-${arch}"
    mkdir -p "output-${arch}"
    cp -rp project/. "output-${arch}"
    # Download Lego
    curl -L "https://github.com/go-acme/lego/releases/download/v${LEGO_VERSION}/lego_v${LEGO_VERSION}_linux_${arch}.tar.gz" | tar -xz -C "output-${arch}" lego
    # Prepare project files
    sed -i \
        -e "s/@@VERSION@@/${VERSION}/g" \
        -e "s/@@VERSION_ID@@/${VERSION_ID}/g" \
        "output-${arch}"/{*,*/*}.*
    # Build auto-updater tool with InstallBuilder
    "${INSTALLBUILDER}/autoupdate/bin/customize.run" build "output-${arch}/bncert-auto-updater.xml" "$INSTALLBUILDER_TARGET"
    cp "${INSTALLBUILDER}/autoupdate/output/autoupdate-${INSTALLBUILDER_TARGET}.run" "output-${arch}/autoupdater/autoupdate-${INSTALLBUILDER_TARGET}.run"

    # Build tool with InstallBuilder
    "${INSTALLBUILDER}/bin/builder" build "output-${arch}/bncert.xml" "$INSTALLBUILDER_TARGET" --setvars \
        project.version="$VERSION" \
        project.versionId="$VERSION_ID" \
        bitnami_stacks_with_disabled_redirections="${BITNAMI_STACKS_WITH_DISABLED_REDIRECTIONS[*]}" \
        bundled_lego_version="$LEGO_VERSION" \
        letsencrypt_tos_url="$LETSENCRYPT_TOS_URL"
    cp "${INSTALLBUILDER}/output/bncert.run" "output-${arch}/bncert-${VERSION}-${INSTALLBUILDER_TARGET}.run"
done
