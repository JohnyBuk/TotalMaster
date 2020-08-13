extends Node2D

var speed = 100

func move(velocity: Vector2):
	var collision = $Head.move_and_collide(velocity)
	$AnimatedSprite.position = $Head.position 
	$Body.position = $Head.position 
	print(speed)

func _physics_process(delta):
	var player_direction = get_node("../Player/Body").global_position -  $Head.global_position
	var velocity = player_direction.normalized()
	z_index = -player_direction.y
	move(velocity * delta * speed)
