extends Node2D

@onready var ko_screen: Node2D = $"."
@onready var again : Button = $again
@onready var novafase : Button = $novafase

	

func _on_again_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/level_one.tscn")


func _on_novafase_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/choose_level_screen.tscn")
	Levelcore.lvl1_unlocked = true
	
	
