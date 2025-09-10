extends Node2D

@onready var teste: Button = $teste
@onready var deck = ["" ]

func _on_teste_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/choose_level_screen.tscn")
	Levelcore.lvl1_unlocked = true
