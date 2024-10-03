#!/bin/bash
image_name=$1
version=$2
source_tag=$3

echo "Mirroring $image_name:$version"
IFS="." read -r -a parts <<< $version
versions=(latest)
current=""
for value in ${parts[@]}; do [[ -z $current ]] && current=$value || current+=".$value" ; versions=(${versions[@]} "$current"); done
for tag in ${versions[@]}; do ./regctl image copy $SOURCE_REGISTRY/$image_name:"$source_tag" $TARGET_REGISTRY/$image_name:$tag; done
