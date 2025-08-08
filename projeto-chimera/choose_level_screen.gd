extends Node2D

@onready var button: Button = %Button
@onready var button_2: Button = %Button2
@onready var button_3: Button = %Button3
@onready var button_4: Button = %Button4
@onready var voltar_btn: Button = $voltar
@onready var lvl_1_locked: ColorRect = $lvl1_locked
@onready var lvl_2_locked: ColorRect = $lvl2_locked
@onready var lvl_3_locked: ColorRect = $lvl3_locked
@onready var lvl_4_locked: ColorRect = $lvl4_locked
@onready var cadeado: Sprite2D = $Cadeado
@onready var cadeado_2: Sprite2D = $Cadeado2
@onready var cadeado_3: Sprite2D = $Cadeado3

func _on_voltar_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://title_screen.tscn")
	
func _ready() -> void:
	button.grab_focus()
	
	# FASE 1
	if Levelcore.lvl1_unlocked == true:
		lvl_1_locked.visible = false
		cadeado.visible = false
	if Levelcore.lvl1_unlocked == false:
		lvl_1_locked.visible = true
		cadeado.visible = true
	
	# FASE 2
	if Levelcore.lvl2_unlocked == true:
		lvl_2_locked.visible = false
		cadeado_2.visible = false
	if Levelcore.lvl2_unlocked == false:
		lvl_2_locked.visible = true
		cadeado_2.visible = true
		
	# FASE 3
	if Levelcore.lvl3_unlocked == true:
		lvl_3_locked.visible = false
		cadeado_3.visible = false
	if Levelcore.lvl3_unlocked == false:
		lvl_3_locked.visible = true
		cadeado_3.visible = true
		
	# FASE 4
	if Levelcore.lvl4_unlocked == true:
		lvl_4_locked.visible = false
	if Levelcore.lvl1_unlocked == false:
		lvl_4_locked.visible = true


func _on_button_pressed() -> void:
	if Levelcore.lvl1_unlocked == false:
		get_tree().change_scene_to_file("res://level_one.tscn")
	else:
		get_tree().change_scene_to_file("res://level_one.tscn")


func _on_button_2_pressed() -> void:
	if Levelcore.lvl1_unlocked == false:
		null
	if Levelcore.lvl1_unlocked == true:
		get_tree().change_scene_to_file("res://level_two.tscn")

func _on_button_3_pressed() -> void:
	if Levelcore.lvl2_unlocked == false:
		null
	if Levelcore.lvl2_unlocked == true:
		get_tree().change_scene_to_file("res://level_three.tscn")
		

func _on_button_4_pressed() -> void:
	if Levelcore.lvl3_unlocked == false:
		null
	if Levelcore.lvl3_unlocked == true:
		get_tree().change_scene_to_file("res://level_four.tscn")
