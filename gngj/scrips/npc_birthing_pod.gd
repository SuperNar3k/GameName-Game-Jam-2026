class_name Npc_Birthing_Pod
extends Node

#GLOBAL VARIABLES
#This array will hold all of our NPCs
var allNPCs = {}

# Names of NPCs
var allTownsfolk = [
	"House of Rouge Knight",
	"Intrepid Adventurer",
	"Mysterious Cloaked Noblewoman",
	"Wobbly Cloaked Figure",
	"Disheveled Academic",
	"Confident Druid",
	"Dirt Covered Field Hand",
	"Novice Witch",
	"Powerful Witch",
	"Wisened Dwarf",
	"Friendly Bar Maid",
	"Unfriendly Squire",
	"Distracted Academic",
	"Ambitious Lady In Waiting",
	"Fearless Privateer",
	"Vacant Mercenary",
	"Awkward Youth",
	"Frog Fanatic",
	"Carefree Blacksmith",
	"Charming Noble"
]

# __init__
func Populate():
	for n in allTownsfolk:
		var baby = npc.new()
		baby.setParams(n, n.to_lower()+".PNG")
		allNPCs.set(n, baby)

func GetRandomTownsfolk():
	return allNPCs.get(allTownsfolk.pick_random())
		
#The mircle of life
func BirthNPC(_name: String):
	if allNPCs.has(_name):
		return allNPCs.get(_name)
	else:
		print("ERROR: NPC " + _name + " does not exist!")
