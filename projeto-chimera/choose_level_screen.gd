extends Node2D

@onready var button: Button = %Button
@onready var button_2: Button = %Button2
@onready var button_3: Button = %Button3
@onready var button_4: Button = %Button4

func _ready() -> void:
	button.grab_focus()
