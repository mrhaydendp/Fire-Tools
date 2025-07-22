# Set Application Tags
$name = "Fire Tools"
$version = "25.07"
$author = "Hayden Plumley & Contributors"

# Build into Seperate Folder with Batch, Gapps, Extracted, Scripts, and Debloat.txt Included
nuitka ./Fire-Tools/main.py --output-filename=fire-tools --mode=standalone --enable-plugin=tk-inter `
--product-name="$name" --product-version=25.07 --copyright="$author" --file-description="$name" `
--include-data-dir=./Fire-Tools/Batch=./Batch `
--include-data-dir=./Fire-Tools/Extracted=./Extracted `
--include-data-dir=./Fire-Tools/Gapps=./Gapps `
--include-data-dir=./Fire-Tools/Scripts=./Scripts `
--include-data-files=./Fire-Tools/Debloat.txt=./ `
--include-data-files=./Fire-Tools/*.apk=./