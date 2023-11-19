.data
.include "backgroundCorrigido.data"


.text

SETUP: la a0,backgroundCorrigido
	li a1,0
	li a2,0
	li a3,0
	call PRINT
#
# a0 = endereço de onde a imagem deve ser rendenizada
# a1 = x
# a2 = y
# a3 = frame(0 ou 1)
#
# t0 = endereço do bitmap display
# t1 = endereço em que a imagem será mostrada
# t2 = contador de linha
# t3 = contador de coluna
# t4 = largura
# t5 = altura

PRINT: li t0,0xFF0 #carrega no registrador t0 o valor base do bitmap display 
	add t0,t0,a3 #adiciona a ele o valor contido no registrador a3, que corresponde ao frame (0 ou 1)
	slli t0,t0,20 #completa o endereço do bitmap display com os zeros restantes
	
	add t0,t0,a1 #adiciona no bitmap display o valor da coordenada x
	addi t1,t1,320 #
	mul t1,t1,a2 #
	add t0,t0,t1 # [As linhas 21,22 e 23 somam o valor da coordenada y ao valor do endereço do bitmap display]
	
	addi t1,a0,8
	
	mv t2,zero #zera o contador de linha
	mv t3,zero #zera o contador de coluna
	
	lw t4,0(a0) #carrega o valor da largura [os 4 primeiros bytes da fonte] em t4
	lw t5 4(a0) #carrega o valor da altura em t5
	
PRINT_LINHAS:
	lw t6,0(t1) #carrega o endereço dos primeiros 32 bits da imgem em t6
	sw t6,0(t0) #guarda esses nuemeros no endereço correspondente no bitmap display
	
	addi t0,t0,4 #avança 4 pixels no endereço do bitmap display
	addi t1,t1,4 #avança 4 pixels no endereço onde a imagem está guardada
	
	addi t3,t3,4 #adiciona 4 ao contador de colunas
	bgt t4,t3,PRINT_LINHAS #Enquanto o valor da largura da imagem for maior que o contador de colunas, branch to 'PRINT_LINHAS'
	
	
	addi t0,t0,320 #pula para o pixel imediatamente abaixo
	sub t0,t0,t4 #subtrai o valor da largura para chegar ao inicio da linha
	# as duas linhas anteriores servem para descer a linha a ser impressa
	
	mv t3,zero #zera o contador de coluna
	addi,t2,t2,1 #incrementa o contador de linha
	ble t2,t5,PRINT_LINHAS
	ret
	


