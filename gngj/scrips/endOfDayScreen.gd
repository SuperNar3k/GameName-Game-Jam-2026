extends Control

var itemSprite
var itemName
var itemAmount

var item = preload("res://Scenes/displayItemOnList.tscn").instantiate()

func displayShit(ingredients: Variant, potions: Variant):
	for ingredient in ingredients: 
		
		#ONLY FOR TESTING
		ingredient.unlocked = true
		
		if(ingredient.unlocked):
			$VBoxContainer/ingredientLable.add_sibling(item)
			item.setSprite(ingredient.sprite)
			item.setItemName(ingredient.itemName)
			item.setItemAmount(ingredient.amountOwned)
			
			item = preload("res://Scenes/displayItemOnList.tscn").instantiate()
			
	for potion in potions:
		
		#ONLY FOR TESTING
		potion.unlocked = true
		
		if(potion.unlocked):
			$VBoxContainer/potionLable.add_sibling(item)
			item.setSprite(potion.sprite)
			item.setItemName(potion.itemName)
			item.setItemAmount(potion.amountOwned)
			
			item = preload("res://Scenes/displayItemOnList.tscn").instantiate()
			
			
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
