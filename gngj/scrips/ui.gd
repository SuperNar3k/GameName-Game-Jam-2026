extends Control

var ItemCreator
var allPotions
var allIngredients
var quests

var activeQuests
var pharmacyQuests
var storeQueue
var potions

var gameStart = false
var bookOpen = false

var lastScreen

signal talkToNpc
signal questAccepted(option)
signal startGame
signal loadGame
signal correctPotionSelected
signal buyItem(cost, item)
signal grindIngredient(ingredient)
signal cookingDone(heldIngredients, cookedLevel)
signal finishedNotifying



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

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("options_btn"):
		if $RecipeBook/Book.position.y == 540.0:
			if !$Options.is_visible_in_tree():
				_on_hud_options_pressed()
			else:
				_on_options_exit_options()
	
	if Input.is_action_just_pressed("recipe_book_btn"):
		if gameStart:
			if !$Options.visible:
				if $RecipeBook/AnimationPlayer.is_playing() == false:
					if bookOpen == false:
						bookOpen = true
						_on_button_pressed("RecipeBook")
					else:
						bookOpen = false
						$RecipeBook._on_exit_btn_pressed()
					

#called from main; saves references of the variables from main into these local (global?) variables
func ref_storage(
	_ItemCreator,
	_allPotions,
	_allIngredients,
	_quests,
	_activeQuests,
	_pharmacyQuests,
	_storeQueue,
	_potions
) -> void:
	ItemCreator = _ItemCreator
	allPotions = _allPotions
	allIngredients = _allIngredients
	quests = _quests
	activeQuests = _activeQuests
	pharmacyQuests = _pharmacyQuests
	storeQueue = _storeQueue
	potions = _potions
	
	$RecipeBook.__init__(_allPotions, _allIngredients)
	$GrindingStation.__init__(_allIngredients)
	$CauldronStation.__init__(_ItemCreator, _allPotions, _allIngredients, _potions)
	$crowStore.__init__(_allIngredients)

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
		pass
	if (button_pressed == "Options"):
		$Options.show()

func _disable_all_buttons() -> void:
	bookOpen = true
	for child in get_children():
		if child != $RecipeBook:
			for innerchild in child.get_children():
				if innerchild is Button:
					innerchild.disabled = true

func _enable_all_buttons() -> void:
	bookOpen = false
	for child in get_children():
		if child != $RecipeBook:
			for innerchild in child.get_children():
				if innerchild is Button:
					innerchild.disabled = false

func endDay():
	if $CauldronStation/IngredientDrawer.position.x < 860:
		$CauldronStation/IngredientDrawer._on_handle_pressed()
		$CauldronStation/IngredientDrawer._redraw()
		
	if $GrindingStation/IngredientDrawer.position.x < 860:
		$GrindingStation/IngredientDrawer._on_handle_pressed()
		$GrindingStation/IngredientDrawer._redraw()

#IMPORTANT!
func _on_main_menu_scene_start_game() -> void:
	$MainMenuScene.hide()
	$FrontRoom.show()
	$FrontRoom/AnimationPlayer.play("fade_to_normal")
	await ($FrontRoom/AnimationPlayer.animation_finished)
	$FrontRoom/ColorRect.hide()
	gameStart = true
	
	#$Hud.show()
	lastScreen = $FrontRoom
	
	startGame.emit()
	
func _on_main_menu_scene_load_game():
	$MainMenuScene.hide()
	$FrontRoom.show()
	$FrontRoom/AnimationPlayer.play("fade_to_normal")
	await ($FrontRoom/AnimationPlayer.animation_finished)
	$FrontRoom/ColorRect.hide()
	gameStart = true
	
	lastScreen = $FrontRoom
	
	loadGame.emit()
		
		
func _on_front_room_to_back_room() -> void:
	$FrontRoom.hide()
	$BackRoom.show()
	
	lastScreen = $BackRoom

func _on_back_room_to_front() -> void:
	$BackRoom.hide()
	$FrontRoom.show()
	
	lastScreen = $FrontRoom

func _on_back_room_to_grind_station() -> void:
	$Hud.hide_leftstuff()
	$BackRoom.hide()
	$GrindingStation.show()
	
	lastScreen = $GrindingStation


func _on_back_room_to_cauldron_station() -> void:
	$Hud.hide_leftstuff()
	$BackRoom.hide()
	$CauldronStation.show()
	
	lastScreen = $CauldronStation


func _on_grinding_station_go_back() -> void:
	$Hud.show_leftstuff()
	$GrindingStation.hide()
	$BackRoom.show()
	
	lastScreen = $BackRoom


func _on_cauldron_station_go_back() -> void:
	$Hud.show_leftstuff()
	$CauldronStation.hide()
	$BackRoom.show()
	
	lastScreen = $BackRoom


func _on_main_menu_scene_display_options() -> void:
	$MainMenuScene.hide()
	$Options.show()

	lastScreen = $MainMenuScene

func _on_options_exit_options() -> void:
	$Options.hide()
	#used to re-enable the thing that hits the menu signs ONLY if we were on the main menu
	if(lastScreen == $MainMenuScene):
		$MainMenuScene/phys_buttons/collisionTimer.paused = false
		$MainMenuScene/phys_buttons/follower/CollisionShape2D.set_deferred("disabled", false)
	else:
		$Hud.show()
		
	lastScreen.show()


func _on_credits_go_back() -> void:
	$credits.hide()
	#used to re-enable the thing that hits the menu signs
	$MainMenuScene/phys_buttons/collisionTimer.paused = false
	$MainMenuScene/phys_buttons/follower/CollisionShape2D.set_deferred("disabled", false)
	$MainMenuScene.show()


func _on_main_menu_scene_display_credits() -> void:
	$MainMenuScene.hide()
	$credits.show()

func _on_hud_quest_pressed() -> void:
	$questListScreen/ColorRect.show()
	$questListScreen/AnimationPlayer.play("slide_up")
	
	$questListScreen.displayShit(activeQuests, pharmacyQuests, allPotions)
	
func _on_quest_list_screen_return_to_game() -> void:
	
	$questListScreen/returnButton.hide()
	$questListScreen/Sprite2D2.hide()
	$questListScreen/AnimationPlayer.play_backwards("slide_up")

func _on_hud_options_pressed() -> void:
	if lastScreen != null:
		$Hud.hide()
		lastScreen.hide()
		$Options.show()
	
func _on_end_of_day() -> void:
	$Hud/gameInfo/endDay.hide()
	$Hud/gameInfo/endDayGraphic.hide()
	$Hud/gameInfo/dayCounter.hide()
	$Hud/gameInfo/currancyGraphic.show()
	$Hud/gameInfo/currencyLable.show()
	lastScreen.hide()
	$endOfDayScreen.show()
	$endOfDayScreen.displayShit(allIngredients, allPotions)
	
	lastScreen = $endOfDayScreen
	
func _on_end_of_day_screen_show_store() -> void:
	$endOfDayScreen.hide()
	$crowStore.show()
	
	lastScreen = $crowStore

func newDay() -> void:
	$Hud.show_leftstuff()
	$crowStore.hide()
	$FrontRoom.show()
	lastScreen = $FrontRoom
	
	startGame.emit()



func _on_front_room_quest_accepted(option: Variant) -> void:
	questAccepted.emit(option)


func _on_front_room_talk_to_npc() -> void:
	talkToNpc.emit()


func _on_front_room_correct_potion_selected() -> void:
	correctPotionSelected.emit()


func _on_crow_store_buy(cost: Variant, item: Variant):
	var ingredient = allIngredients.get(item)
	buyItem.emit(cost,ingredient)


func _on_cauldron_station_cooking_done(held_ingredients: Variant) -> void:
	cookingDone.emit(held_ingredients, 0)


func _on_notification_finished_playing() -> void:
	finishedNotifying.emit()


func _on_grinding_station_grind_ingredient(_ingredient: Variant) -> void:
	grindIngredient.emit(_ingredient)
