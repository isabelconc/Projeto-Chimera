extends Node2D

signal enemy_attacked(damage)
signal enemy_died

var max_hp = 700
var current_hp = 700
var attack_damage = 50
var alive := true
var next_attack_cancelled = false


func update_health_bar():
	if has_node("../HUD/EnemyHP"):
		var bar: ProgressBar = get_node("../HUD/EnemyHP")
		bar.value = current_hp
		if has_node("../HUD/EnemyHP/HPText"):
			var label: Label = get_node("../HUD/EnemyHP/HPText")
			label.text = str(current_hp, "/", max_hp)
			
func die():
	if not alive:
		print("die() chamado mas inimigo já morreu")
		return
	print("die() executado!")
	alive = false
	emit_signal("enemy_died")


func take_damage(amount):
	
	if not alive:
		print("Inimigo já está morto, não toma dano")
		return false
	print("Inimigo tomou", amount, "de dano")
	current_hp -= amount
	current_hp = max(current_hp, 0)
	update_health_bar()
	if current_hp <= 0:
		print("HP <= 0, chamando die()")
		die()
	return current_hp <= 0


func attack_player():
	if not alive:
		return

	if next_attack_cancelled:
		next_attack_cancelled = false
		print("Ataque do inimigo cancelado (J)")
		return

	var timer := get_tree().create_timer(0.4)
	await timer.timeout

	if get_tree().current_scene.has_method("show_enemy_attack_popup"):
		get_tree().current_scene.show_enemy_attack_popup(attack_damage)

	print("Inimigo atacou com", attack_damage)
	get_tree().current_scene.damage_player(attack_damage)
