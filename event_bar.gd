extends TextureRect

signal regular_done()
signal green_done()
signal orange_done()
signal fail()

@export var duration: float = 1.0

@onready var indicator: TextureRect = $Indicator

var x_end_position: float
var green_range_x = Vector2(8,13)
var orange_range_x = Vector2(28, 36)

func _ready() -> void:
	x_end_position = global_position.x - (indicator.size.x * scale.x) / 2
	print("Bar size: ", size)
	print("Indicator size: ", indicator.size)
	start()

func start():
	var end_center_offset = Vector2((size.x * scale.x), (size.y * scale.y) / 2)
	var indicator_ceter_off_set = indicator.size / 2
	
	indicator.global_position = global_position + end_center_offset - indicator_ceter_off_set

func _process(delta: float) -> void:
	indicator.global_position.x -= (size.x * scale.x) / duration * delta
	
	if indicator.global_position.x < x_end_position:
		_finish(true)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		_finish()

func _finish(normalDone = false):
	set_process(false)
	
	if normalDone:
		green_done.emit()
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
	var indicator_position = indicator.global_position.x + (indicator.size.x * scale.x) / 2 - global_position.x
	
	if indicator_position >= event_range.x and indicator_position <= event_range.y:
		return true
	else:
		return false
	
func reset():
	start()
	set_process(true)
		
