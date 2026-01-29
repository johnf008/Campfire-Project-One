extends Control

@export var instructions: Label

var descriptive_var = false; 

func _on_area_2d_body_entered(body: Node2D) -> void:
	if descriptive_var:
		instructions.text = "Press 'enter' to fish"


func _on_area_2d_body_exited(body: Node2D) -> void:
	instructions.text = ""


func _on_character_body_2d_six_seven() -> void:
	descriptive_var = true;
