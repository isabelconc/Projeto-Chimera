extends Node2D

signal enemy_attacked(damage)
signal enemy_died

var max_hp = 200
var current_hp = 200
var attack_damage = 20
var alive := true
var next_attack_cancelled = false


func update_health_bar():
	var scene = get_tree().current_scene

	# Encontrar HUD globalmente pela árvore da cena
	if scene.has_node("HUD"):
		var hud = scene.get_node("HUD")

		# Atualizar a barra
		if hud.has_node("EnemyHP"):
			var bar: ProgressBar = hud.get_node("EnemyHP")
			bar.value = current_hp

		# Atualizar o texto
		if hud.has_node("EnemyHP/HPText"):
			var txt: Label = hud.get_node("EnemyHP/HPText")
			txt.text = str(current_hp, "/", max_hp)


func die():
	if not alive:
		print("die() chamado mas inimigo já morreu")
		return

	print("Inimigo morreu!")
	alive = false
	emit_signal("enemy_died")
	queue_free()


func take_damage(amount):
	if not alive:
		print("Inimigo já está morto, não toma dano")
		return false

	print("Inimigo tomou", amount, "de dano")
	current_hp -= amount
	current_hp = max(current_hp, 0)

	update_health_bar()

	if current_hp <= 0:
		die()

	return current_hp <= 0


func attack_player():
	if not alive:
		return

	if next_attack_cancelled:
		next_attack_cancelled = false
		print("Ataque do inimigo cancelado")
		return

	var timer := get_tree().create_timer(0.4)
	await timer.timeout

	print("Inimigo atacou com", attack_damage)

	get_tree().current_scene.damage_player(attack_damage)
