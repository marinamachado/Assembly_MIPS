	.data
menu0:	.asciiz "\n\tSELECIONAR OPERACAO DESEJADA\n1 - Soma\t\t6 - Raiz quadrada\n2 - Subtracao\t\t7 - Tabuada\n"
menu1:	.asciiz	"3 - Multiplicacao\t8 - Calculo do IMC\n4 - Divisao\t\t9 - Fatorial\n5 - Potencia\t\t10 - Sequencia de Fibonacci\n0 - SAIR\n"

ins1:	.asciiz "> Inserir um numero\n"
ins2:	.asciiz "> Inserir dois numeros\n"

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
sqrt1:	.asciiz "√"

imc:	.asciiz "IMC: "

fat0:	.asciiz "\tFATORIAL\n"
fat1:	.asciiz "!"

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
	li $v0, 4		# chamada de servico 4: impressao de string
	la $a0, menu0
	syscall
	li $v0, 4
	la $a0, menu1
	syscall
	
	# ler opcao
	li $v0, 5		# chamada de servico 5: leitura de inteiro
	syscall
	move $t0, $v0		# t0 = numero digitado
	
	# caso opcao = 1
	addi $t1, $zero, 1
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
	addi $t1, $zero, 0	# sair do programa
	beq $t0, $t1, end_calc
	
	j main

#################################################################################
#										#
#				CASE 1: SOMA					#
#										#
#################################################################################
	
case_1:
	li $v0, 4
	la $a0, sum0	# "SOMA"
	syscall
	
	li $v0, 4
	la $a0, ins2	# "Inserir dois numeros"
	syscall
	
	jal lerInt
	move $a0, $v0	# $v0 = primeiro argumento
	jal lerInt
	move $a1, $v0	# $v1 = segundo argumento
	
	jal soma	# efetua a operacao
	move $s0, $v0	# $s0 = resultado
	
	# imprimir "<$v0> + <$v1> = <$s0>"
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

#################################################################################
#										#
#			   CASE 3: MULTIPLICACAO				#
#										#
#################################################################################

case_3:
	li $v0, 4
	la $a0, mul0	# "MULTIPLICACAO"
	syscall
	
	li $v0, 4
	la $a0, ins2	# "Inserir dois numeros"
	syscall
		
	jal lerInt
	move $a0, $v0	# $v0 = primeiro argumento
	jal lerInt
	move $a1, $v0	# $v1 = segundo argumento
	
	jal mult	# efetua a operacao
	move $s0, $v0	# $s0 = resultado
	
	# imprimir "<$v0> * <$v1> = <$s0>"
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
	
#################################################################################
#										#
#				CASE 4: DIVISAO					#
#										#
#################################################################################

case_4:
	li $v0, 4
	la $a0, div0	# "DIVISAO"
	syscall
	
	li $v0, 4
	la $a0, ins2	# "Inserir dois numeros"
	syscall
	
	jal lerInt
	move $a0, $v0	# $v0 = primeiro argumento
	jal lerInt
	move $a1, $v0	# $v1 = segundo argumento
	
	jal divisao
	move $s0, $v0	# $s0 = quociente
	move $s1, $v1	# $s1 = resto
	
	# imprimir "<$v0> / <$v1> = <$s0>"
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
	
	# imprimir ">> Resto: <$s1>"
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
	la $a0, sqrt0	# "RAIZ QUADRADA"
	syscall
	
	li $v0, 4
	la $a0, ins1	# "Inserir um numero"
	syscall
	
	jal lerInt	# ler inteiro
	move $a0, $v0	# $a0 = primeiro argumento
	
	jal raiz	# efetua operacao
	move $s0, $v0	# $s0 = resultado da operacao
	move $s1, $a0	# $s1 = numero lido
	
	# imprimir "√<$s1> = <$s0>\n"
	li $v0, 4	
	la $a0, sqrt1
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
#			  CASE 8: CALCULO DO IMC				#
#										#
#################################################################################

case_8:
	li $v0, 4
	la $a0, ins2	# "Inserir dois numeros"
	syscall
	
	jal lerFloat
	mov.s $f1, $f0	# $v0 = primeiro argumento
	jal lerFloat
	mov.s $f2, $f0	# $v1 = segundo argumento
	
	jal calc_imc	# efetua a operacao
	mov.s $f1, $f0	# $s0 = resultado da operacao

	# imprimir "IMC: <$s0>"
	li $v0, 4
	la $a0, imc
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
	
	jal lerInt	# ler inteiro
	move $a0, $v0	# $a0 = primeiro argumento
	
	jal calc_fat	# efetua operacao
	move $s0, $v0	# $s0 = resultado da operacao
	move $s1, $a0	# $s1 = primeiro argumento
	
	# "<$s1>! = <$s0>\n"
	li $v0, 1
	move $a0, $s1
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
	
#################################################################################
#										#
#			     PROCEDIMENTO: SOMA					#
#										#
#################################################################################
	
soma:				# retorna o valor $v0 = $a0 + $a1
	addi $sp, $sp, -12	# aloca espaco na pilha
	sw $a0, 0($sp)		# guarda o primeiro argumento
	sw $a1, 4($sp)		# guarda o segundo argumento
	sw $ra, 8($sp)		# guarda o endereço de retorno

	add $v0, $a0, $a1	# realiza a soma

	lw $a0, 0($sp)		# recupera o valor original de $a0
	lw $a1, 4($sp)		# recupera o valor original de $a1
	lw $ra, 8($sp)		# recupera o valor original de $ra
	addi $sp, $sp, 12	# desaloca o espaço utilizado na pilha

	jr $ra 			# retorna para o endereco contido em $ra

#################################################################################
#										#
#			   PROCEDIMENTO: MULTIPLICACAO				#
#										#
#################################################################################
	
mult:				# retorna o valor $v0 = $a0 * $a1
	addi $sp, $sp, -12	# aloca espaco na pilha
	sw $a0, 0($sp)		# guarda o primeiro argumento
	sw $a1, 4($sp)		# guarda o segundo argumento
	sw $ra, 8($sp)		# guarda o endereço de retorno
 
	mul $v0, $a1, $a0	# realiza a multiplicacao

	lw $a0, 0($sp)		# recupera o valor original de $a0
	lw $a1, 4($sp)		# recupera o valor original de $a1
	lw $ra, 8($sp)		# recupera o valor original de $ra
	addi $sp, $sp, 12	# desaloca o espaço utilizado na pilha
 
	jr $ra			# retorna para o endereco contido em $ra
	
#################################################################################
#										#
#			    PROCEDIMENTO: DIVISAO				#
#										#
#################################################################################
	
divisao:			# retorna o valor $v0 = $a0 / $a1 e resto $v1
	addi $sp, $sp, -12	# aloca espaco na pilha
	sw $a0, 0($sp)		# guarda o primeiro argumento
	sw $a1, 4($sp)		# guarda o segundo argumento
	sw $ra, 8($sp)		# guarda o endereço de retorno
	
	div $a0, $a1		# realiza a divisao
	mflo $v0		# s0 = quociente
	mfhi $v1		# s1 = resto

	lw $a0, 0($sp)		# recupera o valor original de $a0
	lw $a1, 4($sp)		# recupera o valor original de $a1
	lw $ra, 8($sp)		# recupera o valor original de $ra
	addi $sp, $sp, 12	# desaloca o espaço utilizado na pilha
 
	jr $ra			# retorna para o endereco contido em $ra
	
#################################################################################
#										#
#			    PROCEDIMENTO: POTENCIA				#
#										#
#################################################################################

pot:
	addi $sp, $sp, -12		# aloca espaco na pilha
	sw $a0, 0($sp)			# coloca primeiro argumento na pilha
	sw $a1, 4($sp)			# coloca segundo argumento na pilha
	sw $ra, 8($sp)			# coloca o endereco de retorno na pilha

	bltz $a1, retorna_zero
	
	beq $a1, $zero, retorna_um	# verifica se o expoente eh 1
	
	addi $t0, $zero, 1		# $t0 = 1
	beq $a1, $t0, retorna_a0	# branch se $a1 = $t0
	
	# verifica se o expoente eh par
	addi $t0, $zero, 2		# $t0 = 2
	div $a1, $t0			# $a1 = $t0 = 2
	mfhi $t0			# $t0 = resto da divisao
	beq $t0, $zero, cont_pot_div2 	# se o expoente for par, procede-se a cont_pot_div2
	
	# continua_pot caso nenhuma dos branches acima tenha sido ativado
	addi $a1, $a1, -1	# decrementa o expoente 
	jal pot  		# faz uma chamada de funcao com pot(a, b-1)

	mul $v0, $v0, $a0       # coloca em $v0 o produto entre o valor resultante da chamada e $a0 

	j end_pot		# vai para o fim da recursao

retorna_zero:
	addi $v0, $zero, 0	# $v0 = 0
	j end_pot		# vai para o fim da recursao
	
retorna_um:
	addi $v0, $zero, 1	# $v0 = 1
	j end_pot		# vai para o fim da recursao

retorna_a0:
	add $v0, $zero, $a0 	# $v0 = $a0
	j end_pot		# vai para o fim da recursao

cont_pot_div2:
	addi $t0, $zero, 2	
	div $a1, $t0		# divide $a1 por 2
	mflo $a1		# coloca o quociente da divisao em $a1

	jal pot 		# calcula pot(a, b/2)

	mul $v0,$v0,$v0		# $v0 = pot(a, b/2) * pot(a, b/2)

end_pot:
	lw $a0, 0($sp)		# recupera o valor original de $a0
	lw $a1, 4($sp)		# recupera o valor original de $a1
	lw $ra, 8($sp)		# recupera o valor original de $ra
	addi $sp, $sp, 12	# desaloca o espaço utilizado na pilha
 
	jr $ra			# retorna para o endereco contido em $ra
	
#################################################################################
#										#
#		      PROCEDIMENTO: CALCULO DA RAIZ QUADRADA			#
#										#
#################################################################################
	
raiz:				# retorna o valor $v0 = sqrt($a0)
	addi $sp, $sp, -8	# aloca espaco na pilha
	sw $a0, 0($sp)		# guarda o primeiro argumento
	sw $ra, 4($sp)		# guarda o endereço de retorno
 
	li $s0, 0		# $s0 = 0
	li $t0, 1		# $t0 = 1, erro de cada iteracao
	div $t1, $a0, 2		# $t1 = $a0 / 2, chute inicial
 
loop_raiz:   
	beq $t0, $s0, end_loop_raiz	# finaliza repeticao quando o erro for igual a 0
	
	move $t2, $t1			# $t2 = $t1
	
	div $t3, $a0, $t1		# $t3 = $a0 / $t1
	add $t3, $t1, $t3		# $t3 = $t1 + $t3
	
	div $t1, $t3, 2			# $t1 = $t3 / 2
	
	sub $t0, $t1, $t2		# $t0 = $t1 - $t2
	
	j loop_raiz			# reinicia loop
 
end_loop_raiz:
	move $v0, $t1		# $v0 = $t1
	
	lw $a0, 0($sp)		# recupera o valor original de $a0
	lw $ra, 4($sp)		# recupera o valor original de $ra
	addi $sp, $sp, 8	# desaloca o espaco utilizado na pilha
 
	jr $ra			# retorna para o endereco contido em $ra
	
#################################################################################
#										#
#		          PROCEDIMENTO: CALCULO DO IMC				#
#										#
#################################################################################
 
calc_imc:
	addi $sp,$sp,-12	# aloca espaco na pilha
	s.s $f1, 0($sp)		# guarda o primeiro argumento (altura)
	s.s $f2, 4($sp)		# guarda o segundo argumento (peso)
	sw $ra, 8($sp)		# guarda o endereço de retorno
 
	mul.s $f3, $f1, $f1	# $f3 = $f1 * $f1 = altura * altura
	div.s $f0, $f2, $f3	# $f0 = $f2 / $f3 = peso / (altura * altura)
 
	l.s $f1, 0($sp)		# recupera o valor original de $f1
	l.s $f2, 4($sp)		# recupera o valor original de $f2
	lw $ra, 8($sp)		# recupera o valor original de $ra
	addi $sp, $sp, 12	# desaloca o espaco utilizado na pilha
 
	jr $ra			# retorna para o endereco contido em $ra
	
#################################################################################
#										#
#			 PROCEDIMENTO: CALCULO DO FATORIAL			#
#										#
#################################################################################
	
calc_fat:	
	addi $sp, $sp, -8	# aloca espaco na pilha
	sw $a0, 0($sp)		# guarda o primeiro argumento
	sw $ra, 8($sp)		# guarda o endereço de retorno
	
	addi $t0, $zero, 1	# $t0 = 1, condicao de parada
	addi $v0, $zero, 1	# $v0 = 1, retorno da funcao
	
loop_fat:
	ble $a0, $t0, end_loop	# finaliza repeticao se $a0 <= 1
	mul $v0, $v0, $a0	# $v0 = $v0 * $a0
	addi $a0, $a0, -1	# $a0 = $a0 - 1
	
	j loop_fat		# reinicia loop
	
end_loop:
	lw $a0, 0($sp)		# recupera o valor original de $a0
	lw $ra, 4($sp)		# recupera o valor original de $ra
	addi $sp, $sp, 8	# desaloca o espaco utilizado na pilha
 
	jr $ra			# retorna para o endereco contido em $ra
	
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
