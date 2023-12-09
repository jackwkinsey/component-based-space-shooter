## Gets input from player.
class_name InputComponent
extends Node

## The overall directional input from the player.
var direction: Vector2


func _input(event: InputEvent) -> void:
	direction.x = Input.get_axis("left", "right")
	if event.is_action_pressed("ui_accept"):
		ui_accept_pressed.emit()


signal ui_accept_pressed
