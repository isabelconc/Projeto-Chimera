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
		"asgeo": valor_base = 1 
		"2geo": valor_base = 2 
		"3geo": valor_base = 3 
		"4geo": valor_base = 4 
		"5geo": valor_base = 5 
		"6geo": valor_base = 6 
		"7geo": valor_base = 7 
		"8geo": valor_base = 8 
		"9geo": valor_base = 9 
		"10geo": valor_base = 10
		"jgeo": valor_base = 10 
		"qgeo": valor_base = 10 
		"kgeo": valor_base = 10 

		
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
