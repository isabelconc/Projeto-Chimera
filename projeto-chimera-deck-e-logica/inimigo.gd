extends Node

var hp: int = 100

func receber_dano(valor: int):
	hp -= valor
	print("💀 Inimigo recebeu", valor, "de dano. HP =", hp)
	if hp <= 0:
		morrer()

func morrer():
	print("☠️ Inimigo derrotado!")
