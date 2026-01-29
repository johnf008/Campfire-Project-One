extends Control

@export var instructions: Label


func _on_area_2d_body_entered(body: Node2D) -> void:
	instructions.text = "Press 'enter' to fish"


func _on_area_2d_body_exited(body: Node2D) -> void:
	instructions.text = ""
