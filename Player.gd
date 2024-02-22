extends Area2D

@export var speed = 350
var screen_size
var angular_speed = PI

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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

	position += velocity * delta
