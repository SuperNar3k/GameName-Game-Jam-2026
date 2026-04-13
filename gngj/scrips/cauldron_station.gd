extends Control

@onready var backButton : Button = $BackButton

signal goBack

var allPotions
var allIngredients

var held_ingredients : Array
var followMouse = false
var recordRot = 0
var addedCook = 0.0
var done = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$liquid/Button.mouse_entered.connect(_on_hovered.bind(true, $liquid/handle))
	$liquid/Button.mouse_exited.connect(_on_hovered.bind(false, $liquid/handle))
	$IngredientDrawer.parent_buttons_hide.connect(hide_buttons)
	$IngredientDrawer.parent_buttons_show.connect(show_buttons)
	backButton.pressed.connect(_on_backButton_pressed)

func __init__(_allPotions : Dictionary, _allIngredients : Dictionary) -> void:
	# Set global dictionaries
	allPotions = _allPotions
	allIngredients = _allIngredients
	$IngredientDrawer.__init__(_allIngredients, true)

func _on_backButton_pressed() -> void:
	goBack.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if followMouse:
		if done == false:
			$liquid.look_at(get_global_mouse_position())
			if recordRot < $liquid.rotation_degrees:
				addedCook += delta
				$liquid/waves.modulate = lerp(Color(0.573, 0.675, 0.737, 1.0), Color(0.725, 0.388, 0.141, 1.0), addedCook / 3)
			recordRot = $liquid.rotation_degrees
			if $liquid/waves.modulate.b <= .141:
				done = true
				_cooking_done()
			
func _on_hovered(hovered: bool, ref) -> void:
	if $IngredientDrawer.held == null:
		ref.material.set_shader_parameter("outline_thickness", 5.0 if hovered else 0.0)


func _on_drop_spot_pressed() -> void:
	if ($IngredientDrawer.held != null):
		held_ingredients.append($IngredientDrawer.held)
		$IngredientDrawer.instance.queue_free()
		$IngredientDrawer.held = null
		$IngredientDrawer.show_buttons()
		print(held_ingredients)
		

func hide_buttons():
	$BackButton.hide()
func show_buttons():
	$BackButton.show()

func _cooking_done():
	held_ingredients.sort()
	var i = 0
	while i < allPotions.keys().size():
		var potionRecipeSorted = allPotions.get(allPotions.keys()[i]).recipe
		potionRecipeSorted.sort()
		if held_ingredients == potionRecipeSorted:
			if allPotions.get(allPotions.keys()[i]).unlocked == false:
				allPotions.get(allPotions.keys()[i]).unlocked = true
			allPotions.get(allPotions.keys()[i]).amountOwned += 1
			break
		i = i + 1

func _on_button_button_down() -> void:
	if $IngredientDrawer.held == null:
		followMouse = true


func _on_button_button_up() -> void:
	if $IngredientDrawer.held == null:
		followMouse = false
