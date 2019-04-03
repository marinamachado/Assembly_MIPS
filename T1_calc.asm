	.data
menu0:	.asciiz "\n\tSELECIONAR OPERACAO DESEJADA\n1 - Soma\n2 - Subtracao\n3 - Multiplicacao\n4 - Divisao\n5 - Potencia\n"
menu1:	.asciiz	"6 - Raiz quadrada\n7 - Tabuada\n8 - Calculo do IMC\n9 - Fatorial\n10 - Sequencia de Fibonacci\n0 - SAIR\n"

ins1:	.asciiz ">> Inserir um numero:\n"
ins2:	.asciiz ">> Inserir dois numeros:\n"

sum0:	.asciiz "\t SOMA\n"
sum1:	.asciiz " + "

sub0:	.asciiz "\tSUBTRACAO"
sub1:	.asciiz " - "

mul0:	.asciiz "\tMULTIPLICACAO"
mul1:	.asciiz " * "

div0:	.asciiz "\tDIVISAO\n"
div1:	.asciiz " / "
rst:	.asciiz "> Resto: "

pot:	.asciiz "^"

sqrt:	.asciiz "√"

imc:	.asciiz "IMC: "

fat:	.asciiz "!"

eq:	.asciiz " = "
nl:	.asciiz "\n"

	.text
	.globl main

#################################################################################
#										#
#				FUNCAO PRINCIPAL				#
#										#
#################################################################################

main:
	# impressao do menu
	li $v0, 4				# numero de servico 4: impressao de string
	la $a0, menu0
	syscall
	li $v0, 4
	la $a0, menu1
	syscall
	
	# ler opcao
	li $v0, 5				# numero de servico 5: leitura de inteiro
	syscall
	move $t0, $v0			# t0 = opcao escolhida por usuario
	
	# caso opcao = 1
	addi $t0, $zero, 1
	beq $t0, $t1, case_1

	# caso opcao = 2

	# caso opcao = 3
	addi $t1, $zero, 3
	beq $t0, $t1, case_3	# multiplicacao

	# caso opcao = 4	
	addi $t1, $zero, 4
	beq $t0, $t1, case_4	# divisao
	
	# caso opcao = 5

	# caso opcao = 6
	addi $t1, $zero, 6
	beq $t0, $t1, case_6	# raiz quadrada
	
	# caso opcao = 7

	# caso opcao = 8
	addi $t1, $zero, 8
	beq $t0, $t1, case_8	# calculo do IMC
	
	#caso opcao = 9
	addi $t1, $zero, 9
	beq $t0, $t1, case_9

	# caso opcao = 10


	# caso opcao = 0
	addi $t1, $zero, 0		# sair do programa
	beq $t0, $t1, end_calc
	
	j main

#################################################################################
#																				#
#							   		CASO 1: SOMA								#
#																				#
#################################################################################

#################################################################################
#																				#
#							   CASO 3: MULTIPLICACAO							#
#																				#
#################################################################################

case_3:
	li $v0, 4
	la $a0, ins2		# "Inserir dois numeros"
	syscall
	
	jal lerInt
	move $a0, $v0	# v0 = a

	jal lerInt
	move $a1, $v0	# v1 = b
	
	jal mult
	move $s0, $v0
	
	li $v0, 1	# imprimir "a * b = c"
	syscall
	li $v0, 4
	la $a0, mul
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
	
#################################################################################
#										#
#				CASE 4: DIVISAO					#
#										#
#################################################################################

case_4:
	li $v0, 4
	la $a0, div0		# "DIVISAO"
	syscall
	
	li $v0, 4
	la $a0, ins2		# "Inserir dois numeros"
	syscall
	
	jal lerInt
	move $a0, $v0	# v0 = a

	jal lerInt
	move $a1, $v0	# v1 = b
	
	jal divisao
	move $s0, $v0	# s0 = quociente
	move $s1, $v1	# s1 = resto
	
	li $v0, 1	# imprimir "a / b = c"
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
	
#################################################################################
#										#
#				CASE 6: RAIZ QUADRADA				#
#										#
#################################################################################

case_6:
	li $v0, 4
	la $a0, ins1	# "Inserir um numero"
	syscall
	
	jal lerInt	# ler inteiro
	move $a0, $v0	# $a0 = numero lido
	
	jal raiz	# calcula raiz do numero lido
	move $s0, $v0	# $s0 = resultado do calculo
	move $s1, $a0	# $s1 = numero lido
	
	# Imprime "√<$s1> = <$s0>\n"
	li $v0, 4	
	la $a0, sqrt
	syscall
	li $v0, 1
	move $a0, $s1
	syscall
	li $v0, 4
	la $a0, eq
	syscall
	li $v0, 5
	move $a0, $s0
	syscall
	li $v0, 4
	la $a0, nl
	syscall
	
	j main	

#################################################################################
#										#
#				CASE 8: CALCULO DO IMC				#
#										#
#################################################################################

case_8:
	li $v0, 4
	la $a0, ins2		# "Inserir dois numeros"
	syscall
	
	jal lerFloat
	mov.s $f1, $f0	# v0 = a

	jal lerFloat
	mov.s $f2, $f0	# v1 = b
	
	jal calc_imc
	mov.s $f1, $f0	# s0 = IMC

	li $v0, 4
	la $a0, imc	# imprimir "IMC: s0\n"	
	syscall
	li $v0, 2
	mov.s $f12, $f1
	syscall
	li $v0, 4
	la $a0, nl
	syscall
	
	j main
	
#################################################################################
#										#
#				CASE 9: FATORIAL				#
#										#
#################################################################################

case_9:
	li $v0, 4
	la $a0, ins1	# "Inserir um numero"
	syscall
	
	jal lerInt	# ler numero
	move $a0, $v0	# $a0 = numero lido
	
	jal calc_fat	# calcula o fatorial de $a0
	move $s1, $a0	# $s1 = numero lido
	move $s0, $v0	# $s0 = resultado da funcao
	
	# "<$s1>! = <$s0>\n"
	li $v0, 1
	move $a0, $s1
	syscall
	li $v0, 4	
	la $a0, fat
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
	
#################################################################################
#										#
#				FUNCAO DA MULTIPLICACAO				#
#										#
#################################################################################
	
mult:
	addi $sp,$sp,-12  
	sw $a1, 8($sp)		# empilha os dois paramentros e o $ra
	sw $a0, 4($sp)
	sw $ra, 0($sp)
 
	mul $v0, $a1, $a0	# multiplica os dois parametros e salva em $v0

	lw $a1, 8($sp)		# acaba a funcao e desempilha
	lw $a0, 4($sp)
	lw $ra, 0($sp)
	addi $sp,$sp,12 
 
	jr $ra
	
#################################################################################
#										#
#				FUNCAO DA DIVISAO				#
#										#
#################################################################################
	
divisao:
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	
	div $a0, $a1
	mflo $v0	# s0 = quociente
	mfhi $v1	# s1 = resto
	
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	addi $sp, $sp, 12
	jr $ra
	
#################################################################################
#										#
#		      FUNCAO DO CALCULO DA RAIZ QUADRADA			#
#										#
#################################################################################
	
raiz:
	addi $sp,$sp,-8
	sw $a0, 4($sp)	# numero cuja raiz sera calculada
	sw $ra, 0($sp)
 
	li $s0, 0	# salva em s0, o numero 0
	li $t0, 1	# $0 =erro de cada iteracao, comeca com 1
	div $t1, $a0, 2	# $t1 - y, chute inicial
 
loop_raiz:   
	beq $t0, $s0, end_loop_raiz	# continua ate o erro ser igual a 0
	move $t2, $t1			#double yAnt=y;
	div $t3, $a0, $t1
	add $t3, $t1, $t3
	div $t1, $t3, 2
	sub $t0, $t1, $t2
	j loop_raiz
 
end_loop_raiz:
	move $v0, $t1
	lw $a0, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 8 
	jr $ra
	
#################################################################################
#										#
#			    FUNCAO DO CALCULO DO IMC				#
#										#
#################################################################################
 
calc_imc:
	addi $sp,$sp,-12
	s.s $f2, 8($sp)		# peso ($f2)
	s.s $f1, 4($sp)		# altura ($f1)
	sw $ra, 0($sp)
 
	mul.s $f3, $f1, $f1	# Salva em $f3 a altura ao quadrado ($f1 * $f1)
	div.s $f0, $f2, $f3	# Salva em $f0 o imc = peso/alturaˆ2
 
	l.s $f2, 8($sp)		# desempilha
	l.s $f1, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 12
 
	jr $ra
	
#################################################################################
#										#
#			FUNCAO DO CALCULO DO FATORIAL				#
#										#
#################################################################################
	
calc_fat:	
	addi $sp, $sp, -8	# aloca espaço pra dois inteiros na pilha
	sw $a0, 0($sp)		# salva o numero lido na 1a posicao da pilha
	sw $ra, 4($sp)		# salva o end. de retorno na 2a posicao da pilha
	
	addi $t0, $zero, 1	# condicao de parada
	addi $v0, $zero, 1	# fat = 1
	
loop_fat:
	ble $a0, $t0, end_loop
	mul $v0, $v0, $a0
	addi $a0, $a0, -1
	
	j loop_fat
	
end_loop:
	lw $a0, 0($sp)
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	
	jr $ra

#################################################################################
#										#
#				FUNCOES AUXILIARES				#
#										#
#################################################################################

end_calc:	
	li $v0, 10
	syscall
	
lerInt:
	li $v0, 5
	syscall
	jr $ra
	
lerFloat:
	li $v0, 6
	syscall
	jr $ra
	
	
	
	
	
