extends KinematicBody2D


# Declare member variables here. Examples:
export var gravity = 10
export var jumpStrength = -200
export var jumpMaximum = 0.6
var velocity = Vector2()
var jumpTime = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += gravity
	if jumpTime <= jumpMaximum:
		if Input.is_action_just_pressed("jump"):
			velocity.y += jumpStrength
		if Input.is_action_pressed("jump"):
			velocity.y += jumpStrength * delta
			jumpTime += delta
			print(jumpTime)
	if is_on_floor():
		jumpTime = 0
	velocity = move_and_slide(velocity, Vector2.UP)
