extends CharacterBody2D

@export var max_health := 3
var current_health := 0

@onready var health_bar: TextureProgressBar = $HealthBar

func _ready():
	current_health = max_health
	health_bar.max_value = max_health
	health_bar.value = current_health
	
func take_damage(amount: int):
	current_health -= amount
	print("Урон получен:", amount, " | Текущее HP:", current_health)
	health_bar.value = current_health  # обновляем HP бар
	if current_health <= 0:
		die()

func die():
	print("Враг уничтожен!")
	queue_free()
