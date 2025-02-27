<html>
  <body style="font-family: Arial, sans-serif; background-color: #f5f5f5; color: #3a3a3a;">

    <h1 style="color: #010839; text-align: center; margin-bottom: 0.2em;">Download Files with Directory Structure Script</h1>
    <p style="text-align: center; font-size: 1.2em; color: #6cd4ff; margin-top: 0;">Automate file downloads with style – preserving directory structure and skipping existing files.</p>
    <hr style="border: 2px solid #bb0000; margin-bottom: 1em;">

    <h2 style="color: #6f0992;">Features</h2>
    <ul>
      <li>
        <strong>Multiple Input Options:</strong>
        <ul>
          <li><span style="color: #010839;">Command-Line Arguments:</span> Supply one or more URLs directly when running the script.</li>
          <li><span style="color: #010839;">URL List File:</span> If no URLs are provided as arguments, the script reads from a file named <code>urls.txt</code> (one URL per line).</li>
        </ul>
      </li>
      <li>
        <strong>Automatic Directory Creation:</strong> The script creates directories based on the URL path after the domain. For example, the URL 
        <code>https://unpkg.com/swiper/swiper-bundle.min.css</code> creates a local directory <code>swiper/</code>.
      </li>
      <li>
        <strong>Skip Existing Files:</strong> If a file already exists locally, the script skips downloading it.
      </li>
    </ul>

    <h2 style="color: #6f0992;">How It Works</h2>
    <ol>
      <li>
        <strong>Input Processing:</strong>
        <ul>
          <li><span style="color: #010839;">Command-Line Arguments:</span> If URLs are provided when invoking the script, those URLs are processed.</li>
          <li><span style="color: #010839;">URL List File:</span> If no arguments are provided, the script looks for a file named <code>urls.txt</code> and reads URLs from it.</li>
        </ul>
      </li>
      <li>
        <strong>Removing the Protocol and Extracting the Path:</strong>
        <ul>
          <li>The script removes <code>http://</code> or <code>https://</code> from each URL.</li>
          <li>It then extracts the file path after the domain. For example:
            <ul>
              <li><code>https://unpkg.com/swiper/swiper-bundle.min.css</code> becomes <code>swiper/swiper-bundle.min.css</code>.</li>
              <li><code>https://cdn.userway.org/widget.js</code> becomes <code>widget.js</code> (saved directly in the current directory).</li>
            </ul>
          </li>
        </ul>
      </li>
      <li>
        <strong>Directory Creation:</strong> If the extracted path contains directories, the script creates them using <code>mkdir -p</code>.
      </li>
      <li>
        <strong>Downloading Files:</strong> The script uses <code>curl</code> with the <code>-L</code> flag to download files. If the file already exists, it is skipped.
      </li>
    </ol>

    <h2 style="color: #6f0992;">Usage Options</h2>
    
    <h3 style="color: #1f7b19;">Option 1: Using Command-Line Arguments</h3>
    <pre style="background-color: #e5e5e5; padding: 1em; border-radius: 5px;"><code>./download_files_interactive.sh https://unpkg.com/swiper/swiper-bundle.min.css https://cdn.userway.org/widget.js</code></pre>
    
    <h3 style="color: #1f7b19;">Option 2: Using a URL List File</h3>
    <ol>
      <li>
        <strong>Prepare the URL List:</strong>
        <p>Create a file named <code>urls.txt</code> in the same directory as the script and add your URLs, one per line. For example:</p>
        <pre style="background-color: #e5e5e5; padding: 1em; border-radius: 5px;"><code>https://unpkg.com/swiper/swiper-bundle.min.css
https://cdn.userway.org/widget.js</code></pre>
      </li>
      <li>
        <strong>Run the Script:</strong>
        <pre style="background-color: #e5e5e5; padding: 1em; border-radius: 5px;"><code>./download_files_interactive.sh</code></pre>
      </li>
    </ol>
    
    <h3 style="color: #1f7b19;">Option 3: Adding More Files</h3>
    <ul>
      <li><strong>Add URLs to <code>urls.txt</code>:</strong> Append new URLs to the file.</li>
      <li><strong>Or, Use Command-Line Arguments:</strong> Pass new URLs directly when running the script.</li>
    </ul>
    
    <h2 style="color: #6f0992;">The Script</h2>
    <pre style="background-color: #e5e5e5; padding: 1em; border-radius: 5px;"><code>#!/bin/bash

# If command-line arguments are provided, use them as the URLs.
# Otherwise, read from urls.txt.
if [ "$#" -gt 0 ]; then
  urls=("$@")
else
  if [ -f "urls.txt" ]; then
    mapfile -t urls &lt; urls.txt
  else
    echo "No URLs provided and urls.txt not found."
    exit 1
  fi
fi

for url in "${urls[@]}"; do
  # Skip empty lines or arguments.
  [[ -z "$url" ]] &amp;&amp; continue

  # Remove the protocol (http:// or https://)
  temp="${url#http://}"
  temp="${temp#https://}"

  # Extract everything after the first slash (i.e., after the domain)
  path="${temp#*/}"

  # If there's no directory after the domain, use the file name from the domain.
  if [ "$path" = "$temp" ]; then
    file=$(basename "$temp")
  else
    file="$path"
  fi

  # Determine the directory (if any) from the file path.
  dir=$(dirname "$file")
  if [ "$dir" != "." ]; then
    mkdir -p "$dir"
  fi

  # Skip downloading if the file already exists.
  if [ -f "$file" ]; then
    echo "File $file already exists, skipping."
    continue
  fi

  echo "Downloading $url to $file"
  curl -L -o "$file" "$url"
done
</code></pre>

    <h2 style="color: #6f0992;">Example</h2>
    <p>If your <code>urls.txt</code> contains:</p>
    <pre style="background-color: #e5e5e5; padding: 1em; border-radius: 5px;"><code>https://unpkg.com/swiper/swiper-bundle.min.css
https://cdn.userway.org/widget.js</code></pre>
    <p>
      - The script creates a folder named <code>swiper</code> and downloads <code>swiper-bundle.min.css</code> into it.<br>
      - It downloads <code>widget.js</code> directly in the current directory (as no directory is specified after the domain).<br>
      - Existing files are skipped.
    </p>

    <h2 style="color: #6f0992;">Customization</h2>
    <ul>
      <li><strong>Input File Name:</strong> Modify the script where it reads <code>urls.txt</code> to use a different file name if desired.</li>
      <li><strong>Directory Structure Logic:</strong> Adjust the logic for directory creation if your URL structure differs.</li>
    </ul>

    <h2 style="color: #6f0992;">License</h2>
    <p>This project is licensed under the <a href="LICENSE" style="color: #bb0000; text-decoration: none;">MIT License</a>.</p>

  </body>
</html>
