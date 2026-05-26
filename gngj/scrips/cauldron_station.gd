extends Control

@onready var backButton : Button = $BackButton

signal goBack
signal cookingDone(held_ingredients)

signal tutorialStep
var inTutorial : bool = false

var spawn_test = preload("res://Scenes/Spawn_Test.tscn")
var instance

var ItemCreator
var allPotions
var allIngredients
var potions

var held_ingredients : Array
var followMouse = false
var recordRot = 0
var addedCook = 0.0
var done = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$liquid/Button.mouse_entered.connect(_on_hovered.bind(true, $liquid/handle))
	$liquid/Button.mouse_exited.connect(_on_hovered.bind(false, $liquid/handle))
	$BackButton.mouse_entered.connect(_on_hovered.bind(true, $Sprite2D))
	$BackButton.mouse_exited.connect(_on_hovered.bind(false, $Sprite2D))
	$IngredientDrawer.parent_buttons_hide.connect(hide_buttons)
	$IngredientDrawer.parent_buttons_show.connect(show_buttons)
	backButton.pressed.connect(_on_backButton_pressed)
	$DropSpot.mouse_entered.connect(_on_hovered.bind(true, null))
	$DropSpot.mouse_exited.connect(_on_hovered.bind(false, null))

func __init__(_ItemCreator, _allPotions : Dictionary, _allIngredients : Dictionary, _potions : Dictionary) -> void:
	# Set global dictionaries
	ItemCreator = _ItemCreator
	allPotions = _allPotions
	allIngredients = _allIngredients
	potions = _potions
	$IngredientDrawer.__init__(_allIngredients, true)

func _on_backButton_pressed() -> void:
	goBack.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if followMouse:
		if done == false:
			$liquid.look_at(get_global_mouse_position())
			if recordRot != $liquid.rotation_degrees:
				if !$sloshing.playing:
					$sloshing.volume_db = 3
					$sloshing.play()
				if $sloshing.volume_db < 0:
					$sloshing.volume_db = 5
			if held_ingredients.size() > 0:
				if recordRot < $liquid.rotation_degrees:
					if !$brewing.playing:
						$brewing.play()
					if $brewing.volume_db < 0:
						$brewing.volume_db = lerp($brewing.volume_db, 0.0, 1.0)
					addedCook += delta
					$liquid/waves.modulate = lerp(Color(0.573, 0.675, 0.737, 1.0), Color(0.725, 0.388, 0.141, 1.0), addedCook / 3)
				recordRot = $liquid.rotation_degrees
				if $liquid/waves.modulate.b <= .141:
					done = true
					held_ingredients.sort()
					cookingDone.emit(held_ingredients)
					$potionDone.play()
					$AnimationPlayer.play_backwards("revert_color")
	$brewing.volume_db = lerp($brewing.volume_db, -80.0, .08 * delta)
	$sloshing.volume_db = lerp($sloshing.volume_db, -80.0, .15 * delta)
			
func _on_hovered(hovered: bool, ref) -> void:
	if followMouse != true:
		if hovered:
			if $IngredientDrawer.held == null:
				var strHold: String = ""
				instance = spawn_test.instantiate()
				add_child(instance)
				for i in held_ingredients.size():
					strHold = strHold + str(held_ingredients[i] + "\n")
				instance.get_child(0).text = strHold
	if $IngredientDrawer.held == null:
		if ref != null:
			ref.material.set_shader_parameter("outline_thickness", 5.0 if hovered else 0.0)
	if !hovered:
		if instance != null:
			instance.queue_free()


func _on_drop_spot_pressed() -> void:
	if !done:
		if ($IngredientDrawer.held != null):
			if allIngredients.get($IngredientDrawer.held).isGrindable:
				var randPitch = randf_range(0.7, 1.1)
				$heavysplash.pitch_scale = randPitch
				$heavysplash.play(.22)
			else:
				var randPitch = randf_range(0.9, 1.3)
				$lightsplash.pitch_scale = randPitch
				$lightsplash.play(.53)
			held_ingredients.append($IngredientDrawer.held)
			$IngredientDrawer.instance.queue_free()
			$IngredientDrawer.held = null
			$IngredientDrawer.show_buttons()
			print("ingredients in cauldron: ", held_ingredients)
			_on_hovered(true, null)
			
			if(inTutorial):
				tutorialStep.emit()
		

func hide_buttons():
	$BackButton.hide()
func show_buttons():
	$BackButton.show()
	

func _on_button_button_down() -> void:
	if $IngredientDrawer.held == null:
		followMouse = true
		$BackButton.disabled = true
		$Sprite2D.hide()


func _on_button_button_up() -> void:
	if $IngredientDrawer.held == null:
		followMouse = false
		$BackButton.disabled = false
		$Sprite2D.show()


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	done = false
	held_ingredients.clear()
	addedCook = 0
	if(inTutorial):
		tutorialStep.emit()


func _on_ingredient_drawer_tutorial_step() -> void:
	tutorialStep.emit()
