# Folder Organizer Scripts

A simple collection of scripts to automatically clean and organize messy folders by moving files into category folders such as **Audio**, **Video**, **Images**, **Excel**, **PDF**, **ZIP Archives**, **Installers**, **Code**, and more.

This project includes scripts for both **Windows** and **Linux/macOS**.

---

## Files Included

| File | Platform | What It Does |
|---|---|---|
| `Organize_Downloads.bat` | Windows | Organizes the default Windows Downloads folder, or a custom folder if provided. |
| `Organize_Current_Folder.sh` | Linux/macOS | Organizes only the folder where this `.sh` file is placed. |

---

## Features

- Creates category folders automatically.
- Moves files based on their extensions.
- Does not move existing folders or subfolders.
- Avoids overwriting duplicate files by renaming them safely.
- Keeps the script file itself safe and unmoved.
- Works offline with no extra software required.
- Simple double-click usage where supported.

---

## Folder Categories

The scripts can create and use folders such as:

- `Audio`
- `Video`
- `Images`
- `Documents`
- `PDF`
- `Word`
- `Excel`
- `PowerPoint`
- `ZIP_Archives`
- `Installers`
- `Code`
- `Text`
- `Ebooks`
- `Fonts`
- `Shortcuts`
- `Torrents`
- `Disk_Images`
- `Others`

Files with unknown extensions are moved into the `Others` folder.

---

## Supported File Types

| Category | Extensions |
|---|---|
| Audio | `.mp3`, `.wav`, `.flac`, `.aac`, `.ogg`, `.m4a`, `.wma`, `.opus`, `.aiff`, `.mid`, `.midi` |
| Video | `.mp4`, `.mkv`, `.avi`, `.mov`, `.wmv`, `.flv`, `.webm`, `.m4v`, `.3gp`, `.mpeg`, `.mpg` |
| Images | `.jpg`, `.jpeg`, `.png`, `.gif`, `.bmp`, `.tif`, `.tiff`, `.webp`, `.svg`, `.heic`, `.ico`, `.raw`, `.cr2`, `.nef` |
| PDF | `.pdf` |
| Word | `.doc`, `.docx` |
| Documents | `.rtf`, `.odt` |
| Excel | `.xls`, `.xlsx`, `.xlsm`, `.csv`, `.ods` |
| PowerPoint | `.ppt`, `.pptx`, `.pptm`, `.odp` |
| ZIP Archives | `.zip`, `.rar`, `.7z`, `.tar`, `.gz`, `.bz2`, `.xz`, `.tgz` |
| Installers | `.exe`, `.msi`, `.msix`, `.apk`, `.appx`, `.deb`, `.rpm`, `.pkg`, `.dmg`, `.run`, `.appimage` |
| Code | `.html`, `.htm`, `.css`, `.js`, `.ts`, `.jsx`, `.tsx`, `.json`, `.xml`, `.py`, `.java`, `.cpp`, `.c`, `.h`, `.hpp`, `.cs`, `.php`, `.rb`, `.go`, `.rs`, `.swift`, `.kt`, `.kts`, `.sh`, `.bash`, `.zsh`, `.bat`, `.cmd`, `.ps1`, `.sql`, `.yml`, `.yaml` |
| Text | `.txt`, `.md`, `.log`, `.ini`, `.conf` |
| Ebooks | `.epub`, `.mobi`, `.azw`, `.azw3`, `.fb2` |
| Fonts | `.ttf`, `.otf`, `.woff`, `.woff2` |
| Shortcuts | `.desktop`, `.lnk`, `.url` |
| Torrents | `.torrent` |
| Disk Images | `.iso`, `.img`, `.vhd`, `.vhdx` |

---

## Windows Usage

Use the Windows batch script:

```bat
Organize_Downloads.bat
```

### Option 1: Double-click

1. Download or copy `Organize_Downloads.bat`.
2. Double-click it.
3. It will organize your default Downloads folder:

```text
%USERPROFILE%\Downloads
```

4. Confirm when asked.

### Option 2: Use a custom folder

You can also run it from Command Prompt and pass a folder path:

```bat
Organize_Downloads.bat "D:\My Folder"
```

This will organize only the folder you provide.

---

## Linux/macOS Usage

Use the shell script:

```bash
Organize_Current_Folder.sh
```

This script is designed to organize **only the folder where the script is placed**.

### Steps

1. Copy `Organize_Current_Folder.sh` into the folder you want to clean.
2. Give it execute permission:

```bash
chmod +x Organize_Current_Folder.sh
```

3. Run it:

```bash
./Organize_Current_Folder.sh
```

### Double-click usage

On some Linux desktop environments, you may be able to double-click the script to run it. If double-click opens the file in a text editor instead, run it from Terminal using the commands above.

---

## Example

Before running:

```text
Downloads/
├── song.mp3
├── movie.mp4
├── report.pdf
├── data.xlsx
├── archive.zip
├── setup.exe
└── notes.txt
```

After running:

```text
Downloads/
├── Audio/
│   └── song.mp3
├── Video/
│   └── movie.mp4
├── PDF/
│   └── report.pdf
├── Excel/
│   └── data.xlsx
├── ZIP_Archives/
│   └── archive.zip
├── Installers/
│   └── setup.exe
└── Text/
    └── notes.txt
```

---

## Duplicate File Handling

If a file with the same name already exists in the destination folder, the script will not overwrite it.

Example:

```text
report.pdf
report (1).pdf
report (2).pdf
```

---

## Safety Notes

- The scripts move files, not copy them.
- Existing folders and subfolders are not moved.
- Files inside subfolders are not scanned.
- The shell script does not move itself.
- It is recommended to test the script on a sample folder first.
- Always keep backups of important files.

---

## Requirements

### Windows

- Windows Command Prompt
- No additional installation required

### Linux/macOS

- Bash shell
- No additional installation required

---

## Customization

You can customize categories by editing the file extension lists inside the scripts.

For example, to add a new extension to the `Images` category, add it to the image extension section in the script.

---

## Contributing

Contributions are welcome. You can improve this project by:

- Adding more file extensions
- Improving category names
- Adding recursive folder organization as an optional feature
- Adding a dry-run mode
- Improving cross-platform compatibility
