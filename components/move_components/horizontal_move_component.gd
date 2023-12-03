## This component allows for the provided actor to moved horizontally by a velocity.
class_name HorizontalMoveComponent
extends MoveComponent


func _process(delta: float) -> void:
	actor.translate(input.horizontal_direction * move_stats.speed * delta)
