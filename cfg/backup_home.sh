#!/bin/bash

LOG_FILE="/var/log/backup_home.log"

{
    echo "=== Backup started: $(date) ==="
    rsync -av --delete ~/ /tmp/backup/
    exit_code=$?
    echo "Backup finished: $(date)"
    
    if [ $exit_code -eq 0 ]; then
        echo "STATUS: OK"
    else
        echo "STATUS: FAILED (exit code: $exit_code)"
    fi
    echo "==============================="
} >> "$LOG_FILE" 2>&1