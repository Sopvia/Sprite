extends Node
@export var obstacle_scene: PackedScene
var score
var gameOver = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	gameOver = true
	$ScoreTimer.stop()
	$ObstacleTimer.stop()
	
	$display.show_game_over()


func new_game():
	get_tree().call_group("obstacles", "queue_free")
	gameOver = false
	score = 0
	$Player.start($StartPlayer.position)
	$StartTimer.start()
	
	$display.update_score(score)
	$display.show_message("Ready?")


func _on_obstacle_timer_timeout():
	var obstacle = obstacle_scene.instantiate()
	
	obstacle.position = $StartObstacle.position
	
	add_child(obstacle)


func _on_score_timer_timeout():
	score += 1
	
	$display.update_score(score)


func _on_start_timer_timeout():
	$ObstacleTimer.start()
	$ScoreTimer.start()
