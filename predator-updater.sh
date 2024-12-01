#! /bin/bash
clear
tput setaf 3;echo "--------------Updating predator-OS to last version---------------"
echo
sleep 3

sudo apt clean -y
sudo apt autoclean -y
sudo apt autoremove -y

export XDG_RUNTIME_DIR=/var/run/user/$UID

clear

sudo mkdir /var/lib/chkbook
tput setaf 3;echo "--------------Checking the current version---------------"
echo 
sleep 3

 
# Check the version in /etc/predator-os-version.txt
VERSION=$(cat /etc/predator-os-version.txt 2>/dev/null)

# Check if msfconsole exists
MSFCONSOLE_EXISTS=false
if [ -f "/usr/bin/msfconsole" ]; then
  MSFCONSOLE_EXISTS=true
fi

# Check the current desktop environment
DESKTOP_ENVIRONMENT=$(echo $XDG_CURRENT_DESKTOP | tr '[:upper:]' '[:lower:]' 2>/dev/null)

# Check the system's default target
DEFAULT_TARGET=$(sudo systemctl get-default)

# Version 3.2
if [[ "$DEFAULT_TARGET" == "multi-user.target" && "$MSFCONSOLE_EXISTS" == true ]]; then
  echo "nodesktop-security-3.5" | sudo tee /etc/predator-os-version.txt
elif [[ "$DEFAULT_TARGET" == "multi-user.target" && "$MSFCONSOLE_EXISTS" == false ]]; then
  echo "nodesktop-home-3.5" | sudo tee /etc/predator-os-version.txt
elif [[ "$VERSION" == "3.2" && "$MSFCONSOLE_EXISTS" == true && "$DESKTOP_ENVIRONMENT" == "plasma" ]]; then
  echo "plasma-security-3.5" | sudo tee /etc/predator-os-version.txt
elif [[ "$VERSION" == "3.2" && "$MSFCONSOLE_EXISTS" == true && "$DESKTOP_ENVIRONMENT" == "mate" ]]; then
  echo "mate-security-3.5" | sudo tee /etc/predator-os-version.txt
elif [[ "$VERSION" == "3.2" && "$MSFCONSOLE_EXISTS" == false && "$DESKTOP_ENVIRONMENT" == "plasma" ]]; then
  echo "plasma-home-3.5" | sudo tee /etc/predator-os-version.txt
elif [[ "$VERSION" == "3.2" && "$MSFCONSOLE_EXISTS" == false && "$DESKTOP_ENVIRONMENT" == "mate" ]]; then
  echo "mate-home-3.5" | sudo tee /etc/predator-os-version.txt
else
  echo "fix /etc/predator-os-version.txt if security or home or NoDesktop Editions"
fi



# Version 3.3
if [[ "$DEFAULT_TARGET" == "multi-user.target" && "$MSFCONSOLE_EXISTS" == true ]]; then
  echo "nodesktop-security-3.5" | sudo tee /etc/predator-os-version.txt
elif [[ "$DEFAULT_TARGET" == "multi-user.target" && "$MSFCONSOLE_EXISTS" == false ]]; then
  echo "nodesktop-home-3.5" | sudo tee /etc/predator-os-version.txt
elif [[ "$VERSION" == "3.3" && "$MSFCONSOLE_EXISTS" == true && "$DESKTOP_ENVIRONMENT" == "plasma" ]]; then
  echo "plasma-security-3.5" | sudo tee /etc/predator-os-version.txt
elif [[ "$VERSION" == "3.3" && "$MSFCONSOLE_EXISTS" == true && "$DESKTOP_ENVIRONMENT" == "mate" ]]; then
  echo "mate-security-3.5" | sudo tee /etc/predator-os-version.txt
elif [[ "$VERSION" == "3.3" && "$MSFCONSOLE_EXISTS" == false && "$DESKTOP_ENVIRONMENT" == "plasma" ]]; then
  echo "plasma-home-3.5" | sudo tee /etc/predator-os-version.txt
elif [[ "$VERSION" == "3.3" && "$MSFCONSOLE_EXISTS" == false && "$DESKTOP_ENVIRONMENT" == "mate" ]]; then
  echo "mate-home-3.5" | sudo tee /etc/predator-os-version.txt
else
  echo "fix /etc/predator-os-version.txt if security or home or NoDesktop Editions"
fi



cp -rf /opt/predator-os-updater/issue /etc/issue
cp -rf /opt/predator-os-updater/os-release   /usr/lib/os-release



clear
tput setaf 3;echo "--------------Backup the current apt and sources.list---------------"
echo 


sudo apt clean -y
sudo apt autoclean -y
sudo apt autoremove -y


sudo mv /etc/apt /etc/apt.bk
echo

echo "deb http://kali.mirror.garr.it/mirrors/kali kali-last-snapshot main contrib non-free non-free-firmware" | sudo tee -a /etc/apt/sources.list

sudo apt nala update -y

clear
tput setaf 3;echo "--------------Installing the new tools---------------"
echo 


sudo pip install git-dumper
apt install zsh-autosuggestions zsh-syntax-highlighting unrar  rar urlcrazy apachetop wifipumpkin3 httpx-toolkit subfinder paramspider  brightnessctl  light xbacklight  sippts goshs  openjdk-24-jre brightnesspicker xserver-xorg-input-multitouch xserver-xorg-input-synaptics xserver-xorg-video-amdgpu xserver-xorg-input-kbd xserver-xorg-input-mouse nvtop fastfetch mdetect fuse3 -y


dpkg --configure -a
sudo apt -f install


tput setaf 3;echo "-------------- Installing new Neofetch---------------"
apt install fastfetch
echo "alias neofetch='fastfetch --logo-color-1 cyan --logo /opt/fastfetch.txt'" | sudo tee -a ~/.bashrc
sudo -u $USER source ~/.bashrc



cd /opt/
mkdir sub404
cd sub404
git clone https://github.com/r3curs1v3-pr0xy/sub404.git
cd sub404
pip install -r requirements.txt

dpkg --configure -a
sudo apt -f install


clear
tput setaf 3;echo "--------------verifying the installation---------------"
sleep 2 


sudo sed -i '/^deb http://kali.mirror.garr.it/mirrors/kali kali-last-snapshot main contrib non-free non-free-firmware/d' /etc/apt/sources.list

sudo apt clean
sudo apt autoclean
sudo apt autoremove
sudo apt nala update
dpkg --configure -a
sudo apt -f install


clear
tput setaf 3;echo "-------------- Fixing some current Problems---------------"
echo

sudo ln -s /usr/lib/x86_64-linux-gnu/blas/libblas.so.3 /usr/lib/libblas.so.3
sudo ldconfig -v


sudo sed -i '/^user.max_user_namespaces = 0/d' /etc/sysctl.conf
echo "user.max_user_namespaces=2000" | sudo tee -a /etc/sysctl.conf

sudo sed -i '/^kernel.unprivileged_bpf_disabled = 1/d' /etc/sysctl.conf
sudo sed -i '/^kernel.unprivileged_bpf_disabled = 0/d' /etc/sysctl.conf


apt remove rsyslog -y
apt remove logrotate -y
sudo systemctl mask rsyslog.service


clear
tput setaf 3;echo "-------------- finalizing--------------"
echo 
sleep 2
echo

# File to check
GRUB_FILE="/etc/default/grub"

# Check if the lines exist
if grep -qE "^#GRUB_DISABLE_OS_PROBER=(true|false)" "$GRUB_FILE"; then
  echo "GRUB_DISABLE_OS_PROBER=false" | sudo tee -a "$GRUB_FILE"
  echo "Added GRUB_DISABLE_OS_PROBER=false to $GRUB_FILE"
else
  echo "No matching lines found. Nothing was added."
fi



sudo sysctl -p
sudo update-grub
sudo update-initramfs -uv


#/boot new config
	#kill -SIGUSR2 $(pidof gvfsd-trash
  

#deb [arch=amd64] https://www.seilany.ir/predator-os/mate-home-updater-ppa ./
#GRUB_CMDLINE_LINUX_DEFAULT="quiet splash priority=critical retbleed=off mitigations=off audit=0 amd_pstate.enable=1 amd-pstate=active intel_pstate=enable nowatchdog fsck.mode=skip debugfs=off nmi_watchdog=0 debug=0 audit=0 show_ssp=0 earlyprintk=off kaslr=off no_pasr cfi=off"


sudo apt update
clear
echo 
tput setaf 3;echo "-------------- finished,You have new Version of Predator--------------"
sleep 2
neofetch
echo
tput setaf 3;echo "-------------- finished,You have new Version of Predator--------------"



sudo sed -i '/^kernel.unprivileged_bpf_disabled=1/d' /etc/sysctl.conf
sudo sed -i '/^net.core.bpf_jit_harden=2/d' /etc/sysctl.conf
sudo sed -i '/^net.core.bpf_jit_harden = 2/d' /etc/sysctl.conf


sudo sed -i '/^Storage=none/d' /etc/systemd/journald.conf
echo "Storage=yes" | sudo tee -a /etc/systemd/journald.conf