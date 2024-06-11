#!/bin/bash

# Prompt the user for IP address, username, and file path
echo "Enter the IP address:"
read ip_address

echo "Enter the username:"
read username

echo "Enter the full path to the file you want to send:"
read file_path

# Use scp to send the file
scp "$file_path" "${username}@${ip_address}:~/"

# Provide feedback
if [ $? -eq 0 ]; then
    echo "File sent successfully!"
else
    echo "File transfer failed!"
fi