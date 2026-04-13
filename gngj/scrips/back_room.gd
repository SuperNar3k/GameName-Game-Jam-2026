extends Control

@onready var ingredientsShelf : Button = $ingredientShelfBtn
@onready var bookShelf: Button = $BookshelfBtn
@onready var recipeBook : Button = $RecipeBookBtn
@onready var cauldonStation : Button = $CauldronBtn
@onready var grindStation : Button = $MortarandPestleBtn
@onready var front : Button = $toFrontRoomBtn

signal toIngredientsShelf
signal toBookShelf
signal toRecipeBook
signal toCauldronStation
signal toGrindStation
signal toFront

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#ingredientsShelf.pressed.connect(_on_backRoomButton_pressed.bind("i"))
	bookShelf.pressed.connect(_on_backRoomButton_pressed.bind("b"))
	recipeBook.pressed.connect(_on_backRoomButton_pressed.bind("r"))
	cauldonStation.pressed.connect(_on_backRoomButton_pressed.bind("c"))
	grindStation.pressed.connect(_on_backRoomButton_pressed.bind("g"))
	front.pressed.connect(_on_backRoomButton_pressed.bind("f"))
	$RecipeBookBtn.mouse_entered.connect(got_hovered.bind("recipe_book", true))
	$RecipeBookBtn.mouse_exited.connect(got_hovered.bind("recipe_book", false))
	$CauldronBtn.mouse_entered.connect(got_hovered.bind("cauldron", true))
	$CauldronBtn.mouse_exited.connect(got_hovered.bind("cauldron", false))
	$MortarandPestleBtn.mouse_entered.connect(got_hovered.bind("mp", true))
	$MortarandPestleBtn.mouse_exited.connect(got_hovered.bind("mp", false))
	$ingredientShelfBtn.mouse_entered.connect(got_hovered.bind("ingshelf", true))
	$ingredientShelfBtn.mouse_exited.connect(got_hovered.bind("ingshelf", false))
	
func _on_backRoomButton_pressed(_name: String) -> void:
	match _name:
		"i":
			toIngredientsShelf.emit()
		"b":
			toBookShelf.emit()
		"r":
			toRecipeBook.emit()
		"c":
			toCauldronStation.emit()
		"g":
			toGrindStation.emit()
		"f":
			toFront.emit()

func got_hovered(btn: String, hovered: bool):
	if btn == "recipe_book":
		$bookstandimg.material.set_shader_parameter("outline_thickness", 3.0 if hovered else 0.0)
	if btn == "cauldron":
		$cauldronimg.material.set_shader_parameter("outline_thickness", 3.0 if hovered else 0.0)
	if btn == "mp":
		$mpimg.material.set_shader_parameter("outline_thickness", 3.0 if hovered else 0.0)
	#if btn == "ingshelf":
		#$ingshelfimg.material.set_shader_parameter("outline_thickness", 3.0 if hovered else 0.0)
