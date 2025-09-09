extends Node2D

var card_being_dragged
func _process(delta: float) -> void:
	if card_being_dragged:
		var mouse_pos = get_global_mouse_position()
		card_being_dragged.position = mouse_pos
		
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
	parametros.collision_mask=1
	var resultado = space_state.intersect_point(parametros)
	print(resultado)
	if resultado.size() > 0   :
		return resultado[0].collider.get_parent()
	return null
