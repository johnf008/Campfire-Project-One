extends TextureRect

signal regular_done()
signal green_done()
signal orange_done()
signal fail()

@export var duration: float = 1.0

@onready var indicator: TextureRect = $Indicator
@export var event_bar: TextureRect


var x_end_position: float
var green_range_x = Vector2(9,17)
var orange_range_x = Vector2(35, 46)

var ready_for_check = false
var ready_for_input = true
var first_time = true

var touching_water = false
var trigger_fishing = false

func _ready() -> void:
	x_end_position = global_position.x - (indicator.size.x) / 2
	print("Bar size: ", size)
	print("Indicator size: ", indicator.size)
	set_process(false)
	

func start():
	#okay so i figured out that the error had to do with the indicators
	#position already starting at the end making the trigger play so i need the trigger 
	#to start at the beginning
	
	var end_center_offset = Vector2(size.x, size.y / 2)
	var indicator_ceter_off_set = indicator.size / 2
	
	indicator.position = end_center_offset - indicator_ceter_off_set
	
	
	print("Bro have you started")
func _process(delta: float) -> void:
	
	indicator.position.x -= size.x / duration * delta
	
	if indicator.position.x < -indicator.size.x / 2:
		_finish(true)

func _input(_event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("accept") and ready_for_input and trigger_fishing:
		_finish()
		ready_for_input = false
		print("six")
		
	if Input.is_action_just_pressed("accept") and touching_water and !is_processing():
			trigger_fishing = true
			event_bar.visible = true
			event_bar.visible = true
			set_process(true)
			print("seven")
	

func _finish(normalDone = false):
	set_process(false)
	
	if normalDone:
		regular_done.emit()
		return
	var in_orange_range = _in_range(orange_range_x)
	var in_green_range = _in_range(green_range_x)
		
	if in_orange_range:
		orange_done.emit()
	elif in_green_range:
		green_done.emit()
	else:
		fail.emit()

	
	#set_process(true)
	#start()
		
	
	
	
	
func _in_range(event_range: Vector2):
	var indicator_position = indicator.position.x + indicator.size.x / 2
	
	if indicator_position >= event_range.x and indicator_position <= event_range.y:
		return true
	else:
		return false
	
func reset():
	start()
	set_process(true)
		


func _on_game_start_again() -> void:
	ready_for_input = true


func _on_character_body_2d_start_bar() -> void:
	
	start()
	set_process(true)


func _on_character_body_2d_six_seven() -> void:
	touching_water = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	touching_water = false
