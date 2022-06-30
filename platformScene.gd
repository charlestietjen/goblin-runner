extends Node2D


# Declare member variables here. Examples:
export var speed = -2
onready var game_node = get_node('../../../Game')

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	move_local_x(game_node.gameSpeed)
