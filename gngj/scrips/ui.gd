extends Control

var potions
var ingredients
var quests

var activeQuests
var pharmacy
var storeQueue

func _ready() -> void:
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
		$RecipeBook._on_recipe_book_btn_pressed(potions)
	if (button_pressed == "Cauldron"):
		pass
	if (button_pressed == "MortarandPestle"):
		pass
	if (button_pressed == "toFrontRoom"):
		pass
