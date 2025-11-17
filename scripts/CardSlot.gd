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

	game.damage_enemy(dano)

	if cura > 0:
		game.heal_player(cura)

	var soma_valores = carta1.valor_base + carta2.valor_base
	var valor_final = soma_valores * multiplicador

	print("Cálculo do ataque:")
	print("- Carta 1:", carta1.name, "valor base:", carta1.valor_base)
	print("- Carta 2:", carta2.name, "valor base:", carta2.valor_base)
	print("- Soma:", soma_valores, "x multiplicador", multiplicador)
	print("valoe do ataque:", valor_final)
	
	# Dano no inimigo
	var game_ref = $"../HUD/EnemyHP"  # ajuste se seu HUD estiver em outro lugar
	game_ref.value -= valor_final
	# ATAQUE DO INIMIGO — turno automático
	var enemy = $"../HUD/PlayerHP" # ajusta para onde seu Enemy está na cena
	enemy.value -= 5


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
