extends Node

var funcoes = [
	"Se f(x) = %dx + %d, qual é o valor de f(%d)?",
	"Se f(x) = x² + %dx + %d, qual é o valor de f(%d)?",
	"Qual é o valor de x para o qual f(x) = %dx + %d é igual a 0?",
	"Se f(x) = %dx + %d e g(x) = %dx + %d, qual é o valor de (f + g)(%d)?",
	"Se f(x) = %dx² e g(x) = %dx, qual é o valor de f(%d) + g(%d)?",
	"Se f(x) = %dx + %d, qual é a taxa de variação da função?",
	"Se f(x) = x², qual é a imagem de x = %d?",
	"Se f(x) = 3x - 5, qual é o valor de f⁻¹(%d)?",
	"Se f(x) = x³, qual é o valor de f(%d)?",
	"Se f(x) = %dx + %d, qual é o valor de f(0)?"
]


func gerar_pergunta(indice:int) -> Array:
	var a = 0
	var b = 0
	var c = 0
	var d = 0

	var resultado = 0.0
	var texto = ""

	match indice:
		0:
			a = randi_range(1, 10)
			b = randi_range(-5, 10)
			c = randi_range(-5, 10)
			resultado = a * c + b
			texto = funcoes[indice] % [a, b, c]

		1:
			a = randi_range(-5, 5)
			b = randi_range(-10, 10)
			c = randi_range(-5, 5)
			resultado = pow(c, 2) + a * c + b
			texto = funcoes[indice] % [a, b, c]

		2:
			a = randi_range(1, 10)
			b = randi_range(-10, 10)
			resultado = -b / float(a)
			texto = funcoes[indice] % [a, b]

		3:
			a = randi_range(1, 5)
			b = randi_range(1, 5)
			c = randi_range(-5, 5)
			d = randi_range(-5, 5)
			var x = randi_range(-3, 3)
			resultado = (a * x + b) + (c * x + d)
			texto = funcoes[indice] % [a, b, c, d, x]

		4:
			a = randi_range(1, 4)
			b = randi_range(1, 4)
			c = randi_range(-3, 3)
			resultado = a * pow(c, 2) + b * c
			texto = funcoes[indice] % [a, b, c, c]

		5:
			a = randi_range(1, 10)
			b = randi_range(-10, 10)
			resultado = a
			texto = funcoes[indice] % [a, b]

		6:
			a = randi_range(-5, 5)
			resultado = pow(a, 2)
			texto = funcoes[indice] % [a]

		7:
			a = randi_range(-10, 10)
			resultado = (a + 5) / 3.0
			texto = funcoes[indice] % [a]

		8:
			a = randi_range(-3, 3)
			resultado = pow(a, 3)
			texto = funcoes[indice] % [a]

		9:
			a = randi_range(1, 10)
			b = randi_range(-10, 10)
			resultado = b
			texto = funcoes[indice] % [a, b]

	return [texto, resultado]
