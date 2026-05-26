extends Control
@onready var backRoomButton : Button = $goToBackroom
@onready var npcButton : TextureButton = $NPC
@onready var acceptButton : Button = $acceptQuestButton
@onready var rejectButton : Button = $rejectQuestButton

signal toBackRoom
signal talkToNpc
signal questAccepted(option)
signal updateQueue

var potionForQuest

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$goToBackroom.mouse_entered.connect(_on_hovered.bind($backimg, true))
	$goToBackroom.mouse_exited.connect(_on_hovered.bind($backimg, false))
	$AnimationPlayer.play("fade_to_normal")
	backRoomButton.pressed.connect(_on_backRoomButton_pressed)
	npcButton.pressed.connect(_on_npcButton_pressed)
	acceptButton.pressed.connect(_on_questAccepted_pressed)
	rejectButton.pressed.connect(_on_questRejected_pressed)
	
	# Set font of Buttons
	var arrayFrontButtons = [backRoomButton, npcButton, acceptButton, rejectButton]
	for i in arrayFrontButtons:
		i.add_theme_font_override("font", load("res://assets/fonts/ArefRuqaaInk-Regular.ttf"))

func _on_hovered(ref, hovered:bool):
	ref.material.set_shader_parameter("outline_thickness", 3.0 if hovered else 0.0)

func displayPotionsInInventory(potions: Variant, keyPotion: Variant):
	var potionButton = preload("res://Scenes/PotionButton.tscn").instantiate()
	var potionShader = ShaderMaterial.new()
	potionShader.shader = load("res://assets/shaders/highlight.gdshader")
	
	potionForQuest = keyPotion
	
	for potion in potions: 
		if(potion.amountOwned > 0 and potion.unlocked and !("Dud" in potion.itemName)):
			$potionHotbar/HBoxContainer.add_child(potionButton)
			potionButton.set_texture_normal(load(potion.sprite))
			potionButton.set_material(potionShader)
			potionButton.pressed.connect(isCorrectPotion.bind(potion))
			potionButton.add_to_group("stuffToDelete")
		
			potionButton = preload("res://Scenes/PotionButton.tscn").instantiate()
			potionShader = ShaderMaterial.new()
			potionShader.shader = load("res://assets/shaders/highlight.gdshader")
			

func isCorrectPotion(selectedPotion: Variant):
	
	if(selectedPotion == potionForQuest):
		$givePotionButton.show()
	else: 
		$givePotionButton.hide()

func clearInventory():
	get_tree().call_group("stuffToDelete","queue_free")
	
func _on_backRoomButton_pressed() -> void:
	toBackRoom.emit()
	
func _on_npcButton_pressed():
	$AnimationPlayerTalk.play("npc_talking")
	talkToNpc.emit()	
	
func _on_questAccepted_pressed():
	questAccepted.emit(true)

func _on_questRejected_pressed():
	questAccepted.emit(false)


func _on_catbtn_pressed() -> void:
	$cat.play()


func _on_bellbtn_pressed() -> void:
	var randPitch = randf_range(0.8, 1.2)
	$bell.pitch_scale = randPitch
	$bell.play(.14)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "npc_fade":
		if $AnimationPlayer.current_animation_position == 0.0:
			updateQueue.emit()
