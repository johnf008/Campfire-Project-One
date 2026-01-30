extends CharacterBody2D

signal startBar()
signal six_seven()

const MAX_SPEED = 100
var last_direction := Vector2(1,0)
var fishing_ability = false
var running_the_bar = false
@export var event_bar: TextureRect

var wait_for_me = 0

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
	if is_in_group("player_and_lake") and wait_for_me != 0:
		fishing_ability = true
		six_seven.emit()
		
		
		#i wanna emit something to the event bar that says yo i want to start the thing
		
		
		
	wait_for_me += 1
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("accept") and fishing_ability and not running_the_bar:
			print("Broooo did you do it?")
			
			running_the_bar = true
			
			startBar.emit()
			event_bar.visible = true
func _on_area_2d_body_exited(body: Node2D) -> void:
	fishing_ability = false
	event_bar.visible = false
	running_the_bar = false
	
