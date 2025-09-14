extends Node2D

const CARD_SCENE_PATH = "res://cenas/cartas/carta.tscn"
var deck = ["3Geo", "2Geo"]

func desenhar_carta():
	var carta_desenhada = deck[0]
	deck.erase(carta_desenhada)
	
	if deck.size() == 0:
		get_node('Area2D/CollisionShape2D').disabled = true
		get_node('Sprite2D').visible = false
	
	var card_scene = preload(CARD_SCENE_PATH)
	var nova_carta = card_scene.instantiate()
	$"../cardmanager".add_child(nova_carta)
	nova_carta.name = "Card"
	$"../Mao_de_Jogo".add_carta_para_mao(nova_carta)
