# Kali Whetstone Script

Hone your Kali instance to a knife edge sheen. Prepares vanillla Kali for a pentest by enabling session logging, installing additional tools, making common configuration changes, and initializing common services.

## NOTE: Must be run as root

## Default Features:

1. Updates system
1. Removes gnome-software
1. Disables auto-lock
1. Enables tap-to-click
1. Initializes Metasploit database
1. Enables details logging of terminal sessions
	1. Including ALL OUTPUT (saved to ~/Logs)

1. Installs the following tools:
	1. CrackMapExec()
	1. Impacket()
	1. Bloodhound()
	1. EAPhammer()
	1. patator()
	1. PCredz
	1. Gowitness
	1. EavesARP() 
	1. bettercap() 
	1. docker
	1. Firefox (official non-ESR version)
	1. Chromium
	1. Sublime Text
	1. BoostNote
	1. jq 	
	1. python-is-python3												
	1. golang (plus environment)
	1. zmap()
	1. LibreOffice
	1. htop
	1. Remmina
	1. gnome-screenshot
	1. realtek-rtl88xxau-dkms (ALFA wireless drivers)
    1. berzerk0's Probable-Wordlists ()     	 	
	1. insidetrust's statistically-likely-usernames()
    1. Covenant () 
    1. Donut()                          	  	
    1. Hatecrack()                                      	
    1. Unicorn()                                          	
	1. Ghidra() 												!

## Optional Features
1. Allows optional installation of the following ICS/SCADA tools 
    1. [ControlThings.io](https://github.com/ControlThings-io/) ICS/SCADA Tools:
		1. ctmodbus
    	1. ctserial
    	1. ctspi
    	1. cti2c

1. Allows optional installation of the following crypto auditing tools:
	1. [HalbornSecurity's](https://github.com/HalbornSecurity): [burp-eth](https://github.com/HalbornSecurity/burp-eth) BurpSuite extension

1. Enables optional installation of licensed software such as:
	1. BurpSuite Pro
	1. Cobalt Strike

1. Invoke a suitable theme according to your mood. Aesthetic is important! 