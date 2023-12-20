.data
prompt_play:
    .asciiz "1. Jogar\n"
prompt_exit:
    .asciiz "2. Sair\n"
prompt_choice:
    .asciiz "Escolha: "
espaco:
	.space 2

.text
.globl _start

_start:
    # Imprimir o menu
    li a0, 1        # Descritor de arquivo: stdout
    la a1, prompt_play
    li a2, 9        # Comprimento da string
    li a7, 64       # Chamada de sistema: write
    ecall

    li a0, 1
    la a1, prompt_exit
    li a2, 7
    li a7, 64
    ecall

    # Solicitar escolha do usuário
    li a0, 1
    la a1, prompt_choice
    li a2, 9
    li a7, 64
    ecall

    # Ler a escolha do usuário
    #li a0, 0        # Descritor de arquivo: stdin
    #la a1, buffer   # Endereço do buffer para armazenar a escolha
   # li a2, 2        # Tamanho do buffer
    #li a7, 63       # Chamada de sistema: read
    #ecall

    # Carregar o primeiro caractere da escolha
    lb a3, 0(a1)

    # Comparar a escolha do usuário
    li a4, '1'
    beq a3, a4, jogar

    li a4, '2'
    beq a3, a4, sair

    # Escolha inválida, reiniciar o programa
    j _start

jogar:
    # Código para a opção "Jogar" aqui
    # Substitua esta linha com o código específico para "Jogar"
    li a0, 10
    li a7, 93       # Chamada de sistema: exit
    ecall

sair:
    # Código para a opção "Sair" aqui
    # Substitua esta linha com o código específico para "Sair"
    li a0, 0
    li a7, 93       # Chamada de sistema: exit
    ecall

