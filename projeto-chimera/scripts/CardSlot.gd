extends Node2D 
class_name CardSlot 
var current_card = null 
var previous_card = null 
var card_placed = false 
var multiplicador := 1 
var cartas_no_slot := [] 
var attack_value: int = 0


func place_card(carta):
	print(">> Recebendo carta:", carta.name, "endereço:", carta.get_instance_id())
	cartas_no_slot.append(carta)

	
	
func atualizar_valor():
	if cartas_no_slot.size() < 2:
		print("dano  tem que ser igual ao valor da carta ")
		return


	var dano = combos()
	var cura = 0

	
	var game = get_tree().current_scene

	# Dano no inimigo
	game.damage_enemy(dano)

	# Cura no player, se houver
	if cura > 0:
		game.heal_player(cura)

	var valor_final = dano
	print("Cálculo do ataque: valor final:", valor_final)

	if game.has_node("Inimigo"):
		var enemy = game.get_node("Inimigo")
		enemy.take_damage(dano)
		if enemy.alive:
			enemy.attack_player()

	
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 0.5
	add_child(timer)
	timer.connect("timeout", Callable(self, "limpar_slot"))
	timer.start()

	card_placed = true
	self.attack_value = valor_final 
	$AttackLabel.text = str(valor_final) 
	$AttackLabel.visible = true           
	mostrar_ataque_temporario(valor_final)


func mostrar_ataque_temporario(valor):
	var label = $AttackLabel
	label.text = str(valor)
	label.visible = true

	var tween = get_tree().create_tween()
	tween.tween_property(label, "modulate:a", 0, 0.8).set_delay(1)
	tween.connect("finished", Callable(label, "hide"))

func limpar_slot():
	for carta in cartas_no_slot:
		if carta.is_inside_tree():
			carta.queue_free()  
	cartas_no_slot.clear()
	current_card = null
	previous_card = null
	card_placed = false
	print("Slot limpo e pronto para novas cartas.")


func combos():
	var arr_vb = cartas_no_slot.duplicate()
	arr_vb.sort_custom(func(a, b): return a.valor_base < b.valor_base)
	
	var dano = verificar_dano(arr_vb)
	# ABRIR QUIZ
	# MULTIPLICADOR RECEBE VALOR VINDO DE OUTRA CENA
	var final = dano * multiplicador
	multiplicador  = 1
	print("valor do dano:", dano, " dano_final: ", final)
	return final



func _on_ataque_pressed() -> void:
	var valor_final = combos()
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 0.5
	add_child(timer)
	timer.connect("timeout", Callable(self, "limpar_slot"))
	timer.start()

	card_placed = true
	self.attack_value = valor_final 
	$AttackLabel.text = str(valor_final) 
	$AttackLabel.visible = true           
	mostrar_ataque_temporario(valor_final)
	
func verificar_dano(arr_vb: Array) -> int:
	if arr_vb.size() == 0:
		return 0
		
	var dano = 0
	var multiplicador = 1
	var cont = 0

	while cont < arr_vb.size():
		var carta = arr_vb[cont]
		var valor = carta.valor_base
		
		# soma o valor da carta
		dano += valor

		# cartas especiais
		if carta.card_name in ["jgeo", "qgeo", "kgeo"]:
			multiplicador += 1  # adiciona multiplicador
			# opcional: se você quiser adicionar valor EXTRA, coloque aqui

		# checar se existe próxima carta
		if cont + 1 < arr_vb.size():
			var proxima = arr_vb[cont + 1]

			# se a próxima NÃO for sequência (ex: 5 → 6)
			if proxima.valor_base != valor + 1:
				break
		cont += 1

	return dano * multiplicador
