#!/bin/bash

# Change directory to your Git repository's root folder
cd $(git rev-parse --show-toplevel)

# Display changes using git status
git status

# Prompt to confirm adding changes
read -p "Do you want to add all changes (Y/n)? " confirm

if [[ "$confirm" == Y  || -z $confirm ]]; then
    # Add all changes
    git add .

    # Prompt for commit message
    read -p "Enter commit message: " commit_msg

    # Commit changes
    git commit -m "$commit_msg"

    # Push changes
    git push origin main

    echo "Changes added, committed, and pushed successfully!"
else
    echo "Changes not added."
fi
