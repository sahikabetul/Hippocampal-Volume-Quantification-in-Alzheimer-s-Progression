#!/bin/bash

curl -X POST http://localhost:8042/tools/execute-script --data-binary @route_dicoms.lua -v
sudo storescp 106 -v -aet HIPPOAI -od "/data/TestVolumes/Study3/11_HCropVolume" --sort-on-study-uid st #"/data/TestVolumes/Study1" /13_HCropVolume