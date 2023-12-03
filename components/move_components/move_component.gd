## This component allows for the provided actor to moved by a velocity.
class_name MoveComponent
extends Node


## The actor to move. Must be a Node2D or inherit from Node2D!
@export var actor: Node2D

## The movement stats used for moving the actor.
@export var move_stats: MoveStats

## The input component to get the movement direction from.
@export var input: InputComponent


func _process(delta: float) -> void:
	actor.translate(input.direction * move_stats.speed * delta)
