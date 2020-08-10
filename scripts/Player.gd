extends KinematicBody2D

export var speed = 400 
var last_velocity = Vector2(0, 1)


func _ready():
	screen_size = get_viewport_rect().size


func choose_animation(velocity: Vector2):
	velocity = velocity.normalized()
	var a = sin(PI/4)

	if velocity.y >= a:
		return ["down", false]
	elif velocity.y <= -a:
		return ["up", false]
	elif velocity.x <= -a:
		return ["left", false]
	elif velocity.x >= a:
		return ["left", true]
	return ["down", false]


func animates_player(velocity: Vector2):
	var animation_name
	
	if velocity.length_squared() > 0:
		last_velocity = velocity
		animation_name = "walk_"
		
	else:
		animation_name = "idle_"
		
	var animation = choose_animation(last_velocity)

	$AnimatedSprite.play(animation_name + animation[0])
	$AnimatedSprite.flip_h = animation[1]


func get_input():
	var velocity = Vector2()

	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	
	return velocity.normalized() * speed

	
func _physics_process(delta):
	var velocity = get_input()
	animates_player(velocity)
	move_and_collide(velocity * delta)
