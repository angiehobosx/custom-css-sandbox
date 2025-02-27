# Download Files with Directory Structure Script

This repository contains a Bash script that automates downloading files from a list of URLs while preserving the local directory structure based on the URL’s path (starting after the domain). The script also skips files that already exist locally. It offers multiple options for providing the URLs, making it easy to add more files.

---

## Features

- **Multiple Input Options:**
  - **Command-Line Arguments:** Supply one or more URLs directly when running the script.
  - **URL List File:** If no URLs are provided as arguments, the script reads from a file named `urls.txt` (one URL per line).

- **Automatic Directory Creation:**  
  The script creates directories based on the URL path after the domain. For example, the URL  
  `https://unpkg.com/swiper/swiper-bundle.min.css`  
  creates a local directory `swiper/` and saves the file as `swiper-bundle.min.css`.

- **Skip Existing Files:**  
  If a file already exists locally, the script skips downloading it.

---

## How It Works

1. **Input Processing:**
   - **Command-Line Arguments:**  
     If URLs are provided when invoking the script, those URLs are processed.
   - **URL List File:**  
     If no arguments are provided, the script checks for a file named `urls.txt` and reads URLs from it.

2. **Removing the Protocol and Extracting the Path:**
   - The script removes `http://` or `https://` from each URL.
   - It then extracts the file path after the domain. For example:
     - `https://unpkg.com/swiper/swiper-bundle.min.css` becomes `swiper/swiper-bundle.min.css`.
     - `https://cdn.userway.org/widget.js` becomes `widget.js` (saved directly in the current directory).

3. **Directory Creation:**
   - If the extracted path contains directories, the script creates them using `mkdir -p`.

4. **Downloading Files:**
   - The script uses `curl` with the `-L` flag to download each file.
   - If the file already exists locally, it is skipped.

---

## Usage Options

### Option 1: Using Command-Line Arguments

Pass one or more URLs directly when running the script:

```bash
./download_files_interactive.sh https://unpkg.com/swiper/swiper-bundle.min.css https://cdn.userway.org/widget.js
