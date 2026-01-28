extends CharacterBody2D

const MAX_SPEED = 100
var last_direction := Vector2(1,0)
var fishing_ability = false
func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * MAX_SPEED
	
	if direction.length() > 0:
		last_direction = direction
	
	if direction.x == -1.0:
		%AnimationPlayer.play("walk_left")
	elif direction.x == 1.0:
		%AnimationPlayer.play("walk_right")
	elif direction.y == -1.0:
		%AnimationPlayer.play("walk_back")
	elif direction.y == 1.0:
		%AnimationPlayer.play("walk_forward")
	elif direction.x ==0 and direction.y == 0:
		%AnimationPlayer.play("forward_idle")

		
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_in_group("player_and_lake"):
		print("You can fish rn")
		fishing_ability = true
	print(body)

func _on_area_2d_body_exited(body: Node2D) -> void:
	print("You can't fish rn")
	fishing_ability = false
