#!/bin/bash

# =========================
# Initial Check: Dependencies
# =========================
if ! command -v dialog &> /dev/null; then
    echo "Please install 'dialog' with: sudo apt install dialog"
    exit 1
fi

# =========================
# File Organizer Function
# Description: Organizes files into folders based on type (images, videos, etc.)
# It supports file move, size tracking, logging, and user confirmation.
# =========================
organize_files() {
    while true; do
        CHOICE=$(dialog --clear --title "File Organizer" \
            --menu "Choose file type to organize:" 15 50 5 \
            1 "Images" \
            2 "Videos" \
            3 "Documents" \
            4 "Music" \
            5 "Back to Main Menu" \
            3>&1 1>&2 2>&3)

        [ -z "$CHOICE" ] && return

        case $CHOICE in
            1) extensions=("*.jpg" "*.jpeg" "*.png" "*.gif" "*.bmp"); target="Images" ;;
            2) extensions=("*.mp4" "*.avi" "*.mkv" "*.mov" "*.flv"); target="Videos" ;;
            3) extensions=("*.pdf" "*.docx" "*.doc" "*.txt" "*.xls" "*.xlsx" "*.pptx"); target="Documents" ;;
            4) extensions=("*.mp3" "*.wav" "*.flac" "*.aac"); target="Music" ;;
            5) return ;;
            *) dialog --msgbox "Invalid option." 6 30; continue ;;
        esac

        mkdir -p "$target"

        moved_files=""
        total_size=0
        file_count=0

        for ext in "${extensions[@]}"; do
            while IFS= read -r -d '' file; do
                [ -e "$file" ] || continue

                dest="$target/$(basename "$file")"
                filename=$(basename "$file")

                # Check if file exists and prompt for overwrite
                if [ -e "$dest" ]; then
                    dialog --yesno "File $filename already exists in $target/. Overwrite?" 7 60
                    if [ $? -ne 0 ]; then
                        continue
                    fi
                fi

                size=$(stat -c "%s" "$file" 2>/dev/null)
                [ -z "$size" ] && continue
                human_size=$(numfmt --to=iec --suffix=B "$size" 2>/dev/null)

                if mv -- "$file" "$target/"; then
                    moved_files+="$filename - $human_size\n"
                    echo "$(date): Moved $filename to $target/ ($human_size)" >> organizer.log  # [NEW]
                    total_size=$((total_size + size))
                    file_count=$((file_count + 1))
                else
                    dialog --msgbox "Failed to move $file. Check permissions." 6 60
                fi
            done < <(find . -maxdepth 1 -type f -iname "$ext" -print0)
        done

        if [ "$file_count" -gt 0 ]; then
            total_hr=$(numfmt --to=iec --suffix=B "$total_size" 2>/dev/null)
            dialog --title "Files Transferred" \
                   --msgbox "Files moved to $target/:\n\n$moved_files\nTotal: $file_count files, $total_hr transferred" 20 60
        fi

        dialog --yesno "Do you want to organize another file type?" 7 50
        [ $? -ne 0 ] && break
    done
}

# =========================
# Disk Usage Dashboard Function
# Description: Provides a menu for monitoring disk usage, CPU, I/O, and thresholds
# Uses dialog and system commands like df, iostat, vmstat, top, etc.
# =========================
disk_dashboard() {
    while true; do
        CHOICE=$(dialog --clear --title "Disk Usage Dashboard" \
            --menu "Select an option:" 20 60 7 \
            1 "Real-time Usage" \
            2 "Storage Threshold Check" \
            3 "Interactive Analysis (ncdu)" \
            4 "Read/Write Stats (iostat)" \
            5 "VM/IO Stats (vmstat)" \
            6 "CPU Utilization (top)" \
            7 "Return to Main Menu" \
            3>&1 1>&2 2>&3)

        [ -z "$CHOICE" ] && break

        case $CHOICE in
            1)
                dialog --infobox "Press Ctrl+C to exit real-time view." 4 40
                sleep 1
                watch -n 1 "df -h | grep -Ev 'tmpfs|loop'"
                ;;
            2)
                threshold=$(dialog --inputbox "Enter threshold percentage (1-100, default: 80):" 8 50 "80" 3>&1 1>&2 2>&3)
                if ! [[ "$threshold" =~ ^[0-9]+$ ]] || [ "$threshold" -lt 1 ] || [ "$threshold" -gt 100 ]; then
                    dialog --msgbox "Invalid input. Using default threshold of 80%" 6 40
                    threshold=80
                fi

                result=$(df -h | awk -v th=$threshold '$5+0 > th {print "ALERT: " $1 " is " $5 " full!"}')
                if [ -n "$result" ]; then
                    dialog --msgbox "$result" 10 50
                else
                    dialog --msgbox "All partitions are under $threshold% usage." 6 40
                fi
                ;;
            3)
                if ! command -v ncdu &> /dev/null; then
                    dialog --msgbox "ncdu not installed.\nUse: sudo apt install ncdu" 7 50
                else
                    ncdu
                fi
                ;;
            4)
                if ! command -v iostat &> /dev/null; then
                    dialog --msgbox "iostat not installed.\nUse: sudo apt install sysstat" 7 50
                else
                    iostat -xz 1 5 > /tmp/iostat.txt 2>&1
                    dialog --textbox /tmp/iostat.txt 20 70
                    rm -f /tmp/iostat.txt
                fi
                ;;
            5)
                vmstat 1 5 > /tmp/vmstat.txt 2>&1
                dialog --textbox /tmp/vmstat.txt 20 70
                rm -f /tmp/vmstat.txt
                ;;
            6)
                top -n 1 | head -20 > /tmp/top.txt 2>&1
                dialog --textbox /tmp/top.txt 20 70
                rm -f /tmp/top.txt
                ;;
            7)
                break
                ;;
            *)
                dialog --msgbox "Invalid choice." 6 30
                ;;
        esac
    done
}

# =========================
# Logged-in Users Info Function
# Description: Displays currently logged-in users using 'who' command
# =========================
user_info() {
    who > /tmp/users.txt 2>&1
    dialog --textbox /tmp/users.txt 20 60
    rm -f /tmp/users.txt
}

# =========================
# Background Alert (storage > 80%)
# Description: Background task that checks if root partition is over 80% full
# Sends warning via wall if condition is met
# =========================
storage_alert() {
    while true; do
        usage=$(df / | awk 'NR==2 {gsub("%","",$5); print $5}')
        if [ "$usage" -gt 80 ] 2>/dev/null; then
            echo "WARNING: Root partition at $usage% capacity!" | wall
            $NOTIFY_AVAILABLE && notify-send "Disk Alert" "Root is $usage% full!"  # [NEW]
        fi
        sleep 300
    done &
}

# Start the background alert only once
if ! pgrep -f "bash.*storage_alert" > /dev/null; then
    storage_alert
fi

# =========================
# Main Menu 
# =========================
while true; do
    CHOICE=$(dialog --clear --title "Main Menu" \
        --menu "Select an option:" 15 50 4 \
        1 "File Organizer" \
        2 "Disk Usage Dashboard" \
        3 "Show Logged-in Users" \
        4 "Exit" \
        3>&1 1>&2 2>&3)

    [ -z "$CHOICE" ] && continue

    case $CHOICE in
        1) organize_files ;;
        2) disk_dashboard ;;
        3) user_info ;;
        4) clear; exit 0 ;;
        *) dialog --msgbox "Invalid option." 6 30 ;;
    esac
done

