#!/bin/bash

# Change directory to your Git repository's root folder
cd $(git rev-parse --show-toplevel)

# Check if there are changes using git status
if ! git status --porcelain | grep -q .
then
    echo "No changes to commit."
    exit 0
fi

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

    read -p "Do you want to push all commits (Y/n/g)? " push

    if [[ "$push" == Y ]]; then
        # Push changes
        git push origin main
        echo "Changes added, committed, and pushed successfully!"
    elif [[ "$push" == g ]]; then
        git push gitlab
        echo "Changes added, committed, and pushed to gitlab successfully!"
        curl http://tinmrn-nuc:5000/evil/remote/pull
    else
        echo "Changes added, committed, but not push."
    fi
else
    echo "Changes not added."
fi
