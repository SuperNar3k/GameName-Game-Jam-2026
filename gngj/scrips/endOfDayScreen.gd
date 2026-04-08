extends Control


@onready var continueButton : Button = $continueButton

signal showStore

var itemSprite
var itemName
var itemAmount

var item = preload("res://Scenes/displayItemOnList.tscn").instantiate()

func displayShit(allIngredients: Dictionary, allPotions: Dictionary):
	
	# Reverse the keys for order
	var keysInReverse = allIngredients.keys()
	keysInReverse.reverse()
	for k:String in keysInReverse:
		var ingredient = allIngredients.get(k)
		
		#ONLY FOR TESTING
		ingredient.unlocked = true
		
		if(ingredient.unlocked):
			$VBoxContainer/ingredientLable.add_sibling(item)
			item.add_to_group("itemToDelete")
			item.setSprite(ingredient.sprite)
			item.setItemName(ingredient.itemName)
			item.setItemAmount(ingredient.amountOwned)
			
			item = preload("res://Scenes/displayItemOnList.tscn").instantiate()
	
	# Reverse the keys for order
	keysInReverse = allPotions.keys()
	keysInReverse.reverse()
	for k:String in keysInReverse:
		k.reverse()
		var potion = allPotions.get(k)
		
		#ONLY FOR TESTING
		potion.unlocked = true
		
		if(potion.unlocked):
			$VBoxContainer/potionLable.add_sibling(item)
			item.add_to_group("itemToDelete")
			item.setSprite(potion.sprite)
			item.setItemName(potion.itemName)
			item.setItemAmount(potion.amountOwned)
			
			item = preload("res://Scenes/displayItemOnList.tscn").instantiate()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	continueButton.pressed.connect(_on_continueButton_pressed)

func _on_continueButton_pressed(): 
	get_tree().call_group("itemToDelete", "queue_free")
	showStore.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
