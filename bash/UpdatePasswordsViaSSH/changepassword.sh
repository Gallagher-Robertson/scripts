#!/bin/bash

REMOTE_USER="your_admin_user" # Change this to your SSH login user
SERVER_FILE="servers.txt"

if [ ! -f "$SERVER_FILE" ]; then
    echo "Error: $SERVER_FILE not found."
    exit 1
fi

# Read the file line by line, splitting by spaces/tabs
while read -r SERVER CURRENT_PASSWORD NEW_PASSWORD || [ -n "$SERVER" ]; do
    # Skip empty lines or comment lines starting with #
    [[ -z "$SERVER" || "$SERVER" =~ ^# ]] && continue

    echo "Processing $SERVER..."
    
    # 1. Pass the unique CURRENT password to 'sudo -S'
    # 2. Pass the unique NEW password to 'chpasswd'
    ssh -o ConnectTimeout=5 -t "$REMOTE_USER@$SERVER" \
        "echo '$CURRENT_PASSWORD' | sudo -S sh -c \"echo 'root:$NEW_PASSWORD' | chpasswd\"" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo "✅ Successfully changed root password on $SERVER"
    else
        echo "❌ FAILED to change password on $SERVER"
    fi
    echo "-----------------------------------"
done < "$SERVER_FILE"
