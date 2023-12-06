extends Node2D


@onready var left_cannon: Marker2D = $LeftCannon
@onready var right_cannon: Marker2D = $RightCannon
@onready var spawner_component: SpawnerComponent = $SpawnerComponent as SpawnerComponent
@onready var fire_rate_timer: Timer = $FireRateTimer
@onready var scale_component: ScaleComponent = $ScaleComponent as ScaleComponent
@onready var input_component: InputComponent = $InputComponent as InputComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	fire_rate_timer.timeout.connect(fire_lasers)


func _process(delta: float) -> void:
	if (input_component.direction.x < 0):
		animated_sprite_2d.play("bank_left")
	elif (input_component.direction.x > 0):
		animated_sprite_2d.play("bank_right")
	else:
		animated_sprite_2d.play("center")


func fire_lasers() -> void:
	spawner_component.spawn(left_cannon.global_position)
	spawner_component.spawn(right_cannon.global_position)
	scale_component.tween_scale()
