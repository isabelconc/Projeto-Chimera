extends Node2D

var COLLISION_MASK_CARD = 1
var card_being_dragged 
var screen_size
func _ready() -> void:
	screen_size = get_viewport_rect().size
	
func _process(delta: float) -> void:
	if card_being_dragged:
		var mouse_pos = get_global_mouse_position()
		card_being_dragged.position = Vector2( clamp( mouse_pos.x, 0, screen_size.x),
		clamp(mouse_pos.y,0,screen_size.y));
		
func _input(event) :
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var card = raycast_check_for_card()
			if card:
				card_being_dragged = card
		else:
			card_being_dragged = null
			
func  raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var parametros = PhysicsPointQueryParameters2D.new()
	parametros.position =get_viewport().get_mouse_position()
	parametros.collide_with_areas = true
	parametros.collision_mask= COLLISION_MASK_CARD
	var resultado = space_state.intersect_point(parametros)
	if resultado.size() > 0   :
		return resultado[0].collider.get_parent()
	return null

func connect_carta_signals(carta):
	carta.connect("hovered", on_hovered_over_carta)
	carta.connect("hovered_off", on_hovered_off_carta)

func on_hovered_over_carta (carta):
	carta_highlight(carta1,false)	
	
func on_hovered_off_carta (carta):
	carta_highlight(carta1, true)	

func carta_highlight (carta):
	if hovered:
		carta.scale(Vector2(1.05,1.05))
		carta.z_index = 2
	else :
		carta.scale(Vector2(1,1))
		carta.z_index = 1
