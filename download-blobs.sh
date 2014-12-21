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

MAGURO_BLOBS="asus-grouper-lrx22g-aec33ad2.tgz
              broadcom-grouper-lrx22g-c7f54ba9.tgz
              elan-grouper-lrx22g-580da07a.tgz
              invensense-grouper-lrx22g-fd3690aa.tgz
              nvidia-grouper-lrx22g-1d3281e3.tgz
              nxp-grouper-lrx22g-93aec176.tgz
              widevine-grouper-lrx22g-179aea10.tgz"

CSUM_LIST="$PWD/blob-shasums"

cd ../../.. &&
install_blobs nexus-7 "$MAGURO_BLOBS" "$CSUM_LIST"

