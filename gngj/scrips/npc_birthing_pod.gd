class_name Npc_Birthing_Pod
extends Node

#GLOBAL VARIABLES
#This array will hold all of our NPCs
var allNPCs = {}
var allChildren = []
var allTownsolk = [
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
"Awkward Youth"]
var allAdventurers = []

# __init__
func Populate():
	for n in allChildren:
		var baby = npc.new()
		baby.setParams(n, n.to_lower()+".PNG", "Child")
		allNPCs.set(n, baby)
	for n in allTownsolk:
		var baby = npc.new()
		baby.setParams(n, n.to_lower()+".PNG", "Townsfolk")
		allNPCs.set(n, baby)
	for n in allAdventurers:
		var baby = npc.new()
		baby.setParams(n, n.to_lower()+".PNG", "Adventurer")
		allNPCs.set(n, baby)

func GetRandomChild():
	return allNPCs.get(allChildren.pick_random())
		
func GetRandomTownsfolk():
	return allNPCs.get(allTownsolk.pick_random())
		
func GetRandomAdventurer():
	return allNPCs.get(allAdventurers.pick_random())
		
#The mircle of life
func BirthNPC(_name: String):
	if allNPCs.has(_name):
		return allNPCs.get(_name)
	else:
		print("ERROR: NPC " + _name + " does not exist!")
