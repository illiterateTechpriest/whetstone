#!/bin/bash

usage()
{
    cat <<EOF
Usage: ${0##*/} [option]
  Options:
    --crypto        Install additional packages for crypto pentesting
    --ics           Install additional packages for ICS/SCADA pentesting
    --dark          Initialize dark theme
    --light         Initialize light theme
    --help          Display this message

EOF
exit 0
}

# parse arguments
while :
do
    case $1 in
        crypto|-crypto|--crypto)
            crypto=true;
            ;;
        ics|-ics|--ics)
            ics=true;
            ;;
        dark|-dark|--dark)
            dark=true;
            ;;
        light|-light|--light)
            light=true;
            ;;
        -h|--help|help)
            usage
            ;;
        *)
            break
    esac
    shift
done

# make sure we're root
if [ "$HOME" != "/root" ]
then
    printf "Please run while logged in as root\n"
    exit 1
fi

# fix bashrc
cp /root/.bashrc /root/.bashrc.bak
cp "/home/$(fgrep 1000:1000 /etc/passwd | cut -d: -f1)/.bashrc" /root/.bashrc
. /root/.bashrc

# enable command aliasing
shopt -s expand_aliases

# skip prompts in apt-upgrade, etc.
export DEBIAN_FRONTEND=noninteractive
alias apt-get='yes "" | apt-get -o Dpkg::Options::="--force-confdef" -y'
apt-get update

# make sure Downloads folder exists
mkdir -p ~/Downloads 2>/dev/null

# if we're not on a headless system
if [ -n "$DISPLAY" ]
then

    printf '\n============================================================\n'
    printf '[+] Enabling Tap-to-click\n'
    printf '============================================================\n\n'
    gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
    xfconf-query -c pointers -p /SynPS2_Synaptics_TouchPad/Properties/libinput_Tapping_Enabled -n -t int -s 1 --create
    xfconf-query -c pointers -p /SynPS2_Synaptics_TouchPad/Properties/Synaptics_Tap_Action -n -s 0 -s 0 -s 0 -s 0 -s 1 -s 3 -s 2 -t int -t int -t int -t int -t int -t int -t int --create

    printf '\n============================================================\n'
    printf '[+] Disabling Auto-lock, Sleep on AC\n'
    printf '============================================================\n\n'
    # disable session idle
    gsettings set org.gnome.desktop.session idle-delay 0
    # disable sleep when on AC power
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
    # disable screen timeout on AC
    xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/blank-on-ac -s 0 --create --type int
    xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-ac-off -s 0 --create --type int
    xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-ac-sleep -s 0 --create --type int
    # disable sleep when on AC
    xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/inactivity-on-ac -s 14 --create --type int
    # hibernate when power is critical
    xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/critical-power-action -s 2 --create --type int

    printf '\n============================================================\n'
    printf '[+] Setting Default Terminal\n'
    printf '============================================================\n\n'
    apt-get install gnome-terminal
    # set default terminal
    touch ~/.config/xfce4/helpers.rc
    sed -i '/TerminalEmulator=.*/c\' ~/.config/xfce4/helpers.rc
    echo 'TerminalEmulator=gnome-terminal' >> ~/.config/xfce4/helpers.rc
    # disable menus in gnome terminal
    gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
    # disable "close terminal?" prompt
    gsettings set org.gnome.Terminal.Legacy.Settings confirm-close false

    printf '\n============================================================\n'
    printf '[+] Disabling Animations\n'
    printf '============================================================\n\n'
    gsettings set org.gnome.desktop.interface enable-animations false

    printf '\n============================================================\n'
    printf '[+] Disabling Terminal Transparency\n'
    printf '============================================================\n\n'
    profile=$(gsettings get org.gnome.Terminal.ProfilesList default)
    profile=${profile:1:-1}
    gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/" use-transparent-background false
    # bring back minimize/maxminize buttons
    gsettings set org.gnome.desktop.wm.preferences button-layout appmenu:minimize,maximize,close

fi

#printf '\n============================================================\n'
#printf '[+] Installing pip\n'
#printf '============================================================\n\n'
#cd /root/Downloads
#curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
#python3 get-pip.py
#apt-get install python3-pip

printf '\n============================================================\n'
printf '[+] Disabling LL-MNR\n'
printf '============================================================\n\n'
echo '[Match]
name=*

[Network]
LLMNR=no' > /etc/systemd/network/90-disable-llmnr.network

printf '\n============================================================\n'
printf '[+] Removing gnome-software\n'
printf '============================================================\n\n'
killall gnome-software
while true
do
    pgrep gnome-software &>/dev/null || break
    sleep .5
done
apt-get remove gnome-software

printf '\n============================================================\n'
printf '[+] Installing the essentials:\n'
printf '     - dnsmasq \n'
printf '     - docker.io \n'
printf '     - golang \n'
printf '     - hcxtools \n'
printf '     - htop \n'
printf '     - jq \n'
printf '     - mosh \n'
printf '     - net-tools \n'
printf '     - nfs-kernel-server \n'
printf '     - patator \n'
printf '     - powershell \n'
printf '     - powershell-empire \n'
printf '     - python3-dev \n'
printf '     - python3-pip \n'
printf '     - python-is-python3 \n'
printf '     - realtek-rtl88xxau-dkms \n'
printf '     - starkiller \n'
printf '     - terminator \n'
printf '     - tmux \n'
printf '     - vim \n'
printf '     - zmap \n'
printf '============================================================\n\n'

apt-get install \
    dnsmasq \
    docker.io \
    golang \
    hcxtools \
    htop \
    jq \
    mosh \
    net-tools \
    nfs-kernel-server \
    patator \
    powershell \
    powershell-empire \
    python3-dev \
    python3-pip \
    python-is-python3 \
    realtek-rtl88xxau-dkms \
    starkiller \
    terminator \
    tmux \
    vim \
    zmap \

python2 -m pip install pipenv
python3 -m pip install pipenv
apt-get remove mitmproxy
python3 -m pip install mitmproxy

# default tmux config
cat <<EOF > "$HOME/.tmux.conf"
set -g mouse on
set -g history-limit 50000

# set second prefix key to "CTRL + A"
set -g prefix2 C-a
bind C-a send-prefix -2

# List of plugins
set -g @plugin 'tmux-plugins/tmux-logging'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
EOF

# enable and start docker
systemctl stop docker &>/dev/null
echo '{"bip":"172.16.199.1/24"}' > /etc/docker/daemon.json
systemctl enable docker --now

# initialize mitmproxy cert
mitmproxy &>/dev/null &
sleep 5
killall mitmproxy
# trust certificate
cp ~/.mitmproxy/mitmproxy-ca-cert.cer /usr/local/share/ca-certificates/mitmproxy-ca-cert.crt
update-ca-certificates

mkdir -p /root/.go
gopath_exp='export GOPATH="$HOME/.go"'
path_exp='export PATH="/usr/local/go/bin:$GOPATH/bin:$PATH"'
sed -i '/export GOPATH=.*/c\' ~/.profile
sed -i '/export PATH=.*GOPATH.*/c\' ~/.profile
echo $gopath_exp | tee -a "$HOME/.profile"
grep -q -F "$path_exp" "$HOME/.profile" || echo $path_exp | tee -a "$HOME/.profile"
. "$HOME/.profile"

# enable NFS server (without any shares)
systemctl enable nfs-server
systemctl start nfs-server
fgrep '1.1.1.1/255.255.255.255(rw,sync,all_squash,anongid=0,anonuid=0)' /etc/exports &>/dev/null || echo '#/root        1.1.1.1/255.255.255.255(rw,sync,all_squash,anongid=0,anonuid=0)' >> /etc/exports
exportfs -a

# example NetworkManager.conf line for blacklist interfaces
fgrep 'unmanaged-devices' &>/dev/null /etc/NetworkManager/NetworkManager.conf || echo -e '[keyfile]\nunmanaged-devices=mac:de:ad:be:ef:de:ad' >> /etc/NetworkManager/NetworkManager.conf

printf '\n============================================================\n'
printf '[+] Updating System\n'
printf '============================================================\n\n'
apt-get update
apt-get upgrade

printf '\n============================================================\n'
printf '[+] Installing Bettercap\n'
printf '============================================================\n\n'
apt-get install libnetfilter-queue-dev libpcap-dev libusb-1.0-0-dev
go get -v github.com/bettercap/bettercap

printf '\n============================================================\n'
printf '[+] Installing EapHammer\n'
printf '============================================================\n\n'
cd ~/Downloads
git clone https://github.com/s0lst1c3/eaphammer.git
cd eaphammer
apt-get install $(grep -vE "^\s*#" kali-dependencies.txt  | tr "\n" " ")
chmod +x kali-setup
# remove prompts from setup script
sed -i 's/.*input.*Do you wish to proceed.*/    if False:/g' kali-setup
./kali-setup
ln -s ~/Downloads/eaphammer/eaphammer /usr/local/bin/eaphammer

printf '\n============================================================\n'
printf '[+] Installing Gowitness\n'
printf '============================================================\n\n'
go get -v github.com/sensepost/gowitness

printf '\n============================================================\n'
printf '[+] Installing MAN-SPIDER\n'
printf '============================================================\n\n'
cd ~/Downloads
git clone https://github.com/blacklanternsecurity/MANSPIDER
cd MANSPIDER && python3 -m pipenv install -r requirements.txt

printf '\n============================================================\n'
printf '[+] Installing bloodhound.py\n'
printf '============================================================\n\n'
pip install bloodhound

printf '\n============================================================\n'
printf '[+] Installing PCredz\n'
printf '============================================================\n\n'
apt-get remove python-pypcap
apt-get install python-libpcap
cd ~/Downloads
git clone https://github.com/lgandx/PCredz.git
ln -s ~/Downloads/PCredz/Pcredz /usr/local/bin/pcredz

printf '\n============================================================\n'
printf '[+] Installing EavesARP\n'
printf '============================================================\n\n'
cd ~/Downloads
git clone https://github.com/mmatoscom/eavesarp
cd eavesarp && python3 -m pip install -r requirements.txt
cd && ln -s ~/Downloads/eavesarp/eavesarp.py /usr/local/bin/eavesarp

printf '\n============================================================\n'
printf '[+] Installing CrackMapExec\n'
printf '============================================================\n\n'
cme_dir="$(ls -d /root/.local/share/virtualenvs/* | grep CrackMapExec | head -n 1)"
if [[ ! -z "$cme_dir" ]]; then rm -r "${cme_dir}.bak"; mv "${cme_dir}" "${cme_dir}.bak"; fi
apt-get install libssl-dev libffi-dev python-dev build-essential
cd ~/Downloads
git clone --recursive https://github.com/byt3bl33d3r/CrackMapExec
cd CrackMapExec && python3 -m pipenv install
python3 -m pipenv run python setup.py install
ln -s ~/.local/share/virtualenvs/$(ls /root/.local/share/virtualenvs | grep CrackMapExec | head -n 1)/bin/cme ~/usr/local/bin/cme
apt-get install crackmapexec

printf '\n============================================================\n'
printf '[+] Installing Impacket\n'
printf '============================================================\n\n'
cd ~/Downloads
git clone https://github.com/CoreSecurity/impacket.git
cd impacket && python3 -m pipenv install
python3 -m pipenv run python setup.py install

printf '\n============================================================\n'
printf '[+] Enabling bash session logging\n'
printf '============================================================\n\n'

apt-get install tmux-plugin-manager
mkdir -p "$HOME/.tmux/plugins" 2>/dev/null
export XDG_CONFIG_HOME="$HOME"
export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins"
/usr/share/tmux-plugin-manager/scripts/install_plugins.sh
mkdir -p "$HOME/Logs" 2>/dev/null

grep -q 'TMUX_LOGGING' "/etc/profile" || echo '
export HISTSIZE= 
export HISTFILESIZE=
export PROMPT_COMMAND="history -a"
export HISTTIMEFORMAT="%F %T "
setopt INC_APPEND_HISTORY 2>/dev/null

logdir="$HOME/Logs"
mkdir -p $logdir 2>/dev/null
#gzip -q $logdir/*.log &>/dev/null
export XDG_CONFIG_HOME="$HOME"
export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins"
if [[ ! -z "$TMUX" && -z "$TMUX_LOGGING" ]]; then
    logfile="$logdir/tmux_$(date -u +%F_%H_%M_%S)_UTC.$$.log"
    "$TMUX_PLUGIN_MANAGER_PATH/tmux-logging/scripts/start_logging.sh" "$logfile"
    export TMUX_LOGGING="$logfile"
fi' >> "/etc/profile"

normal_log_script='
export HISTSIZE= 
export HISTFILESIZE=
export PROMPT_COMMAND="history -a"
export HISTTIMEFORMAT="%F %T "
setopt INC_APPEND_HISTORY 2>/dev/null

logdir="$HOME/Logs"
mkdir -p $logdir 2>/dev/null
if [[ -z "$NORMAL_LOGGING" && ! -z "$PS1" && -z "$TMUX" ]]; then
    logfile="$logdir/$(date -u +%F_%H_%M_%S)_UTC.$$.log"
    export NORMAL_LOGGING="$logfile"
    script -f -q "$logfile"
    exit
fi'

grep -q 'NORMAL_LOGGING' "$HOME/.bashrc" || echo "$normal_log_script" >> "$HOME/.bashrc"
grep -q 'NORMAL_LOGGING' "$HOME/.zshrc" || echo "$normal_log_script" >> "$HOME/.zshrc"

printf '\n============================================================\n'
printf '[+] Initializing Metasploit Database\n'
printf '============================================================\n\n'
systemctl start postgresql
systemctl enable postgresql
msfdb init

printf '\n============================================================\n'
printf '[+] Installing SecLists\n'
printf '============================================================\n\n'
cd /usr/share/wordlists/
#git clone https://github.com/danielmiessler/SecLists.git

printf '\n============================================================\n'
printf '[+] Installing Probable-Wordlists-v2.0\n'
printf '============================================================\n\n'
cd /usr/share/wordlists/
#git clone https://github.com/berzerk0/Probable-Wordlists.git

printf '\n============================================================\n'
printf '[+] Installing Statistically-Likely-Usernames\n'
printf '============================================================\n\n'
cd /usr/share/wordlists/
#git clone https://github.com/insidetrust/statistically-likely-usernames.git


printf '\n============================================================\n'
printf '[+] Unzipping RockYou\n'
printf '============================================================\n\n'
#gunzip /usr/share/wordlists/rockyou.txt.gz 2>/dev/null

# why?
# ln -s /usr/share/wordlists ~/Downloads/wordlists 2>/dev/null

printf '\n============================================================\n'
printf '[+] Installing Hatecrack\n'
printf '============================================================\n\n'
cd ~/Downloads
git clone https://github.com/trustedsec/hate_crack.git
ln -s ~/Downloads/hate_crack/hate_crack.py /usr/local/bin/hatecrack

printf '\n============================================================\n'
printf '[+] Installing Unicorn\n'
printf '============================================================\n\n'
cd ~/Downloads
git clone https://github.com/trustedsec/unicorn.git
ln -s ~/Downloads/unicorn/unicorn.py /usr/local/bin/unicorn

printf '\n============================================================\n'
printf '[+] Installing Donut\n'
printf '============================================================\n\n'
pip3 install donut-shellcode

printf '\n============================================================\n'
printf '[+] Installing Covenant\n'
printf '============================================================\n\n'
cd ~/Downloads
wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
apt-get install -y dotnet-sdk-3.1
git clone --recurse-submodules https://github.com/cobbr/Covenant
echo "alias covenant='cd ~/Downloads/Covenant/Covenant && dotnet run'" >> ~/.zshrc

printf '\n============================================================\n'
printf '[+] Installing Ghidra\n'
printf '============================================================\n\n'
cd ~/Downloads
apt-get install default-jdk
wget https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.1.2_build/ghidra_10.1.2_PUBLIC_20220125.zip -o ghidra.zip
unzip ghidra.zip
ln -s ~/Downloads/ghidra/ghidraRun /usr/local/bin/ghidra

if [ -n "$ics"]
then 

    printf '\n============================================================\n'
    printf '[+] Installing Controlthings.io Suite & other ICS tools:\n'
    printf '     - ctmodbus\n'
    printf '     - ctserial\n'
    printf '     - ctspi\n'
    printf '     - cti2c\n'
    printf '     - GRASSMARLIN\n'
    printf '     - killerbee\n'
    printf '     - mbtget\n'
    printf '     - python-snap7\n'
    printf '     - plcscan\n'
    printf "     - scadastrangelove's scadapass wordlist\n"
    printf '     - s7-cracker.py\n'
    printf '     - s7scan\n'
    printf '============================================================\n\n'
    
    # install ctmodbus
    cd ~/Downloads
    git clone https://github.com/ControlThings-io/ctmodbus
    cd ControlThings-io/
    pip3 install ctmodbus
    ln -s ~/Downloads/ctmodbus/ctmodbus.py /usr/local/bin/ctmodbus

    # install ctserial
    cd ~/Downloads
    git clone https://github.com/ControlThings-io/ctserial
    ln -s ~/Downloads/ctserial/ctserial.py /usr/local/bin/ctserial

    # install ctspi
    cd ~/Downloads
    git clone https://github.com/ControlThings-io/ctspi
    ln -s ~/Downloads/ctspi/ctspi.py /usr/local/bin/ctspi

    # install cti2c
    cd ~/Downloads
    git clone https://github.com/ControlThings-io/cti2c
    ln -s ~/Downloads/cti2c/cti2c.py /usr/local/bin/cti2c

    # install plcscan
    cd ~/Downloads
    git clone https://github.com/meeas/plcscan.git
    ln -s ~/Downloads/plcscan/plcscan.py /usr/local/bin/plcscan

    # install mbtget
    cd ~/Downloads
    git clone https://github.com/sourceperl/mbtget.git
    cd mbtget
    perl Makefile.PL
    make
    sudo make install

    # install GrassMarlin
    cd ~/Downloads
    wget -O grassmarlin.deb https://github.com/nsacyber/GRASSMARLIN/releases/download/v3.2.1/grassmarlin_3.2.1.kali-1_amd64.deb -o 
    dpkg -i grassmarlin.deb
    rm grassmarlin.deb

    # install s7scan
    cd ~/Downloads
    git clone https://github.com/klsecservices/s7scan.git
    ln -s ~/Downloads/s7scan/s7scan.py /usr/local/bin/s7scan

    # install s7-cracker.py
    cd ~/Downloads
    wget -O s7-cracker.py https://raw.githubusercontent.com/hslatman/awesome-industrial-control-system-security/main/source/s7-cracker.py
    ln -s ~/Downloads/s7-cracker.py /usr/local/bin/s7-cracker

    # install python-snap7
    pip install python-snap7

    # download scadastrangelove's scadapass wordlist
    cd /usr/share/wordlists/ 
    wget -O scadapass.csv https://raw.githubusercontent.com/scadastrangelove/SCADAPASS/master/scadapass.csv

    # install killerbee
    cd ~/Downloads
    apt-get install python-usb python-crypto python-serial python-dev libgcrypt-dev
    git clone https://github.com/riverloopsec/killerbee.git
    cd killerbee/
    python3 setup.py install

fi 

if [ -n "$dark" ]
then

    printf '\n============================================================\n'
    printf '[+] Setting Dark Theme\n'
    printf '============================================================\n\n'
    # dark theme
    #gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
    mkdir -p '/usr/share/wallpapers/wallpapers/' &>/dev/null
    wallpaper_file="$(find . -type f -name dusk-4k.png)"
    if [[ -z "$wallpaper_file" ]]
    then
        wget -P '/usr/share/wallpapers/wallpapers/' https://raw.githubusercontent.com/illiterateTechpriest/whetstone/master/dusk-4k.png
    else
        cp "$wallpaper_file" '/usr/share/wallpapers/wallpapers/dusk-4k.png'
    fi
    export DISPLAY=:0
    export XAUTHORITY=/home/kali/.Xauthority
    export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
    su kali -c 'xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s /usr/share/wallpapers/wallpapers/dusk-4k.png'
    su kali -c 'xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor1/image-path -s /usr/share/wallpapers/wallpapers/dusk-4k.png'
    su kali -c 'xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVirtual1/workspace0/last-image -s /usr/share/wallpapers/wallpapers/dusk-4k.png'
    su kali -c 'xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVirtual1/workspace1/last-image -s /usr/share/wallpapers/wallpapers/dusk-4k.png'
    su kali -c 'xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVirtual1/workspace0/image-style -s 3'
    su kali -c 'xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVirtual1/workspace1/image-style -s 3'

fi

if [ -n "$light" ]
then

    printf '\n============================================================\n'
    printf '[+] Setting Light Theme\n'
    printf '============================================================\n\n'
    # dark theme
    #gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
    mkdir -p '/usr/share/wallpapers/wallpapers/' &>/dev/null
    wallpaper_file="$(find . -type f -name dawn-4k.png)"
    if [[ -z "$wallpaper_file" ]]
    then
        wget -P '/usr/share/wallpapers/wallpapers/' https://raw.githubusercontent.com/illiterateTechpriest/whetstone/master/dawn-4k.png
    else
        cp "$wallpaper_file" '/usr/share/wallpapers/wallpapers/dawn-4k.png'
    fi
    export DISPLAY=:0
    export XAUTHORITY=/home/kali/.Xauthority
    export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
    su kali -c 'xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s /usr/share/wallpapers/wallpapers/dawn-4k.png'
    su kali -c 'xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor1/image-path -s /usr/share/wallpapers/wallpapers/dawn-4k.png'
    su kali -c 'xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVirtual1/workspace0/last-image -s /usr/share/wallpapers/wallpapers/dawn-4k.png'
    su kali -c 'xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVirtual1/workspace1/last-image -s /usr/share/wallpapers/wallpapers/dawn-4k.png'
    su kali -c 'xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVirtual1/workspace0/image-style -s 3'
    su kali -c 'xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVirtual1/workspace1/image-style -s 3'

fi

# if we're not on a headless system
if [ -n "$DISPLAY" ]
then

    printf '\n============================================================\n'
    printf '[+] Installing:\n'
    printf '     - gnome-screenshot\n'
    printf '     - LibreOffice\n'
    printf '     - Remmina\n'
    printf '     - file explorer SMB capability\n'
    printf '============================================================\n\n'
    apt-get install \
        gnome-screenshot \
        libreoffice \
        remmina \
        gvfs-backends # smb in file explorer

    printf '\n============================================================\n'
    printf '[+] Installing Bloodhound\n'
    printf '============================================================\n\n'
    # uninstall old version
    apt-get remove bloodhound
    rm -rf /opt/BloodHound-linux-x64 &>/dev/null

    # download latest bloodhound release from github
    release_url="https://github.com/$(curl -s https://github.com/BloodHoundAD/BloodHound/releases | egrep -o '/BloodHoundAD/BloodHound/releases/download/.{1,10}/BloodHound-linux-x64.zip' | head -n 1)"
    cd /opt
    wget "$release_url"
    unzip -o 'BloodHound-linux-x64.zip'
    rm 'BloodHound-linux-x64.zip'    

    # fix white screen issue
    echo -e '#!/bin/bash\n/opt/BloodHound-linux-x64/BloodHound --no-sandbox $@' > /usr/local/bin/bloodhound
    chmod +x /usr/local/bin/bloodhound

    # install Neo4J
    wget -O - https://debian.neo4j.org/neotechnology.gpg.key | apt-key add -
    echo 'deb https://debian.neo4j.org/repo stable/' > /etc/apt/sources.list.d/neo4j.list
    apt-get update
    apt-get install neo4j

    # increase open file limit
    apt-get install neo4j gconf-service gconf2-common libgconf-2-4
    mkdir -p /usr/share/neo4j/logs /usr/share/neo4j/run
    grep '^root   soft    nofile' /etc/security/limits.conf || echo 'root   soft    nofile  500000
    root   hard    nofile  600000' >> /etc/security/limits.conf
    grep 'NEO4J_ULIMIT_NOFILE=60000' /etc/default/neo4j 2>/dev/null || echo 'NEO4J_ULIMIT_NOFILE=60000' >> /etc/default/neo4j
    grep 'fs.file-max' /etc/sysctl.conf 2>/dev/null || echo 'fs.file-max=500000' >> /etc/sysctl.conf
    sysctl -p
    neo4j start

    # install cypheroth, which automates bloodhound queries & outputs to CSV
    cd ~/Downloads
    git clone https://github.com/seajaysec/cypheroth
    ln -s ~/Downloads/cypheroth/cypheroth.sh /usr/local/bin/cypheroth


    printf '\n============================================================\n'
    printf '[+] Installing Firefox\n'
    printf '============================================================\n\n'
    if [[ ! -f /usr/share/applications/firefox.desktop ]]
    then
        wget -O /tmp/firefox.tar.bz2 'https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US'
        cd /opt
        tar -xvjf /tmp/firefox.tar.bz2
        if [[ -f /usr/bin/firefox ]]; then mv /usr/bin/firefox /usr/bin/firefox.bak; fi
        ln -s /opt/firefox/firefox /usr/bin/firefox
        rm /tmp/firefox.tar.bz2

        cat <<EOF > /usr/share/applications/firefox.desktop
[Desktop Entry]
Name=Firefox
Comment=Browse the World Wide Web
GenericName=Web Browser
X-GNOME-FullName=Firefox Web Browser
Exec=/opt/firefox/firefox %u
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=firefox-esr
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;
StartupWMClass=Firefox-esr
StartupNotify=true
EOF
    fi


    printf '\n============================================================\n'
    printf '[+] Installing Chromium\n'
    printf '============================================================\n\n'
    apt-get install chromium
    sed -i 's#Exec=/usr/bin/chromium %U#Exec=/usr/bin/chromium --no-sandbox %U#g' /usr/share/applications/chromium.desktop


    printf '\n============================================================\n'
    printf '[+] Installing Sublime Text\n'
    printf '============================================================\n\n'
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
    apt-get install apt-transport-https
    echo "deb https://download.sublimetext.com/ apt/stable/" > /etc/apt/sources.list.d/sublime-text.list
    apt-get update
    apt-get install sublime-text


    printf '\n============================================================\n'
    printf '[+] Installing BoostNote\n'
    printf '============================================================\n\n'
    boost_deb_url="https://github.com$(curl -Ls https://github.com/BoostIO/boost-releases/releases/latest | egrep -o '/BoostIO/boost-releases/releases/download/.+.deb')"
    cd /opt
    wget -O boostnote.deb "$boost_deb_url"
    apt-get install gconf2 gvfs-bin
    dpkg -i boostnote.deb
    rm boostnote.deb
fi

printf '\n============================================================\n'
printf '[+] Cleaning Up\n'
printf '     - Running Final Upgrade, Autoclean & Autoremove\n'
printf '     - Deleting unecessary folders\n'
printf '============================================================\n\n'
apt-get update
apt-get upgrade
apt-get autoclean
rmdir ~/Music ~/Public ~/Videos ~/Templates ~/Desktop &>/dev/null
updatedb

printf '\n============================================================\n'
printf "[+] Done.\n"
printf '============================================================\n\n'
