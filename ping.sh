#!/bin/bash

# Function to ping a host and determine its availability
ping_host() {
    ping -c 1 -W 1 $1 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "$1 is reachable"
    else
        echo "$1 is unreachable"
    fi
}

# Function to extract the network prefix
extract_network_prefix() {
    echo $1 | cut -d "." -f 1-3
}

# Prompt the user to input the network address
read -p "Enter the network address (e.g., 192.168.1): " network_address

# Generate a list of IP addresses within the network range and ping each one
for host in $(seq 1 254); do
    ip_address="$network_address.$host"
    ping_host $ip_address &
done

# Wait for all background processes to finish
wait
