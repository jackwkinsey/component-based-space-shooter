class_name PlayerShip
extends Node2D

@onready var death_flash_component := %DeathFlashComponent as FlashComponent
@onready var hit_flash_component := %HitFlashComponent as FlashComponent
@onready var hit_shake_component := %HitShakeComponent as ShakeComponent
@onready var hurtbox_component := %HurtboxComponent as HurtboxComponent
@onready var input_component := %InputComponent as InputComponent
@onready var move_component := %MoveComponent as MoveComponent
@onready var spawner_component := %SpawnerComponent as SpawnerComponent
@onready var stats_component := %StatsComponent as StatsComponent
@onready var switch_scene_component: SwitchSceneComponent = %SwitchSceneComponent as SwitchSceneComponent
@onready var flame_animated_sprite: AnimatedSprite2D = %FlameAnimatedSprite
@onready var ship_animated_sprite: AnimatedSprite2D = %ShipAnimatedSprite
@onready var left_cannon: Marker2D = %LeftCannon
@onready var right_cannon: Marker2D = %RightCannon
@onready var fire_rate_timer: Timer = %FireRateTimer

@export var starting_position: Vector2


func _ready() -> void:
	fire_rate_timer.timeout.connect(fire_lasers)
	stats_component.no_health.connect(die)
	hurtbox_component.hurt.connect(hurt)


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
	visible = false
	position = starting_position
	hurtbox_component.is_invincible = true
	move_component.allow_movement = false


func turn_ship_on() -> void:
	await get_tree().create_timer(1.0).timeout
	stats_component.health = stats_component.max_health
	move_component.allow_movement = true
	visible = true
	death_flash_component.flash()
	fire_rate_timer.timeout.connect(fire_lasers)
	await get_tree().create_timer(1).timeout
	hurtbox_component.is_invincible = false


func hurt(_hitbox: HitboxComponent):
	hit_flash_component.flash()
	hit_shake_component.tween_shake()


func die() -> void:
	turn_ship_off()
	
	if stats_component.lives <= 0:
		end_game()
	else:
		turn_ship_on()


func end_game() -> void:
	await get_tree().create_timer(1.0).timeout
	switch_scene_component.switch_scene()
