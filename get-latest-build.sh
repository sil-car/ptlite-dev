#!/usr/bin/env bash

drive_name="Nate SIL Google"
builds_path="ParatextSharedBuilds"
start_dir="$PWD"


# Get latest build dir.
release_dir=$(rclone lsd "${drive_name}":"${builds_path}" | tr -s ' ' | cut -d' ' -f6 | sort | tail -n1)

# Get PT version number.
ver=${release_dir##*_}

# Download package.zip to folder named with version number.
mkdir "$release_dir"
cd "$release_dir"
rclone copy "${drive_name}":"${builds_path}/${release_dir}/package.zip" . -P

# Streamline package.zip.
rm -rf package
# Can't unzip to stdout b/c of ZIP format limitations; must extract to dir,
# then recompress.
unzip package.zip "package/Assets/*" "package/delete*" "package/LinuxArm64/*" "package/Terms/*"
rm -f package.zip
zip -r package.zip package
rm -rf package
cd "$start_dir"