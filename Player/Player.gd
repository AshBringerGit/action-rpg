extends CharacterBody2D

@export var speed := 200.0
@export var bullet_scene: PackedScene

@onready var shoot_cooldown: Timer = $ShootCooldown
@onready var bullet_spawn: Marker2D = $BulletSpawn

func _physics_process(delta):
	var input_vector = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	print("Input:", input_vector)
	velocity = input_vector * speed
	move_and_slide()

	if Input.is_action_pressed("fire") and not shoot_cooldown.is_running():
		shoot()
		shoot_cooldown.start()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = bullet_spawn.global_position
	bullet.rotation = rotation
	get_tree().current_scene.add_child(bullet)
