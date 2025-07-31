# Projeto-Chimera
Jogo desenvolvido para a disciplina de Matemática Computacional do terceiro ano de DS no Instituto Federal. 

🐉 Chimera — Jogo de Cartas inspirado em Mão do Demônio do lol

Chimera é um jogo de cartas educativo criado na Godot, em que o jogador enfrenta inimigos através de combinações estratégicas de cartas matemáticas. Cada fase representa uma área da matemática, vinculada a um naipe do baralho, e o jogador deve derrotar os inimigos utilizando conhecimento e raciocínio. Mecânicas de desafios extras nas fases de acordo com o inimigo em batalha também são parte do combate, que busca entreter usando matemática ao invés de se preocupar em ensinar.

<img width="1536" height="799" alt="image" src="https://github.com/user-attachments/assets/75689029-cd18-4885-bb54-87e1360b6d67" />


- Estrutura do Jogo

TitleScreen contendo créditos
Tutorial simples com a mecânica principal do jogo
4 Níveis (1 para cada Naipe) -> Introdução simples ao conteúdo matemático da fase


- Mecânica de Combate

    O jogador possui um baralho com cartas temáticas da fase.

    Combinar duas ou mais cartas gera ataques matemáticos únicos.

    Cada combinação tem um efeito diferente (dano, cura, etc.), baseado em conteúdos matemáticos reais.

    O inimigo possui uma barra de vida, e o objetivo é esvaziá-la usando combinações válidas.

    Mecânicas como "lojinhas" de powerups e desafios matemáticos durante a fase variam a jogabilidade.

- Sistema de Progresso

    Apenas a primeira fase está desbloqueada no início.

    Vencer uma fase (derrotar o inimigo) desbloqueia a próxima.

    O progresso é salvo automaticamente.

🧩 Exemplos de Combinações

Fase de Funções (♥):

    Função bijetora + Função afim → “Mapeamento Total” → Dano dobrado

    Função crescente + decrescente → “Contradição Lógica” → Dano + cura

Fase de Geometria (♣):

    Triângulo Retângulo + Ângulo de 90° → “Ataque Hipotenusa” → Dano = valor²

- Metodologias

    Godot Engine (versão 4.0)

