extends HBoxContainer

func setSprite(sprite : Variant):
	$AspectRatioContainer/itemSprite.set_texture(load(sprite)) 
	
func setPotionName(_name: Variant):
	$VBoxContainer/potionNameLable.text = _name
	
func setNpcName(_name: Variant):
	$VBoxContainer/HBoxContainer/npcName.text = _name
	
func setDaysUntilDue(days: Variant):
	$VBoxContainer/HBoxContainer/daysUntilDue.text = str(days)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
