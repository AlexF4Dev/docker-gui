#!/bin/bash
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

################################################################################
# Script to run glxgears in a container.
# This version uses VirtualGL to perform “split rendering” (GLX forking) which
# intercepts GLX calls and renders to a memory buffer, which can then be 
# forwarded to a remote display.
################################################################################

TARGET_DISPLAY=${DISPLAY:-:0}
DISPLAY=${VGL_DISPLAY:-:0} # The Display to use for 3D rendering

BIN=$(cd $(dirname $0); echo ${PWD%docker-gui*})docker-gui/bin
. $BIN/docker-xauth.sh
. $BIN/docker-gpu.sh

$DOCKER_COMMAND run --rm \
    -u $(id -u):$(id -g) \
    -v /etc/passwd:/etc/passwd:ro \
    $X11_FLAGS \
    $GPU_FLAGS \
    -e DISPLAY=$TARGET_DISPLAY \
    glxgears-vgl vglrun glxgears

