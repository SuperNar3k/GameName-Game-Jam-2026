extends HBoxContainer

func setSprite(sprite : Variant):
	$AspectRatioContainer/itemSprite.set_texture(load(sprite)) 
	
func setItemName(_name: Variant):
	$itemName.text = _name
	
func setItemAmount(amount: Variant):
	$itemAmount.text = str(amount)
