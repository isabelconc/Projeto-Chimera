extends Node2D
class_name CardSlot  

var current_card = null
var previous_card = null
var card_placed = false

func place_card(carta):
	if current_card:  
		# já tinha carta → guarda como previous
		previous_card = current_card
	
	current_card = carta
	card_placed = true

	# se tiver duas cartas diferentes, dispara combinação
	if previous_card and current_card:
		calcular_combinacao()
		

func calcular_combinacao():
	var c1_val = previous_card.attack_value
	var c2_val = current_card.attack_value
	var ataque = pow(c1_val + c2_val, 2)
	print("🔥 Ataque Hipotenusa =", ataque)
