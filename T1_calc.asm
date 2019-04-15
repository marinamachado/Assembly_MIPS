#				   	     UNIVERSIDADE DE SAO PAULO
#				  INSTITUTO DE CIENCIAS MATEMATICAS E DE COMPUTACAO
#
# 				 SSC0902 - Organizacao e Arquitetura de Computadores		
#
#						 1o. Trabalho Pratico
#						    Calculadora
#
# 	Este programa visa simular, em Assembly MIPS, uma calculadora capaz de realizar as seguintes operacoes:
# - soma	- multiplicacao		- potencia		- tabuada		- fatorial
# - subtracao	- divisao		- raiz quadrada		- calculo do IMC	- sequencia de Fibonacci
#
#
#													ALUNOS:
#							Joao Pedro Almeida Secundino			10692054
#							Luis Eduardo Rozante de Freitas Pereira		10734794
#							Luiza Pereira Pinto Machado			 7564426
#							Marina Fontes Alcantara Machado			10692040
#
################################################################################################################

	.data
menu0:	.asciiz "\n\tSELECIONAR OPERACAO DESEJADA\n1 - Soma\t\t6 - Raiz quadrada\n2 - Subtracao\t\t7 - Tabuada\n"
menu1:	.asciiz	"3 - Multiplicacao\t8 - Calculo do IMC\n4 - Divisao\t\t9 - Fatorial\n5 - Potencia\t\t10 - Sequencia de Fibonacci\n0 - SAIR\n"

ins1:	.asciiz "> Inserir um numero\n"
ins2:	.asciiz "> Inserir dois numeros\n"

err0:	.asciiz "ERRO: Valor invalido! Os argumentos devem ser estar entre -32767 e 32767.\n"
err1:	.asciiz "ERRO: Valor invalido! O(s) argumento(s) não deve(m) ser negativo(s).\n"
err2:	.asciiz "ERRO: Valor invalido! Este argumento deve ser diferente de zero.\n"

sum0:	.asciiz "\tSOMA\n"
sum1:	.asciiz " + "

sub0:	.asciiz "\tSUBTRACAO\n"
sub1:	.asciiz " - "

mul0:	.asciiz "\tMULTIPLICACAO\n"
mul1:	.asciiz " * "

div0:	.asciiz "\tDIVISAO\n"
div1:	.asciiz " / "
rst:	.asciiz "> Resto: "

pot0:	.asciiz "\tPOTENCIA\n"
pot1:	.asciiz "^"

sqrt0:	.asciiz "\tRAIZ QUADRADA\n"
sqrt1:	.asciiz "sqrt"

tab0:	.asciiz "\tTABUADA\n"
tab1:	.asciiz "> Tabuada de "
tabXis: .asciiz " x "

imc0:	.asciiz "Inserir altura (m) e peso (kg)\n"
imc1:	.asciiz "IMC: "

fat0:	.asciiz "\tFATORIAL\n"
fat1:	.asciiz "!"

phi0:	.asciiz "\tFIBONACCI\n"
phi1:	.asciiz "> Numeros de Fibonacci "
invrg:	.asciiz "ERRO: O segundo valor deve ser maior do que o primeiro!\n"

aa:	.asciiz " a "
eq:	.asciiz " = "
nl:	.asciiz "\n"
space:	.asciiz " "
par_op:	.asciiz "("
par_cl:	.asciiz ")"
tdot:	.asciiz ":\n"

	.text
	.globl main

#				
#	FUNCAO PRINCIPAL		
#				

main:
	# IMPRESSAO DO MENU
	li $v0, 4		# Chamada de servico 4: impressao de string
	la $a0, menu0
	syscall
	li $v0, 4
	la $a0, menu1
	syscall
	
	# LER OPCAO
	li $v0, 5	# Chamada de servico 5: leitura de inteiro
	syscall
	move $t0, $v0	# $t0 = numero digitado
	
	# $s7 = 0 indica que nenhuma operacao foi escolhida ou nao ha restricoes para a operacao selecionada
	addi $s7, $zero, 0
	
	# Caso opcao = 1
	# Soma
	addi $t1, $zero, 1
	beq $t0, $t1, case_1 	
	
	# Caso opcao = 2
	# Subtracao
	addi $t1, $zero, 2
	beq $t0, $t1, case_2	
	
	# Caso opcao = 3
	# Multiplicacao
	addi $t1, $zero, 3
	beq $t0, $t1, case_3	

	# Caso opcao = 4
	# Divisao
	addi $t1, $zero, 4
	beq $t0, $t1, case_4	
	
	# Caso opcao = 5
	# Potencia
	addi $t1, $zero, 5
	beq $t0, $t1, case_5	
	
	# Caso opcao = 6
	# Raiz quadrada
	addi $t1, $zero, 6
	beq $t0, $t1, case_6	
	
	# Caso opcao = 7
	# Tabuada
	addi $t1, $zero, 7
	beq $t0, $t1, case_7
	
	# Caso opcao = 8
	# Calculo do IMC
	addi $t1, $zero, 8
	beq $t0, $t1, case_8	
	
	# Caso opcao = 9
	# Calculo do fatorial
	addi $t1, $zero, 9
	beq $t0, $t1, case_9	
	
	# Caso opcao = 10
	# Calculo da sequencia de Fibonacci
	addi $t1, $zero, 10
	beq $t0, $t1, case_10	
	
	# Caso opcao = 0
	# Sair do programa
	addi $t1, $zero, 0	
	beq $t0, $t1, end_calc
	
	j main

#
#	CASE 1: SOMA
#	
case_1:
	li $v0, 4
	la $a0, sum0	# "SOMA"
	syscall
	
	li $v0, 4
	la $a0, ins2	# "Inserir dois numeros"
	syscall
	
	jal lerInt
	move $a0, $v0	# $a0 = primeiro argumento
	jal lerInt
	move $a1, $v0	# $a1 = segundo argumento
	
	jal soma	# Efetuar operacao
	move $s0, $v0	# $s0 = resultado
	
	# "<$a0> + <$a1> = <$s0>"
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, sum1
	syscall
	li $v0, 1
	move $a0, $a1
	syscall
	li $v0, 4
	la $a0, eq
	syscall
	li $v0, 1
	move $a0, $s0
	syscall
	li $v0, 4
	la $a0, nl
	syscall
	
	j main


#
#	CASE 2: SUBTRACAO
#
	
case_2:
	li $v0, 4
	la $a0, sub0	# "SUBTRACAO"
	syscall
	
	li $v0, 4
	la $a0, ins2	# "Inserir dois numeros"
	syscall
	
	jal lerInt
	move $a0, $v0	# $a0 = primeiro argumento
	jal lerInt
	move $a1, $v0	# $a1 = segundo argumento
	
	jal subt	# Efetuar operacao
	move $s0, $v0	# $s0 = resultado
	
	# "<$a0> - <$a1> = <$s0>"
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, sub1
	syscall
	li $v0, 1
	move $a0, $a1
	syscall
	li $v0, 4
	la $a0, eq
	syscall
	li $v0, 1
	move $a0, $s0
	syscall
	li $v0, 4
	la $a0, nl
	syscall
	
	j main
	
#
#	CASE 3: MULTIPLICACAO
#

case_3:
	li $v0, 4
	la $a0, mul0	# "MULTIPLICACAO"
	syscall
	
	li $v0, 4
	la $a0, ins2	# "Inserir dois numeros"
	syscall
	
	# $s7 = 1 indica que a operacao nao aceita numeros maiores que 32767 (2^15) ou menores que -32767
	addi $s7, $zero, 1
	
	jal lerInt
	move $a0, $v0	# $a0 = primeiro argumento
	jal lerInt
	move $a1, $v0	# $a1 = segundo argumento
	
	jal mult	# Efetuar operacao
	move $s0, $v0	# $s0 = resultado
	
	# "<$a0> * <$a1> = <$s0>"
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, mul1
	syscall
	li $v0, 1
	move $a0, $a1
	syscall
	li $v0, 4
	la $a0, eq
	syscall
	li $v0, 1
	move $a0, $s0
	syscall
	li $v0, 4
	la $a0, nl
	syscall
	
	j main
	
#
#	CASE 4: DIVISAO
#

case_4:
	li $v0, 4
	la $a0, div0	# "DIVISAO"
	syscall
	
	li $v0, 4
	la $a0, ins2	# "Inserir dois numeros"
	syscall
	
	jal lerInt
	move $a0, $v0	# $a0 = primeiro argumento
	addi $s7, $zero, 3	# $s7 = 3 : operando deve ser diferente de zero
	jal lerInt
	move $a1, $v0	# $a1 = segundo argumento
	
	jal divisao 	# Efetuar operacao
	move $s0, $v0	# $s0 = quociente
	move $s1, $v1	# $s1 = resto
	
	# "<$a0> / <$a1> = <$s0>"
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, div1
	syscall
	li $v0, 1
	move $a0, $a1
	syscall
	li $v0, 4
	la $a0, eq
	syscall
	li $v0, 1
	move $a0, $s0
	syscall
	li $v0, 4
	la $a0, nl
	syscall
	
	# ">> Resto: <$s1>"
	li $v0, 4
	la $a0, rst
	syscall
	li $v0, 1
	move $a0, $s1
	syscall
	li $v0,4
	la $a0, nl
	syscall
	
	j main

#
#		CASE 5: POTENCIA
#

case_5:
	li $v0, 4
	la $a0, pot0	# "POTENCIA"
	syscall
	
	li $v0, 4
	la $a0, ins2	# "Inserir dois numeros"
	syscall
	
	li $s7, 2	#incica que a operacao nao aceita numeros negativos
	jal lerInt
	move $a0, $v0	# $a0 = primeiro argumento
	jal lerInt
	move $a1, $v0	# $a1 = segundo argumento
	
	jal pot		# Efetuar operacao
	move $s0, $v0	# $s0 = resultado
	
	# "<$a0> ^ <$a1> = <$s0>"
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, pot1
	syscall
	bgez $a1, skip0
	li $v0, 4
	la $a0, par_op
	syscall
skip0:	li $v0, 1
	move $a0, $a1
	syscall
	bgez $a1, skip1
	li $v0, 4
	la $a0, par_cl
	syscall
skip1:	li $v0, 4
	la $a0, eq
	syscall
	li $v0, 36
	move $a0, $s0
	syscall
	li $v0, 4
	la $a0, nl
	syscall
	
	j main

#
#	CASE 6: RAIZ QUADRADA
#

case_6:
	li $v0, 4
	la $a0, sqrt0	# "RAIZ QUADRADA"
	syscall
	
	li $v0, 4
	la $a0, ins1	# "Inserir um numero"
	syscall
	
	# $s7 = 2 indica que a operacao nao aceita numeros negativos
	addi $s7, $zero, 2
	
	jal lerInt		
	move $a0, $v0	# $a0 = primeiro argumento
	
	jal raiz	# Efetuar operacao
	move $s0, $v0	# $s0 = resultado da operacao
	move $s1, $a0	# $s1 = numero lido
	
	# "√<$s1> = <$s0>\n"
	li $v0, 4	
	la $a0, sqrt1
	syscall
	li $v0, 4
	la $a0, par_op
	syscall
	li $v0, 1
	move $a0, $s1
	syscall
	li $v0, 4
	la $a0, par_cl
	syscall
	li $v0, 4
	la $a0, eq
	syscall
	li $v0, 1
	move $a0, $s0
	syscall
	li $v0, 4
	la $a0, nl
	syscall
	
	j main	
	
#
#	CASE 7: TABUADA
#

case_7:
	li $v0, 4
	la $a0, ins1
	syscall			# Imprime a string "digite um numero"
	
	li $s7, 2	#incica que a operacao nao aceita numeros negativos
	jal lerInt
	move $s1, $v0	# $a0 = primeiro argumento

	li $v0, 9
	li $a0, 44
	syscall       		# Aloca espaco na heap
	la $a1, ($v0)		# Coloca o vetor alocado em $a1  
	
	move $a0, $s1  		# Coloca o inteiro lido em $s1 em $a0
	
	jal tabuada 		# Chama a tabuada
	
	la $s0, ($a1) 		# Coloca o vetor retornado em $s0

	addi $t0, $zero, 0
	addi $t1, $zero, 11

	li $v0, 4
	la $a0, tab1    	# Imprime "tabuada de "
	syscall

	li $v0, 1
	move $a0, $s1 		# Imprime o numero digitado
	syscall

	li $v0, 4
	la $a0, tdot		# Imprime ":\n"
	syscall

loop_imprime_tabuada: #<$s1> x <$t0> = <0($s0)>
	bge $t0, $t1, end_imprime_tabuada
	
	li $v0, 36		# Imprime o numero digitado
	move $a0, $s1 
	syscall 

	li $v0, 4
	la $a0, tabXis		# Imprime o sinal da multiplicação
	syscall

	li $v0, 36
	move $a0, $t0 		# Imprime o multiplicador atual
	syscall

	li $v0, 4
	la $a0, eq		# Imprime o sinal de igual
	syscall

	li $v0, 36
	lw $a0, 0($s0)		# Imprime o resultado
	syscall
	
	li $v0, 4
	la $a0, nl		# Imprime nova linha
	syscall	
	
	addi $t0, $t0, 1	# Atualiza iterador
	addi $s0, $s0, 4 	# Atualiza ponteiro do vetor

	j loop_imprime_tabuada
	
end_imprime_tabuada:
	j main

#
#	CASE 8: CALCULO DO IMC
#

case_8:
	li $v0, 4
	la $a0, imc0	# "Inserir altura (m) e peso (kg)"
	syscall
	
	jal lerFloat
	mov.s $f1, $f0	# $f1 = altura
	jal lerFloat
	mov.s $f2, $f0	# $f2 = peso
	
	jal calc_imc	# Efetuar operacao
	mov.s $f1, $f0	# $f1 = resultado da operacao

	# "IMC: <$f1>"
	li $v0, 4
	la $a0, imc1
	syscall
	li $v0, 2
	mov.s $f12, $f1
	syscall
	li $v0, 4
	la $a0, nl
	syscall
	
	j main
	
#
#	CASE 9: FATORIAL
#

case_9:
	li $v0, 4
	la $a0, ins1	# "Inserir um numero"
	syscall
	
	# $s7 = 2 indica que a operacao nao aceita numeros negativos
	addi $s7, $zero, 2
	
	jal lerInt	
	move $a0, $v0	# $a0 = primeiro argumento
	
	jal calc_fat	# Efetuar operacao
	move $s0, $v0	# $s0 = resultado da operacao
#	move $s1, $a0	# $s1 = primeiro argumento
	
	# "<$a0>! = <$s0>\n"
	li $v0, 1
#	move $a0, $s1
	syscall
	li $v0, 4	
	la $a0, fat1
	syscall
	li $v0, 4
	la $a0, eq
	syscall
	li $v0, 1
	move $a0, $s0
	syscall
	li $v0, 4	
	la $a0, nl
	syscall
	
	j main
	
#
#	CASE 10: SEQUENCIA DE FIBONACCI
#

case_10:

	li $v0, 4
	la $a0, phi0		# "FIBONACCI"
	syscall
	
	li $v0, 4
	la $a0, ins2		# "Inserir dois numeros"
	syscall
	
	# $s7 = 2 indica que a operacao nao aceita numeros negativos
	addi $s7, $zero, 2
	
	jal lerInt
	move $a0, $v0		# $v0 = primeiro argumento
	jal lerInt
	move $a1, $v0		# $v1 = segundo argumento

	bge $a0, $a1, phi_error	# Verifica se $a0 < $a1, caso contrario da erro 
	
	move $s1, $a0		# $s1 = primeiro argumento
	move $s2, $a1		# $s2 = segundo argumento
	
	# Imprimir "Numeros de Fibonacci <$a0> a <$a1>:"
	li $v0, 4
	la $a0, phi1
	syscall
	
	li $v0, 1
	move $a0, $s1
	syscall
	
	li $v0, 4
	la $a0, aa
	syscall
	
	li $v0, 1
	move $a0, $s2
	syscall
	
	li $v0, 4
	la $a0, tdot
	syscall
	
	move $a0, $s1		#  Recupera o primeiro argumento, que foi perdido na hora de imprimir a mensagem
							
	jal calc_fib		# Calcula e imprime os numeros da sequencia de Fibonacci no range [<$a0>,<$a1>]
	
	j main
	
# Notifica que um intervalo invalido de numeros foi inserido e retorna para a main
phi_error:
	li $v0, 4
	la $a0, invrg
	syscall

	j main	

#
#	CASE 0: Sair
#

end_calc:	
	li $v0, 10
	syscall
	
#
#	PROCEDIMENTO: SOMA
#
	
soma:				# Retorna o valor $v0 = $a0 + $a1
	addi $sp, $sp, -12	# Aloca espaco na pilha
	sw $a0, 0($sp)		# Guarda o primeiro argumento
	sw $a1, 4($sp)		# Guarda o segundo argumento
	sw $ra, 8($sp)		# Guarda o endereço de retorno

	add $v0, $a0, $a1	# Realiza a soma

	lw $a0, 0($sp)		# Recupera o valor original de $a0
	lw $a1, 4($sp)		# Recupera o valor original de $a1
	lw $ra, 8($sp)		# Recupera o valor original de $ra
	addi $sp, $sp, 12	# Desaloca o espaço utilizado na pilha

	jr $ra 			# Retorna para o endereco contido em $ra

#
#	PROCEDIMENTO: SUBTRACAO
#

subt:				# Retorna o valor $v0 = $a0 - $a1
	addi $sp, $sp, -12	# Aloca espaco na pilha
	sw $a0, 0($sp)		# Guarda o primeiro argumento
	sw $a1, 4($sp)		# Guarda o segundo argumento
	sw $ra, 8($sp)		# Guarda o endereço de retorno

	sub $v0, $a0, $a1	# Realiza a subtracao

	lw $a0, 0($sp)		# Recupera o valor original de $a0
	lw $a1, 4($sp)		# Recupera o valor original de $a1
	lw $ra, 8($sp)		# Recupera o valor original de $ra
	addi $sp, $sp, 12	# Desaloca o espaço utilizado na pilha

	jr $ra 			# Retorna para o endereco contido em $ra

#
#	PROCEDIMENTO: MULTIPLICACAO
#
	
mult:				# Retorna o valor $v0 = $a0 * $a1
	addi $sp, $sp, -12	# Aloca espaco na pilha
	sw $a0, 0($sp)		# Guarda o primeiro argumento
	sw $a1, 4($sp)		# Guarda o segundo argumento
	sw $ra, 8($sp)		# Guarda o endereço de retorno
 
	mul $v0, $a1, $a0	# Realiza a multiplicacao

	lw $a0, 0($sp)		# Recupera o valor original de $a0
	lw $a1, 4($sp)		# Recupera o valor original de $a1
	lw $ra, 8($sp)		# Recupera o valor original de $ra
	addi $sp, $sp, 12	# Desaloca o espaço utilizado na pilha
 
	jr $ra			# Retorna para o endereco contido em $ra
	
#
#	PROCEDIMENTO: DIVISAO 
#
	
divisao:			# Retorna o valor $v0 = $a0 / $a1 e resto $v1
	addi $sp, $sp, -12	# Aloca espaco na pilha
	sw $a0, 0($sp)		# Guarda o primeiro argumento
	sw $a1, 4($sp)		# Guarda o segundo argumento
	sw $ra, 8($sp)		# Guarda o endereço de retorno
	
	div $a0, $a1		# Realiza a divisao
	mflo $v0		# $s0 = quociente
	mfhi $v1		# $s1 = resto

	lw $a0, 0($sp)		# Recupera o valor original de $a0
	lw $a1, 4($sp)		# Recupera o valor original de $a1
	lw $ra, 8($sp)		# Recupera o valor original de $ra
	addi $sp, $sp, 12	# Desaloca o espaço utilizado na pilha
 
	jr $ra			# Retorna para o endereco contido em $ra

#
#	PROCEDIMENTO: POTENCIA
#

pot:					# Retorna o valor de $a0 ^ $a1 em $v0
	addi $sp, $sp, -12		# Aloca espaco na pilha
	sw $a0, 0($sp)			# Guarda o primeiro argumento
	sw $a1, 4($sp)			# Guarda o segundo argumento
	sw $ra, 8($sp)			# Guarda o endereço de retorno

	# Verifica se o expoente eh menor que zero
	bltz $a1, retorna_zero
	
	# Verifica se o expoente eh igual a 1
	beq $a1, $zero, retorna_um	
	
	addi $t0, $zero, 1		# $t0 = 1
	beq $a1, $t0, retorna_a0	# branch se $a1 = $t0
	
	# Verifica se o expoente eh par
	addi $t0, $zero, 2		# $t0 = 2
	div $a1, $t0			# $a1 = $t0 = 2
	mfhi $t0			# $t0 = resto da divisao
	beq $t0, $zero, cont_pot_div2 	# Se o expoente for par, procede-se a cont_pot_div2
	
	# Caso nenhum dos branches acima tenha sido ativado, continua pot
	addi $a1, $a1, -1		# Decrementa o expoente 
	jal pot  			# Faz uma chamada de funcao com pot(a, b-1)

	mul $v0, $v0, $a0       	# Coloca em $v0 o produto entre o valor resultante da chamada e $a0 

	j end_pot			# Finaliza recursao

retorna_zero:
	addi $v0, $zero, 0		# $v0 = 0
	j end_pot			# Finaliza recursao
	
retorna_um:
	addi $v0, $zero, 1		# $v0 = 1
	j end_pot			# Finaliza recursao

retorna_a0:
	add $v0, $zero, $a0 		# $v0 = $a0
	j end_pot			# Finaliza recursao

cont_pot_div2:
	addi $t0, $zero, 2		# $t0 = 2
	div $a1, $t0			# Divide $a1 por 2
	mflo $a1			# Coloca o quociente da divisao em $a1

	jal pot 			# Calcula pot(a, b/2)

	mul $v0, $v0, $v0		# $v0 = pot(a, b/2) * pot(a, b/2)

end_pot:
	lw $a0, 0($sp)			# Recupera o valor original de $a0
	lw $a1, 4($sp)			# Recupera o valor original de $a1
	lw $ra, 8($sp)			# Recupera o valor original de $ra
	addi $sp, $sp, 12		# Desaloca o espaço utilizado na pilha
 
	jr $ra				# Retorna para o endereco contido em $ra
	
#
#	PROCEDIMENTO: CALCULO DA RAIZ QUADRADA 
#
						#UTILIZA O METODO DE NEWTON PARA RESOLUCAO
raiz:						# Retorna o valor $v0 = sqrt($a0)
	addi $sp, $sp, -8			# Aloca espaco na pilha
	sw $a0, 0($sp)				# Guarda o primeiro argumento
	sw $ra, 4($sp)				# Guarda o endereço de retorno
 
	li $s0, 0				# $s0 = 0
	li $t0, 1				# $t0 = 1, erro de cada iteracao
	div $t1, $a0, 2	                        # $t1 = $a0 / 2, chute inicial
	beq $t1,$s0,resp_raiz			# se for raiz 0, vai para a resposta como 0
 	li $t5,0				# $t5 =cont= 0
 	li $s1,100				# $s1=100
loop_raiz:   
	beq $t0, $s0, end_loop_raiz		# Finaliza repeticao quando o erro for igual a 0
	beq $t5,$s1,end_loop_raiz		#Termina se passou pelo loop 100 vezes
	move $t2, $t1				# $t2 = $t1
	
	div $t3, $a0, $t1			# $t3 = $a0 / $t1
	add $t3, $t1, $t3			# $t3 = $t1 + $t3
	
	div $t1, $t3, 2				# $t1 = $t3 / 2
	
	sub $t0, $t1, $t2			# $t0 = $t1 - $t2
	addi $t5,$t5,1
	j loop_raiz				# Reinicia loop
 
end_loop_raiz:
	mul $s2,$t1,$t1
	ble  $s2,$a0,resp_raiz			#checa se o resultado da funcao é maior que meu numero
	addi $t1,$t1,-1				# se for arredonda para baixo
	
resp_raiz:
	move $v0, $t1				# $v0 = $t1
	lw $a0, 0($sp)				# Recupera o valor original de $a0
	lw $ra, 4($sp)				# Recupera o valor original de $ra
	addi $sp, $sp, 8			# Desaloca o espaco utilizado na pilha
 
	jr $ra					# Retorna para o endereco contido em $ra

#
#	PROCEDIMENTO: TABUADA
#
  
# Este procedimento retona um endereco de vetor de tamanho 10 e nao imprime nenhum valor na tela. 
# O retorno da funcao eh colocado no vetor passado no argumento 1.
tabuada:
	addi $sp, $sp, -12		# Aloca espaco na pilha
	sw $a0, 0($sp)			# Guarda o primeiro argumento, numero que indica qual a tabuada a ser retornada
	sw $a1, 4($sp)			# Guarda o segundo argumento, vetor no qual a tabuada sera colocada
	sw $ra, 8($sp)			# Guarda o endereço de retorno	

	addi $t0, $zero, 0		# Cria um iterador para o loop (it = 0,1,2,..,10, 11)
	addi $t1, $zero, 11		# Cria um limite para o loop, $t1 = 11

loop_tab:	
	beq  $t0, $t1, end_loop_tab	# Interrompe o loop se $t0 = 11
	mul  $t2, $a0, $t0		# Guarda o valor da multiplicação em $t2

	sw $t2, 0($a1)			# Guarda o valor da multiplicação no vetor

	addi $a1, $a1, 4       		# Incrementa a posição do vetor indicado por $a1
	addi $t0, $t0, 1		# Incrementa o iterador do loop

	j loop_tab

end_loop_tab:
	lw $a0, 0($sp)			# Recupera o valor original do primeiro argumento
	lw $a1, 4($sp)			# Recupera o valor original do segundo argumento
	lw $ra, 8($sp)			# Recupera o valor original do endereco de retorno
	addi $sp, $sp, 12		# Desaloca espaco da pilha

	jr $ra				# Retorna para o endereco contido em $ra
			
									
#
#	PROCEDIMENTO: CALCULO DO IMC
#
 
calc_imc:
	addi $sp, $sp, -12	# Aloca espaco na pilha
	s.s $f1, 0($sp)		# Guarda o primeiro argumento (altura)
	s.s $f2, 4($sp)		# Guarda o segundo argumento (peso)
	sw $ra, 8($sp)		# Guarda o endereço de retorno
	
	mul.s $f3, $f1, $f1	# $f3 = $f1 * $f1 = altura * altura
	div.s $f0, $f2, $f3	# $f0 = $f2 / $f3 = peso / (altura * altura)
 
	l.s $f1, 0($sp)		# Recupera o valor original de $f1
	l.s $f2, 4($sp)		# Recupera o valor original de $f2
	lw $ra, 8($sp)		# Recupera o valor original de $ra
	addi $sp, $sp, 12	# Desaloca o espaco utilizado na pilha
 
	jr $ra			# Retorna para o endereco contido em $ra

#
#	PROCEDIMENTO: CALCULO DO FATORIAL
#
	
calc_fat:	
	addi $sp, $sp, -8		# Aloca espaco na pilha
	sw $a0, 0($sp)			# Guarda o primeiro argumento
	sw $ra, 4($sp)			# Guarda o endereço de retorno
	
	addi $t0, $zero, 1		# $t0 = 1, condicao de parada
	addi $v0, $zero, 1		# $v0 = 1, retorno da funcao
	
loop_fat:
	ble $a0, $t0, end_loop_fat	# Finaliza repeticao se $a0 <= 1
	mul $v0, $v0, $a0		# $v0 = $v0 * $a0
	addi $a0, $a0, -1		# $a0 = $a0 - 1
	
	j loop_fat			# Reinicia loop
	
end_loop_fat:
	lw $a0, 0($sp)			# Recupera o valor original de $a0
	lw $ra, 4($sp)			# Recupera o valor original de $ra
	addi $sp, $sp, 8		# Desaloca o espaco utilizado na pilha
 
	jr $ra				# Retorna para o endereco contido em $ra
	
#
#	PROCEDIMENTO: SEQUENCIA DE FIBONACCI
#
	
calc_fib:
	addi $sp, $sp, -36		# Aloca espaco na pilha
	sw $a0, 0($sp)			# Guarda o primeiro argumento
	sw $a1, 4($sp)			# Guarda o segundo argumento
	sw $ra, 8($sp)			# Guarda o endereço de retorno
	sw $t0, 12($sp)			# Guarda o valor original de $t0 para nao sobrescreve-lo
	sw $t1, 16($sp)			# Guarda o valor original de $t1 para nao sobrescreve-lo
	sw $t2, 20($sp)			# Guarda o valor original de $t2 para nao sobrescreve-lo
	sw $t3, 24($sp)			# Guarda o valor original de $t3 para nao sobrescreve-lo
	sw $t4, 28($sp)			# Guarda o valor original de $t4 para nao sobrescreve-lo
	sw $t5, 32($sp)			# Guarda o valor original de $t5 para nao sobrescreve-lo
	
	move $t3, $a0			# Salva o primeiro argumento em $t3
	move $t4, $a1			# Salva o segundo argumento em $t4	
	
	li $t0, 1			# $t0 = 0, valor F(0)
	li $t1, 1			# $t1 = 1, valor F(1)
	
	li $t5, 1			# Guarda em $t5 que o numero atual da sequencia eh o primeiro
	
	bgt $t3, $t5, goto_fib_2        #verifica se o primeiro elemento da sequencia esta no intervalo
	
	# Imprime o primeiro valor da sequencia se ele estiver no intervalo. 
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 4			# Imprime um espaco
	la $a0, space
	syscall

goto_fib_2:

	addi $t5, $t5, 1		# Incrementa $t5 para indicar que o numero atual da sequencia eh o segundo

	blt $t5, $t3, loop_fib 		#verifica se FIB(2) esta no intervalo
 
	# Imprime o segundo valor da sequencia se ele estiver no intervalo.
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 4			# Imprime um espaco
	la $a0, space
	syscall		
					
loop_fib:

	addi $t5, $t5, 1		# Incrementa $t5 para indicar que o proximo numero da sequencia esta sendo calculado
	bgt $t5, $t4, end_loop_fib 	# Finaliza o loop se o intervalo jah foi ultrapassado ($t5 > $t4: acima do maximo)

	# Calcula o proximo valor da sequencia
	add $t2, $t0, $t1 		# $t2 = $t0 + $t1 (F(n) = F(n-1) + F(n-2))
	
	blt $t5, $t3, nao_printa_phi 	# Verifica se o valor eh maior ou igual ao minimo antes de printar ($t2 < $t3: a baixo do minimo)
	
	li $v0, 1			# Imprime o novo valor da sequencia
	move $a0, $t2
	syscall
	
	li $v0, 4			# Imprime um espaco
	la $a0, space
	syscall
	
	nao_printa_phi: 
	
	move $t0, $t1 			# Move os valores da sequencia "um registrador para baixo" para poder calcular o proximo
	move $t1, $t2
	
	j loop_fib			# Reinicia loop
	
end_loop_fib:

	lw $a0, 0($sp)			# Recupera o valor original de $a0
	lw $a1, 4($sp)			# Recupera o valor original de $a1
	lw $ra, 8($sp)			# Recupera o valor original de $ra
	lw $t0, 12($sp)			# Recupera o valor original de $t0
	lw $t1, 16($sp)			# Recupera o valor original de $t1
	lw $t2, 20($sp)			# Recupera o valor original de $t2
	lw $t3, 24($sp)			# Recupera o valor original de $t3
	lw $t4, 28($sp)			# Recupera o valor original de $t4
	lw $t5, 32($sp)			# Recupera o valor original de $t5
	addi $sp, $sp, 36		# Desaloca o espaco utilizado na pilha
 
	jr $ra				# Retorna para o endereco contido em $ra
	
#
#	FUNCOES AUXILIARES
#

lerInt:
	li $v0, 5		# Lê inteiro
	syscall
	
	addi $s6, $zero, 0	# $s6 = 0 : operacao nao possui restricoes relativas aos operandos.
	beq $s7, $s6, return
	
	addi $s6, $zero, 1	# $s6 = 1 : operacao aceita operandos de, no maximo, 15 bytes.
	beq $s7, $s6, bit15
	
	addi $s6, $zero, 2	# $s6 = 2 : operacao nao aceita operandos negativos.
	beq $s7, $s6, no_neg
	
	addi $s6, $zero, 3	# $s6 = 3 : operacao nao aceita operando igual a zero.
	beq $s7, $s6, no_zero
	
return:	jr $ra
	
bit15:	
	addi $t6, $zero, 32767	# Limite superior
	addi $t7, $zero, -32767	# Limite inferior
	bgt $v0, $t6, err_msg0	# Caso o valor lido seja maior que o limite superior, exibe mensagem de erro
	blt $v0, $t7, err_msg0	# Caso o valor lido seja menor que o limite inferior, exibe mensagem de erro
	j return		# Caso não haja erro, retorna o valor lido em $v0
	
no_neg:	
	bltz $v0, err_msg1	# Caso o valor lido seja menor que zero, exibe mensagem de erro
	j return
	
no_zero:
	beqz $v0, err_msg2	# Caso o valor lido seja igual a zero, exibe mensagem de erro
	j return
	
err_msg0:
	li $v0, 4
	la $a0, err0		# "ERRO: Valor invalido! Os argumentos devem ser estar entre -32767 e 32767."
	syscall
	j main

err_msg1:
	li $v0, 4
	la $a0, err1		# "ERRO: Valor invalido! O(s) argumento(s) não deve(m) ser negativo(s)."
	syscall
	j main

err_msg2:
	li $v0, 4
	la $a0, err2		# "ERRO: Valor invalido! Este argumento deve ser diferente de zero."
	syscall
	j main	
	
lerFloat:
	li $v0, 6		# Lê número de ponto flutuante
	syscall
	
	mtc1 $zero, $f11	# Converte o valor inteiro 0 para ponto flutuante e o armazena em $f1
	c.le.s $f0, $f11	# Caso o valor lido seja menor que zero,
	bc1t err_msg1		# exibe mensagem de erro
	
	jr $ra			# Caso não haja erro, retorna o valor lido em $f0
