#!/bin/bash

if test ! -d DeviceMap-Resource; then
  #svn co https://svn.apache.org/repos/asf/devicemap/trunk/data/device-data/src/main/resources/devicedata DeviceMap-Resource
  svn checkout http://svn.apache.org/repos/asf/devicemap/trunk/data/1.0/device-data/src/main/resources/devicedata DeviceMap-Resource
fi
(cd DeviceMap-Resource; svn update)

DEVICEMAP_RESOURCE_PATH=DeviceMap-Resource


DCLASS_BIN=../src/dclass_client

if [ ! -d "$DEVICEMAP_RESOURCE_PATH" ]
then
    echo "ERROR: invalid DeviceMap resource path: $DEVICEMAP_RESOURCE_PATH"
    exit 1
fi

if [ ! -s "$DCLASS_BIN" ]
then
    echo "ERROR: dclass_client binary not found"
    exit 1
fi

cp BuilderDataSourcePatch.xml DeviceDataSourcePatch.xml "$DEVICEMAP_RESOURCE_PATH"

$DCLASS_BIN -d "$DEVICEMAP_RESOURCE_PATH" -o ../dtrees/devicemap.dtree

