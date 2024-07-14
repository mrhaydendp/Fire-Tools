## Updated main.py, requirements.txt, version 07/14/2024
- Version bump (24.07)
- Cleaned up and improved the speed of package list generation by ≥ 7%
- Added search to packagelist
- Updated Urllib3 requirement to 2.2.2 to for CVE-2024-37891
- Updated Certifi requirement to 2024.7.4 for CVE-2024-39689
- Added to Debloat.txt: Tap to Alexa, Alexa on Android OS, Profile Settings (Amazon Profiles & Family Library), Parental Controls, Speak Selection
- Removed from Debloat.txt: Calendar, Calendar Storage, Contacts, Contacts Storage, Call Logs Backup, AOSP Music Player
- Fire Tools now sets current path to working directory to make .desktop and .exe files work in the future
- Added flake.nix file to repo for easy setup with Nix by @Sleeping-Donut