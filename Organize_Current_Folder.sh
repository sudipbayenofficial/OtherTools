#!/usr/bin/env bash

# ================================================================
# Organize_Current_Folder.sh
#
# Place this file inside ANY folder, then run/double-click it.
# It will organize ONLY that same folder where this script is placed.
#
# It creates category folders like Audio, Video, Excel, ZIP_Archives,
# etc., and moves matching files into them.
#
# Notes:
#   - It does NOT organize your whole Downloads folder automatically.
#   - It does NOT scan subfolders.
#   - It does NOT move existing folders.
#   - It does NOT move this script file.
#   - If a duplicate filename exists, it adds a number like file (1).pdf
# ================================================================

set -u

# Find the folder where this script itself is located.
# This makes the script organize only the folder where the user placed it,
# even if it is launched from another working directory.
SCRIPT_PATH="${BASH_SOURCE[0]}"
SCRIPT_DIR="$(cd -- "$(dirname -- "$SCRIPT_PATH")" >/dev/null 2>&1 && pwd -P)"
SCRIPT_FILE="$(basename -- "$SCRIPT_PATH")"
TARGET_DIR="$SCRIPT_DIR"

# Safety check
if [[ ! -d "$TARGET_DIR" ]]; then
    echo "ERROR: Target folder not found: $TARGET_DIR"
    read -r -p "Press Enter to exit..."
    exit 1
fi

echo "================================================================"
echo " Folder Organizer"
echo "================================================================"
echo
echo "This script will organize ONLY this folder:"
echo "$TARGET_DIR"
echo
echo "Existing folders and subfolders will not be moved."
echo

read -r -p "Continue? [y/N]: " ANSWER
case "$ANSWER" in
    y|Y|yes|YES|Yes) ;;
    *)
        echo
        echo "Cancelled. No files were moved."
        read -r -p "Press Enter to exit..."
        exit 0
        ;;
esac

# Create category folders
CATEGORIES=(
    "Audio"
    "Video"
    "Images"
    "Documents"
    "PDF"
    "Word"
    "Excel"
    "PowerPoint"
    "ZIP_Archives"
    "Installers"
    "Code"
    "Text"
    "Ebooks"
    "Fonts"
    "Shortcuts"
    "Torrents"
    "Disk_Images"
    "Others"
)

for category in "${CATEGORIES[@]}"; do
    mkdir -p -- "$TARGET_DIR/$category"
done

moved=0
skipped=0

get_category() {
    local filename="$1"
    local ext="${filename##*.}"

    # Files without extension go to Others
    if [[ "$filename" == "$ext" ]]; then
        echo "Others"
        return
    fi

    ext="${ext,,}"  # lowercase extension

    case "$ext" in
        # Audio
        mp3|wav|flac|aac|ogg|m4a|wma|opus|aiff|mid|midi)
            echo "Audio"
            ;;

        # Video
        mp4|mkv|avi|mov|wmv|flv|webm|m4v|3gp|mpeg|mpg)
            echo "Video"
            ;;

        # Images
        jpg|jpeg|png|gif|bmp|tif|tiff|webp|svg|heic|ico|raw|cr2|nef)
            echo "Images"
            ;;

        # Documents
        pdf)
            echo "PDF"
            ;;
        doc|docx)
            echo "Word"
            ;;
        rtf|odt)
            echo "Documents"
            ;;

        # Excel
        xls|xlsx|xlsm|csv|ods)
            echo "Excel"
            ;;

        # PowerPoint
        ppt|pptx|pptm|odp)
            echo "PowerPoint"
            ;;

        # Archives / ZIP
        zip|rar|7z|tar|gz|bz2|xz|tgz)
            echo "ZIP_Archives"
            ;;

        # Installers / Apps
        exe|msi|msix|apk|appx|deb|rpm|pkg|dmg|run|appimage)
            echo "Installers"
            ;;

        # Code
        html|htm|css|js|ts|jsx|tsx|json|xml|py|java|cpp|c|h|hpp|cs|php|rb|go|rs|swift|kt|kts|sh|bash|zsh|bat|cmd|ps1|sql|yml|yaml)
            echo "Code"
            ;;

        # Text / Notes
        txt|md|log|ini|conf)
            echo "Text"
            ;;

        # Ebooks
        epub|mobi|azw|azw3|fb2)
            echo "Ebooks"
            ;;

        # Fonts
        ttf|otf|woff|woff2)
            echo "Fonts"
            ;;

        # Shortcuts / Torrents / Disk Images
        desktop|lnk|url)
            echo "Shortcuts"
            ;;
        torrent)
            echo "Torrents"
            ;;
        iso|img|vhd|vhdx)
            echo "Disk_Images"
            ;;

        *)
            echo "Others"
            ;;
    esac
}

move_safely() {
    local src="$1"
    local dest_dir="$2"
    local base name ext dest n

    base="$(basename -- "$src")"
    name="${base%.*}"
    ext="${base##*.}"

    # Handle files without extensions correctly
    if [[ "$base" == "$ext" ]]; then
        ext=""
    else
        ext=".$ext"
    fi

    dest="$dest_dir/$base"
    n=1

    while [[ -e "$dest" ]]; do
        dest="$dest_dir/$name ($n)$ext"
        n=$((n + 1))
    done

    if mv -- "$src" "$dest"; then
        echo "[MOVED] $base -> $(basename -- "$dest_dir")/$(basename -- "$dest")"
        moved=$((moved + 1))
    else
        echo "[SKIPPED] $base"
        skipped=$((skipped + 1))
    fi
}

echo
echo "Organizing files..."
echo

# Loop only over files directly inside TARGET_DIR.
# This does not enter subfolders.
shopt -s nullglob dotglob
for file in "$TARGET_DIR"/*; do
    # Skip folders/subfolders
    [[ -f "$file" ]] || continue

    base="$(basename -- "$file")"

    # Skip this script itself
    [[ "$base" == "$SCRIPT_FILE" ]] && continue

    category="$(get_category "$base")"
    move_safely "$file" "$TARGET_DIR/$category"
done
shopt -u nullglob dotglob

echo
echo "================================================================"
echo " Done!"
echo " Files moved:   $moved"
echo " Files skipped: $skipped"
echo "================================================================"
echo
read -r -p "Press Enter to exit..."
