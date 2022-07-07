extends KinematicBody2D


# Declare member variables here. Examples:
export var gravity = 10
export var jumpStrength = -250
export var jumpMaximum = 0.6
var velocity = Vector2()
var jumpTime = 0
var disabledControls = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !is_on_floor():
		velocity.y += gravity
	if is_on_floor() && !disabledControls && Input.is_action_just_pressed("jump"):
		$jump.play()
		velocity.y += jumpStrength
	if is_on_floor():
		$AnimationTree.set('parameters/move_state/current', 1)
	else:
		$AnimationTree.set('parameters/move_state/current', 0)
	velocity = move_and_slide(velocity, Vector2.UP)


func disableControls():
	disabledControls = true
