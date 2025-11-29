#!/bin/bash

# Step 1: Find the root partition
myroot=$(sudo findmnt -no SOURCE /)
echo "$myroot"  # Show the actual root partition, not the string "myroot"

# Step 2: Get the UUID of the root partition
myuuid=$(sudo blkid -s UUID -o value "$myroot")
echo "$myuuid"  # Show the actual UUID, not the string "myuuid"

# Step 3: Check if the UUID exists in the 40_custom file
if grep -q "$myuuid" /etc/grub.d/40_custom; then
    echo "UUID is already present in the 40_custom file. No changes are needed."
    touch /opt/nochanged.txt
else
    echo "UUID mismatch found. Replacing..."

    # Step 4: Replace the old UUID with the new one in the file
    sudo sed -i "s|UUID=[^[:space:]]*|UUID=$myuuid|g" /etc/grub.d/40_custom

    echo "UUID has been successfully replaced with the new one."
fi

# Step 5: Update GRUB
sudo update-grub
