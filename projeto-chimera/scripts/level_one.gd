extends Node2D

@onready var teste: Button = $teste
@onready var deck = [""]

# Barras de vida
@onready var player_hp: ProgressBar = $HUD/PlayerHP
@onready var enemy_hp: ProgressBar = $HUD/EnemyHP

# Botões de teste
@onready var dano_player_btn: Button = $DanoPlayerBtn
@onready var dano_enemy_btn: Button = $DanoEnemyBtn

# Valores iniciais
var player_max_hp: int = 100
var enemy_max_hp: int = 100
var player_current_hp: int = player_max_hp
var enemy_current_hp: int = enemy_max_hp

func _ready() -> void:
	# Configura barras
	player_hp.max_value = player_max_hp
	enemy_hp.max_value = enemy_max_hp
	player_hp.value = player_current_hp
	enemy_hp.value = enemy_current_hp

	# Conectar botões
	dano_player_btn.pressed.connect(_on_dano_player_pressed)
	dano_enemy_btn.pressed.connect(_on_dano_enemy_pressed)

# Funções de dano
func damage_player(amount: int) -> void:
	player_current_hp = max(player_current_hp - amount, 0)
	player_hp.value = player_current_hp

func damage_enemy(amount: int) -> void:
	enemy_current_hp = max(enemy_current_hp - amount, 0)
	enemy_hp.value = enemy_current_hp

# Botões de teste
func _on_dano_player_pressed() -> void:
	damage_player(10)

func _on_dano_enemy_pressed() -> void:
	damage_enemy(10)

# Botão de completar fase
func _on_teste_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/choose_level_screen.tscn")
	Levelcore.lvl1_unlocked = true
	
	
