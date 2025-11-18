extends Node2D
class_name CardSlot
var current_card = null 
var previous_card = null 
var card_placed = false 
var multiplicador := 10 
var cartas_no_slot := [] 
var attack_value: int = 0


func place_card(carta):
	print(">> Recebendo carta:", carta.name, "endereço:", carta.get_instance_id())
	if carta in cartas_no_slot:
		print("place_card: carta já no slot:", carta.name)
		return

	if cartas_no_slot.size() >= 2:
		print("place_card: slot cheio.")
		return

	cartas_no_slot.append(carta)
	if cartas_no_slot.size() == 1:
		current_card = carta
		print("Primeira carta posicionada no slot: ", carta.name)
	else:
		previous_card = carta
		print("Segunda carta posicionada no slot: ", carta.name)

	if cartas_no_slot.size() == 2:
		atualizar_valor()
		
	get_tree().current_scene.check_no_moves_left()


func atualizar_valor():
	if cartas_no_slot.size() < 2:
		return

	var carta1 = cartas_no_slot[0]
	var carta2 = cartas_no_slot[1]

	var dano := 0
	var cura := 0
	var valor_final := 0
	var game = get_tree().current_scene

	if carta1.card_name == "qmar" or carta2.card_name == "qmar":
		var base = (carta1.valor_base + carta2.valor_base) * multiplicador
		dano = base / 2
		cura = base / 2
		valor_final = base

		game.damage_enemy(dano)
		game.heal_player(cura)

		print("Q aplicado: dano =", dano, " cura =", cura)

	elif carta1.card_name == "kmar" or carta2.card_name == "kmar":
		var carta_normal = carta1 if carta1.card_name != "kmar" else carta2
		var base = carta_normal.valor_base

		dano = (base * base) * multiplicador
		valor_final = dano

		game.damage_enemy(dano)

		print("K aplicado: carta =", carta_normal.card_name, " base =", base, " dano =", dano)

	
	elif carta1.card_name == "Jmar" or carta2.card_name == "Jmar":
		game.get_node("Inimigo").next_attack_cancelled = true
		valor_final = 0
		print("J aplicado: próximo ataque inimigo anulado.")

	else:
		valor_final = (carta1.valor_base + carta2.valor_base) * multiplicador
		dano = valor_final

		game.damage_enemy(dano)

		print("Ataque normal:", dano)

	$AttackLabel.text = str(valor_final)
	$AttackLabel.visible = true
	mostrar_ataque_temporario(valor_final)

	if game.has_node("Inimigo"):
		var enemy = game.get_node("Inimigo")
		enemy.take_damage(dano)

		if enemy.alive:
			await get_tree().create_timer(2.1).timeout
			enemy.attack_player()

	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 0.5
	add_child(timer)
	timer.connect("timeout", Callable(self, "limpar_slot"))
	timer.start()

func mostrar_ataque_temporario(valor):
	var label = $AttackLabel
	label.text = str(valor)
	label.show()
	label.modulate.a = 1.0

	var tween = get_tree().create_tween()
	tween.tween_property(label, "modulate:a", 0, 0.8).set_delay(1)

	tween.connect("finished", func():
		if is_instance_valid(label):
			label.hide()
	)

func limpar_slot():
	for carta in cartas_no_slot:
		if carta.is_inside_tree():
			carta.queue_free()  
	cartas_no_slot.clear()
	current_card = null
	previous_card = null
	card_placed = false
	get_tree().current_scene.check_no_moves_left()
