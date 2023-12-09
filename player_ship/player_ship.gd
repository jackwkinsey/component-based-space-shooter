extends Node2D

@onready var left_cannon: Marker2D = $LeftCannon
@onready var right_cannon: Marker2D = $RightCannon
@onready var spawner_component: SpawnerComponent = $SpawnerComponent as SpawnerComponent
@onready var fire_rate_timer: Timer = $FireRateTimer
@onready var input_component: InputComponent = $InputComponent as InputComponent
@onready var ship_animated_sprite: AnimatedSprite2D = %ShipAnimatedSprite
@onready var flame_animated_sprite: AnimatedSprite2D = %FlameAnimatedSprite
@onready var stats_component: StatsComponent = $StatsComponent as StatsComponent
@onready var switch_scene_component: SwitchSceneComponent = $SwitchSceneComponent as SwitchSceneComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent as HurtboxComponent
@onready var flash_component: FlashComponent = $FlashComponent as FlashComponent
@onready var move_component: MoveComponent = $MoveComponent as MoveComponent

@export var starting_position: Vector2


func _ready() -> void:
	fire_rate_timer.timeout.connect(fire_lasers)
	stats_component.no_health.connect(die)


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


func turn_ship_off() -> void:
	fire_rate_timer.timeout.disconnect(fire_lasers)
	stats_component.health = stats_component.max_health
	visible = false
	position = starting_position
	hurtbox_component.is_invincible = true
	move_component.allow_movement = false


func turn_ship_on() -> void:
	await get_tree().create_timer(1.0).timeout
	move_component.allow_movement = true
	visible = true
	flash_component.flash()
	fire_rate_timer.timeout.connect(fire_lasers)
	await get_tree().create_timer(1).timeout
	hurtbox_component.is_invincible = false


func die() -> void:
	turn_ship_off()
	
	if stats_component.lives <= 0:
		end_game()
	else:
		turn_ship_on()


func end_game() -> void:
	await get_tree().create_timer(1.0).timeout
	switch_scene_component.switch_scene()
