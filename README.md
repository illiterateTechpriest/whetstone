# Whetstone

Hone Kali to a knife edge sheen. Prepares for a pentest by enabling session logging, installing additional tools, making common configuration changes, and initializing common services.

Credit: [BlackLanternSecurity](https://github.com/blacklanternsecurity/kali-setup-script)

## Eat me, drink me, run me as root!

```sudo -i
curl -k -s https://raw.githubusercontent.com/illiterateTechpriest/whetstone/main/whetstone.sh  | bash
```

```
./whetstone.sh --help
Usage: whetstone.sh [option]
  Options:
    --crypto        Install additional packages for crypto pentesting
    --ics           Install additional packages for ICS pentesting
    --dark          Initialize dark theme
    --light         Initialize light theme
    --help          Display this message
```

## Default Features:

- Installs the following tools:
	- [Berzerk0's](https://github.com/berzerk0) [Probable-Wordlists](https://github.com/berzerk0/Probable-Wordlists)
	- [Bettercap](https://github.com/bettercap/bettercap) 
	- [Bloodhound](https://github.com/BloodHoundAD/BloodHound)
	- [BoostNote](https://github.com/BoostIO/BoostNote-App)
	- [Chromium](https://www.kali.org/tools/chromium/)
	- [Covenant](https://github.com/cobbr/Covenant)
	- [CrackMapExec](https://github.com/byt3bl33d3r/CrackMapExec)
	- [Docker.io](https://www.kali.org/docs/containers/installing-docker-on-kali/)
	- [Donut](https://github.com/TheWover/donut)  
	- [Impacket](https://github.com/SecureAuthCorp/impacket)
	- [EAPhammer](https://github.com/s0lst1c3/eaphammer)
	- [EavesARP](https://github.com/arch4ngel/eavesarp)
	- [Empire](https://github.com/BC-SECURITY/Empire)
	- [Firefox](https://wiki.debian.org/Firefox) (official non-ESR version)
	- [Ghidra](https://ghidra-sre.org/) 
	- [Gnome-screenshot](https://linux.die.net/man/1/gnome-screenshot)
	- [golang](https://go.dev/)
	- [Gowitness](https://github.com/sensepost/gowitness)
	- [Hatecrack](https://github.com/trustedsec/hate_crack) 
	- [htop](https://htop.dev/)
	- [Insidetrust's](https://github.com/insidetrust) [statistically-likely-usernames](https://github.com/insidetrust/statistically-likely-usernames)
	- [jq](https://stedolan.github.io/jq/)
	- [LibreOffice](https://www.libreoffice.org/)
	- [Patator](https://github.com/lanjelot/patator)
	- [PCredz](https://github.com/lgandx/PCredz)
	- [Python-is-python3](https://www.kali.org/docs/general-use/python3-transition/)
	- [Remmina](https://remmina.org/)
	- [Sublime Text](https://www.sublimetext.com/docs/linux_repositories.html)
	- [realtek-rtl88xxau-dkms](https://gitlab.com/kalilinux/packages/realtek-rtl88xxau-dkms) (ALFA wireless drivers)
	- [Starkiller](https://github.com/BC-SECURITY/Starkiller)
	- [Unicorn](https://github.com/trustedsec/unicorn)
	- [zmap](https://github.com/zmap/zmap)
	
- Updates system
- Removes gnome-software
- Disables auto-lock
- Enables tap-to-click
- Initializes Metasploit database
- Enables details logging of terminal sessions (all output saved to ~/Logs)					

## Optional Features

- ```--ics``` enables optional installation of the following ICS tools:
    - [ControlThings.io's:](https://www.controlthings.io/)
		- [ctmodbus](https://github.com/ControlThings-io/ctmodbus)
    	- [ctserial](https://github.com/ControlThings-io/ctserial)
    	- [ctspi](https://github.com/ControlThings-io/ctspi)
    	- [cti2c](https://github.com/ControlThings-io/cti2c)
	- [killerbee](https://github.com/riverloopsec/killerbee)
	- [plcscan](https://github.com/meeas/plcscan)
	- [mbtget](https://github.com/sourceperl/mbtget)
	- [GRASSMARLIN](https://github.com/nsacyber/GRASSMARLIN)
	- [s7-cracker.py](https://raw.githubusercontent.com/hslatman/awesome-industrial-control-system-security/main/source/s7-cracker.py)
	- [s7scan](https://github.com/klsecservices/s7scan)
	- [python-snap7](https://github.com/gijzelaerr/python-snap7)

- ```--crypto``` enables optional installation of the following crypto auditing tools:
	- [HalbornSecurity's](https://github.com/HalbornSecurity) [burp-eth](https://github.com/HalbornSecurity/burp-eth) BurpSuite extension

- Invoke a suitable theme according to your mood. Aesthetic is important!
	- Are you feeling ```--light``` or ```--dark``` today?
