extends CharacterBody2D

@export var speed := 200.0
@export var bullet_scene: PackedScene
@export var bullet_speed := 1500.0

@onready var shoot_cooldown: Timer = $ShootCooldown
@onready var bullet_spawn: Marker2D = $BulletSpawn

var firing := false

func _process(delta):
	firing = Input.is_action_pressed("fire")

func _physics_process(delta):
	var input_vector = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	velocity = input_vector * speed
	move_and_slide()

func _on_shoot_cooldown_timeout():
	if firing:
		shoot()
		shoot_cooldown.start()

func shoot():
	if bullet_scene == null:
		return

	var bullet = bullet_scene.instantiate()
	var direction = (get_global_mouse_position() - bullet_spawn.global_position).normalized()

	bullet.global_position = bullet_spawn.global_position
	bullet.rotation = direction.angle()
	bullet.set("velocity", direction * bullet_speed)

	get_tree().current_scene.add_child(bullet)
	
func _ready():
	shoot_cooldown.start()
