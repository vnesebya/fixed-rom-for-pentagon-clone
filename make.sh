#!/bin/bash

sjasmplus "src/main.asm"
./tools/rom_slicer.sh "build/pentagon128.rom"
