class_name Quest
extends Node

#GLOBAL VARIABLES

var accepted = false
var questCompleted = false

var questDialog = [[],[],[],[],[]]
var requirements = []
var rewards = [[],[],[]]
var daysUntilDue
var daysUntilReward
var isRepeatable
var npc = Sprite2D.new()







# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
