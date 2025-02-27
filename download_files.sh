#!/bin/bash

# File containing your list of URLs (one per line)
input_file="urls.txt"

while IFS= read -r url; do
  # Skip empty lines
  [[ -z "$url" ]] && continue

  # Remove the protocol (http:// or https://)
  temp="${url#http://}"
  temp="${temp#https://}"

  # Extract everything after the first slash (i.e. after the domain)
  path="${temp#*/}"

  # If the URL has no slash after the domain, path will be the same as temp.
  # In that case, use the full domain value as the file name.
  if [ "$path" = "$temp" ]; then
    file=$(basename "$temp")
  else
    file="$path"
  fi

  # Determine the directory portion (if any)
  dir=$(dirname "$file")

  # If there is a directory path (dir is not just '.'), create it.
  if [ "$dir" != "." ]; then
    mkdir -p "$dir"
  fi

  # If the file already exists, skip downloading it
  if [ -f "$file" ]; then
    echo "File $file already exists, skipping."
    continue
  fi

  echo "Downloading $url to $file"
  curl -L -o "$file" "$url"

done < "$input_file"
