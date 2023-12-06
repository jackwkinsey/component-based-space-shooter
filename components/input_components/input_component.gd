## Gets input from player.
class_name InputComponent
extends Node


## The overall directional input from the player.
var direction: Vector2


func _input(_event: InputEvent) -> void:
	direction.x = Input.get_axis("left", "right")
