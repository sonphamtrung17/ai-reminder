#!/bin/zsh

cd ../app
# $1: dev
# $2: build/run
# $3 (optional): apk/appbundle/ios/ipa
# $4 (optional): --export-options-plist=ios/exportOptions.plist
cmd="flutter $2 $3 $4 --flavor $1 --dart-define FLAVOR=$1"
echo $cmd
eval $cmd