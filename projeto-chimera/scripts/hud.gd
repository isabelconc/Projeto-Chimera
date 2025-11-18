extends CanvasLayer

func update_player_hp(hp: int):
	$PlayerHP/HPText.text = str(hp)

func update_enemy_hp(hp: int):
	$EnemyHP/HPText.text = str(hp)
