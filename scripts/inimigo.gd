extends Node2D

signal enemy_attacked(damage)
signal enemy_died

var max_hp = 100
var current_hp = 100
var attack_damage = 50
var alive := true

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
		print("Inimigo está morto, não ataca")
		return
	print("Inimigo atacou com", attack_damage)
	emit_signal("enemy_attacked", attack_damage)
