extends Node2D

@onready var game_over: Node2D = $"."
@onready var tentarnovamente : Button = $tentarnovamente
@onready var voltarmenu : Button = $voltarmenu

func _on_tentarnovamente_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/level_one.tscn")


func _on_voltarmenu_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/title_screen.tscn")
