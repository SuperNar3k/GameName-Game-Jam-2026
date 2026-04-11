extends Control

var allPotions
var allIngredients
var quests

var activeQuests
var pharmacyQuests
var storeQueue

signal talkToNpc
signal questAccepted(option)

var gameStart = false
var bookOpen = false

func _ready() -> void:
	#Custom Signals from children
	$RecipeBook.enable_outside_buttons.connect(_enable_all_buttons.bind())
	$Hud.recipe_pressed.connect(_on_button_pressed.bind("RecipeBook"))
	$Hud.quest_pressed.connect(_on_button_pressed.bind("Quests"))
	$Hud.options_pressed.connect(_on_button_pressed.bind("Options"))
	#FrontRoom Buttons
	
	#BackRoom Buttons
	$BackRoom/ingredientShelfBtn.pressed.connect(_on_button_pressed.bind("ingredientShelf"))
	$BackRoom/BookshelfBtn.pressed.connect(_on_button_pressed.bind("Bookshelf"))
	$BackRoom/RecipeBookBtn.pressed.connect(_on_button_pressed.bind("RecipeBook"))
	$BackRoom/CauldronBtn.pressed.connect(_on_button_pressed.bind("Cauldron"))
	$BackRoom/MortarandPestleBtn.pressed.connect(_on_button_pressed.bind("MortarandPestle"))
	$BackRoom/toFrontRoomBtn.pressed.connect(_on_button_pressed.bind("toFrontRoom"))

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("options_btn"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("recipe_book_btn"):
		if gameStart:
			if $RecipeBook/AnimationPlayer.is_playing() == false:
				if bookOpen == false:
					bookOpen = true
					_on_button_pressed("RecipeBook")
				else:
					bookOpen = false
					$RecipeBook._on_exit_btn_pressed()

#called from main; saves references of the variables from main into these local (global?) variables
func ref_storage(
	_allPotions,
	_allIngredients,
	_quests,
	_activeQuests,
	_pharmacyQuests,
	_storeQueue
) -> void:
	allPotions = _allPotions
	allIngredients = _allIngredients
	quests = _quests
	activeQuests = _activeQuests
	pharmacyQuests = _pharmacyQuests
	storeQueue = _storeQueue
	
	$RecipeBook.__init__(_allPotions, _allIngredients)

func _on_button_pressed(button_pressed: String) -> void:
	if (button_pressed == "ingredientShelf"):
		pass
	if (button_pressed == "Bookshelf"):
		pass
	if (button_pressed == "RecipeBook"):
		_disable_all_buttons()
		$RecipeBook._on_recipe_book_btn_pressed()
	if (button_pressed == "Cauldron"):
		pass
	if (button_pressed == "MortarandPestle"):
		pass
	if (button_pressed == "toFrontRoom"):
		pass
	if (button_pressed == "Quests"):
		$questListScreen.displayShit(activeQuests, pharmacyQuests, allPotions)
		$questListScreen.show()
	if (button_pressed == "Options"):
		$Options.show()

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


#IMPORTANT!
func _on_main_menu_scene_start_game() -> void:
	$MainMenuScene.hide()
	$FrontRoom.show()
	gameStart = true
	$Hud.show()

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
	#used to re-enable the thing that hits the menu signs
	$MainMenuScene/phys_buttons/collisionTimer.paused = false
	$MainMenuScene/phys_buttons/follower/CollisionShape2D.set_deferred("disabled", false)
	$MainMenuScene.show()


func _on_credits_go_back() -> void:
	$credits.hide()
	#used to re-enable the thing that hits the menu signs
	$MainMenuScene/phys_buttons/collisionTimer.paused = false
	$MainMenuScene/phys_buttons/follower/CollisionShape2D.set_deferred("disabled", false)
	$MainMenuScene.show()


func _on_main_menu_scene_display_credits() -> void:
	$MainMenuScene.hide()
	$credits.show()


func _on_main_menu_scene_test_that_shit() -> void:
	$MainMenuScene.hide()
	$endOfDayScreen.show()
	
	$endOfDayScreen.displayShit(allIngredients, allPotions)


func _on_end_of_day_screen_show_store() -> void:
	$endOfDayScreen.hide()
	$crowStore.show()


func newDay() -> void:
	$crowStore.hide()
	$MainMenuScene.show()


func _on_main_menu_scene_test_that_other_shit() -> void:
	$MainMenuScene.hide()
	$questListScreen.show()
	
	$questListScreen.displayShit(activeQuests, pharmacyQuests, allPotions)


func _on_quest_list_screen_return_to_game() -> void:
	$questListScreen.hide()
	$MainMenuScene.show()


func _on_front_room_quest_accepted(option: Variant) -> void:
	questAccepted.emit(option)


func _on_front_room_talk_to_npc() -> void:
	talkToNpc.emit()
