extends Node2D 
class_name CardSlot 
var current_card = null 
var previous_card = null 
var card_placed = false 
var multiplicador := 1
var cartas_no_slot := [] 
var attack_value: int = 0
var aguardando_quiz := false
var ataque_pendente := false


func place_card(carta):
	print(">> Recebendo carta:", carta.name, "endereço:", carta.get_instance_id())
	cartas_no_slot.append(carta)

	
	
func atualizar_valor():
	if cartas_no_slot.size() < 2:
		print("dano  tem que ser igual ao valor da carta ")
		return


	var dano = combos()
	var cura = 40
	var game = get_tree().current_scene
	# Dano no inimigo
	game.damage_enemy(dano)

	# Cura no player, se houver
	if cura > 0:
		game.heal_player(cura)
	var valor_final = dano
	print("Cálculo do ataque: valor final:", valor_final)
	if game.has_node("InimigoProb"):
		var enemy = game.get_node("InimigoProb")
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
	
	# MULTIPLICADOR RECEBE VALOR VINDO DE OUTRA CENA
	var final = dano * multiplicador
	multiplicador  = 1
	print("valor do dano:", dano, " dano_final: ", final,"pontuacao" )
	return final



func _on_ataque_pressed() -> void:
	# Verificar se há carta especial que exige quiz
	if existe_carta_especial():
		aguardando_quiz = true
		ataque_pendente = true
		abrir_quiz()
		return  # para tudo e espera terminar o quiz

	# Se não houver carta especial → ataque normal
	executar_ataque()
func executar_ataque():
	var valor_final = combos()

	card_placed = true
	self.attack_value = valor_final
	$AttackLabel.text = str(valor_final)
	$AttackLabel.visible = true
	mostrar_ataque_temporario(valor_final)

	# ACHAR INIMIGO NA CENA PRINCIPAL
	var scene = get_tree().current_scene

	if scene.has_node("InimigoProb"):
		var enemy = scene.get_node("InimigoProb")
		enemy.take_damage(valor_final)

		# Contra-ataque se estiver vivo
		if enemy.alive:
			enemy.attack_player()

	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 0.5
	add_child(timer)
	timer.connect("timeout", Callable(self, "limpar_slot"))
	timer.start()

func existe_carta_especial() -> bool:
	for carta in cartas_no_slot:
		print("Checando carta:", carta.card_name)
		if carta.card_name.to_lower() in ["jprob", "qprob", "kprob"]:
			print("Carta especial detectada!")
			return true
	print("Nenhuma carta especial encontrada.")
	return false

func verificar_dano(arr_vb: Array) -> float:
	if arr_vb.size() == 0:
		return 0
		
	var dano_total: float = 0.0

	var seq_soma = arr_vb[0].valor_base
	var seq_count = 1
	
	for i in range(1, arr_vb.size()):
		var atual = arr_vb[i].valor_base
		var anterior = arr_vb[i - 1].valor_base

		dano_total += anterior  # sempre soma normal

		# Continua sequência
		if atual == anterior + 1:
			seq_soma += atual
			seq_count += 1
		else:
			# Finaliza sequência anterior
			if seq_count > 1:
				dano_total += seq_soma * 0.25
			# Reinicia nova sequência
			seq_soma = atual
			seq_count = 1

	# Última carta sempre entra
	dano_total += arr_vb[arr_vb.size() - 1].valor_base

	# Última sequência
	if seq_count > 1:
		dano_total += seq_soma * 0.25

	return dano_total



func abrir_quiz():
	var quiz_scene = preload("res://cenas/Quiz.tscn")
	var quiz = quiz_scene.instantiate()
	print("Quiz carregado?", quiz_scene)

	# CONECTA O SINAL ANTES DE ADICIONAR A CENA
	quiz.pontuacao.connect(_on_quiz_finalizado)

	get_tree().current_scene.add_child(quiz)
	
func _on_quiz_finalizado(quiz_node, pontos):
	print("Quiz finalizado! Pontos recebidos:", pontos)

	multiplicador += pontos  # buff real do multiplicador

	quiz_node.queue_free()

	aguardando_quiz = false

	# Agora que o quiz acabou → se ataque estava esperando, executa
	if ataque_pendente:
		ataque_pendente = false
		executar_ataque()
		
