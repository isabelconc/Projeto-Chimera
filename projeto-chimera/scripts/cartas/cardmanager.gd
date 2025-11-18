extends Node2D 

const COLLISION_MASK_CARD = 1 
const COLISSION_MASK_SLOT = 2 
const DEFAULT_CARD_SCALE = 1.086
const CARD_BIGGER_SCALE = 1.100
var card_being_dragged 
var screen_size 
var is_hovering_on_card 
var refenrencia_de_mao 

func _ready() -> void:
	screen_size = get_viewport_rect().size 
	refenrencia_de_mao =  get_parent().get_node("Mao_de_Jogo")
	$"../InputManager".connect("left_mouse_button_released", on_left_click_released)

func _process(_delta: float) -> void: 
	if card_being_dragged: 
		var mouse_pos = get_global_mouse_position() 
		card_being_dragged.position = Vector2( clamp( mouse_pos.x, 0, screen_size.x), clamp(mouse_pos.y,0,screen_size.y)); 
		
func on_left_click_released(): 
	if card_being_dragged: 
		finish_drag() 
		
func start_drag(card): 
	card_being_dragged = card 
	card.scale = Vector2(DEFAULT_CARD_SCALE, DEFAULT_CARD_SCALE) 

func finish_drag():
	if not card_being_dragged:
		return

	card_being_dragged.scale = Vector2(DEFAULT_CARD_SCALE, DEFAULT_CARD_SCALE)

	var card_slot_found = raycast_check_for_card()
	if card_slot_found:
		print("finish_drag: colocando", card_being_dragged.name, "no slot", card_slot_found.name)
		refenrencia_de_mao.remover_carta(card_being_dragged)
		
		var offset = Vector2(0,0)
		if card_slot_found.cartas_no_slot.size() == 0:
			offset = Vector2(-20, 0)  
		elif card_slot_found.cartas_no_slot.size() == 1:
			offset = Vector2(20, 0)   

		card_being_dragged.position = card_slot_found.position + offset
		card_being_dragged.get_node("Area2D/CollisionShape2D").disabled = true

		card_slot_found.place_card(card_being_dragged)
	else:
		print("finish_drag: retornando para mão:", card_being_dragged.name)
		refenrencia_de_mao.add_carta_para_mao(card_being_dragged)

	card_being_dragged = null


		
func raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var parametros = PhysicsPointQueryParameters2D.new()
	parametros.position = get_viewport().get_mouse_position()
	parametros.collide_with_areas = true
	parametros.collision_mask = COLISSION_MASK_SLOT

	var resultado = space_state.intersect_point(parametros)
	if resultado.size() == 0:
		return null

	var node = resultado[0].collider
	while node:
		if node is CardSlot:
			return node
		node = node.get_parent()
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
	if !card_being_dragged: higlight(carta,false) 
	var new_card_hovered = raycast_check_for_card() 
	if new_card_hovered: 
		higlight(new_card_hovered, true) 
	else: 
		is_hovering_on_card=false 
		
func higlight(carta, hovered): 
	if hovered: 
		carta.scale = Vector2(CARD_BIGGER_SCALE, CARD_BIGGER_SCALE) 
		carta.z_index= 2 
	else: 
		carta.scale = Vector2(DEFAULT_CARD_SCALE, DEFAULT_CARD_SCALE) 
		carta.z_index= 1 
		pass
