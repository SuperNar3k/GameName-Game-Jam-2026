class_name npc
extends Node

#GLOBAL VARIABLES
var npcName = "DEFAULT NPC"
var sprite = ""
var type = "CHILD" # CHILD, TOWNSFOLK, ADVENTURER

#Set params
func setParams(_name: String, _spriteName: String, _type: String): 
	sprite = "res://assets/npcs/" + _spriteName
		
	npcName = _name
	type = _type
