extends Node2D

@export var event_bar: TextureRect

signal startAgain()

func _on_event_bar_fail() -> void:
	print("Bro you failed")
	_reset()

func _on_event_bar_green_done() -> void:
	print("Did it land on green?")
	_reset()

func _on_event_bar_orange_done() -> void:
	print("Did it land on orange?")
	_reset()

func _on_event_bar_regular_done() -> void:
	print("Did it land on regular")
	_reset()
	
func _reset():
		await get_tree().create_timer(1).timeout
		event_bar.reset()
		
		#i need something here that tells the game yo we're ready for another input
		startAgain.emit()
