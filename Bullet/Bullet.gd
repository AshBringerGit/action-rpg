extends Area2D

@export var life_time := 2.0
var velocity := Vector2.ZERO

func _ready():
	$Timer.wait_time = life_time
	$Timer.start()

func _physics_process(delta):
	position += velocity * delta

func _on_Timer_timeout():
	queue_free()

func _on_Bullet_body_entered(body):
	print(123);
	if body.has_method("take_damage"):
		body.take_damage(1)
	queue_free()
