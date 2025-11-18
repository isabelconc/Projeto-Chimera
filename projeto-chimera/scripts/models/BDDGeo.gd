extends Node


var geometria = [
	"Qual é a área de um triângulo com base %d cm e altura %d cm?",
	"Qual é o perímetro de um retângulo com lados de %d cm e %d cm?",
	"Qual é a área de um quadrado com lado de %d cm?",
	"Qual é a área de um círculo com raio de %d cm? (use π = 3,14)",
	"Qual é o volume de um cubo com aresta de %d cm?",
	"Qual é o volume de um paralelepípedo com dimensões %d × %d × %d cm?",
	"Qual é o volume de um cilindro com raio %d cm e altura %d cm? (use π = 3,14)",
	"Um triângulo tem dois ângulos de %d° e %d°. Qual é o valor do terceiro ângulo?",
	"Qual é a soma dos ângulos internos de um polígono de %d lados?",
	"Um mapa está na escala 1:%d. Se a distância real é %d km, qual é a distância no mapa?",
	"Em um triângulo retângulo com catetos de %d cm e %d cm, qual é o valor da hipotenusa?"
]

func gerar_pergunta(indice) -> Array:
	print("info chegou no model")

	var a = 0
	var b = 0
	var c = 0
	var resultado = 0.0
	var texto = ""
	
	match indice:
		0:
			a = randi_range(4, 20)
			b = randi_range(3, 15)
			resultado = (a * b) / 2.0
			texto = geometria[indice] % [a, b]
			
		1:
			a = randi_range(3, 15)
			b = randi_range(3, 15)
			resultado = 2 * (a + b)
			texto = geometria[indice] % [a, b]
			
		2:
			a = randi_range(2, 12)
			resultado = a * a
			texto = geometria[indice] % [a]
			
		3:
			a = randi_range(2, 10)
			resultado = 3.14 * a * a
			texto = geometria[indice] % [a]
			
		4:
			a = randi_range(2, 8)
			resultado = pow(a, 3)
			texto = geometria[indice] % [a]
			
		5:
			a = randi_range(2, 10)
			b = randi_range(2, 10)
			c = randi_range(2, 10)
			resultado = a * b * c
			texto = geometria[indice] % [a, b, c]
			
		6:
			a = randi_range(2, 8)
			b = randi_range(5, 15)
			resultado = 3.14 * a * a * b
			texto = geometria[indice] % [a, b]
			
		7:
			a = randi_range(20, 80)
			b = randi_range(20, 80)
			resultado = 180 - (a + b)
			texto = geometria[indice] % [a, b]
			
		8:
			a = randi_range(3, 10)
			resultado = (a - 2) * 180
			texto = geometria[indice] % [a]
			
		9:
			a = randi_range(1000, 100000)
			b = randi_range(10, 200)
			resultado = float(b * 1000) / a
			texto = geometria[indice] % [a, b]
			

	return [texto, resultado]
