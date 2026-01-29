extends Node2D

@export var event_bar: TextureRect

var cooldown = false

func _on_event_bar_fail() -> void:
	print("Bro you failed")
	_reset()
	cooldown = false

func _on_event_bar_green_done() -> void:
	print("Did it land on green?")
	_reset()
	cooldown = false

func _on_event_bar_orange_done() -> void:
	print("Did it land on orange?")
	_reset()
	cooldown = false

func _on_event_bar_regular_done() -> void:
	print("Did it land on regular")
	_reset()
	cooldown = false
	
func _reset():
	if cooldown == true:
		await get_tree().create_timer(1).timeout
		event_bar.reset()


func _on_event_bar_cooldown() -> void:
	cooldown = true
