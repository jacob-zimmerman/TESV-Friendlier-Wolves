;===================================================================================
; FRIENDLIER WOLVES MOD
;
; VERSION 1.0
;
; AUTHOR: Jacob Lloyd Zimmerman
;
; DESCRIPTION: A mod that allows the player to edit the relationship between the
; player and wolves (members of the wolf faction). By default, if the player is a
; werewolf, wolves only have a disposition of 2 with the player, meaning that they
; are merely confidant in the player (will not attack player unless provoked). This
; mod allows the player to change this value to whatever they see fit, and even set
; separate values depending on whether or not the player is a werewolf. Furthermore,
; the user can even change the relationship of wolves with other factions, such as
; vampires. I for one find it somewhat strange that wolves are more friendly towards
; vampires than they are towards werewolves, and wrote this script to correct this.
;
; PLANS FOR FUTURE VERSIONS: In the future, I plan to allow players to approach any
; wolf in the wild and make them a follower of the player. I also plan to create an
; option that allows the player to summon a pack of wolves upon transforming into a
; werewolf or by using a custom power. 
;
;===================================================================================

scriptname FW_ConfigMenu extends SKI_ConfigBase

;========================== SCRIPT VERSION ==========================

String modName = "Friendlier Wolves"

int function GetVersion()
  return 1 ; the default version of my mod
endFunction

;========================== PRIVATE VARIABLES ==========================

; OIDs (T:Text B:Toggle S:Slider M:Menu, C:Color, K:Key)
int playerIsWerewolf_OID_T
int playerRelationship_OID_T
int vampireRelationship_OID_T
int werewolfRelationship_OID_T

int restoreDefaults_OID_T

int playerRelationship_OID_S
int vampireRelationship_OID_S
int werewolfRelationship_OID_S

; State

; ...

; Internal
Actor Property PlayerRef Auto

Faction Property PlayerWerewolfFaction Auto
Faction Property WolfFaction Auto
Faction Property WerewolfFaction Auto
Faction Property VampireFaction Auto

bool isWerewolf ; true if the player is a werewolf
int playerRelationship ; relationship rank between the wolves and the player
int vampireRelationship ; relationship rank between the wolves and the vampires
int werewolfRelationship ; relationship rank between the wolves and the werewolves



;========================== INITIALIZATION ==========================

; @implements SKI_ConfigBase
event OnConfigInit()
{Called when this config menu is initialized}
	isWerewolf = playerIsWerewolf()

	if isWerewolf
		playerRelationship = 2
	else
		playerRelationship = 0
	endIf

	vampireRelationship = 3
	werewolfRelationship = 3

endEvent

;========================== EVENTS ==========================

; @implements SKI_ConfigBase
event OnPageReset(string a_page)
	{Called when a new page is selected, including the initial empty page}
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)

	AddHeaderOption("STATUS")

	if isWerewolf
		playerIsWerewolf_OID_T = AddTextOption("PlayerIsWerewolf: ", "True")
	else
		playerIsWerewolf_OID_T = AddTextOption("PlayerIsWerewolf: ", "False")
	endIf

	if (playerRelationship == (-4))
		playerRelationship_OID_T = AddTextOption("Player Relationship: ","-4 (Archnemesis)")
	elseIf (playerRelationship == (-3))
		playerRelationship_OID_T = AddTextOption("Player Relationship: ","-3 (Enemy)")
	elseIf (playerRelationship == (-2))
		playerRelationship_OID_T = AddTextOption("Player Relationship: ","-2 (Foe)")
	elseIf (playerRelationship == (-1))
		playerRelationship_OID_T = AddTextOption("Player Relationship: ","-1 (Rival)")
	elseIf (playerRelationship == 0)
		playerRelationship_OID_T = AddTextOption("Player Relationship: ","0 (Acquaintance)")
	elseIf (playerRelationship == 1)
		playerRelationship_OID_T = AddTextOption("Player Relationship: ","1 (Friend)")
	elseIf (playerRelationship == 2)
		playerRelationship_OID_T = AddTextOption("Player Relationship: ","2 (Confidant)")
	elseIf (playerRelationship == 3)
		playerRelationship_OID_T = AddTextOption("Player Relationship: ","3 (Ally)")
	elseIf (playerRelationship == 4)
		playerRelationship_OID_T = AddTextOption("Player Relationship: ","4 (Lover?)")
	endIf

	if (vampireRelationship == (-4))
		vampireRelationship_OID_T = AddTextOption("Vampire Relationship: ","-4 (Archnemesis)")
	elseIf (vampireRelationship == (-3))
		vampireRelationship_OID_T = AddTextOption("Vampire Relationship: ","-3 (Enemy)")
	elseIf (vampireRelationship == (-2))
		vampireRelationship_OID_T = AddTextOption("Vampire Relationship: ","-2 (Foe)")
	elseIf (vampireRelationship == (-1))
		vampireRelationship_OID_T = AddTextOption("Vampire Relationship: ","-1 (Rival)")
	elseIf (vampireRelationship == 0)
		vampireRelationship_OID_T = AddTextOption("Vampire Relationship: ","0 (Acquaintance)")
	elseIf (vampireRelationship == 1)
		vampireRelationship_OID_T = AddTextOption("Vampire Relationship: ","1 (Friend)")
	elseIf (vampireRelationship == 2)
		vampireRelationship_OID_T = AddTextOption("Vampire Relationship: ","2 (Confidant)")
	elseIf (vampireRelationship == 3)
		vampireRelationship_OID_T = AddTextOption("Vampire Relationship: ","3 (Ally)")
	elseIf (vampireRelationship == 4)
		vampireRelationship_OID_T = AddTextOption("Va(mpire Relationship: ","4 (Lover?)")
	endIf

	if (werewolfRelationship == (-4))
		werewolfRelationship_OID_T = AddTextOption("Werewolf Relationship: ","-4 (Archnemesis)")
	elseIf (werewolfRelationship == (-3))
		werewolfRelationship_OID_T = AddTextOption("Werewolf Relationship: ","-3 (Enemy)")
	elseIf (werewolfRelationship == (-2))
		werewolfRelationship_OID_T = AddTextOption("Werewolf Relationship: ","-2 (Foe)")
	elseIf (werewolfRelationship == (-1))
		werewolfRelationship_OID_T = AddTextOption("Werewolf Relationship: ","-1 (Rival)")
	elseIf (werewolfRelationship == 0)
		werewolfRelationship_OID_T = AddTextOption("Werewolf Relationship: ","0 (Acquaintance)")
	elseIf (werewolfRelationship == 1)
		werewolfRelationship_OID_T = AddTextOption("Werewolf Relationship: ","1 (Friend)")
	elseIf (werewolfRelationship == 2)
		werewolfRelationship_OID_T = AddTextOption("Werewolf Relationship: ","2 (Confidant)")
	elseIf (werewolfRelationship == 3)
		werewolfRelationship_OID_T = AddTextOption("Werewolf Relationship: ","3 (Ally)")
	elseIf (werewolfRelationship == 4)
		werewolfRelationship_OID_T = AddTextOption("Werewolf Relationship: ","4 (Lover?)")
	endIf
	AddEmptyOption()

	AddHeaderOption("RELATIONSHIP ADJUSTMENT")
	if isWerewolf
		playerRelationship_OID_S = addSliderOption("Player Relationship", 2.0, "{0}")
	else
		playerRelationship_OID_S = addSliderOption("Player Relationship", 0.0, "{0}")
	endIf
	vampireRelationship_OID_S = addSliderOption("Vampire Relationship", 3.0, "{0}")
	werewolfRelationship_OID_S = addSliderOption("Werewolf Relationship", 3.0, "{0}")
	AddEmptyOption()

	SetCursorFillMode(LEFT_TO_RIGHT)
	AddEmptyOption()
	AddHeaderOption("OTHER")
	SetCursorFillMode(TOP_TO_BOTTOM)
	restoreDefaults_OID_T = addTextOption("Restore Defaults","")

endEvent

; @implements SKI_ConfigBase
event OnOptionHighlight(int a_option)
{Called when highlighting an option}
	if (a_option == playerIsWerewolf_OID_T)
		SetInfoText("Displays whether or not the player is a werewolf. True if the player is a werewolf; false otherwise.")

	elseIf (a_option == playerRelationship_OID_T)
		SetInfoText("The player's current relationship with members of the wolf faction. Ranges from -4 to 4, with -4 being very hostile and 4 being very friendly.\nDefault: 2 (if werewolf); 0 (otherwise)")

	elseIf (a_option == vampireRelationship_OID_T)
		SetInfoText("NPC vampires' current relationship with members of the wolf faction. Ranges from -4 to 4, with -4 being very hostile and 4 being very friendly.\nDefault: 3")

	elseIf (a_option == werewolfRelationship_OID_T)
		SetInfoText("NPC werewolves' current relationship with members of the wolf faction. Ranges from -4 to 4, with -4 being very hostile and 4 being very friendly.\nDefault: 3")

	elseIf (a_option == playerRelationship_OID_S)
		SetInfoText("Allows you to adjust the player's current relationship with members of the wolf faction. Ranges from -4 to 4, with -4 being very hostile and 4 being very friendly.\nDefault: 2 (if werewolf); 0 (otherwise)")

	elseIf (a_option == vampireRelationship_OID_S)
		SetInfoText("Allows you to adjust NPC vampires' current relationship with members of the wolf faction. Ranges from -4 to 4, with -4 being very hostile and 4 being very friendly.\nDefault: 3")

	elseIf (a_option == werewolfRelationship_OID_S)
		SetInfoText("Allows you to adjust NPC werewolves' current relationship with members of the wolf faction. Ranges from -4 to 4, with -4 being very hostile and 4 being very friendly.\nDefault: 3")
	endIf

endEvent

; @implements SKI_ConfigBase
event OnOptionSelect(int a_option)
{Called when a non-interactive option has been selected}
	if (a_option == restoreDefaults_OID_T)
		OnOptionDefault(playerRelationship_OID_T)
		OnOptionDefault(vampireRelationship_OID_T)
		OnOptionDefault(werewolfRelationship_OID_T)
	endIf

endEvent

; @implements SKI_ConfigBase
event OnOptionDefault(int a_option)
{Called when resetting an option to its default value}
	isWerewolf = playerIsWerewolf()
	if (a_option == playerIsWerewolf_OID_T)
		if isWerewolf
			setTextOptionValue(playerIsWerewolf_OID_T, "True")
		else
			setTextOptionValue(playerIsWerewolf_OID_T, "False")
		endIf

	elseIf (a_option == playerRelationship_OID_T || a_option == playerRelationship_OID_S)
		if (isWerewolf)
			playerRelationship = 2
			setPlayerRelationship(playerRelationship)
			setTextOptionValue(playerRelationship_OID_T, "2 (Confidant)")
			setSliderOptionValue(playerRelationship_OID_S, 2.0, "{0}")
		else
			playerRelationship = 0
			setPlayerRelationship(playerRelationship)
			setTextOptionValue(playerRelationship_OID_T, "0 (Acquaintance)")
			setSliderOptionValue(playerRelationship_OID_S, 0.0, "{0}")
		endIf

	elseIf (a_option == vampireRelationship_OID_T || a_option == vampireRelationship_OID_S)
		vampireRelationship = 3
		setVampireRelationship(vampireRelationship)
		setTextOptionValue(vampireRelationship_OID_T, "3 (Ally)")
		setSliderOptionValue(vampireRelationship_OID_S, 3.0, "{0}")
	
	elseIf (a_option == werewolfRelationship_OID_T || a_option == werewolfRelationship_OID_S)
		werewolfRelationship = 3
		setWerewolfRelationship(werewolfRelationship)
		setTextOptionValue(werewolfRelationship_OID_T, "3 (Ally)")
		setSliderOptionValue(werewolfRelationship_OID_S, 3.0, "{0}")

	elseIf (a_option == restoreDefaults_OID_T)
		setTextOptionValue(restoreDefaults_OID_T, "")
	endIf

; ...
endEvent

; @implements SKI_ConfigBase
event OnOptionSliderOpen(int a_option)
{Called when a slider option has been selected}
	isWerewolf = playerIsWerewolf()

	if (a_option == playerRelationship_OID_S)
		if (isWerewolf)
			setSliderDialogStartValue(2.0)
		else
			setSliderDialogStartValue(0.0)
			setSliderDialogRange(-4.0, 4.0)
			setSliderDialogInterval(1.0)
	endIf

	elseIf (a_option == vampireRelationship_OID_S)
		setSliderDialogStartValue(3.0)
		setSliderDialogRange(-4.0, 4.0)
		setSliderDialogInterval(1.0)
		
	elseIf (a_option == werewolfRelationship_OID_S)
		setSliderDialogStartValue(3.0)
		setSliderDialogRange(-4.0, 4.0)
		setSliderDialogInterval(1.0)
	endIf

endEvent

; @implements SKI_ConfigBase
event OnOptionSliderAccept(int a_option, float a_value)
{Called when a new slider value has been accepted}
	if (a_option == playerRelationship_OID_S)
		playerRelationship = a_value as int

		setPlayerRelationship(playerRelationship)

		if (playerRelationship == (-4))
			setTextOptionValue(playerRelationship_OID_T, "-4 (Archnemesis)")
		elseIf (playerRelationship == (-3))
			setTextOptionValue(playerRelationship_OID_T, "-3 (Enemy)")
		elseIf (playerRelationship == (-2))
			setTextOptionValue(playerRelationship_OID_T, "-2 (Foe)")
		elseIf (playerRelationship == (-1))
			setTextOptionValue(playerRelationship_OID_T, "-1 (Rival)")
		elseIf (playerRelationship == 0)
			setTextOptionValue(playerRelationship_OID_T, "0 (Acquaintance)")
		elseIf (playerRelationship == 1)
			setTextOptionValue(playerRelationship_OID_T, "1 (Friend)")
		elseIf (playerRelationship == 2)
			setTextOptionValue(playerRelationship_OID_T, "2 (Confidant)")
		elseIf (playerRelationship == 3)
			setTextOptionValue(playerRelationship_OID_T, "3 (Ally)")
		elseIf (playerRelationship == 4)
			setTextOptionValue(playerRelationship_OID_T, "4 (Lover?)")
		endIf

		setSliderOptionValue(playerRelationship_OID_S, playerRelationship as float, "{0}")

	elseIf (a_option == vampireRelationship_OID_S)
		vampireRelationship = a_value as int

		setVampireRelationship(vampireRelationship)

		if (vampireRelationship == (-4))
			setTextOptionValue(vampireRelationship_OID_T, "-4 (Archnemesis)")
		elseIf (vampireRelationship == (-3))
			setTextOptionValue(vampireRelationship_OID_T, "-3 (Enemy)")
		elseIf (vampireRelationship == (-2))
			setTextOptionValue(vampireRelationship_OID_T, "-2 (Foe)")
		elseIf (vampireRelationship == (-1))
			setTextOptionValue(vampireRelationship_OID_T, "-1 (Rival)")
		elseIf (vampireRelationship == 0)
			setTextOptionValue(vampireRelationship_OID_T, "0 (Acquaintance)")
		elseIf (vampireRelationship == 1)
			setTextOptionValue(vampireRelationship_OID_T, "1 (Friend)")
		elseIf (vampireRelationship == 2)
			setTextOptionValue(vampireRelationship_OID_T, "2 (Confidant)")
		elseIf (vampireRelationship == 3)
			setTextOptionValue(vampireRelationship_OID_T, "3 (Ally)")
		elseIf (vampireRelationship == 4)
			setTextOptionValue(vampireRelationship_OID_T, "4 (Lover?)")
		endIf

		setSliderOptionValue(vampireRelationship_OID_S, vampireRelationship as float, "{0}")


	elseIf (a_option == werewolfRelationship_OID_S)
		werewolfRelationship = a_value as int

		setWerewolfRelationship(werewolfRelationship)

		if (werewolfRelationship == (-4))
			setTextOptionValue(werewolfRelationship_OID_T, "-4 (Archnemesis)")
		elseIf (werewolfRelationship == (-3))
			setTextOptionValue(werewolfRelationship_OID_T, "-3 (Enemy)")
		elseIf (werewolfRelationship == (-2))
			setTextOptionValue(werewolfRelationship_OID_T, "-2 (Foe)")
		elseIf (werewolfRelationship == (-1))
			setTextOptionValue(werewolfRelationship_OID_T, "-1 (Rival)")
		elseIf (werewolfRelationship == 0)
			setTextOptionValue(werewolfRelationship_OID_T, "0 (Acquaintance)")
		elseIf (werewolfRelationship == 1)
			setTextOptionValue(werewolfRelationship_OID_T, "1 (Friend)")
		elseIf (werewolfRelationship == 2)
			setTextOptionValue(werewolfRelationship_OID_T, "2 (Confidant)")
		elseIf (werewolfRelationship == 3)
			setTextOptionValue(werewolfRelationship_OID_T, "3 (Ally)")
		elseIf (werewolfRelationship == 4)
			setTextOptionValue(werewolfRelationship_OID_T, "4 (Lover?)")
		endIf

		setSliderOptionValue(werewolfRelationship_OID_S, werewolfRelationship as float, "{0}")
	endIf

endEvent

; @implements SKI_ConfigBase
event OnOptionMenuOpen(int a_option)
{Called when a menu option has been selected}

; ...
endEvent

; @implements SKI_ConfigBase
event OnOptionMenuAccept(int a_option, int a_index)
{Called when a menu entry has been accepted}

; ...
endEvent

; @implements SKI_ConfigBase
event OnOptionColorOpen(int a_option)
{Called when a color option has been selected}

; ...
endEvent

; @implements SKI_ConfigBase
event OnOptionColorAccept(int a_option, int a_color)
{Called when a new color has been accepted}

; ...
endEvent

; @implements SKI_ConfigBase
event OnOptionKeyMapChange(int a_option, int a_keyCode, string a_conflictControl, string a_conflictName)
{Called when a key has been remapped}

; ...
endEvent

;========================== NON-MCM EVENTS ==========================

; returns true if the player is a werewolf -- false otherwise
bool Function playerIsWerewolf()

	if PlayerRef.IsInFaction(PlayerWerewolfFaction)
		Debug.Trace("Player is a werewolf.")
		return true
	else
		Debug.Trace("Player is not a werewolf.")
		return false
	endIf

endFunction

; updates relationships between wolves and other factions/actors
Event update()
	PlayerRef.SetFactionRank(WolfFaction, playerRelationship)
	WolfFaction.SetReaction(PlayerWerewolfFaction, playerRelationship)
	WolfFaction.SetReaction(WerewolfFaction, werewolfRelationship)
	WolfFaction.SetReaction(VampireFaction, vampireRelationship)
endEvent

; restores defaults
Event restoreDefaults()
	if isWerewolf
		playerRelationship = 2
	else
		playerRelationship = 0
	endIf

	vampireRelationship = 3
	werewolfRelationship = 3
	update()
endEvent

; Changes value representing relationship between wolves and the player. It does not
; actually change the relatonship until update() is called
Event setPlayerRelationship(int x)
	playerRelationship = x
	PlayerRef.SetFactionRank(WolfFaction, playerRelationship)
	WolfFaction.SetReaction(PlayerWerewolfFaction, playerRelationship)
endEvent

; Changes value representing relationship between wolves and the werewolves. It does 
; not actually change the relatonship until update() is called
Event setWerewolfRelationship(int x)
	werewolfRelationship = x
	WolfFaction.SetReaction(WerewolfFaction, werewolfRelationship)
endEvent

; Changes value representing relationship between wolves and the vampires. It does 
; not actually change the relatonship until update() is called
Event setVampireRelationship(int x)
	vampireRelationship = x
	WolfFaction.SetReaction(VampireFaction, vampireRelationship)
endEvent




