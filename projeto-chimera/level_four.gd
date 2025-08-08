extends Node2D

@onready var teste: Button = $teste

func _on_teste_pressed() -> void:
	get_tree().change_scene_to_file("res://choose_level_screen.tscn")
	Levelcore.lvl4_unlocked = true
