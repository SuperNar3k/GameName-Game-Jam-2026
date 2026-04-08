class_name npc_birthing_pod
extends Node

#GLOBAL VARIABLES
#This array will hold all of our NPCs
var allNPCs = {}
var allChildren = ["Pepper", "Violet", "Jay Cutter", "Jeremiah", "Godwyn Blackbarrel", "Bard"]
var allTownsolk = ["Aldric Hayworth", "Brenna Tallowmere", "Oswin Cutter", "Maribel Fenwick", "Torren Blackbarrel", "Elswyth Porridgepot", "Joric Underbough", "Lysa Thornwhistle", "Garrin Millstone", "Fara Goodbrook"]
var allAdventurers = ["Lil Freak", "Obamna", "Sir Henry the Brave", "Gonzalles the Erratic", "Timothy the Tatted"]

# __init__
func Populate():
	for n in allChildren:
		var baby = npc.new()
		baby.setParams(n, n.to_lower()+".jpg", "Child")
		allNPCs.set(n, baby)
	for n in allTownsolk:
		var baby = npc.new()
		baby.setParams(n, n.to_lower()+".jpg", "Townsfolk")
		allNPCs.set(n, baby)
	for n in allAdventurers:
		var baby = npc.new()
		baby.setParams(n, n.to_lower()+".jpg", "Adventurer")
		allNPCs.set(n, baby)
	# print("Total number of NPCs: " + str(allNPCs.size()))
	# print(allNPCs)

func GetRandomChild():
	var name = allChildren.pick_random()
	return allNPCs.get(name)
		
func GetRandomTownsfolk():
	var name = allTownsolk.pick_random()
	return allNPCs.get(name)
		
func GetRandomAdventurer():
	var name = allAdventurers.pick_random()
	return allNPCs.get(name)
		
#The mircle of life
func BirthNPC(_name: String):
	if allNPCs.has(_name):
		return allNPCs.get(_name)
	else:
		print("ERROR: That NPC does not exist!")
