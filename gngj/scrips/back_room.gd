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
	ingredientsShelf.pressed.connect(_on_backRoomButton_pressed.bind("i"))
	bookShelf.pressed.connect(_on_backRoomButton_pressed.bind("b"))
	recipeBook.pressed.connect(_on_backRoomButton_pressed.bind("r"))
	cauldonStation.pressed.connect(_on_backRoomButton_pressed.bind("c"))
	grindStation.pressed.connect(_on_backRoomButton_pressed.bind("g"))
	front.pressed.connect(_on_backRoomButton_pressed.bind("f"))
	
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
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
