extends Area2D

export var speed = 400 
var screen_size  
var last_velocity = Vector2(0, 1)


func _ready():
	screen_size = get_viewport_rect().size


func choose_animation(velocity: Vector2):
	velocity = velocity.normalized()
	var a = sqrt(2)/2

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
	var result
	
	if velocity.length_squared() > 0:
		last_velocity = velocity
		result = choose_animation(last_velocity)
		animation_name = result[0] + "_walk"
		
	else:
		result = choose_animation(last_velocity)
		animation_name = result[0] + "_idle"

	$AnimatedSprite.play(animation_name)
	$AnimatedSprite.flip_h = result[1]


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


func _process(delta):
	var velocity = get_input()

	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	animates_player(velocity)



