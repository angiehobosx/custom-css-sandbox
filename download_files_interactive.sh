#!/bin/bash

# If command-line arguments are provided, use them as the URLs.
# Otherwise, read from urls.txt.
if [ "$#" -gt 0 ]; then
  urls=("$@")
else
  if [ -f "urls.txt" ]; then
    mapfile -t urls < urls.txt
  else
    echo "No URLs provided and urls.txt not found."
    exit 1
  fi
fi

for url in "${urls[@]}"; do
  # Skip empty lines or arguments.
  [[ -z "$url" ]] && continue

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
