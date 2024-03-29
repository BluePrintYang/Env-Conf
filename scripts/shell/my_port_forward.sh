#!/bin/bash


# Remote server and SFTP directory details
remote_user="nuc22"
remote_host="tinmrn-nuc"

# Function to perform port forwarding
# nuc 端口转发到本地
function perform_port_forwarding() {
    read -p "Enter the remote port you want to forward: " remote_port

    # Validate the remote port
    if [[ ! $remote_port =~ ^[0-9]+$ || $remote_port -lt 1 || $remote_port -gt 65535 ]]; then
        echo "Error: Invalid remote port number. Please enter a valid port number (1 to 65535)."
        exit 1
    fi

    read -p "Enter local port to forward ${remote_port}: (default the same as the remote port): " input_local_port

    # If user directly presses Enter, use the same local port as remote port
    if [[ -z $input_local_port ]]; then
        local_port=${remote_port}
    elif [[ $input_local_port =~ ^[0-9]+$ && $input_local_port -ge 1024 && $input_local_port -le 65535 ]]; then
        local_port=${input_local_port}
    else
        echo "Error: Invalid local port number. Please enter a valid port number (1024 to 65535) or press Enter to use the same as the remote port."
        exit 1
    fi


    if [[ $local_port -lt 1024 ]]; then
        echo "Error: Invalid local port number. Please enter a valid port number (1025 to 65535)."
        exit 1
    fi

    # Replace 'nuc22' with your remote user and 'tinmrn-nuc' with your remote hostname (example.com)
    ssh -L ${local_port}:localhost:${remote_port} -fN $remote_user@$remote_host
}


while [ $# -gt 0 ]; do
    case "$1" in
        -c) shift; check=true ;;
        -arg2) shift; arg2="$1" ;;
        -arg3) shift; arg3="$1" ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
    shift
done

if [ -z "$check" ] && [ -z "$arg2" ] && [ -z "$arg3" ]; then
    # echo "No arguments provided."
    # Main script execution
    perform_port_forwarding
elif [ "$check" = true ]; then
    echo "Check ssh port forward status."
    ps aux | grep 'ssh.*-R\|ssh.*-L\|ssh.*-fN'
else
    echo "arg2: $arg2"
    echo "arg3: $arg3"
fi



