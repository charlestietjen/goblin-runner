extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = -1
onready var game_node = get_node('../../../Game')


# Called when the node enters the scene tree for the first time.
func _ready():
	connect('body_entered', self, '_on_body_entered')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	move_local_x(game_node.gameSpeed)

func _on_body_entered(body):
	if body.name == 'player':
		game_node._player_death()
