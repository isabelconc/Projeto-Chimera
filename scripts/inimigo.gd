extends Node2D

var damage_amount := 50  

func attack_player():
	print("Inimigo atacou! Causou", damage_amount, "de dano.")
	
	var game_ref = get_node("../")  
	game_ref.damage_player(damage_amount)
