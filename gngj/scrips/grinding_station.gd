extends Control
@onready var backButton : Button = $BackButton

signal goBack
signal grindIngredient(_ingredient)

var grindLVL = 0
var grindDone = false

var allIngredients
var bowlIngredient = null

var grindSFX = preload("res://assets/sound/Grind Stone.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$IngredientDrawer.parent_buttons_hide.connect(hide_buttons)
	$IngredientDrawer.parent_buttons_show.connect(show_buttons)
	$BackButton.mouse_entered.connect(_on_hovered.bind(true, $Sprite2D))
	$BackButton.mouse_exited.connect(_on_hovered.bind(false, $Sprite2D))
	backButton.pressed.connect(_on_backButton_pressed)
	
func __init__(_allIngredients : Dictionary) -> void:
	# Set global dictionaries
	allIngredients = _allIngredients
	$IngredientDrawer.__init__(_allIngredients, false)
	
func _on_backButton_pressed() -> void:
	goBack.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if $grind.get_playback_position() > .61:
		$grind.stream_paused = true
	#pass

func _on_hovered(hovered: bool, ref) -> void:
	ref.material.set_shader_parameter("outline_thickness", 5.0 if hovered else 0.0)


func _on_drop_spot_pressed() -> void:
	if $fruitBowl.texture == null:
		if ($IngredientDrawer.held != null):
			bowlIngredient = $IngredientDrawer.held
			$fruitBowl.set_texture(load(allIngredients.get(bowlIngredient).sprite))
			$IngredientDrawer.instance.queue_free()
			$IngredientDrawer.held = null
			$IngredientDrawer.grabbingAllowed = false
			$IngredientDrawer.show_buttons()
			grindDone = false
			grindLVL = 0
	else:
		$fruitBowl.texture = null
		allIngredients.get(bowlIngredient).amountOwned += 1
		bowlIngredient = null
		$IngredientDrawer.grabbingAllowed = true
		$IngredientDrawer._redraw()
	
func hide_buttons():
	$BackButton.hide()
func show_buttons():
	$BackButton.show()


func _on_grinding_area_body_entered(_body: Node2D) -> void:
	if bowlIngredient != null and grindDone == false:
		grindLVL += 1
		if ($TweenTimer.is_stopped()):
			var pos_hold = $fruitBowl.position
			var tween = create_tween()
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.set_ease(Tween.EASE_IN)
			tween.tween_property($fruitBowl, "position", pos_hold + Vector2(randf_range(0.25 * grindLVL, grindLVL), 0), .05)
			tween.tween_property($fruitBowl, "position", pos_hold + Vector2(randf_range(-1 * grindLVL, -2.5 ), 0), .05)
			tween.tween_property($fruitBowl, "position", pos_hold, .05)
			$TweenTimer.start()
		if !$grind.playing:
			$grind.play(.13)
	if grindLVL == 30 and grindDone == false:
		grindDone = true
		
		# Check if grinding is possible
		var crushedName:String = bowlIngredient + " powder"
		if crushedName in allIngredients:
			grindIngredient.emit(allIngredients.get(bowlIngredient))
			$fruitBowl.set_texture(load(allIngredients.get(crushedName).sprite))
