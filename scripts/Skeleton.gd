extends KinematicBody2D

export var speed = 5 

func _physics_process(delta):
	var velocity = (get_node("../Player").position - position).normalized()
	move_and_collide(velocity * speed)
