#!/usr/bin/env sh

# Build into Seperate Folder with Batch, Gapps, Extracted, Scripts, and Debloat.txt Included
nuitka ./Fire-Tools/main.py --output-filename=fire-tools --mode=standalone --enable-plugin=tk-inter \
--product-name="Fire Tools" --product-version=25.07 --copyright="Hayden Plumley & Contributors" --file-description="Fire Tools" \
--include-data-dir=./Fire-Tools/Batch=./Batch \
--include-data-dir=./Fire-Tools/Extracted=./Extracted \
--include-data-dir=./Fire-Tools/Gapps=./Gapps \
--include-data-dir=./Fire-Tools/Scripts=./Scripts \
--include-data-files=./Fire-Tools/Debloat.txt=./ \
--include-data-files=./Fire-Tools/*.apk=./