# Set Application Tags
$name = "Fire Tools"
$author = "Hayden Plumley & Contributors"
$path=".\Fire-Tools"
$version = (Get-Content "$path\version")

# Build into Seperate Folder with Batch, Gapps, Extracted, Scripts, and Debloat.txt Included
python -m nuitka $path\main.py --output-filename=fire-tools --mode=standalone --enable-plugin=tk-inter `
--product-name="$name" --product-version="$version" --copyright="$author" --file-description="$name" `
--include-data-dir="$path\Batch"=.\Batch `
--include-data-dir="$path\Extracted"=.\Extracted `
--include-data-dir="$path\Gapps"=.\Gapps `
--include-data-dir="$path\Scripts\PowerShell"=.\Scripts\PowerShell `
--include-data-files="$path\Debloat.txt"=.\ `
--include-data-files="$path\*.apk"=.\
