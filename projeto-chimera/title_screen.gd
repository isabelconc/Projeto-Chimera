extends Control


func _on_comecar_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://choose_level_screen.tscn")

func _on_creditos_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://credits_screen.tscn")


func _on_sair_btn_pressed() -> void:
	get_tree().quit()
