# Download Files with Directory Structure Script

This repository contains a Bash script that automates the process of downloading files from a list of URLs. The script creates a local directory structure based on the URL's path starting after the domain, then downloads each file into its respective folder. If a URL does not include any directories after the domain, the file is downloaded directly into the current directory.

## How It Works

1. **Reading URLs:**  
   The script reads URLs from an input file (`urls.txt`), with each URL on a separate line.

2. **Removing the Protocol:**  
   It strips the protocol (`http://` or `https://`) from the URL, leaving only the domain and path.

3. **Extracting the Path:**  
   The script extracts the portion of the URL that comes after the domain name. For example:
   - `https://unpkg.com/swiper/swiper-bundle.min.css` becomes `swiper/swiper-bundle.min.css`.
   - `https://cdn.userway.org/widget.js` becomes `widget.js` because there is no directory after the domain.

4. **Creating Directories:**  
   If the URL includes directories (e.g., `swiper/`), the script automatically creates those directories using `mkdir -p`.

5. **Downloading Files:**  
   Finally, the script uses `curl` to download the file into the correct directory. The `-L` flag is used to follow any redirects.

## Requirements

- **Bash:** The script is written in Bash and should work on any Unix-like system.
- **curl:** Make sure that `curl` is installed on your system.

## Usage

1. **Prepare the URL List:**
   - Create a file named `urls.txt` in the same directory as the script.
   - Add your URLs to `urls.txt`, one per line.

2. **Make the Script Executable:**
   ```bash
   chmod +x download_files.sh
