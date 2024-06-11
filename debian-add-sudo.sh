#!/bin/bash

# Prompt the user for a username
echo "Please enter a username:"
read username

# Use usermod to add the user to the sudo group
sudo usermod -aG sudo $username

# Use visudo to add the user to the sudoers file
echo "$username ALL=(ALL:ALL) ALL" | sudo EDITOR='tee -a' visudo
