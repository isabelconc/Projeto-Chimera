extends Node2D

const COLLISION_MASK_CARD = 1
const COLISSION_MASK_SLOT = 2
var card_being_dragged 
var screen_size
var is_hovering_on_card
var refenrencia_de_mao

func _ready() -> void:
	screen_size = get_viewport_rect().size
	refenrencia_de_mao = $"../Mao_de_Jogo"
	$"../InputManager".connect("left_mouse_button_released", on_left_click_released)
	
func _process(_delta: float) -> void:
	if card_being_dragged:
		var mouse_pos = get_global_mouse_position()
		card_being_dragged.position = Vector2( clamp( mouse_pos.x, 0, screen_size.x),
		clamp(mouse_pos.y,0,screen_size.y));
		
		
func on_left_click_released():
			if card_being_dragged:
				finish_drag()

func start_drag(card):
	card_being_dragged = card
	card.scale = Vector2(1, 1)
	
func finish_drag():
	card_being_dragged.scale = Vector2(1.05, 1.05)
	var card_slot_found = raycast_check_for_card()
	if card_slot_found and not card_slot_found.card_placed:
		refenrencia_de_mao.remover_carta(card_being_dragged)
		card_being_dragged.position = card_slot_found.position
		card_being_dragged.get_node("Area2D/CollisionShape2D").disabled = true
		
		card_slot_found.place_card(card_being_dragged)  # 👈 chama método do slot
		
		card_slot_found.card_placed = true
		card_slot_found.current_card = card_being_dragged   # 👈 guarda a carta no slot
		
		print("Carta posicionada no slot:", card_being_dragged.name)
	else:
		refenrencia_de_mao.add_carta_para_mao(card_being_dragged)
	card_being_dragged = null



	

#func  raycast_check_for_card():
#	var space_state = get_world_2d().direct_space_state
#	var parametros = PhysicsPointQueryParameters2D.new()
#	parametros.position =get_viewport().get_mouse_position()
#	parametros.collide_with_areas = true
#	parametros.collision_mask= COLLISION_MASK_CARD
#	var resultado = space_state.intersect_point(parametros)
#	if resultado.size() > 0   :
#		return get_card_with_highest_z_index(resultado)
#	return null

func raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var parametros = PhysicsPointQueryParameters2D.new()
	parametros.position = get_viewport().get_mouse_position()
	parametros.collide_with_areas = true
	parametros.collision_mask = COLISSION_MASK_SLOT
	
	var resultado = space_state.intersect_point(parametros)
	if resultado.size() > 0:
		# O raycast atinge o Area2D, então vamos subir até o Node2D (CardSlot)
		var node = resultado[0].collider
		while node and not (node is CardSlot):
			node = node.get_parent()
		return node
	return null



	
func get_card_with_highest_z_index(cards):
	var highest_z_card = cards[0].collider.get_parent()
	var highest_z_index = highest_z_card.z_index
	
	for i in range(1, cards.size()):
		var current_card = cards[1].collider.get_parent()
		if current_card.z_index > highest_z_index:
			highest_z_card = current_card
			highest_z_index = current_card.z_index
			
	return highest_z_card

func connect_carta_signals(carta):
	carta.connect("hovered", on_hovered_over_carta)
	carta.connect("hovered_off" , on_hovered_off_carta)

func on_hovered_over_carta (carta):
	if !is_hovering_on_card:
		higlight(carta, true)
		is_hovering_on_card = true
	
func on_hovered_off_carta (carta):
	if !card_being_dragged:
		higlight(carta,false)
		var new_card_hovered = raycast_check_for_card()
		if new_card_hovered:
			higlight(new_card_hovered, true)
		else:
			is_hovering_on_card=false
		
func higlight(carta, hovered):
	if hovered:
		carta.scale = Vector2(1.05, 1.05)
		carta.z_index= 2
	else:
		carta.scale = Vector2(1, 1)
		carta.z_index= 1
		pass

# Lista de combinações especiais
var combinacoes = {
	["3 de Copas", "3 de copas"]: 6,
}

# Verifica combinações entre cartas em slots
func check_combinacao(slot):
	var parent = slot.get_parent()
	var slots = parent.get_children()
	
	for s in slots:
		if s != slot and s.card_placed:
			var carta1 = slot.current_card.card_name
			var carta2 = s.current_card.card_name
			var ataque = calcular_combinacao(carta1, carta2)
			
			if ataque > 0:
				print("🔥 Combinação encontrada:", carta1, "+", carta2, "→ Ataque =", ataque)
				aplicar_ataque(ataque)


# Retorna o ataque da combinação (ou 0 se não existir)
func calcular_combinacao(c1: String, c2: String) -> int:
	var chave = [c1, c2]
	var chave_invertida = [c2, c1]
	if combinacoes.has(chave):
		return combinacoes[chave]
	elif combinacoes.has(chave_invertida):
		return combinacoes[chave_invertida]
	return 0


# Aplica o dano no inimigo (exemplo simples)
func aplicar_ataque(valor: int) -> void:
	var inimigo = get_parent().get_node("Inimigo") # ajusta pro seu nó de inimigo
	inimigo.receber_dano(valor)
