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

func _ready():
	# Chama o comportamento base do Card (importante!)
	# Agora sobrescreve os valores APENAS para probabilidade
	match card_name:
		"asprob": valor_base = 1
		"2prob": valor_base = 2
		"3prob": valor_base = 3
		"4prob": valor_base = 4
		"5prob": valor_base = 5
		"6prob": valor_base = 6
		"7prob": valor_base = 7
		"8prob": valor_base = 8
		"9prob": valor_base = 9
		"10prob": valor_base = 10
		"jprob": valor_base = 10
		"qprob": valor_base = 10
		"kprob": valor_base = 10
		
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
