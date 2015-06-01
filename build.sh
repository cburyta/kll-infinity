#!/bin/bash
# Configure and build firmware for my infinity keyboard.
# Invoke this script from the build subdirectory of the controller.

# This directory, where the source files are located.
SOURCE_DIR=$(dirname ${BASH_SOURCE[0]})
SOURCE_DIR=${SOURCE_DIR%/}

# Make sure a symlink exists from the kll to my configuration files.
LAYOUTS_DIR=$(dirname ${PWD})/kll/layouts
rm -f "${LAYOUTS_DIR}/config"
ln -s "${SOURCE_DIR}" "${LAYOUTS_DIR}/config"

# Configure the build.
cmake                                                                   \
      -DCHIP=mk20dx128vlf5                                              \
      -DScanModule=MD1                                                  \
      -DMacroModule=PartialMap                                          \
      -DOutputModule=pjrcUSB                                            \
      -DDebugModule=full                                                \
      -DBaseMap=defaultMap                                              \
      -DDefaultMap="config/full/base;" \
      -DPartialMaps="config/partial/boards/poker2 config/partial/p1; config/partial/vi/viNormal config/partial/p2; config/partial/p3" \
      ..

# -DPartialMaps="config/poker2 config/viKeys;config/viKeys"

# Rebuild.
make clean
make -j8 VERBOSE=1
