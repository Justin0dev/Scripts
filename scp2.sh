#!/bin/bash

# Prompt the user for IP address, username, file path, and destination path
echo "Enter the IP address:"
read ip_address

echo "Enter the username:"
read username

echo "Enter the full path to the file you want to send:"
read file_path

echo "Enter the destination path on the remote server:"
read dest_path

# Use scp to send the file to the specified destination
scp "$file_path" "${username}@${ip_address}:${dest_path}"

# Provide feedback
if [ $? -eq 0 ]; then
    echo "File sent successfully!"
else
    echo "File transfer failed!"
fi