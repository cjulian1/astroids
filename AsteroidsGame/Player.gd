extends Area2D

signal hit

@export var speed = 350
var screen_size
var angular_speed = PI

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	pass # Replace with function body.

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = 0
	if Input.is_action_pressed("ui_left"):
		direction = -1
	if Input.is_action_pressed("ui_right"):
		direction = 1

	rotation += angular_speed * direction * delta

	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2.RIGHT.rotated(rotation) * speed
	
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2.LEFT.rotated(rotation) * speed

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "flying"
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.animation = "stationary"
		$AnimatedSprite2D.play()

	position += velocity * delta


func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)


