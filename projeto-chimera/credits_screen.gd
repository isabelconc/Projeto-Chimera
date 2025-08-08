extends Node2D

@onready var credits_screen: Node2D = $"."
@onready var voltar_btn: Button = $voltar_btn


func _on_voltar_btn_2_pressed() -> void:
	get_tree().change_scene_to_file("res://title_screen.tscn")
