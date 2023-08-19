#!/bin/bash

# 映射nuc D盘到本地
# Remote server and SFTP directory details
remote_user="nuc22"
remote_host="tinmrn-nuc"
remote_directory="/D:/"

# Local mount point directory
local_mount_point="/Users/tinmrn/sftp_mount"

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
