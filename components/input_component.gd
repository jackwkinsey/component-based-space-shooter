## Gets input from player.
class_name InputComponent
extends Node


## The overall directional input from the player.
var direction: Vector2 = Vector2.ZERO

## The horizontal directional input from the player.
var horizontal_direction: Vector2

## The vertical directional input from the player.
var vertical_direction: Vector2


func _input(event: InputEvent) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	horizontal_direction = Vector2(Input.get_axis("left", "right"), 0)
	vertical_direction = Vector2(0, Input.get_axis("up", "down"))
