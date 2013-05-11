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
; werewolf.
;
;===================================================================================


scriptname FW_Master extends Quest

Actor Property PlayerRef Auto

Faction Property PlayerWerewolfFaction
Faction Property WolfFaction Auto
Faction Property WerewolfFaction Auto
Faction Property VampireFaction Auto

bool isWerewolf ; true if the player is a werewolf
int playerRelationship ; relationship rank between the wolves and the player
int vampireRelationship ; relationship rank between the wolves and the vampires
int werewolfRelationship ; relationship rank between the wolves and the werewolves
 
Event OnInit()

	Debug.Trace("Player is " + PlayerRef)
	isWerewolf = playerIsWerewolf()

	if isWerewolf
		playerRelationship = 2
	else
		playerRelationship = 0
	endIf

	vampireRelationship = 3
	werewolfRelationship = 3

endEvent

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
endEvent

; Changes value representing relationship between wolves and the werewolves. It does 
; not actually change the relatonship until update() is called
Event setWerewolfRelationship(int x)
	werewolfRelationship = x
endEvent

; Changes value representing relationship between wolves and the vampires. It does 
; not actually change the relatonship until update() is called
Event setVampireRelationship(int x)
	update()
endEvent

