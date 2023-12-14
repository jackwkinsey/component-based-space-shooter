class_name LivesContainer
extends MarginContainer

@export var player_ship: PlayerShip
@onready var label: Label = $HBoxContainer/Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_lives_remaining()
	player_ship.stats_component.lives_changed.connect(set_lives_remaining)


func set_lives_remaining() -> void:
	label.text = "x" + str(player_ship.stats_component.lives)
