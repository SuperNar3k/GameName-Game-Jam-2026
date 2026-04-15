extends HBoxContainer

func setSprite(sprite : Variant):
	$AspectRatioContainer/itemSprite.set_texture(load(sprite)) 
	
func setPotionName(_name: Variant):
	$VBoxContainer/HBoxContainer2/potionNameLable.text = _name
	
func setNpcName(_name: Variant):
	$VBoxContainer/HBoxContainer/npcName.text = _name
	
func setDaysUntilDue(days: Variant):
	$VBoxContainer/HBoxContainer/daysUntilDue.text = str(days)
