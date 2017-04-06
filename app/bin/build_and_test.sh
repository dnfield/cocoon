# Copyright (c) 2016 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set -e

if [ ! -f "pubspec.yaml" -a ! -f "app.yaml" ]; then
  echo '[ERROR]: cwd must be the root of the cocoon app containing pubspec.yaml and app.yaml'
  exit 1
fi

(cd ../commands && go test)

rm -rf build
pub get
dartanalyzer --strong bin/*.dart web/*.dart test/*.dart
pub run test -p vm
pub run test -p dartium
pub build

echo
echo "Build succeeded! To deploy to App Engine run the following command after replacing {VERSION}:"
echo "gcloud app deploy --no-promote --no-stop-previous-version -v {VERSION}"
