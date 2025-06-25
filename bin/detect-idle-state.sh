#!/bin/bash

# Configuration
CPU_THRESHOLD=5.0
LOAD_THRESHOLD=0.2
CONNECTION_THRESHOLD=5
IDLE_DURATION=900  # 15 minutes in seconds
LOG_FILE="$HOME/log/server-idle-check.log"

log_message() {
    echo "$(date): $1" >> "$LOG_FILE"
}

check_cpu_usage() {
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
    if (( $(echo "$cpu_usage < $CPU_THRESHOLD" | bc -l) )); then
        return 0  # Low CPU
    fi
    return 1
}

check_load_average() {
    load_15min=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $3}' | tr -d ',')
    if (( $(echo "$load_15min < $LOAD_THRESHOLD" | bc -l) )); then
        return 0  # Low load
    fi
    return 1
}

check_network_activity() {
    active_connections=$(netstat -an | grep ESTABLISHED | wc -l)
    if [ $active_connections -lt $CONNECTION_THRESHOLD ]; then
        return 0  # Low network activity
    fi
    return 1
}

check_user_activity() {
    active_users=$(who | wc -l)
    if [ $active_users -eq 0 ]; then
        return 0  # No users
    fi
    return 1
}

check_disk_io() {
    # Check if disk I/O is minimal
    io_wait=$(iostat -c 1 2 | tail -1 | awk '{print $4}')
    if (( $(echo "$io_wait < 1.0" | bc -l) )); then
        return 0  # Low I/O wait
    fi
    return 1
}

is_server_idle() {
    local idle_checks=0
    local total_checks=5
    
    if check_cpu_usage; then
        ((idle_checks++))
        log_message "CPU usage is low"
    fi
    
    if check_load_average; then
        ((idle_checks++))
        log_message "Load average is low"
    fi
    
    if check_network_activity; then
        ((idle_checks++))
        log_message "Network activity is low"
    fi
    
    if check_user_activity; then
        ((idle_checks++))
        log_message "No active users"
    fi
    
    if check_disk_io; then
        ((idle_checks++))
        log_message "Disk I/O is low"
    fi
    
    # Server is considered idle if at least 4 out of 5 checks pass
    if [ $idle_checks -ge 4 ]; then
        return 0
    fi
    return 1
}

main() {
    log_message "Starting idle detection check"
    
    if is_server_idle; then
        log_message "Server appears to be idle - candidate for hibernation"
        
        # Get instance ID
        instance_id=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
        
        # Check if instance supports hibernation
        hibernation_enabled=$(aws ec2 describe-instance-attribute \
            --instance-id "$instance_id" \
            --attribute hibernationOptions \
            --query 'HibernationOptions.Configured' \
            --output text)
        
        if [ "$hibernation_enabled" = "true" ]; then
            log_message "Hibernating instance $instance_id"
            aws ec2 stop-instances --instance-ids "$instance_id" --hibernate
        else
            log_message "Instance does not support hibernation"
        fi
    else
        log_message "Server is active - not hibernating"
    fi
}

# Run the main function
main
