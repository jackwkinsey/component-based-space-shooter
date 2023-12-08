extends Node2D

@onready var left_cannon: Marker2D = $LeftCannon
@onready var right_cannon: Marker2D = $RightCannon
@onready var spawner_component: SpawnerComponent = $SpawnerComponent as SpawnerComponent
@onready var fire_rate_timer: Timer = $FireRateTimer
@onready var input_component: InputComponent = $InputComponent as InputComponent
@onready var ship_animated_sprite: AnimatedSprite2D = %ShipAnimatedSprite
@onready var flame_animated_sprite: AnimatedSprite2D = %FlameAnimatedSprite


func _ready() -> void:
	fire_rate_timer.timeout.connect(fire_lasers)


func _process(_delta: float) -> void:
	animate_ship()


func fire_lasers() -> void:
	spawner_component.spawn(left_cannon.global_position)
	spawner_component.spawn(right_cannon.global_position)


func animate_ship() -> void:
	if (input_component.direction.x < 0):
		ship_animated_sprite.play("bank_left")
		flame_animated_sprite.play("bank_left")
	elif (input_component.direction.x > 0):
		ship_animated_sprite.play("bank_right")
		flame_animated_sprite.play("bank_right")
	else:
		ship_animated_sprite.play("center")
		flame_animated_sprite.play("center")
