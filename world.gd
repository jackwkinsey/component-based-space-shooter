extends Node2D

@onready var player_ship: Node2D = $PlayerShip
@onready var switch_scene_component: SwitchSceneComponent = $SwitchSceneComponent as SwitchSceneComponent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_ship.tree_exiting.connect(func():
		await get_tree().create_timer(1.0).timeout
		switch_scene_component.switch_scene()
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
