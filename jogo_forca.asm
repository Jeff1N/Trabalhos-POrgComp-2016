; Grupo 10
;
; Jefferson Boldrin Cardozo 	- 7591671
; Gabriel Pinheiro de Carvalho 	- 7960727

; ---------------
;  Jogo da Forca
; ---------------

; ------- TABELA DE CORES -------
; adicione ao caracter para Selecionar a cor correspondente

; 0 branco							0000 0000
; 256 marrom						0001 0000
; 512 verde							0010 0000
; 768 oliva							0011 0000
; 1024 azul marinho					0100 0000
; 1280 roxo							0101 0000
; 1537 teal							0110 0000
; 1793 prata						0111 0000
; 2048 cinza						1000 0000
; 2304 vermelho						1001 0000
; 2561 lima							1010 0000
; 2816 amarelo						1011 0000
; 3072 azul							1100 0000
; 3328 rosa							1101 0000
; 3584 aqua							1110 0000
; 3839 branco						1111 0000

Letra : 		var #1
Palavra: 		var #40
tamPalavra: 	var #1

tryList: 		var #40
tamList : 		var #1

flagAcerto : 	var #1
Acerto : 		var #1
Erro: 			var #1 

msgDigite: 		string "Digite uma letra"
msgRepetida: 	string "Letra Repetida"
msgDeNovo: 		string "Jogar novamente? (S/N)"
msgVenceu: 		string "Parabens, voce venceu :D"
msgNula:		string "                                        "	; Usada para apagar uma linha

jmp main

main:
	loadn r0, #0
	store tamList,r0
	store Acerto, r0
	store Erro, r0
	
	call inputPalavra
	call desenhaForca
	call desenhaEspacinhos
	

Loop_main:	
	call inputLetra
	call compara
	call testaFim
	jmp Loop_main
halt

;Entrada da palavra a ser adivinhada
inputPalavra:
	push fr
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	
	loadn r7, #38	; tamanho máximo da palavra
	loadn r6, #40 	; posição para imprimir asterisco
	loadn r4, #0 	; r4 = i
	loadn r5, #13 	; r5 = enter
	
	msg: string "Digite a palavra a ser adivinhada:      "
	loadn r0, #0
	loadn r1,#msg
	loadn r2, #0
	call Imprime
	
	loadn r3,#Palavra 	; r3 recebe a posição da string palvra
	add r4,r4,r3 		; posiciona i
loop_palavra:	
	call digLetra 		; pega uma letra do teclado
	load r0,Letra 		; move o conteudo de letra para r0
	cmp r0, r5 			; compara para ver se apertou enter
	jeq fimLoopPalavra
	dec r7
	jz fimLoopPalavra 		; verifica se digitou mais de 40 letras
	storei r4 , r0 			; armazena a letra na string
	inc r4					; incrementa i
	call imprimeAsterisco 	; imprime um asterisco
	inc r6 					; incrementa posição do asterisco
	jmp loop_palavra	
fimLoopPalavra:
	inc r4
	loadn r0, #'\0'
	storei r4, r0	
	
	loadn r0, #40
	subc r6,r6,r0
	
	store tamPalavra, r6 ; guarda tamanha da palavra
	
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
rts

; Entrada de teclado
digLetra:
	push fr
	push r0
	push r1
	
	loadn r1, #255
	
loop_dig:	
	inchar r0
	cmp r0,r1
	jeq loop_dig
	store Letra, r0	

	
	pop r1	
	pop r0
	pop fr
	
rts	

imprimeAsterisco:
	push fr
	push r0
	push r1
	push r2
	push r6				; posição
	ast: string "*"
	mov r0,r6
	loadn r1,#ast
	loadn r2, #0
	call Imprime
	pop r6
	pop r2
	pop r1
	pop r0
	pop fr
	rts
	
imprimePalavra:	
	push fr
	push r0
	push r1
	push r2
	push r3
	push r4
	
	loadn r4,#0 		; r4 =i
	loadn r3,#Palavra
	add r4, r4,r3
	
	loadn r1, #Palavra	; le o vetor de string que o usuario digitou 
	loadn r0, #640
	loadn r2, #0;
	call Imprime
	
	
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	rts
	
desenhaForca:

	push r3
	push r2
	push r1
	push r0
	push fr
	
	call apagaTela
	
	telaLinha1: string  "                                        "
	telaLinha2: string  "    {=======}                           "	
	telaLinha3: string  "    {       |                           "	
	telaLinha4: string  "    {                                   "
	telaLinha5: string  "    {                                   "
	telaLinha6: string  "    {                                   "
	telaLinha7: string  "    {                                   "	
	telaLinha8: string  "    {                                   "	
	telaLinha9: string  "    {                                   "	
	telaLinha10:string  "    {                                   "	
	telaLinha11:string  "    }}}}}}}}}}}}}}}                     "	
	telaLinha12:string  "    }/           \\}                     "	
	telaLinha13:string  "    }             }                     "	
	telaLinha14:string  "                                        "	
	telaLinha15:string  "                                        "	
	telaLinha16:string  "                                        "	
	telaLinha17:string  "                                        "	
	telaLinha18:string  "                                        "	
	telaLinha19:string  "                                        "	
	telaLinha20:string  "                                        "	
	telaLinha21:string  "                                        "	
	telaLinha22:string  "                                        "	
	telaLinha23:string  "                                        "	
	telaLinha24:string  "                                        "	
	telaLinha25:string  "                                        "	
	telaLinha26:string  "                                        "	
	telaLinha27:string  "                                        "	
	telaLinha28:string  "                                        "	
	telaLinha29:string  "                                        "	
	telaLinha30:string  "                                        "	
	
	loadn r0, #0
	loadn r1, #telaLinha1
	loadn r2, #0
	loadn r3, #1200
	
	call desenhaTela
	
	pop fr
	pop r0
	pop r1
	pop r2
	pop r3
rts


desenhaTela:
	push r0		; Posição inicial da tela
	push r1		; Endereço do cenário
	push r2		; Cor
	push r3		; Posição final da tela
	push r4
	push r5
	push fr

	
	loadn r4, #40
	loadn r5, #41
	
draw_loop:
	cmp r0,	r3
	jeq FimDraw
		call Imprime
		add  r0,r0,r4  ; r0 = posição da tela + 40
		add  r1,r1,r5  ; r1 posição da string + 41
	jmp draw_loop

FimDraw	:
	pop fr
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
		
rts 


apagaTela:
	push fr
	push r0
	push r1
	loadn r0,#1200
	loadn r1, #' '
	
	Apaga_loop:
		dec r0
		outchar r1,r0
	jnz Apaga_loop
	
	pop r1
	pop r0
	pop fr
rts

desenhaEspacinhos:
	push fr
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	
	load r4, tamPalavra
	
	
	loadn r0,#600
	loadn r1,#msgDigite
	loadn r2,#0
	call Imprime
	
	
	loadn r0,#640
	loadn r1,#'_'
	
loop_espacos:
	outchar r1,r0
	inc r0
	dec r4
	jnz loop_espacos
	
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
rts


; Digita uma letra e verifica se ja foi digitada
inputLetra:
	push fr
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5

loop_inputLetra:
	load r1, tamList 	; carrega numero de erros
	loadn r2, #0 		; auxiliar para comparar com 0
	loadn r3, #tryList 	; posição inicial da lista
	
	call digLetra		; pega letra que o usuario digitou
	load r0,Letra
	
	cmp r1,r2 			; if (tamList==0) goto insere primeiro elemento na lista
	jeq insereLista
	
	dec r1				; tamList -1
loop_for:
	cmp r2,r1 			; i< tamList
	jgr insereLista 	; sai do for 
	
	; caso contrario
	loadi r4,r3 		; carrega tryList[i]
	
	cmp r0,r4 			; if (tryList[i] == Letra)
	jne  incrementa		; false
	; true
	call imprimeRepetido
	jmp loop_inputLetra
	
incrementa:	
	inc r2 				; i++
	inc r3				; prox letra
	
	
	
	jmp loop_for

insereLista:
	load r0, Letra
	loadn r3, #tryList 	; carrega 1 pos da lista
	load r1, tamList 	; carrega tamanha da lista da memoria
	add r3,r3,r1 		; posiciona r3 no fim da lista
	storei r3, r0 		; guarda letra na memoria
	
	inc r3				; acrescenta o /0 para impressao
	loadn r4, #'\0'
	storei r3,r4
	
	inc r1				; atualiza tamanho na memoria
	store tamList, r1
	
	call imprimeTryList
	
	;Apaga mensagem de letra repetida
	push r0
	push r1
	push r2
	
	loadn r0, #680
	loadn r1, #msgNula
	loadn r2, #0
	call Imprime
	
	pop r2
	pop r1
	pop r0
	
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
rts

; Mensagem de palavra repetida
imprimeRepetido:
	push fr
	push r0
	push r1
	push r2
	loadn r0, #680
	loadn r1, #msgRepetida
	loadn r2, #0
	call Imprime
	pop r2
	pop r1
	pop r0
	pop fr
rts

; Imprimi a TryList
imprimeTryList:
	push fr
	push r0
	push r1
	push r2
	
	loadn r0,#720
	loadn r1,#tryList
	loadn r2, #0
	call Imprime
	
	pop r2
	pop r1
	pop r0
	pop fr
rts

; Compara letra digitada com a palavra a ser acertada
compara:
	push fr
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	push r6
	
	loadn r0, #0
	store flagAcerto, r0
	
	load r1, tamPalavra
	dec r1 ; tam-1
	
	loadn r3, #Palavra
	load r4, Letra
	
	;r0 iterador do for
loop_for_compara:
	cmp r0, r1 				; compara i > tam-1
	jgr fim_for_compara 	; sai do for
							; caso contrario
	loadi r6,r3
	cmp r4, r6 				; if(Letra == palavra[i])
	jne inc_for_comp 		; se false	
		
		; se true
		loadn r5,#640		; Imprime a Letra dentro da palavra
		add r5, r5, r0 		; posição da tela onde esta a letra
		outchar r4, r5
	
		loadn r5,#1			; flagAcerto =1
		store flagAcerto, r5
		
		load r5, Acerto 	;Acerto++
		inc r5
		store Acerto, r5
		
inc_for_comp:
	inc r3	; prox letra da palvra
	inc r0 	; i++
	jmp loop_for_compara
	
fim_for_compara:
	
	loadn r6,#0
	load r5, flagAcerto
	cmp r5, r6 			; if(flagAcerto==0) 
	jne fim_compara 	; false
	
		; true
		load r5, Erro	; erro++
		inc r5
		store Erro, r5
		
		loadn r6,#1
		cmp r5,r6 ; case 1:
		jne case2
		
		call desenhaCabeca
		
		jmp switch_end
case2: 
	loadn r6,#2
	cmp r5,r6; case 2
	jne case3
	   
		call desenhaCorpo1
		
	jmp switch_end
	   
case3:
	loadn r6,#3
	cmp r5,r6 ; case 3
	jne case4
	
		call desenhaCorpo2
		
	jmp switch_end
case4: 
	loadn r6,#4
	cmp r5,r6 ; case 4
	jne case5
	   call desenhaBracoDir
	
	jmp switch_end
	
case5: 
	loadn r6,#5
	cmp r5,r6 ; case 5
	jne case6
	   
	  call desenhaBracoEsq
	  
	jmp switch_end
case6:
	loadn r6,#6
	cmp r5,r6  ; case 6
	jne case7
	   
	 call desenhaPernaDir

	jmp switch_end
case7:  
	 call desenhaPernaEsq
	   
switch_end:		
fim_compara:	
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
rts

; Funções de desenho do boneco enforcado
desenhaCabeca:
	push fr
	push r0
	push r1
	push r2
	push r3
	
	cabeca1: string  "    {     (o o)                         "	
	cabeca2: string  "    {      (-)                          "	
	loadn r0, #120
	loadn r1,#cabeca1
	loadn r2, #0
	loadn r3, #200
	call desenhaTela
	
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	
rts

desenhaCorpo1:
	push fr
	push r0
	push r1
	push r2
	push r3
	
	corpo1: string  "    {       |                           "
	loadn r0, #200
	loadn r1,#corpo1
	loadn r2, #0
	loadn r3, #240
	call desenhaTela
	
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
rts

desenhaCorpo2:
	push fr
	push r0
	push r1
	push r2
	push r3
	
	corpo2: string  "    {       O                           "
    loadn r0,#240
	loadn r1,#corpo2
	loadn r2,#0
	loadn r3, #280
	call desenhaTela
	
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
rts

desenhaBracoDir:
	push fr
	push r0
	push r1
	push r2
	push r3
	
	bracoDir: string  "    {       | \\                         "
	loadn r0, #200
	loadn r1,#bracoDir
	loadn r2, #0
	loadn r3, #240
	call desenhaTela
	
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
rts

desenhaBracoEsq:
	push fr
	push r0
	push r1
	push r2
	push r3
	
	bracoEsq: string  "    {     / | \\                         "
	loadn r0, #200
	loadn r1,#bracoEsq
	loadn r2, #0
	loadn r3, #240
	call desenhaTela
	
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
rts

desenhaPernaDir:
	push fr
	push r0
	push r1
	push r2
	push r3
	
	pernaDir: string  "    {        \\                          "
	loadn r0, #280
	loadn r1,#pernaDir
	loadn r2, #0
	loadn r3, #320
	call desenhaTela
	
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
rts

desenhaPernaEsq:
	push fr
	push r0
	push r1
	push r2
	push r3
	
	pernaEsq: string  "    {      / \\                          "
	loadn r0, #280
	loadn r1,#pernaEsq
	loadn r2, #0
	loadn r3, #320
	call desenhaTela
	
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
rts

testaFim:
	push fr
	push r0
	push r1
	push r2
	push r3
	push r4

	load r0, Erro
	loadn r1,#7
	cmp r0,r1 ; if(erro==8)
	jne continua ; false
	; true
		call imprimePalavra ; mostra resposta
		call imprimePerdeu 	; pergunta se quer jogar de novo
novamente:
		push r0 
		push r1
		push r2
		loadn r0, #800
		loadn r1, #msgDeNovo
		loadn r2, #0
		call Imprime
		pop r2
		pop r1
		pop r0
		
		call digLetra ; carrega letra q o usuario digitou
		load r0, Letra
		loadn r1, #'s'
		cmp r0,r1 ; if (Letra =='s')
		jne fim_jogo ;apertou outra tecla
		; apertou S	
			call apagaTela
			pop r4
			pop r3
			pop r2
			pop r1
			pop r0
			pop fr
			jmp main
	
continua:
	load r0, Acerto
	load r1, tamPalavra
	cmp r0,r1 ; if(Acerto == tamPalavra)
	jne fim_testa ; se false
	; true
		push r0
		push r1
		push r2
		loadn r0, #760
		loadn r1, #msgVenceu
		loadn r2, #0
		call Imprime
		pop r2
		pop r1
		pop r0
		jmp novamente
fim_testa:
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
rts

fim_jogo:
	call apagaTela
	halt
	
imprimePerdeu:
	push fr
	push r0
	push r1
	push r2
	push r3
	push r4

	surpresa: string "    {     (- -)                         "	
	loadn r0, #120
	loadn r1, #surpresa
	loadn r2, #0
	loadn r3, #160
	call desenhaTela
	
	loadn r0,#0
	loadn r1,#200	
	

	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
rts	

