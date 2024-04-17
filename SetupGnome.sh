gnRED=`tput bold && tput setaf 1`
GREEN=`tput bold && tput setaf 2`
YELLOW=`tput bold && tput setaf 3`
BLUE=`tput bold && tput setaf 4`
NC=`tput sgr0`

function RED(){
	echo -e "\n${RED}${1}${NC}"
}
function GREEN(){
	echo -e "\n${GREEN}${1}${NC}"
}
function YELLOW(){
	echo -e "\n${YELLOW}${1}${NC}"
}
function BLUE(){
	echo -e "\n${BLUE}${1}${NC}"
}

if [ $UID -ne 0 ]
then
	RED "You must run this script as root!" && echo
	exit
fi

RED "Remove Gnome Garbage"
dnf remove -y \
libreoffice-* gnome-maps \
gnome-boxes nautilus \
simple-scan rhythmbox \
gnome-weather gnome-tour
# Table with all pre-installed shit
# https://unix.stackexchange.com/questions/691386/remove-preinstalled-gnome-applications

dnf autoremove -y

BLUE "System Utilitys"
GREEN "Install Qemu-Guest-Agent"
dnf install qemu-guest-agent -y
GREEN "Install Firewall Config"
dnf install firewall-config -y
GREEN "Flatpak Install Gnome-Extensions"
flatpak install org.gnome.Extensions -y
GREEN "Install gparted"
dnf install gparted -y
GREEN "Install htop"
dnf install htop -y

BLUE "Setting up Git Stack"
GREEN "Installing GIT"
dnf install git -y
GREEN "Installing Github Desktop"
rpm --import https://rpm.packages.shiftkey.dev/gpg.key
sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/yum.repos.d/shiftkey-packages.repo'
dnf install github-desktop -y

BLUE "Setting up IDE and Note Taking"
GREEN "Install Kate"
dnf install kate -y
GREEN "Install VS-Code"
rpm --import https://packages.microsoft.com/keys/microsoft.asc
sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf install code -y

BLUE "Setup Remote Access"
GREEN "Install Remote Desktop Manager"
dnf install https://cdn.devolutions.net/download/Linux/RDM/2024.1.0.8/RemoteDesktopManager_2024.1.0.8_x86_64.rpm -y
GREEN "Install Virt-Viewer on the Machine"
dnf install virt-viewer-11.0-7.fc39.x86_64 -y
GREEN "Install TailScale"
curl -fsSL https://tailscale.com/install.sh | sh
GREEN "Install No-Machine"
dnf install https://download.nomachine.com/download/8.11/Linux/nomachine_8.11.3_4_x86_64.rpm -y

BLUE "File Managers"
GREEN "Installing krusader"
dnf install krusader -y
Green "Install Dolphin"
dnf install dolphin -y

YELLOW "Gnome Extensions to Install after this script"
echo "1: Allow Locked Remote Desktop"
echo "2: App Icons Taskbar"
echo "3: Apps at top"
echo "4: Caffeine"
echo "5: Tailscale QS"
echo "6: Transparent Top Bar"
echo "7: Workspace Matrix"
echo "8: ArcMenu"
echo "9: WokSpace Matrix"
echo "10: No Titlebar When Maximized"
