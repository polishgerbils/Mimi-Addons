# MimiAddons
Ashita v4.16 addon package

# Installation Instructions

1.) Copy Game folder to root directory and click "replace files."
	
	HorizonXI/Game

2.) Open config/addons folder

3.) Change folder names to your character name (check other addons you have for the proper folder name syntax)
	
Ex: My folder names would be Mimiru_36283
	
	
# Addon Configuration insturctions

* **LuAshitacast**
	
		HorizonXI/Game/docs/luashitacast folder for tutorials and commands
	
	
* **Ttimers**

	Add a new timer
	
		/tt custom "name" time r

    		examples & presets:
  		26s Repeatable timer for adds popping every 26s
  			/tt custom "adds" 26s r
  		10m Repeatable timer starting at 10:00:00am (24hr format)
  			/tt custom "Faf" 10m r 10:00:00t
  		30 minute timer for battlefield such as Omega
  			/om
  		5 minute repeatable timer used for omega pods
  			/rpod
  
  	Add new alias timers in default.txt
	
  		/alias add /hnm /tt custom "HNM Window" 10m r 1
  			in game type /hnm 10:00:00t for 10m repeatable hnm timer starting at entered time
  				
			
* **tHotBar**

	/tb for config

	Ctrl + Left Click on any hotbar window to bring up customization
	Under "Appearance" can set folder path for custom icons, click update after path added
	Ex:
		spells2/whm/cure.png
		
	Navigate to the following directory to add new icons:
	
		Game/addons/tHotBar/resources
		
	abilities2 and spells2 are current custom icon folders, create new job subfolders and name icons whatever you'd like
	
	Icon Package included from FFXIV icons, some have already been added
	
	
* **HXui**

	/hxui for config
	
	
* **XITools**

	/xit for config
	

* **Points**

	/points config for config
	
	
* **xicamera**

	Change camera distance outside of combat to # value
	/cam d #
	
	Change camera distance in combat to # value
	/cam b #

* **Metrics**

	/met for help and commands 
  	
	
	
