class_name npc
extends Node

#GLOBAL VARIABLES
var npcName = ""
var sprite = Sprite2D.new()

#This array will hold all of our npc sprites. We can add an additions array or something if we wanna have one for
#townspeople or adventurer's specifically. 
var allSprites = ["res://assets/npcs/lil freak.jpg"]

#Here's where the magic happens
func setRandNPC(): 
	sprite.set_texture(load(allSprites.pick_random()))
	npcName = "lil freak"
