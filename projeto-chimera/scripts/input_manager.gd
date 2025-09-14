extends Node2D

signal left_mouse_button_click
signal left_mouse_button_released

const COLLISION_MASK_CARD = 1
const COLISSION_MASK_DECK = 4
var referencia_card_manager
var referencia_deck

func _ready() -> void:
	referencia_card_manager = $"../cardmanager"
	referencia_deck = $"../Deck"

func _input(event) :
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			emit_signal("left_mouse_button_click")
			raycast_at_cursor()
		else:
			emit_signal("left_mouse_button_released")
			
func  raycast_at_cursor():
	var space_state = get_world_2d().direct_space_state
	var parametros = PhysicsPointQueryParameters2D.new()
	parametros.position =get_viewport().get_mouse_position()
	parametros.collide_with_areas = true
	var resultado = space_state.intersect_point(parametros)
	if resultado.size() > 0   :
		var result_collision_mask = resultado[0].collider.collision_mask
		match result_collision_mask:
			COLLISION_MASK_CARD:
				var carta_found = resultado[0].collider.get_parent()
				if carta_found:
					referencia_card_manager.start_draf(carta_found)
			COLISSION_MASK_DECK:
				referencia_deck.desenhar_carta()
