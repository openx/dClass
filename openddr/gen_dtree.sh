#!/bin/bash

if test ! -d OpenDDR-Resources ; then
  git clone git://github.com/OpenDDRdotORG/OpenDDR-Resources.git
fi
(cd OpenDDR-Resources ; git pull)

OPENDDR_RESOURCE_PATH=OpenDDR-Resources/resources
DCLASS_BIN=../src/dclass_client

if [ ! -s "$DCLASS_BIN" ]
then
        echo "ERROR: dclass_client binary not found"
        exit 1
fi

cp BuilderDataSourcePatch.xml DeviceDataSourcePatch.xml "$OPENDDR_RESOURCE_PATH"

$DCLASS_BIN -d "$OPENDDR_RESOURCE_PATH" -o ../dtrees/openddr.dtree

(cd OpenDDR-Resources; git checkout -- resources/BuilderDataSourcePatch.xml resources/DeviceDataSourcePatch.xml)
