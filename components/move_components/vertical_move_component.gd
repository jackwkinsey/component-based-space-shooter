## This component allows for the provided actor to moved vertically by a velocity.
class_name VerticalMoveComponent
extends MoveComponent


func _process(delta: float) -> void:
	actor.translate(input.vertical_direction * move_stats.speed * delta)
