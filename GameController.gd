extends Node2D

var platform_scene = preload("res://platformScene.tscn")
var start = 30
var end = -90
#var platform = platform_scene.instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$startPlatform.move_local_x(-1)
	$platformNode.move_local_x(-1)
	$platformNode.position.x = wrapf($platformNode.position.x, end, start)
	if $platformNode.position.x == start - 1:
		print('node reached start')
		var platform = platform_scene.instance()
		$platformNode.add_child(platform)
	print($platformNode.position.x)
#	pass
