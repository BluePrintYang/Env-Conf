#!/bin/bash

# Remote server and SFTP directory details
remote_user="user" # username
remote_host="host" # host name
remote_directory="/path"

# Local mount point directory
local_mount_point="/Users/<username>/sftp_mount"

# AutoSSH options
autossh_options="-M 0 -o ServerAliveInterval=30 -o ServerAliveCountMax=5"

# SSHFS options
sshfs_options="-o reconnect"

# Mount function
function mount_sshfs() {
    # Mount the SSHFS directory
    sshfs $sshfs_options $remote_user@$remote_host:$remote_directory $local_mount_point

    # Print message on successful mount
    if [ $? -eq 0 ]; then
        echo "SSHFS mounted successfully at $local_mount_point"
    else
        echo "Failed to mount SSHFS"
    fi
}

# Unmount function
function unmount_sshfs() {
    umount $local_mount_point
    echo "SSHFS unmounted"
}

unmount_sshfs
mount_sshfs
