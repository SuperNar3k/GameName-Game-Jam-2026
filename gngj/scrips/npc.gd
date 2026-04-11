class_name npc
extends Node

#GLOBAL VARIABLES
var npcName = "DEFAULT NPC"
var sprite = ""
var type = "CHILD" # CHILD, TOWNSFOLK, ADVENTURER

#Set params
func setParams(_name: String, _spriteName: String, _type: String): 
	if FileAccess.file_exists("res://assets/npcs/" + _spriteName):
		sprite = "res://assets/npcs/" + _spriteName # Load sprite if the file exists
	else:
		sprite = "res://assets/npcs/lil freak.jpg"
		
	npcName = _name
	type = _type
