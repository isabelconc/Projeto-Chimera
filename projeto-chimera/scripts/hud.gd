extends CanvasLayer

func update_player_hp(hp: int):
	$PlayerHP.value = hp
	$PlayerHP/HPText.text = str(hp)

func update_enemy_hp(hp: int):
	$EnemyHP.value = hp
	$EnemyHP/HPText.text = str(hp)
