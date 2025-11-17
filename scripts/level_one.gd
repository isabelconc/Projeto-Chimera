extends Node2D 

@onready var teste: Button = $teste 
@onready var deck = [""] 
@onready var player_hp: ProgressBar = $HUD/PlayerHP 
@onready var enemy_hp: ProgressBar = $HUD/EnemyHP 
@onready var player_hp_label: Label = $HUD/PlayerHP/HPText
@onready var enemy_hp_label: Label = $HUD/EnemyHP/HPText
@onready var dano_player_btn: Button = $DanoPlayerBtn 
@onready var dano_enemy_btn: Button = $DanoEnemyBtn 

var player_max_hp: int = 500
var enemy_max_hp: int = 1000
var player_current_hp: int = player_max_hp
var enemy_current_hp: int = enemy_max_hp


func _ready() -> void: 
	player_hp.max_value = player_max_hp
	enemy_hp.max_value = enemy_max_hp
	player_hp.value = player_current_hp
	enemy_hp.value = enemy_current_hp
	player_hp_label.text = str(player_current_hp, "/", player_max_hp)
	enemy_hp_label.text = str(enemy_current_hp, "/", enemy_max_hp)


func damage_player(amount: int) -> void:
	player_current_hp = max(player_current_hp - amount, 0)
	player_hp.value = player_current_hp
	player_hp_label.text = str(player_current_hp, "/", player_max_hp)

	
func damage_enemy(amount: int) -> void:
	enemy_current_hp = max(enemy_current_hp - amount, 0)
	enemy_hp.value = enemy_current_hp
	enemy_hp_label.text = str(enemy_current_hp, "/", enemy_max_hp)
	

func heal_player(amount: int) -> void:
	player_current_hp = min(player_current_hp + amount, player_max_hp)
	player_hp.value = player_current_hp
	player_hp_label.text = str(player_current_hp, "/", player_max_hp)
	

func heal_enemy(amount: int) -> void:
	enemy_current_hp = min(enemy_current_hp + amount, enemy_max_hp)
	enemy_hp.value = enemy_current_hp
	enemy_hp_label.text = str(enemy_current_hp, "/", enemy_max_hp)

# Botão de completar fase 
func _on_teste_pressed() -> void: 
	get_tree().change_scene_to_file("res://cenas/choose_level_screen.tscn") 
	Levelcore.lvl1_unlocked = true
