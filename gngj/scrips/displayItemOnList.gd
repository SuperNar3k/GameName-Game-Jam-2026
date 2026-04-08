extends HBoxContainer


func setSprite(sprite : Variant):
	$AspectRatioContainer/itemSprite.set_texture(load(sprite)) 
	
func setItemName(name: Variant):
	$itemName.text = name
	
func setItemAmount(amount: Variant):
	$itemAmount.text = str(amount)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
