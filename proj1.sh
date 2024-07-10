#!/bin/bash

# Advanced System Health and Maintenance Script
# Author: [Your Name]
# Date: [Current Date]
# Version: 2.0

# Function to display a separator line
function separator() {
    echo "=============================================="
}

# Function to check if a command exists
function command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install a package if it doesn't exist
function install_package() {
    if ! command_exists "$1"; then
        echo "Installing $1..."
        sudo apt-get install -y "$1"
    fi
}

# Function to display the system health report
function display_report() {
    clear
    separator
    echo "         Advanced System Health Report "
    separator

    # Get the system uptime
    echo -e "\n\033[1;34mUptime:\033[0m"
    uptime

    # Get the CPU usage
    echo -e "\n\033[1;34mCPU Usage:\033[0m"
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4 + $6}')
    echo "CPU Usage: $CPU_USAGE%"

    # Get the memory usage
    echo -e "\n\033[1;34mMemory Usage:\033[0m"
    free -h

    # Get the disk usage
    echo -e "\n\033[1;34mDisk Usage:\033[0m"
    df -h | grep '^/dev/'

    # Get the network activity
    echo -e "\n\033[1;34mNetwork Activity:\033[0m"
    if command_exists ifstat; then
        echo "Incoming/Outgoing Traffic:"
        ifstat -i $(ip -o -4 route show to default | awk '{print $5}') 1 1 | awk 'NR==3{print "RX: "$1 " KB/s, TX: "$2 " KB/s"}'
    else
        echo "ifstat not installed. Install it for network statistics."
    fi

    # Get the system load averages
    echo -e "\n\033[1;34mLoad Averages (1, 5, 15 minutes):\033[0m"
    uptime | awk -F'load average:' '{ print $2 }'

    # Get the top 5 processes by memory usage
    echo -e "\n\033[1;34mTop 5 Processes by Memory Usage:\033[0m"
    ps aux --sort=-%mem | awk 'NR<=6{print $0}'

    # Get the top 5 processes by CPU usage
    echo -e "\n\033[1;34mTop 5 Processes by CPU Usage:\033[0m"
    ps aux --sort=-%cpu | awk 'NR<=6{print $0}'

    # Get the temperature of the CPU
    echo -e "\n\033[1;34mCPU Temperature:\033[0m"
    if command_exists sensors; then
        sensors | grep 'Core'
    else
        echo "lm-sensors not installed. Install it for temperature information."
    fi

    # Get the battery status (for laptops)
    echo -e "\n\033[1;34mBattery Status:\033[0m"
    if command_exists upower; then
        upower -i $(upower -e | grep BAT) | grep -E "state|percentage|time to empty"
    else
        echo "upower not installed. Install it for battery information."
    fi

    # Get the top 5 processes by disk I/O
    echo -e "\n\033[1;34mTop 5 Processes by Disk I/O:\033[0m"
    if command_exists iotop; then
        sudo iotop -b -o -n 1 | head -n 7
    else
        echo "iotop not installed. Install it for disk I/O information."
    fi

    # Get system logs
    echo -e "\n\033[1;34mRecent System Logs:\033[0m"
    sudo tail -n 10 /var/log/syslog

    # Get active user sessions
    echo -e "\n\033[1;34mActive User Sessions:\033[0m"
    who

    # Get listening ports
    echo -e "\n\033[1;34mListening Ports:\033[0m"
    sudo netstat -tuln | grep LISTEN

    separator
    echo "         End of Report "
    separator
}

# Function to update the system
function update_system() {
    echo "Updating the system..."
    sudo apt update && sudo apt upgrade -y
    echo "System update completed."
}

# Function to clean the system cache and temporary files
function clean_system() {
    echo "Cleaning cache and temporary files..."
    sudo apt autoremove -y
    sudo apt clean
    sudo rm -rf /tmp/*
    echo "Cache and temporary files cleaned."
}

# Function to perform a security audit
function security_audit() {
    echo "Performing security audit..."
    
    # Check for failed login attempts
    echo "Recent failed login attempts:"
    sudo grep "Failed password" /var/log/auth.log | tail -n 5

    # Check for open ports
    echo "Open ports:"
    sudo netstat -tuln | grep LISTEN

    # Check for running services
    echo "Running services:"
    systemctl list-units --type=service --state=running

    # Check for available updates
    echo "Available security updates:"
    sudo apt list --upgradable | grep -i security

    echo "Security audit completed."
}

# Function to backup important directories
function backup_system() {
    echo "Backing up important directories..."
    
    BACKUP_DIR="/home/$USER/system_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"

    # Backup home directory
    sudo rsync -avz --exclude='.*' /home/$USER "$BACKUP_DIR"

    # Backup etc directory
    sudo rsync -avz /etc "$BACKUP_DIR"

    echo "Backup completed. Files are stored in $BACKUP_DIR"
}

# Main menu function
function main_menu() {
    while true; do
        clear
        separator
        echo "         System Health and Maintenance Menu"
        separator
        echo "1. Display System Health Report"
        echo "2. Update System"
        echo "3. Clean System Cache and Temporary Files"
        echo "4. Perform Security Audit"
        echo "5. Backup Important Directories"
        echo "6. Exit"
        separator

        read -p "Enter your choice (1-6): " choice

        case $choice in
            1) display_report; read -p "Press Enter to continue..." ;;
            2) update_system; read -p "Press Enter to continue..." ;;
            3) clean_system; read -p "Press Enter to continue..." ;;
            4) security_audit; read -p "Press Enter to continue..." ;;
            5) backup_system; read -p "Press Enter to continue..." ;;
            6) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid choice. Please try again."; sleep 2 ;;
        esac
    done
}

# Check and install required packages
install_package "ifstat"
install_package "lm-sensors"
install_package "upower"
install_package "iotop"

# Run the main menu
main_menu