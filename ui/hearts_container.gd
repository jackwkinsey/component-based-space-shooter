class_name HeartsContainer
extends MarginContainer

@export var player_ship: PlayerShip
@onready var heart_scene = preload("res://ui/heart.tscn")
@onready var h_box_container: HBoxContainer = $HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_max_hearts(player_ship.stats_component.max_health)
	player_ship.stats_component.health_changed.connect(update_hearts)


func set_max_hearts(max_hearts: int) -> void:
	for i in range(max_hearts):
		var heart = heart_scene.instantiate()
		h_box_container.add_child(heart)


func update_hearts() -> void:
	var hearts = h_box_container.get_children()
	var player_health = player_ship.stats_component.health
	
	for i in range(player_health):
		(hearts[i] as Heart).update(true)
	
	for i in range(player_health, hearts.size()):
		(hearts[i] as Heart).update(false)
