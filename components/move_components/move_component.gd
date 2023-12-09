## This component allows for the provided actor to moved by a velocity.
class_name MoveComponent
extends Node

## The actor to move. Must be a Node2D or inherit from Node2D!
@export var actor: Node2D
## The movement stats used for moving the actor.
@export var move_stats: MoveStats
## The input component to get the movement direction from.
@export var input: InputComponent
## The direction to move the actor in (only used if no Input Component is provided)
@export var direction: Vector2

var allow_movement: bool


func _ready() -> void:
	allow_movement = true


func _process(delta: float) -> void:
	if not allow_movement:
		return
	
	if (input != null):
		actor.translate(input.direction * move_stats.speed * delta)
	else:
		actor.translate(direction * move_stats.speed * delta)
