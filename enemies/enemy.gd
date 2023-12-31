class_name Enemy
extends Node2D

@onready var move_component: MoveComponent = $MoveComponent as MoveComponent
@onready var stats_component: StatsComponent = $StatsComponent as StatsComponent
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var scale_component: ScaleComponent = $ScaleComponent as ScaleComponent
@onready var flash_component: FlashComponent = $FlashComponent as FlashComponent
@onready var shake_component: ShakeComponent = $ShakeComponent as ShakeComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent as HurtboxComponent
@onready var hitbox_component: HitboxComponent = $HitboxComponent as HitboxComponent
@onready var spawner_component: SpawnerComponent = $SpawnerComponent as SpawnerComponent
@onready var destroyed_component: DestroyedComponent = $DestroyedComponent as DestroyedComponent


func _ready() -> void:
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)
	hurtbox_component.hurt.connect(hurt)
	hitbox_component.hit_hurtbox.connect(destroyed_component.destroy.unbind(1))
	stats_component.no_lives.connect(queue_free)


func hurt(_hitbox: HitboxComponent):
	scale_component.tween_scale()
	flash_component.flash()
	shake_component.tween_shake()
