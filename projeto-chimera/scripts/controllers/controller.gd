extends Node

var i = 0
var data = []

func gerar_pergunta_por_tema(tema:int):
	match tema:
		0:
			print("info chegou mo controller")

			i = randi_range(0, 10)
			data = BddGeo.gerar_pergunta(i)
			print("info saiu do controller")
			return data
		1:
			i = randi_range(0, 9)
			data=  BddFunc.gerar_pergunta(i)
			return data			
		2:
			i = randi_range(0, 9)
			data = BddProb.gerar_pergunta(i)
			return data
		3: 
			i = randi_range(0,9)
			data= BddArit.gerar_pergunta_aritmetica(i)
			return data
			
	
