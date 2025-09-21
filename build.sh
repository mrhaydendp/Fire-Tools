#!/usr/bin/env sh

# Set Application Tags
name="Fire Tools"
author="Hayden Plumley & Contributors"
path="./Fire-Tools"
version=$(cat "$path/version")

# Set Scripts as Executables
chmod +x "$path"/Scripts/Posix/*.sh

# Build into Seperate Folder with Batch, Gapps, Extracted, Scripts, and Debloat.txt Included
python3 -m nuitka ./Fire-Tools/main.py --output-filename=fire-tools --mode=standalone --enable-plugin=tk-inter \
--product-name="$name" --product-version="$version" --copyright="$author" --file-description="$name" \
--include-data-dir="$path/Batch"=./Batch \
--include-data-dir="$path/Extracted"=./Extracted \
--include-data-dir="$path/Gapps"=./Gapps \
--include-data-dir="$path/Scripts/Posix"=./Scripts/Posix \
--include-data-files="$path/Debloat.txt"=./ \
--include-data-files="$path/*.apk"=./
