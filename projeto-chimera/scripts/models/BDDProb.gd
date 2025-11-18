extends Node

var probabilidade = [
	"Em um dado comum de 6 faces, qual é a probabilidade de sair o número %d?",
	"Em um baralho com 52 cartas, qual é a probabilidade de tirar uma carta de copas?",
	"Em um sorteio com %d números, qual é a probabilidade de sair o número %d?",
	"Uma urna tem %d bolas vermelhas e %d azuis. Qual é a probabilidade de tirar uma vermelha?",
	"Uma moeda é lançada duas vezes. Qual é a probabilidade de sair cara nas duas?",
	"Em uma urna com %d bolas numeradas de 1 a %d, qual é a probabilidade de tirar um número par?",
	"Em um baralho de 52 cartas, qual é a probabilidade de tirar um Ás?",
	"Um dado é lançado duas vezes. Qual é a probabilidade de a soma ser igual a 7?",
	"Uma urna tem 3 bolas vermelhas, 2 verdes e %d azuis. Qual é a probabilidade de tirar uma bola verde?",
	"Um número é sorteado de 1 a %d. Qual é a probabilidade de ser múltiplo de 3?"
]


func gerar_pergunta(indice:int) -> Array:
	var a = 0
	var b = 0
	var resultado = 0.0
	var texto = ""

	match indice:
		0:
			a = randi_range(1, 6)
			resultado = 1.0 / 6.0
			texto = probabilidade[indice] % [a]

		1:
			resultado = 13.0 / 52.0
			texto = probabilidade[indice]

		2:
			a = randi_range(10, 100)
			b = randi_range(1, a)
			resultado = 1.0 / float(a)
			texto = probabilidade[indice] % [a, b]

		3:
			a = randi_range(1, 10)
			b = randi_range(1, 10)
			resultado = a / float(a + b)
			texto = probabilidade[indice] % [a, b]

		4:
			resultado = 1.0 / 4.0
			texto = probabilidade[indice]

		5:
			a = randi_range(4, 20)
			resultado = floor(a / 2.0) / float(a)
			texto = probabilidade[indice] % [a, a]

		6:
			resultado = 4.0 / 52.0
			texto = probabilidade[indice]

		7:
			resultado = 6.0 / 36.0  # existem 6 combinações que somam 7
			texto = probabilidade[indice]

		8:
			a = randi_range(3, 10)
			resultado = 2.0 / (3.0 + 2.0 + a)
			texto = probabilidade[indice] % [a]

		9:
			a = randi_range(10, 100)
			resultado = floor(a / 3.0) / float(a)
			texto = probabilidade[indice] % [a]

	return [texto, resultado]
