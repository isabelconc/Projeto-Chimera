extends Node2D

var mao_player = []
var centro_tela_x
const CARD_WIDTH = 125
const MAO_Y_POSITION = 575

func _ready() -> void:
	centro_tela_x = get_viewport().size.x / 2
		
func add_carta_para_mao(carta):
	if carta not in mao_player:
		mao_player.insert(0, carta)
		update_pos_mao()
	else:
		animar_carta_para_position(carta, carta.position_mao)
	
func update_pos_mao():
	for i in range(mao_player.size()):
		var new_position = Vector2(calcular_pos_carta(i), MAO_Y_POSITION)
		var carta = mao_player[i]
		carta.position_mao = new_position
		animar_carta_para_position(carta, new_position)
		
func animar_carta_para_position(carta, position):
	var tween = get_tree().create_tween()
	tween.tween_property(carta, "position", position, 0.16)

func calcular_pos_carta(index):
	var total_width = (mao_player.size() - 1) * CARD_WIDTH
	var x_offset = centro_tela_x + index * CARD_WIDTH - total_width /2 
	return x_offset

func remover_carta(carta):
	if carta in mao_player:
		mao_player.erase(carta)
		update_pos_mao()
