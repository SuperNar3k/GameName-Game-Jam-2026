class_name npc
extends Node

#GLOBAL VARIABLES
var npcName = "DEFAULT NPC"
var sprite = ""

#Set params
func setParams(_name: String, _spriteName: String): 
	sprite = "res://assets/npcs/" + _spriteName
	npcName = _name
