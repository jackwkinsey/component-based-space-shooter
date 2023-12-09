class_name SwitchSceneComponent
extends Node

## The scene to switch to
@export var scene: String
## Optional input component to listen for UI Accept button press
@export var input_component: InputComponent


func _ready() -> void:
	if input_component != null:
		input_component.ui_accept_pressed.connect(switch_scene)


func switch_scene() -> void:
	get_tree().change_scene_to_file(scene)
