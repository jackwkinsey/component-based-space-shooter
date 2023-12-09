## Stats for the connected actor
class_name StatsComponent
extends Node

## The connected actor's health
@export var health: int = 1:
	set(value):
		health = value
		
		# Signal out that the health has changed
		health_changed.emit()
		
		# Signal out when health is at 0
		if health == 0: no_health.emit()


## The connected actor's number of lives
@export var lives: int = 1:
	set(value):
		lives = value
		
		# Signal out that the number of lives has changed
		lives_changed.emit()
		
		# Signal out when no lives are left
		if lives == 0: no_lives.emit()


## The maximum health of the actor
@export var max_health: int = 1


# Create our signals for health
signal health_changed() # Emit when the health value has changed
signal no_health() # Emit when there is no health left
signal lives_changed()
signal no_lives()
