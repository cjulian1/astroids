extends Node
@export var meteor_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$ScoreTimer.stop()
	$EnemyTimer.stop()
	#$HUD.show_game_over()


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	#$HUD.update_score(score)
	#$HUD.show_message("Get Ready")


func _on_enemy_timer_timeout():
	var meteor = meteor_scene.instantiate()

	var enemy_spawn_location = $EnemyPath/EnemySpawnLocation
	enemy_spawn_location.progress_ratio = randf()

	var direction = enemy_spawn_location.rotation + PI / 2

	meteor.position = enemy_spawn_location.position

	direction += randf_range(-PI / 4, PI / 4)
	meteor.rotation = direction

	var velocity = Vector2(randf_range(150.0, 300.0), 0.0)
	meteor.linear_velocity = velocity.rotated(direction)

	add_child(meteor)


func _on_score_timer_timeout():
	score += 1
	#$HUD.update_score(score)


func _on_start_timer_timeout():
	$EnemyTimer.start()
	$ScoreTimer.start()
