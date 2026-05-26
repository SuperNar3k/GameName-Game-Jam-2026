extends Sprite2D

signal parent_buttons_hide
signal parent_buttons_show

var huh = 0
var held = null
var spawn_test = preload("res://Scenes/Spawn_Test.tscn")
var instance
var allIngredients
var wantGrinded : bool
var grabbingAllowed = true
var nextPressed = false
var showOnCompleted = false
var page = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play('arrow')
	$Handle.mouse_entered.connect(_on_hovered.bind(true, self, null))
	$Handle.mouse_exited.connect(_on_hovered.bind(false, self, null))
	
	$Button.mouse_entered.connect(_on_hovered.bind(true, $Button/Sprite2D, 0))
	$Button.mouse_exited.connect(_on_hovered.bind(false, $Button/Sprite2D, 0))
	$Button2.mouse_entered.connect(_on_hovered.bind(true, $Button2/Sprite2D, 1))
	$Button2.mouse_exited.connect(_on_hovered.bind(false, $Button2/Sprite2D, 1))
	$Button3.mouse_entered.connect(_on_hovered.bind(true, $Button3/Sprite2D, 2))
	$Button3.mouse_exited.connect(_on_hovered.bind(false, $Button3/Sprite2D, 2))
	$Button4.mouse_entered.connect(_on_hovered.bind(true, $Button4/Sprite2D, 3))
	$Button4.mouse_exited.connect(_on_hovered.bind(false, $Button4/Sprite2D, 3))
	$Button5.mouse_entered.connect(_on_hovered.bind(true, $Button5/Sprite2D, 4))
	$Button5.mouse_exited.connect(_on_hovered.bind(false, $Button5/Sprite2D, 4))
	$Button6.mouse_entered.connect(_on_hovered.bind(true, $Button6/Sprite2D, 5))
	$Button6.mouse_exited.connect(_on_hovered.bind(false, $Button6/Sprite2D, 5))
	$Button7.mouse_entered.connect(_on_hovered.bind(true, $Button7/Sprite2D, 6))
	$Button7.mouse_exited.connect(_on_hovered.bind(false, $Button7/Sprite2D, 6))
	$Button8.mouse_entered.connect(_on_hovered.bind(true, $Button8/Sprite2D, 7))
	$Button8.mouse_exited.connect(_on_hovered.bind(false, $Button8/Sprite2D, 7))
	$Button9.mouse_entered.connect(_on_hovered.bind(true, $Button9/Sprite2D, 8))
	$Button9.mouse_exited.connect(_on_hovered.bind(false, $Button9/Sprite2D, 8))
	$Button10.mouse_entered.connect(_on_hovered.bind(true, $Button10/Sprite2D, 9))
	$Button10.mouse_exited.connect(_on_hovered.bind(false, $Button10/Sprite2D, 9))
	$Button11.mouse_entered.connect(_on_hovered.bind(true, $Button11/Sprite2D, 10))
	$Button11.mouse_exited.connect(_on_hovered.bind(false, $Button11/Sprite2D, 10))
	$Button12.mouse_entered.connect(_on_hovered.bind(true, $Button12/Sprite2D, 11))
	$Button12.mouse_exited.connect(_on_hovered.bind(false, $Button12/Sprite2D, 11))
	$Button13.mouse_entered.connect(_on_hovered.bind(true, $Button13/Sprite2D, 12))
	$Button13.mouse_exited.connect(_on_hovered.bind(false, $Button13/Sprite2D, 12))
	$Button14.mouse_entered.connect(_on_hovered.bind(true, $Button14/Sprite2D, 13))
	$Button14.mouse_exited.connect(_on_hovered.bind(false, $Button14/Sprite2D, 13))
	$Button15.mouse_entered.connect(_on_hovered.bind(true, $Button15/Sprite2D, 14))
	$Button15.mouse_exited.connect(_on_hovered.bind(false, $Button15/Sprite2D, 14))
	$Button16.mouse_entered.connect(_on_hovered.bind(true, $Button16/Sprite2D, 15))
	$Button16.mouse_exited.connect(_on_hovered.bind(false, $Button16/Sprite2D, 15))
	$nextBtn.mouse_entered.connect(_on_hovered.bind(true, $Sprite2D, -1))
	$nextBtn.mouse_exited.connect(_on_hovered.bind(false, $Sprite2D, -1))
	
	$Button.button_down.connect(_on_drawer_button_down.bind(0))
	$Button2.button_down.connect(_on_drawer_button_down.bind(1))
	$Button3.button_down.connect(_on_drawer_button_down.bind(2))
	$Button4.button_down.connect(_on_drawer_button_down.bind(3))
	$Button5.button_down.connect(_on_drawer_button_down.bind(4))
	$Button6.button_down.connect(_on_drawer_button_down.bind(5))
	$Button7.button_down.connect(_on_drawer_button_down.bind(6))
	$Button8.button_down.connect(_on_drawer_button_down.bind(7))
	$Button9.button_down.connect(_on_drawer_button_down.bind(8))
	$Button10.button_down.connect(_on_drawer_button_down.bind(9))
	$Button11.button_down.connect(_on_drawer_button_down.bind(10))
	$Button12.button_down.connect(_on_drawer_button_down.bind(11))
	$Button13.button_down.connect(_on_drawer_button_down.bind(12))
	$Button14.button_down.connect(_on_drawer_button_down.bind(13))
	$Button15.button_down.connect(_on_drawer_button_down.bind(14))
	$Button16.button_down.connect(_on_drawer_button_down.bind(15))
	
	$Button.button_up.connect(_on_drawer_button_up.bind(0))
	$Button2.button_up.connect(_on_drawer_button_up.bind(1))
	$Button3.button_up.connect(_on_drawer_button_up.bind(2))
	$Button4.button_up.connect(_on_drawer_button_up.bind(3))
	$Button5.button_up.connect(_on_drawer_button_up.bind(4))
	$Button6.button_up.connect(_on_drawer_button_up.bind(5))
	$Button7.button_up.connect(_on_drawer_button_up.bind(6))
	$Button8.button_up.connect(_on_drawer_button_up.bind(7))
	$Button9.button_up.connect(_on_drawer_button_up.bind(8))
	$Button10.button_up.connect(_on_drawer_button_up.bind(9))
	$Button11.button_up.connect(_on_drawer_button_up.bind(10))
	$Button12.button_up.connect(_on_drawer_button_up.bind(11))
	$Button13.button_up.connect(_on_drawer_button_up.bind(12))
	$Button14.button_up.connect(_on_drawer_button_up.bind(13))
	$Button15.button_up.connect(_on_drawer_button_up.bind(14))
	$Button16.button_up.connect(_on_drawer_button_up.bind(15))
	
func __init__(_allIngredients : Dictionary, _wantGrinded : bool) -> void:
	# Set global dictionaries
	allIngredients = _allIngredients
	wantGrinded = _wantGrinded
	
func _on_drawer_button_down(button_down : int) -> void:
	#if instance != null:
		#if instance.get_child(0) != null:
			#instance.get_child(0).queue_free()
	if grabbingAllowed:
		if(held == null):
			if page != 1:
				if button_down + 16 < 30:
					if (allIngredients.get(allIngredients.keys()[button_down+16]).amountOwned > 0):
						if (wantGrinded):
							var ref = allIngredients.get(allIngredients.keys()[button_down+16])
							if instance != null:
								instance.queue_free()
							instance = spawn_test.instantiate()
							add_child(instance)
							instance.set_texture(load(allIngredients.get(allIngredients.keys()[button_down+16]).sprite))  
							held = allIngredients.keys()[button_down+16]
							hide_buttons()
							allIngredients.get(allIngredients.keys()[button_down+16]).amountOwned -= 1
							instance.get_child(0).text = (ref.itemName + "\n" + str(ref.amountOwned))
							get_child(button_down).get_child(0).material.set_shader_parameter("outline_thickness", 0.0)
						else:
							if (allIngredients.get(allIngredients.keys()[button_down+16]).isGrindable):
								#var ref = allIngredients.get(allIngredients.keys()[button_down+16])
								if instance != null:
									instance.queue_free()
								instance = spawn_test.instantiate()
								add_child(instance)
								instance.set_texture(load(allIngredients.get(allIngredients.keys()[button_down+16]).sprite))  
								held = allIngredients.keys()[button_down+16]
								hide_buttons()
								allIngredients.get(allIngredients.keys()[button_down+16]).amountOwned -= 1
								get_child(button_down).get_child(0).material.set_shader_parameter("outline_thickness", 0.0)
						if (allIngredients.get(allIngredients.keys()[button_down+16]).amountOwned == 0):
							get_child(button_down).get_child(0).set_texture(Texture2D)
			else:
				if (allIngredients.get(allIngredients.keys()[button_down]).amountOwned > 0):
						if (wantGrinded):
							#var ref = allIngredients.get(allIngredients.keys()[button_down])
							if instance != null:
								instance.queue_free()
							instance = spawn_test.instantiate()
							add_child(instance)
							instance.set_texture(load(allIngredients.get(allIngredients.keys()[button_down]).sprite))  
							held = allIngredients.keys()[button_down]
							hide_buttons()
							allIngredients.get(allIngredients.keys()[button_down]).amountOwned -= 1
							get_child(button_down).get_child(0).material.set_shader_parameter("outline_thickness", 0.0)
						else:
							if (allIngredients.get(allIngredients.keys()[button_down]).isGrindable):
								#var ref = allIngredients.get(allIngredients.keys()[button_down])
								if instance != null:
									instance.queue_free()
								instance = spawn_test.instantiate()
								add_child(instance)
								instance.set_texture(load(allIngredients.get(allIngredients.keys()[button_down]).sprite))  
								held = allIngredients.keys()[button_down]
								hide_buttons()
								allIngredients.get(allIngredients.keys()[button_down]).amountOwned -= 1
								get_child(button_down).get_child(0).material.set_shader_parameter("outline_thickness", 0.0)
						if (allIngredients.get(allIngredients.keys()[button_down]).amountOwned == 0):
							get_child(button_down).get_child(0).set_texture(Texture2D)
		#else:
			

func _on_drawer_button_up(button_up : int) -> void:
	if page != 1:
				if held == allIngredients.keys()[button_up+16]:
					held = null
					instance.queue_free()
					allIngredients.get(allIngredients.keys()[button_up+16]).amountOwned += 1
					_on_hovered(true, get_child(button_up).get_child(0), button_up)
					_redraw()
					show_buttons()
	else:
				if held == allIngredients.keys()[button_up]:
					held = null
					instance.queue_free()
					allIngredients.get(allIngredients.keys()[button_up]).amountOwned += 1
					_on_hovered(true, get_child(button_up).get_child(0), button_up)
					_redraw()
					show_buttons()
#func inst(pos):
	
	#instance.position = pos
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_handle_pressed() -> void:
	$tutarrow.hide()
	$nextBtn.hide()
	$Sprite2D.hide()
	var child = 0
	while child < 16:
		get_children()[child].disabled = true
		child += 1
	if (huh % 2 == 0):
		$AnimationPlayer.play("Drawer_Slide")
		huh = huh + 1
		page = 1
		
		_redraw()
	else:
		$AnimationPlayer.play_backwards("Drawer_Slide")
		huh = huh + 1

func _on_hovered(hovered: bool, ref, button) -> void:
	if held == null:
		if hovered:
			var ing
			if button == -1:
				instance = spawn_test.instantiate()
				add_child(instance)
				instance.get_child(0).text = "Next Drawer"
			elif button != null:
				if get_child(button).disabled == false:
					if ref.texture != null:
						if page != 1:
							if (button + 16) < 30:
								ing = allIngredients.get(allIngredients.keys()[button+16])
						else:
							ing = allIngredients.get(allIngredients.keys()[button])
				else:
					return
				instance = spawn_test.instantiate()
				if ing != null:
					add_child(instance)
					instance.get_child(0).text = (ing.itemName + "\n" + str(ing.amountOwned))
		else:
			if instance != null:
				instance.queue_free()
		ref.material.set_shader_parameter("outline_thickness", 5.0 if hovered else 0.0)
	else:
		ref.material.set_shader_parameter("outline_thickness", 0.0)


func _on_animation_player_animation_finished(_anim_name: StringName):
	if $AnimationPlayer.current_animation_position == $AnimationPlayer.current_animation_length and held == null:
		$nextBtn.show()
		$Sprite2D.show()
		var child = 0
		while child < 16:
			get_children()[child].disabled = false
			child += 1
	
	if nextPressed:
		var delete = 0
		while delete < 16:
			get_child(delete).get_child(0).set_texture(Texture2D)
			delete = delete + 1
		if page != 1:
			page = 1
			var i = 0
			for ingred in allIngredients.keys():
				if i <= 15:
					if allIngredients.get(ingred).amountOwned > 0:
						get_child(i).get_child(0).set_texture(load(allIngredients.get(ingred).sprite))
				i = i + 1
		else:
			page = 2
			var i = 0
			for ingred in allIngredients.keys():
				if i <= 15:
					pass
				else:
					if allIngredients.get(ingred).amountOwned > 0:
						get_child(i-16).get_child(0).set_texture(load(allIngredients.get(ingred).sprite))
				i = i + 1
		$AnimationPlayer.play("Drawer_Slide")
		nextPressed = false
	if showOnCompleted:
		show_buttons()
		showOnCompleted = false


func _on_next_btn_pressed() -> void:
	$nextBtn.hide()
	$Sprite2D.hide()
	var child = 0
	while child < 16:
		get_children()[child].disabled = true
		child += 1
	$AnimationPlayer.play_backwards("Drawer_Slide")
	nextPressed = true

func _redraw() -> void:
	var delete = 0
	while delete < 16:
		get_child(delete).get_child(0).set_texture(Texture2D)
		delete = delete + 1
	if page == 1:
		var i = 0
		for ingred in allIngredients.keys():
			if i <= 15:
				if allIngredients.get(ingred).amountOwned > 0:
					get_child(i).get_child(0).set_texture(load(allIngredients.get(ingred).sprite))
			i = i + 1
	else:
		var i = 0
		for ingred in allIngredients.keys():
			if i <= 15:
				pass
			else:
				if allIngredients.get(ingred).amountOwned > 0:
					get_child(i-16).get_child(0).set_texture(load(allIngredients.get(ingred).sprite))
			i = i + 1

func hide_buttons():
	$nextBtn.hide()
	$Sprite2D.hide()
	#var child = 0
	#while child < 16:
		#get_children()[child].disabled = true
		#child += 1
	$Handle.hide()
	parent_buttons_hide.emit()
func show_buttons():
	if $AnimationPlayer.is_playing():
		showOnCompleted = true
	else:
		$nextBtn.show()
		$Sprite2D.show()
		$Handle.show()
		parent_buttons_show.emit()
