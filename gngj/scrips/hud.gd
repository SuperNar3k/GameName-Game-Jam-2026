extends Control

signal recipe_pressed
signal quest_pressed
signal options_pressed


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Recipes.mouse_entered.connect(_on_hovered.bind($Recipes, true))
	$Recipes.mouse_exited.connect(_on_hovered.bind($Recipes, false))
	$Quests.mouse_entered.connect(_on_hovered.bind($Quests, true))
	$Quests.mouse_exited.connect(_on_hovered.bind($Quests, false))
	$Options.mouse_entered.connect(_on_hovered.bind($Options, true))
	$Options.mouse_exited.connect(_on_hovered.bind($Options, false)) 
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_hovered(guy, hovered):
	guy.get_child(0).material.set_shader_parameter("outline_thickness", 3.0 if hovered else 0.0)

func _on_recipes_pressed() -> void:
	recipe_pressed.emit()


func _on_quests_pressed() -> void:
	quest_pressed.emit()


func _on_options_pressed() -> void:
	options_pressed.emit()
	
func updateCurrency(currency: Variant):
	$gameInfo/currencyLable.text = str(currency) 
	
func updateTimer(timer: Timer):
	var hours_left = floor((timer.time_left / 240) * 8)
	$gameInfo/endDay.text = str(int(hours_left) + 1) + " hours"

func hide_leftstuff():
	$gameInfo.hide()
	

func show_leftstuff():
	$gameInfo.show()
