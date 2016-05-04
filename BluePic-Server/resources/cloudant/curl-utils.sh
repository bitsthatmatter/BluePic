#!/bin/bash

##
# Copyright IBM Corporation 2016
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##

# If any commands fail, we want the shell script to exit immediately.
set -e

imagesFolder=`dirname $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )`/images

# Upload images via Kitura-based server
curl -v --data-binary @$imagesFolder/bridge.jpg -X POST http://localhost:8090/users/1002/images/bridge.jpg/Bridge/34.2/80.5/Austin,%20Texas
curl -v --data-binary @$imagesFolder/car.jpg -X POST http://localhost:8090/users/1002/images/car.jpg/Car/50.2/90.5/Tuscon,%20Arizona
curl -v --data-binary @$imagesFolder/yosemite.png -X POST http://localhost:8090/users/1002/images/yosemite.png/Yosemite%20Hiking/37.864851/119.538523/Mariposa,%20California
