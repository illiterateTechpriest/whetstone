# Kali Whetstone Script

Hone your Kali instance to a knife edge sheen. Prepares vanillla Kali for a pentest by enabling session logging, installing additional tools, making common configuration changes, and initializing common services.

## NOTE: Must be run as root

## Default Features:

- Installs the following tools:
	- [CrackMapExec](https://github.com/byt3bl33d3r/CrackMapExec)
	- [Impacket](https://github.com/SecureAuthCorp/impacket)
	- [Bloodhound](https://github.com/BloodHoundAD/BloodHound)
	- [EAPhammer](https://github.com/s0lst1c3/eaphammer)
	- [Patator](https://github.com/lanjelot/patator)
	- [PCredz](https://github.com/lgandx/PCredz)
	- [Gowitness](https://github.com/sensepost/gowitness)
	- [EavesARP](https://github.com/arch4ngel/eavesarp) 
	- [bettercap](https://github.com/bettercap/bettercap) 
	- [docker.io](https://www.kali.org/docs/containers/installing-docker-on-kali/)
	- [Firefox](https://wiki.debian.org/Firefox) (official non-ESR version)
	- [Chromium](https://www.kali.org/tools/chromium/)
	- [Sublime Text](https://www.sublimetext.com/docs/linux_repositories.html)
	- [BoostNote](https://github.com/BoostIO/BoostNote-App)
	- [jq](https://stedolan.github.io/jq/)
	- [python-is-python3](https://www.kali.org/docs/general-use/python3-transition/)
	- [gnome-screenshot](https://linux.die.net/man/1/gnome-screenshot)			
	- [golang](https://go.dev/) (plus environment)
	- [zmap](https://github.com/zmap/zmap)
	- [LibreOffice](https://www.libreoffice.org/)
	- [htop](https://htop.dev/)
	- [Remmina](https://remmina.org/)
	- [realtek-rtl88xxau-dkms](https://gitlab.com/kalilinux/packages/realtek-rtl88xxau-dkms) (ALFA wireless drivers)
    - [berzerk0's](https://github.com/berzerk0) [Probable-Wordlists](https://github.com/berzerk0/Probable-Wordlists)     	 	
	- [insidetrust's](https://github.com/insidetrust) [statistically-likely-usernames](https://github.com/insidetrust/statistically-likely-usernames)
    - [Covenant](https://github.com/cobbr/Covenant) 
    - [Donut](https://github.com/TheWover/donut)                          	  	
    - [Hatecrack](https://github.com/trustedsec/hate_crack)                                      
    - [Unicorn](https://github.com/trustedsec/unicorn)  
	- [Ghidra](https://ghidra-sre.org/) 	
- Updates system
- Removes gnome-software
- Disables auto-lock
- Enables tap-to-click
- Initializes Metasploit database
- Enables details logging of terminal sessions (all output saved to ~/Logs)											
## Optional Features
- Allows optional installation of the following ICS/SCADA tools 
    - [ControlThings.io's](https://github.com/ControlThings-io/) ICS/SCADA Tools:
		- ctmodbus
    	- ctserial
    	- ctspi
    	- cti2c
- Allows optional installation of the following crypto auditing tools:
	- [HalbornSecurity's](https://github.com/HalbornSecurity): [burp-eth](https://github.com/HalbornSecurity/burp-eth) BurpSuite extension
- Invoke a suitable theme according to your mood. Aesthetic is important! 