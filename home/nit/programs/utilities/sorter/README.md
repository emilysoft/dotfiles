# Sorter Script

This directory contains the script that automatically organizes the Downloads folder.

## Files

| File | Description |
|---|---|
| `sorter.sh` | Bash script that moves files from the Downloads folder into subfolders based on their type (images, documents, videos, music, archives, etc.). |

It runs automatically every 5 minutes via a systemd timer configured in `home/nit/services/sorter.nix`. The goal is to keep the downloads folder organized without requiring manual intervention.
