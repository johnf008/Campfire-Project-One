extends CharacterBody2D

const MAX_SPEED = 100
var last_direction := Vector2(1,0)

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * MAX_SPEED
	
	move_and_slide()
	
	if direction.length() > 0:
		last_direction = direction
