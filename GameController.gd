extends Node2D

onready var platform_scene = preload("res://platformScene.tscn")
onready var skeleton_scene = preload("res://skeleton.tscn")
onready var looped_bgm = preload("res://music/bgm_no_loop.ogg")
export var gameSpeed = 0
var difficultyLevel = 1.0
var spawnAdjust = 0.0
var gameActive = false
var gameOver = false
var start = 30
var end = -90
onready var random = RandomNumberGenerator.new()
var rSeed = 213
var score = 0
#var platform = platform_scene.instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	random.seed = rSeed
	var skeleton = skeleton_scene.instance()
	$obstacleEntry.add_child(skeleton)
	random.randomize()

func spawnPlatform():
	var platform = platform_scene.instance()
	$platformNode.call_deferred("add_child", platform)
func spawnSkeleton():
	var skeleton = skeleton_scene.instance()
	$obstacleEntry.call_deferred("add_child", skeleton)
	var variationRoll = random.randi_range(0, 5)
	if variationRoll > 3:
		skeleton.get_node('Sprite').set('frame', 1)
		skeleton.position.y -= 30


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if gameOver:
		gameSpeed = lerp(gameSpeed, 0, 0.1)
	if gameOver && Input.is_action_just_pressed("jump"):
		get_tree().reload_current_scene()
	if !gameActive && Input.is_action_just_pressed("jump"):
		$startInstructions.visible = not visible
		gameSpeed = -1
		gameActive = true
		$spawnTimer.start()
		$difficultyStep.start()
		$bgmPlayer.play()


func _on_platformStart_area_exited(_area):
	spawnPlatform()


func _on_platformEnd_area_entered(area):
	area.queue_free() # Replace with function body.

func _player_death():
	$player.get_node('sprite').visible = not visible
	$player.get_node('deathSprite').visible = visible
	$gameOverLabel.visible = visible
	$spawnTimer.stop()
	$difficultyStep.stop()
	$hit.play()
	gameOver = true



func _on_spawnTimer_timeout():
	var skeletonRoll = random.randf_range(0.0, 10.00)
	if skeletonRoll + spawnAdjust <= difficultyLevel:
		spawnAdjust = 0.0
		spawnSkeleton()
	else:
		spawnAdjust -= 0.5
	score += int(1.0 * difficultyLevel)
	$scoreCount.text = str(score)


func _on_difficultyStep_timeout():
	if gameSpeed > -4:
		gameSpeed -= 0.1
	if difficultyLevel < 8:
		difficultyLevel += 0.2
#	print('gamespeed: ',gameSpeed,'difficultylevel: ', difficultyLevel)

