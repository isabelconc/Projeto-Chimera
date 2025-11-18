extends Node

# Array de templates de perguntas de aritmética
var funcoes_aritmetica = [
	"Qual é o valor de %d + %d?",            # 0: Adição
	"Qual é o valor de %d - %d?",            # 1: Subtração
	"Qual é o valor de %d x %d?",            # 2: Multiplicação
	"Qual é o valor de %d / %d?",            # 3: Divisão (com resultado inteiro se possível)
	"Qual é o valor de %d²?",                # 4: Quadrado
	"Qual é o valor de %d + %d - %d?",       # 5: Operações Mistas 1
	"Qual é o valor de (%d + %d) * %d?",     # 6: Ordem de Operações (PEMDAS/BODMAS)
	"Qual é o valor de %d³?",                # 7: Cubo
	"Se um número for %d, qual é o seu dobro mais %d?", # 8: Aplicação simples
	"Qual é o valor de %d x (%d - %d)?"      # 9: Ordem de Operações (com parênteses)
]


func gerar_pergunta_aritmetica(indice: int) -> Array:

	var a = 0
	var b = 0
	var c = 0

	var resultado = 0.0 
	var texto = ""

	match indice:
		0: # Adição: a + b
			a = randi_range(10, 50)
			b = randi_range(1, 40)
			resultado = float(a + b)
			texto = funcoes_aritmetica[indice] % [a, b]

		1: # Subtração: a - b (garantindo resultado não negativo para simplicidade)
			b = randi_range(1, 30)
			a = randi_range(b + 5, 60)
			resultado = float(a - b)
			texto = funcoes_aritmetica[indice] % [a, b]

		2: # Multiplicação: a * b
			a = randi_range(2, 12)
			b = randi_range(2, 10)
			resultado = float(a * b)
			texto = funcoes_aritmetica[indice] % [a, b]

		3: # Divisão: a / b (garantindo que 'a' seja múltiplo de 'b' para resultado inteiro)
			b = randi_range(2, 8)
			var multiplicador = randi_range(3, 15)
			a = b * multiplicador
			resultado = float(a / b)
			texto = funcoes_aritmetica[indice] % [a, b]
			# O resultado final será 5.0, 8.0, etc., que é a forma mais segura de lidar com ele.

		4: # Quadrado: a²
			a = randi_range(2, 10)
			resultado = float(pow(a, 2))
			texto = funcoes_aritmetica[indice] % [a]

		5: # Operações Mistas 1: a + b - c
			a = randi_range(10, 30)
			b = randi_range(1, 15)
			c = randi_range(1, 10)
			resultado = float(a + b - c)
			texto = funcoes_aritmetica[indice] % [a, b, c]

		6: # Ordem de Operações: (a + b) * c
			a = randi_range(1, 5)
			b = randi_range(1, 5)
			c = randi_range(2, 5)
			resultado = float((a + b) * c)
			texto = funcoes_aritmetica[indice] % [a, b, c]

		7: # Cubo: a³
			a = randi_range(2, 5)
			resultado = float(pow(a, 3))
			texto = funcoes_aritmetica[indice] % [a]

		8: # Aplicação simples: 2*a + b
			a = randi_range(5, 15)
			b = randi_range(1, 10)
			resultado = float(2 * a + b)
			texto = funcoes_aritmetica[indice] % [a, b]

		9: # Ordem de Operações: a * (b - c)
			a = randi_range(2, 5)
			c = randi_range(1, 5)
			b = randi_range(c + 1, 10) # 'b' é maior que 'c'
			resultado = float(a * (b - c))
			texto = funcoes_aritmetica[indice] % [a, b, c]

	return [texto, resultado]

func _ready():
	randomize()
		
	for i in range(5):
		var indice_aleatorio = randi_range(0, funcoes_aritmetica.size() - 1)
		var pergunta_e_resposta = gerar_pergunta_aritmetica(indice_aleatorio)
		
		var pergunta = pergunta_e_resposta[0]
		var resposta = pergunta_e_resposta[1]
		
		var resposta_formatada = ""
		if fmod(resposta, 1.0) == 0:
			resposta_formatada = str(int(resposta))
		else:
			resposta_formatada = str(resposta)
			
