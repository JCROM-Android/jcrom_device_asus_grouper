#!/bin/bash

# Copyright (C) 2012 JCROM Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

EXTRACT_RC="$PWD/extract.rc"

install_blobs() {
    mkdir -p download-$1 &&
    (cd download-$1 && shasum -p -c $3) ||
    for BLOB in $2 ; do
        rm -f download-$1/$BLOB &&
        curl https://dl.google.com/dl/android/aosp/$BLOB -o download-$1/$BLOB ||
        exit -1
    done &&
    (cd download-$1 && shasum -p -c $3) &&
    for BLOB in $2 ; do
        tar xvfz download-$1/$BLOB -C download-$1 ||
        exit -1
    done &&
    for BLOB_SH in download-$1/extract-*.sh ; do
        BASH_ENV="$EXTRACT_RC" bash $BLOB_SH
    done
}

MAGURO_BLOBS="asus-grouper-jwr66y-d9ad928d.tgz
              broadcom-grouper-jwr66y-af694cc9.tgz
              elan-grouper-jwr66y-2ece01e1.tgz
              invensense-grouper-jwr66y-f21f0c49.tgz
              nvidia-grouper-jwr66y-b3b0003e.tgz
              nxp-grouper-jwr66y-f5d295e4.tgz
              widevine-grouper-jwr66y-a0b9cafc.tgz"

CSUM_LIST="$PWD/blob-shasums"

cd ../../.. &&
install_blobs nexus-7 "$MAGURO_BLOBS" "$CSUM_LIST"

