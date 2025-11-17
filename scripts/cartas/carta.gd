extends Node2D 

class_name Card 
signal hovered 
signal hovered_off 
signal card_selected(card)

@export var attack_value: int = 0 
@export var card_name: String = ""
var selected = false 
var position_mao 
var valor_base := 0 

func _ready() -> void: 
	print("DEBUG:", name, "tem card_name =", card_name)
	match card_name: 
		"asArit": valor_base = 1 
		"2Arit": valor_base = 2 
		"3Arit": valor_base = 3 
		"4Arit": valor_base = 4 
		"5Arit": valor_base = 5 
		"6Arit": valor_base = 6 
		"7Arit": valor_base = 7 
		"8Arit": valor_base = 8 
		"9Arit": valor_base = 9 
		"10Arit": valor_base = 10 
		
	get_parent().connect_carta_signals(self)

func _on_area_2d_mouse_entered() -> void: 
	emit_signal("hovered", self) 
	
func _on_area_2d_mouse_exited() -> void: 
	emit_signal("hovered_off", self) 
	
func _input_event(viewport, event, shape_idx): 
	if event is InputEventMouseButton and event.pressed: selected = !selected 
	if selected: 
		modulate = Color(1, 0.9, 0.7) 
		emit_signal("card_selected", self) 
	else: 
		modulate = Color(1, 1, 1)
