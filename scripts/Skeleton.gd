extends KinematicBody2D

export var speed = 5 

func _physics_process(delta):
	var player_direction = get_node("../Player").position - position
	var velocity = player_direction.normalized()
	move_and_collide(velocity * speed)
	z_index = -player_direction.y
