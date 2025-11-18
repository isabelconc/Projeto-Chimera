extends Node2D

@onready var enemy: Node2D = $InimigoProb
@onready var player_hp: ProgressBar = $HUD/PlayerHP 
@onready var enemy_hp: ProgressBar = $HUD/EnemyHP 
@onready var player_hp_label: Label = $HUD/PlayerHP/HPText
@onready var enemy_hp_label: Label = $HUD/EnemyHP/HPText
var player_max_hp: int = 100
var player_current_hp: int = player_max_hp


func _ready() -> void: 
	player_hp.max_value = player_max_hp
	player_hp.value = player_current_hp
	player_hp_label.text = str(player_current_hp, "/", player_max_hp)
	enemy_hp.max_value = enemy.max_hp
	enemy_hp.value = enemy.current_hp
	enemy_hp_label.text = str(enemy.current_hp, "/", enemy.max_hp)
	enemy.connect("enemy_attacked", Callable(self, "_on_enemy_attacked"))
	enemy.connect("enemy_died", Callable(self, "_on_enemy_died"))


func _on_enemy_attacked(damage):
	player_current_hp = max(player_current_hp - damage, 0)
	player_hp.value = player_current_hp
	player_hp_label.text = str(player_current_hp, "/", player_max_hp)
	print("Player tomou ", damage, " -> HP:", player_current_hp)

func player_attack_enemy(damage: int):
	print("Player atacando com", damage) # DEGUB
	enemy.take_damage(damage)

func end_player_turn():
	enemy.attack_player()

func damage_player(amount: int) -> void:
	player_current_hp = max(player_current_hp - amount, 0)
	player_hp.value = player_current_hp
	player_hp_label.text = str(player_current_hp, "/", player_max_hp)

	if player_current_hp <= 0:
		game_over()

	
func show_enemy_attack_popup(damage: int) -> void:
	var label = $HUD/EnemyAttackLabel
	label.text = "-" + str(damage)
	label.visible = true
	label.modulate.a = 1  

	var tween = get_tree().create_tween()
	tween.tween_property(label, "modulate:a", 0, 0.6).set_delay(0.4)

	tween.connect("finished", func():
		label.hide()
	)

	
func heal_player(amount: int) -> void:
	player_current_hp = min(player_current_hp + amount, player_max_hp)
	player_hp.value = player_current_hp
	player_hp_label.text = str(player_current_hp, "/", player_max_hp)

func damage_enemy(amount: int) -> void:
	enemy_hp.value = max(enemy_hp.value - amount, 0)
	enemy_hp_label.text = str(enemy_hp.value, "/", enemy.max_hp)

func _on_enemy_died():
	print("Sinal enemy_died recebido!")
	enemy_hp.value = 0
	enemy_hp_label.text = "0/" + str(enemy.max_hp)
	print("Inimigo derrotado! Transição para tela de K.O.")

	var fade = ColorRect.new()
	fade.color = Color(0,0,0,0)
	fade.size = get_viewport_rect().size  # <-- use 'size' em vez de rect_size
	add_child(fade)

	var tween = get_tree().create_tween()
	tween.tween_property(fade, "color:a", 1, 1.0)
	tween.connect("finished", Callable(self, "_go_to_ko_scene"))

func _go_to_ko_scene():
	get_tree().change_scene_to_file("res://cenas/ko_screen.tscn")
	
func check_no_moves_left():
	var deck_empty = $Deck.deck.size() == 0
	var hand_empty = $"Mao_de_Jogo".mao_player.size() == 0

	if deck_empty and hand_empty:
		enemy = $InimigoProb
		if enemy and enemy.alive:
			game_over()

	
func game_over():
	print("game overkkkkkk")
	
	if get_tree().paused:
		return

	get_tree().paused = true

	get_tree().change_scene_to_file("res://assets/joguinho-main/telasentrefase/chimera/telachimera.png")
