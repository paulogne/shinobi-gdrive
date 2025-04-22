#!/bin/bash

BASE_DIR="/home/Shinobi/records"

rclone mkdir gdrive:Shinobi/Camera01
rclone mkdir gdrive:Shinobi/Camera02
rclone mkdir gdrive:Shinobi/Camera03

rclone copy $BASE_DIR/1 gdrive:Shinobi/Camera01 --update --create-empty-src-dirs
rclone copy $BASE_DIR/2 gdrive:Shinobi/Camera02 --update --create-empty-src-dirs
rclone copy $BASE_DIR/3 gdrive:Shinobi/Camera03 --update --create-empty-src-dirs
