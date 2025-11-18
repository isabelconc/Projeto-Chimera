extends CanvasLayer

@onready var controler = preload("res://Scripts/controllers/controller.gd").new()
@onready var button = $content/QuestionHolder/Button
@onready var button2 = $content/QuestionHolder/Button2
@onready var button3 = $content/QuestionHolder/Button3
@onready var button4 = $content/QuestionHolder/Button4
@onready var labelPergunta =$content/Question_info/QuestionText
signal pontuacao(quiz_node, pontos)

var pergunta
var auxiliar
var resposta 
var botoes = []
var respostas=[]
var tema: int = 3
#0 Geometria_ 1 Função _ 2 Probabilidade
var pontos= 0

func _ready() -> void:

	botoes.append(button)
	botoes.append(button2)
	botoes.append(button3)
	botoes.append(button4)

	for i in botoes.size():
		botoes[i].pressed.connect(func():
			_on_button_pressed(botoes[i])
		)
	comecar_jogo()

func comecar_jogo():
	auxiliar = controler.gerar_pergunta_por_tema(tema)
	pergunta = auxiliar[0]
	resposta = auxiliar[1]
	labelPergunta.text = str(pergunta)
	gerar_botoes_resposta2(resposta)

	

func _on_button_pressed(resposta_player):
	if resposta_player.text == str(resposta):
		pontos += 1
		comecar_jogo()
	else:
		print(pontos)

		# Envia o sinal com os pontos
		emit_signal("pontuacao", self, pontos)
		print("mandando sinal para o jogo")

		# Remove somente o quiz, não o jogo inteiro
		queue_free()
	
func gerar_botoes_resposta2(resposta):
	var posicao = randi_range(0,3)
	for i in range(4):
		var aux = 0
		var valores_usados =[resposta]
		if posicao == i:
			botoes[i].text =str(resposta)
			aux = resposta
		else:
			while true:
				var diferenca = randi_range(-5,5)
				aux = resposta + diferenca
				if( diferenca == 0 and not aux in valores_usados):
					pass
				else: 
					break
			valores_usados.append(aux)
			botoes[i].text = str(aux)
	return botoes
