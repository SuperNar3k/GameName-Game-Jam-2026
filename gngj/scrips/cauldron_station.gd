extends Control

@onready var backButton : Button = $BackButton

signal goBack
signal cookingDone(held_ingredients)

signal tutorialIngredientsInCauldron
signal tutorialComplete
signal tutorialStep
signal tutorialMessedUp
var inTutorial : bool = false
var cauldronPointer
var dirtPointer
var tearsPointer
var thornyPointer
var pointersLeft 
var showIng :bool = true


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

var drop : bool = false

var ingredientsDisplayed = ["","",""]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$liquid/Button.mouse_entered.connect(_on_hovered.bind(true, $liquid/handle))
	$liquid/Button.mouse_exited.connect(_on_hovered.bind(false, $liquid/handle))
	$BackButton.mouse_entered.connect(_on_hovered.bind(true, $Sprite2D))
	$BackButton.mouse_exited.connect(_on_hovered.bind(false, $Sprite2D))
	$IngredientDrawer.parent_buttons_hide.connect(hide_buttons)
	$IngredientDrawer.parent_buttons_show.connect(show_buttons)
	backButton.pressed.connect(_on_backButton_pressed)
	#$DropSpot.mouse_entered.connect(_on_hovered.bind(true, null))
	#$DropSpot.mouse_exited.connect(_on_hovered.bind(false, null))
	$ingredientsInCauldron/ingredient1.mouse_entered.connect(_on_hovered.bind(true,$ingredientsInCauldron/ingredient1))
	$ingredientsInCauldron/ingredient1.mouse_exited.connect(_on_hovered.bind(false,$ingredientsInCauldron/ingredient1))
	$ingredientsInCauldron/ingredient2.mouse_entered.connect(_on_hovered.bind(true,$ingredientsInCauldron/ingredient2))
	$ingredientsInCauldron/ingredient2.mouse_exited.connect(_on_hovered.bind(false,$ingredientsInCauldron/ingredient2))
	$ingredientsInCauldron/ingredient3.mouse_entered.connect(_on_hovered.bind(true,$ingredientsInCauldron/ingredient3))
	$ingredientsInCauldron/ingredient3.mouse_exited.connect(_on_hovered.bind(false,$ingredientsInCauldron/ingredient3))
	$DropSpot.hide()

func __init__(_ItemCreator, _allPotions : Dictionary, _allIngredients : Dictionary, _potions : Dictionary) -> void:
	# Set global dictionaries
	ItemCreator = _ItemCreator
	allPotions = _allPotions
	allIngredients = _allIngredients
	potions = _potions
	$IngredientDrawer.__init__(_allIngredients, true)

func _on_backButton_pressed() -> void:
	# Exit scene with transition
	$"../SceneTransition".fadeIn()
	await get_tree().create_timer(0.2).timeout
	goBack.emit()
	$"../SceneTransition".fadeOut()

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
					
					$ingredientsInCauldron/ingredient1/image.set_texture(null)
					$ingredientsInCauldron/ingredient2/image.set_texture(null)
					$ingredientsInCauldron/ingredient3/image.set_texture(null)
					
					var i = 0
					while i < ingredientsDisplayed.size():
						ingredientsDisplayed[i] = ""
						i = i+1
					
					if(inTutorial):
						tutorialComplete.emit()
					
	$brewing.volume_db = lerp($brewing.volume_db, -80.0, .08 * delta)
	$sloshing.volume_db = lerp($sloshing.volume_db, -80.0, .15 * delta)
			
func _on_hovered(hovered: bool, ref) -> void:
	#Cauldron is not being stirred
	if followMouse != true:
		if hovered:
			if $IngredientDrawer.held == null:
				
				#if we're hovering the spoon or back button
				if ref == $liquid/handle or ref == $Sprite2D:
					ref.material.set_shader_parameter("outline_thickness", 5.0)
				
				#if we're hoving the ingredients
				else:
					instance = spawn_test.instantiate()
					add_child(instance)
					
					if ref == $ingredientsInCauldron/ingredient1 and ingredientsDisplayed[0] != "": 
						$ingredientsInCauldron/ingredient1/image.material.set_shader_parameter("outline_thickness", 5.0)
						instance.get_child(0).text = ingredientsDisplayed[0]
					elif ref == $ingredientsInCauldron/ingredient2 and ingredientsDisplayed[1] != "": 
						instance.get_child(0).text = ingredientsDisplayed[1]
						$ingredientsInCauldron/ingredient2/image.material.set_shader_parameter("outline_thickness", 5.0)
					elif ref == $ingredientsInCauldron/ingredient3 and ingredientsDisplayed[2] != "": 
						instance.get_child(0).text = ingredientsDisplayed[2]
						$ingredientsInCauldron/ingredient3/image.material.set_shader_parameter("outline_thickness", 5.0)
							
	if !hovered:
		if ref == $liquid/handle or ref == $Sprite2D:
			ref.material.set_shader_parameter("outline_thickness", 0.0)
		else:
			if ref == $ingredientsInCauldron/ingredient1: 
				$ingredientsInCauldron/ingredient1/image.material.set_shader_parameter("outline_thickness", 0.0)
			elif ref == $ingredientsInCauldron/ingredient2: 
				$ingredientsInCauldron/ingredient2/image.material.set_shader_parameter("outline_thickness", 0.0)
			else:
				$ingredientsInCauldron/ingredient3/image.material.set_shader_parameter("outline_thickness", 0.0)
				
		if instance != null:
			instance.queue_free()

#Triggered by dropping ingredients into cauldron
func _on_drop_spot_pressed() -> void:
	pass

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


func _on_drop_point_mouse_entered() -> void:
	drop = true


func _on_drop_point_mouse_exited() -> void:
	drop = false

func _input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed:
			if drop == true:
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
							
						if(inTutorial):
							tutorialDeletePointer($IngredientDrawer.held)
							tutorialSwapVision()
							
							if(pointersLeft.size() == 1):
								tutorialDeletePointer("cauldron")
							
						held_ingredients.append($IngredientDrawer.held)
						$IngredientDrawer.instance.queue_free()
						$IngredientDrawer.held = null
						$IngredientDrawer.show_buttons()
						print("ingredients in cauldron: ", held_ingredients)
						_on_hovered(true, null)
						
			
						var i = 0
						for ing in held_ingredients:
							var ingredient = allIngredients.get(ing)
							match i: 
								0:
									$ingredientsInCauldron/ingredient1/image.set_texture(load(ingredient.sprite))
									ingredientsDisplayed[0] = ing
								1: 
									$ingredientsInCauldron/ingredient2/image.set_texture(load(ingredient.sprite))
									ingredientsDisplayed[1] = ing
								2:
									$ingredientsInCauldron/ingredient3/image.set_texture(load(ingredient.sprite))
									ingredientsDisplayed[2] = ing
									
							i += 1
						

func tutorialRoutine():
	var pointerNode = preload("res://Scenes/pointerImage.tscn")
	
	await tutorialStep
	
	cauldronPointer = pointerNode.instantiate()
	add_child(cauldronPointer)
	dirtPointer = pointerNode.instantiate()
	add_child(dirtPointer)
	tearsPointer = pointerNode.instantiate()
	add_child(tearsPointer)
	thornyPointer = pointerNode.instantiate()
	add_child(thornyPointer)
	
	pointersLeft = [cauldronPointer, dirtPointer, tearsPointer, thornyPointer]
	
	#point at cauldron
	cauldronPointer.rotation_degrees = 270
	cauldronPointer.global_position = Vector2(500, 200)
	cauldronPointer.playAnimation("pointUp")
	cauldronPointer.hide()
	
	#Point at dirt
	dirtPointer.global_position = Vector2(1230,280)
	dirtPointer.playAnimation("pointUp2")
	
	#Point at a thorny heart
	thornyPointer.global_position = Vector2(1840, 280)
	thornyPointer.playAnimation("pointUp3")
	
	#Point at tears of trees
	tearsPointer.global_position = Vector2(1430, 550)
	tearsPointer.playAnimation("pointUp4")
	
	await tutorialIngredientsInCauldron
	
	#point at spoon
	var point = pointerNode.instantiate()
	point.rotation_degrees = 270
	$liquid.add_child(point)
	point.global_position = Vector2(900, 400)
	point.playAnimation("pointUp")

	await tutorialComplete
	point.queue_free()

func _on_ingredient_drawer_tutorial_step() -> void:
	tutorialStep.emit()


func tutorialDeletePointer(ingredient : String):
	match ingredient: 
		"cauldron":
			cauldronPointer.queue_free()
			tutorialIngredientsInCauldron.emit()
		"earth":
			pointersLeft.erase(dirtPointer)
			dirtPointer.queue_free()
			
		"tears of trees":
			pointersLeft.erase(tearsPointer)
			tearsPointer.queue_free()
		
		"a thorny heart":
			pointersLeft.erase(thornyPointer)
			thornyPointer.queue_free()


func tutorialSwapVision(): 
	showIng = !showIng
	var i = 1
	if(showIng):
		pointersLeft[0].hide()
		while(i < pointersLeft.size()):
			pointersLeft[i].show()
			i += 1
	else: 
		pointersLeft[0].show()
		while(i < pointersLeft.size()):
			pointersLeft[i].hide()
			i += 1
