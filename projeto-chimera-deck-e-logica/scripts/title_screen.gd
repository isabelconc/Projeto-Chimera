extends Control


func _on_comecar_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/choose_level_screen.tscn")

func _on_creditos_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/credits_screen.tscn")


func _on_sair_btn_pressed() -> void:
	get_tree().quit()
