extends Control

var potions
var ingredients
var quests

var activeQuests
var pharmacy
var storeQueue

func _ready() -> void:
	#Custom Signals from children
	$RecipeBook.enable_outside_buttons.connect(_enable_all_buttons.bind())
	#FrontRoom Buttons
	
	#BackRoom Buttons
	$BackRoom/ingredientShelfBtn.pressed.connect(_on_button_pressed.bind("ingredientShelf"))
	$BackRoom/BookshelfBtn.pressed.connect(_on_button_pressed.bind("Bookshelf"))
	$BackRoom/RecipeBookBtn.pressed.connect(_on_button_pressed.bind("RecipeBook"))
	$BackRoom/CauldronBtn.pressed.connect(_on_button_pressed.bind("Cauldron"))
	$BackRoom/MortarandPestleBtn.pressed.connect(_on_button_pressed.bind("MortarandPestle"))
	$BackRoom/toFrontRoomBtn.pressed.connect(_on_button_pressed.bind("toFrontRoom"))

#called from main; saves references of the variables from main into these local (global?) variables
func ref_storage(
	_potions,
	_ingredients,
	_quests,
	_activeQuests,
	_pharmacy,
	_storeQueue
) -> void:
	potions = _potions
	ingredients = _ingredients
	quests = _quests
	activeQuests = _activeQuests
	pharmacy = _pharmacy
	storeQueue = _storeQueue

func _on_button_pressed(button_pressed: String) -> void:
	if (button_pressed == "ingredientShelf"):
		pass
	if (button_pressed == "Bookshelf"):
		pass
	if (button_pressed == "RecipeBook"):
		_disable_all_buttons()
		$RecipeBook._on_recipe_book_btn_pressed(potions, ingredients)
	if (button_pressed == "Cauldron"):
		pass
	if (button_pressed == "MortarandPestle"):
		pass
	if (button_pressed == "toFrontRoom"):
		pass

func _disable_all_buttons() -> void:
	for child in get_children():
		if child != $RecipeBook:
			for innerchild in child.get_children():
				if innerchild is Button:
					innerchild.disabled = true

func _enable_all_buttons() -> void:
	for child in get_children():
		if child != $RecipeBook:
			for innerchild in child.get_children():
				if innerchild is Button:
					innerchild.disabled = false


func _on_main_menu_scene_start_game() -> void:
	$MainMenuScene.hide()
	$FrontRoom.show()

func _on_front_room_to_back_room() -> void:
	$FrontRoom.hide()
	$BackRoom.show()

func _on_back_room_to_front() -> void:
	$BackRoom.hide()
	$FrontRoom.show()

func _on_back_room_to_grind_station() -> void:
	$BackRoom.hide()
	$GrindingStation.show()


func _on_back_room_to_cauldron_station() -> void:
	$BackRoom.hide()
	$CauldronStation.show()


func _on_grinding_station_go_back() -> void:
	$GrindingStation.hide()
	$BackRoom.show()


func _on_cauldron_station_go_back() -> void:
	$CauldronStation.hide()
	$BackRoom.show()


func _on_main_menu_scene_display_options() -> void:
	$MainMenuScene.hide()
	$Options.show()


func _on_options_exit_options() -> void:
	$Options.hide()
	$MainMenuScene.show()


func _on_credits_go_back() -> void:
	$credits.hide()
	$MainMenuScene.show()


func _on_main_menu_scene_display_credits() -> void:
	$MainMenuScene.hide()
	$credits.show()


func _on_main_menu_scene_test_that_shit() -> void:
	$MainMenuScene.hide()
	$endOfDayScreen.show()
	
	$endOfDayScreen.displayShit(ingredients, potions)


func _on_end_of_day_screen_show_store() -> void:
	$endOfDayScreen.hide()
	$crowStore.show()


func newDay() -> void:
	$crowStore.hide()
	$MainMenuScene.show()
