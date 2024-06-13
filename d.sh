#!/bin/bash

# Define the output file for saving paths
output_file="/tmp/t/dd.txt"

# List all directories under /home
home_dirs=$(find /home -mindepth 1 -maxdepth 1 -type d)

# Loop through each home directory
for home_dir in $home_dirs; do
    # Extract the username from the home directory path
    user=$(basename "$home_dir")

    # Look for htdocs directories within each home directory
    htdocs_dirs=$(find "$home_dir" -type d -name htdocs)

    # Loop through each htdocs directory
    for htdocs_dir in $htdocs_dirs; do
        # List directories within the htdocs directory and extract domain names
        domains=$(ls -d "$htdocs_dir"/*/ | awk -F/ '{print $(NF-1)}')

        # Loop through each domain
        for domain in $domains; do
            # Construct the target path for saving as a txt file
            target_path="/home/$user/htdocs/$domain/test.php"

            # Save the target path to the output file
            echo "$target_path" | sed 's#/home/'"$user"'/htdocs/##' >> "$output_file"
        done
    done
done

echo "Paths saved to $output_file"
