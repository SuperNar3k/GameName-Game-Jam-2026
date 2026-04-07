class_name npc
extends Node

#GLOBAL VARIABLES
var npcName = ""
var sprite = Sprite2D.new()

var allSprites = ["res://assets/npcs/lil freak.jpg"]


func setRandNPC(): 
	sprite.set_texture(load(allSprites.pick_random()))
	npcName = "lil freak"
