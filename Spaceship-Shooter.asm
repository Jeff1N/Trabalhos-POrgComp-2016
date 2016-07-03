; Spaceship Shooter

ShipPos:  	var #1

ShootPos: 	var #1
isShooting: var #1

AlienPos:	var #1
AlienDir:	var #1
AlienState: var #1


;Codigo principal
main:
	initialize:
		loadn r0, #35
		store AlienPos, r0
		
		loadn r1, #1
		store AlienDir, r1	
		
		loadn r6, #0
	
	loop:
		call PrintShip
		call MoveShip
		call Shoot
		call Alien
		
		call Delay
		
		jmp loop
	
;Funcoes

PrintShip:
	push r1
	push r2
	
	loadn r1, #62		; char r1 = '>';
	load r2, ShipPos	; int r2 = ShipPos;
	outchar r1, r2		; printf("%c", r1);
	
	pop r2
	pop r1
	
	rts

MoveShip:
	push r0	; ShipPos
	push r1	; LineSize
	push r2	; max/min pos
	
	push r4	; cmp inchar
	push r5 ; char ' '
	
	; Sincronização
		loadn r0, #200
		loadn r1, #0
		mod r0, r6, r0		; r1 = r0 % r1 (Teste condições de contorno)
		cmp r0, r1
		jne MoveShip_End
	
	load r0, ShipPos
	inchar r7
	
	loadn r4, #97	; char r4 = 'a'
	cmp r7, r4
	jeq MoveShip_A
	
	loadn r4, #100	; char r4 = 'd'
	cmp r7, r4
	jeq MoveShip_D
	
	loadn r4, #119	; char r4 = 'w'
	cmp r7, r4
	jeq MoveShip_W
	
	loadn r4, #115	; char r4 = 's'
	cmp r7, r4
	jeq MoveShip_S
	
	jmp MoveShip_End
	
	MoveShip_A:				; Move nave para a esquerda
		loadn r1, #40
		loadn r2, #0
		mod r1, r0, r1		; r1 = r0 % r1 (Teste condições de contorno)
		cmp r1, r2
		jeq MoveShip_End
		
		loadn r5, #32		; int r5 = 32; ('espaço' em ascii)
		outchar r5, r0		; Apaga nave
		
		dec r0
		store ShipPos, r0
		jmp MoveShip_End
	
	MoveShip_D:				; Move nave para a direita
		loadn r1, #40
		loadn r2, #10
		mod r1, r0, r1		; r1 = r0 % r1 (Teste condições de contorno)
		cmp r1, r2
		jeq MoveShip_End
		
		loadn r5, #32		; int r5 = 32; ('espaço' em ascii)
		outchar r5, r0		; Apaga nave
		
		inc r0
		store ShipPos, r0
		jmp MoveShip_End
	
	MoveShip_W:
		loadn r1, #40
		cmp r0, r1
		jle MoveShip_End
		
		loadn r5, #32		; int r5 = 32; ('espaço' em ascii)
		outchar r5, r0		; Apaga nave
		
		sub r0, r0, r1
		store ShipPos, r0
		jmp MoveShip_End
	
	MoveShip_S:
		loadn r1, #1159
		loadn r2, #40
		cmp r0, r1
		jgr MoveShip_End
		
		loadn r5, #32		; int r5 = 32; ('espaço' em ascii)
		outchar r5, r0		; Apaga nave
		
		add r0, r0, r2
		store ShipPos, r0
		jmp MoveShip_End
	
	MoveShip_End:
		pop r5
		pop r4
		
		pop r2
		pop r1
		pop r0
	
	rts

Shoot:
	push r0	; ShootPos
	push r1	; LineSize
	push r2 ; '-'	
	push r3 ; isShooting
	push r4 ; #1, #' ', max/min pos
	
	; Sincronização
		loadn r0, #50
		loadn r1, #0
		mod r0, r6, r0		; r1 = r0 % r1 (Teste condições de contorno)
		cmp r0, r1
		jne Shoot_End
	
	load r3, isShooting
	loadn r4, #1
	cmp r3, r4
	
	jeq Shoot_isShooting
	
	loadn r4, #' '	; char r4 = ' '
	cmp r7, r4
	jeq Shoot_Space
		
	jmp Shoot_End
	
	Shoot_Space:				; Atira
		load r3, isShooting
		loadn r4, #1
		cmp r3, r4		
		jeq Shoot_isShooting
	
		loadn r3, #1			; isShooting = true
		store isShooting, r3
		load r0, ShipPos		; ShootPos = ShipPos
		
		jmp Shoot_Draw
		
	Shoot_isShooting:
		load r0, ShootPos
		
	Shoot_Draw:
		outchar r4, r0		; Apaga tiro
		inc r0				; ShootPos++
		
		loadn r1, #40
		loadn r4, #0
		mod r1, r0, r1		; r1 = r0 % r1 (Teste condições de contorno)
		cmp r1, r4
		
		jeq Shoot_Disable	; Reinicia as variáveis de tiro	
		
		store ShootPos, r0
	
		loadn r2, #45		; int r5 = 45; ('-' em ascii)
		outchar r2, r0		; Desenha tiro
		
		jmp Shoot_Killed
		
	Shoot_Disable:
		loadn r3, #0			; isShooting = false
		store isShooting, r3
	
	Shoot_Killed:
		load r1, AlienPos
		cmp r0, r1
		jne Shoot_End
		
		loadn r1, #1
		store AlienState, r1
	
	Shoot_End:
		pop r4		
		pop r3
		pop r2
		pop r1
		pop r0
		
	rts	

Alien:
	push r0
	push r1
	push r2
	push r3
	
	; Sincronização
		loadn r0, #1000
		loadn r1, #0
		mod r0, r6, r0		; r1 = r0 % r1 (Teste condições de contorno)
		cmp r0, r1
		jne Alien_End
	
	load 	r0, AlienPos	; int r2 = ShipPos;
	loadn 	r1, #' '		; char r1 = 'X';
	outchar r1, r0			; printf("%c", r1);
	
	load 	r1, AlienDir	; r1 = AlienDir
	loadn 	r2, #40			; r2 = 40
	mul 	r2, r2, r1		; r2 *= r1
	add 	r0, r0, r2		; r0 += r2
	
	; if (AlienPos > 1200) goto Alien_Overflow
	loadn r3, #1200
	cmp r0, r3
	jgr Alien_Overflow
	
	; if (AlienPos > 1200) goto Alien_Underflow
	loadn r3, #0
	cmp r0, r3
	jle Alien_Underflow
	
	jmp Alien_Draw
	
	Alien_Underflow:
		loadn 	r1, #1			; r1 = 1
		store 	AlienDir, r1	; AlienDir = r1
		loadn 	r2, #40			; r2 = 40
		add 	r0, r0, r2		; r0 += r2
		
		jmp Alien_Draw
		
	Alien_Overflow:
		dec 	r1				; r1 = -1
		dec 	r1
		store 	AlienDir, r1	; AlienDir = r1
		loadn 	r2, #40			; r2 = 40
		mul 	r2, r2, r1		; r2 *= -1
		add 	r0, r0, r2		; r0 += r2
	
	Alien_Draw:	
		store 	AlienPos, r0
		
		loadn 	r2, #1
		load 	r3, AlienState
		cmp 	r3, r2
		jeq 	Dead_Alien
		
		jmp Alive_Alien
		
		Dead_Alien:
			loadn 	r1, #' '
			jmp outchar_Alien
		Alive_Alien:
			loadn 	r1, #'X'		; char r1 = 'X';
		outchar_Alien:
			outchar r1, r0			; printf("%c", r1);
	
	
	Alien_End:
		pop r3
		pop r2
		pop r1
		pop r0
	
	rts

;----------------------------------
Delay:
	push r0
	
	inc r6
	loadn r0, #5000
	cmp r6, r0
	jgr Reset_Timer
	
	jmp Timer_End
	
	Reset_Timer:
		loadn r6, #0
	Timer_End:		
		pop r0
	
	rts