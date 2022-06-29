extends KinematicBody2D


# Declare member variables here. Examples:
export var maxSpeed = 10
export var acceleration = 0.1
export var friction = 0.1
export var gravity = 10
export var jumpStrength = -300
var velocity = Vector2()
var inputVelocity


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	inputVelocity = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if is_on_floor() && inputVelocity != 0:
		velocity.x = lerp(velocity.x, maxSpeed * inputVelocity, acceleration)
		if velocity.x < 0:
			$Sprite.scale.x = -1
		if velocity.x > 0:
			$Sprite.scale.x = 1
		$AnimationTree.set('parameters/move_state/current', 1)
	elif is_on_floor() && inputVelocity == 0:
		velocity.x = lerp(velocity.x, 0, friction)
		$AnimationTree.set('parameters/move_state/current', 0)
	else:
		velocity.x = lerp(velocity.x, maxSpeed * inputVelocity, acceleration / 3)
	velocity.y = velocity.y + gravity
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = jumpStrength
	velocity = move_and_slide(velocity, Vector2.UP)
