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

func atualizar_valor():
	if cartas_no_slot.size() < 2:
		print("atualizar_valor: menos de duas cartas no slot.")
		return

	var carta1 = cartas_no_slot[0]
	var carta2 = cartas_no_slot[1]
	
	var dano = 0
	var cura = 0

	if carta1.card_name == "qArit":
		dano = carta2.valor_base * multiplicador / 2
		cura = carta2.valor_base * multiplicador / 2
	elif carta2.card_name == "qArit":
		dano = carta1.valor_base * multiplicador / 2
		cura = carta1.valor_base * multiplicador / 2
	else:
		dano = (carta1.valor_base + carta2.valor_base) * multiplicador

	var game = get_tree().current_scene

	# Dano no inimigo
	game.damage_enemy(dano)

	# Cura no player, se houver
	if cura > 0:
		game.heal_player(cura)

	var valor_final = (carta1.valor_base + carta2.valor_base) * multiplicador
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
