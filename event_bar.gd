extends TextureRect

signal regular_done()
signal green_done()
signal orange_done()
signal fail()
signal cooldown()

@export var duration: float = 1.0

@onready var indicator: TextureRect = $Indicator
@onready var cooldown_timer: Timer = $"Cooldown Timer"

var x_end_position: float
var green_range_x = Vector2(9,17)
var orange_range_x = Vector2(35, 46)

var ready_for_input = true

func _ready() -> void:
	x_end_position = global_position.x - (indicator.size.x) / 2
	print("Bar size: ", size)
	print("Indicator size: ", indicator.size)
	start()

func start():
	var end_center_offset = Vector2(size.x, size.y / 2)
	var indicator_ceter_off_set = indicator.size / 2
	
	indicator.position = end_center_offset - indicator_ceter_off_set

func _process(delta: float) -> void:
	indicator.position.x -= size.x / duration * delta
	
	if indicator.position.x < -indicator.size.x / 2:
		_finish(true)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept") and ready_for_input:
		_finish()
		ready_for_input = false

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
