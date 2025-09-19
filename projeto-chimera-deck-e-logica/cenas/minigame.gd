extends Node2D

var b
var a 
var operacao = ["+","-","x", "/"]
var pergunta = Label.new()
var resultado 
var pontos : float
var botoes
#para as perguntas-> função que gera os numeros e coloca no label
#para as respostas -> 3 ou 4 botões com numeros aleatorios proximos ao da resposta
#se a resposta estiver certa-> add pontos ao multiplicador e passa pra proxima pergunta
#se estiver errada -> fecha a janela e encerra, retornando o valor do multiplicador 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_button_pressed() -> void:
	$Label.queue_free()
	$Button.queue_free()
	comecar_jogo()
	
func comecar_jogo():
		print("pontuação atual: ", pontos)

		var op = operacao[randi_range(0,3)]
		#conta(faz a conta com a operacao e os numeros aleatorios)
		var c = conta(op)
		#cria a pergunta
		botoes = gerar_botoes_resposta(c)
		exibir_botoes(botoes)
		var pergunta = perguntar(op)

		#gerar_botoes_resposta_cria os botoes para responder
		
	
	 # Replace with function body.
func perguntar(op:String):
	pergunta.position= Vector2(150, 50)
	pergunta.text = "quanto é: %d %s %d?" % [a,op ,b]
	pergunta.visible= true
	
	add_child(pergunta)
	return pergunta
	
func conta(op_math):
	a = randi_range(30,50)
	b =randi_range(1,20)
	match op_math:
			"+":
				resultado = a+b
			"-":
				resultado = a-b
			"x":
				resultado = a*b
			"/":
				while a % b != 0:
					a = randi_range(30, 50)
					b = randi_range(1, 20)
				resultado = a / b
	return resultado
		 			
func gerar_botoes_resposta(result):
	var y = 100
	var posicao = randi_range(0,3)
	var btt = []
	var valores_usados =[result]

	for i in range(4):
		var botao = Button.new()
		botao.position =Vector2(150,y)
		y+=50
		var aux =0
		if posicao == i:
			botao.text =str(result)
			aux =  result
			
		else: 
			while true:
				var off_set = randi_range(-5,5)
				print(off_set)
				aux = result + off_set
				if( off_set == 0 and not aux in valores_usados):
					pass
				else: 
					break
				
			valores_usados.append(aux)
			botao.text = str(aux)
		btt.append(botao)
	return btt
	
func exibir_botoes(botoes):
	for i in range(0, botoes.size()):
		add_child(botoes[i])
		botoes[i].pressed.connect(func(): _on_botao_pressed(botoes[i]))
func limpar_botoes(botoes):
	for i in range(0, botoes.size()):
		botoes[i].text = ""
		
func _on_botao_pressed(compare_button):
	if compare_button.text == str(resultado):
		pontos+=0.5
		for i in range(botoes.size()):
			botoes[i].queue_free()
		comecar_jogo()
		print("pontuação atual: ", pontos)
		
	else:
		emit_signal("pontuacao",self, pontos)
		print("mandando sinal para o jogo")
		get_tree().quit()
		
