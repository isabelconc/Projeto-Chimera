extends Node2D

const CARD_SCENE_PATH = "res://cenas/cartas/cartaFunc.tscn"
var deck = ["asfunc", "2func", "3func", "4func", "5func", "6func", "7func", "8func", "9func", "10func", "kfunc", "qfunc", "jfunc", "qfunc"]
var card_database_reference 

func _ready() -> void:
	card_database_reference = preload("res://scripts/CardDatabase.gd")
	deck.shuffle()
	
func desenhar_carta():
	var carta_desenhada = deck[0]
	deck.erase(carta_desenhada)
	
	if deck.size() == 0:
		get_node('Area2D/CollisionShape2D').disabled = true
		get_node('Sprite2D').visible = false
	
	var card_scene = preload(CARD_SCENE_PATH)
	
	var nova_carta = card_scene.instantiate()
	nova_carta.card_name = carta_desenhada 
	var card_image_path = str("res://assets/joguinho-main/deckfunc/" + carta_desenhada + ".png")
	nova_carta.get_node("CardImage").texture = load(card_image_path)
	$"../cardmanager".add_child(nova_carta)
	$"../Mao_de_Jogo".add_carta_para_mao(nova_carta)
	
	get_tree().current_scene.check_no_moves_left()
