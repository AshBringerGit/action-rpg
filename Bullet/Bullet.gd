extends Area2D

@export var speed := 500.0
@export var life_time := 2.0

func _ready():
	$Timer.wait_time = life_time
	$Timer.start()

func _physics_process(delta):
	position += Vector2.RIGHT.rotated(rotation) * speed * delta

func _on_timer_timeout():
	queue_free()
