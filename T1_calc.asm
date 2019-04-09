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
sqrt1:	.asciiz "sqrt"

imc0:	.asciiz "Inserir altura (m) e peso (kg)\n"
imc1:	.asciiz "IMC: "

fat0:	.asciiz "\tFATORIAL\n"
fat1:	.asciiz "!"

phi0:	.asciiz "\tFIBONACCI\n"
phi1:	.asciiz "Numeros de Fibonacci entre "
phi2:	.asciiz ":\n"
phi3:	.asciiz "ERRO: O segundo valor deve ser maior do que o primeiro!\n"

ee:	.asciiz " e "
eq:	.asciiz " = "
nl:	.asciiz "\n"
space:	.asciiz " "
par_op:	.asciiz "("
par_cl:	.asciiz ")"

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
	li $v0, 5		# Chamada de servico 5: leitura de inteiro
	syscall
	move $t0, $v0	# $t0 = numero digitado
	
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
#		CASE 5: POTENCIA			#
#

case_5:
	li $v0, 4
	la $a0, pot0	# "POTENCIA"
	syscall
	
	li $v0, 4
	la $a0, ins2	# "Inserir dois numeros"
	syscall
		
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
	li $v0, 1
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
#	 CASE 10: SEQUENCIA DE FIBONACCI	#
#

case_10:

	li $v0, 4
	la $a0, phi0	# "FIBONACCI"
	syscall
	
	li $v0, 4
	la $a0, ins2	# "Inserir dois numeros"
	syscall
		
	jal lerInt
	move $a0, $v0	# $a0 = primeiro argumento
	jal lerInt
	move $a1, $v0	# $a1 = segundo argumento

	# verifica se $a0 < $a1 e, caso contrario, da erro 
	bge $a0, $a1, phi_error 
			
	jal calc_fat	# Efetuar operacao
	move $s0, $v0	# $s0 = resultado da operacao
	move $s1, $a0	# $s1 = primeiro argumento
	move $s2, $a1	# $s1 = seundo argumento
	
	# "Numeros de Fibonacci entre <$a0> e <$a1>:"
	li $v0, 4
	la $a0, phi1
	syscall	
	li $v0, 1
	move $a0, $s1
	syscall
	li $v0, 4
	la $a0, ee
	syscall	
	li $v0, 1
	move $a0, $s2
	syscall	
	li $v0, 4
	la $a0, phi2
	syscall
	
	j main
	
#	Se os argumentos forem invalidos, 
# imprimir mensagem de erro e retornar para a main
phi_error:
	li $v0, 4
	la $a0, phi3
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
	
mult:					# Retorna o valor $v0 = $a0 * $a1
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

raiz:						# Retorna o valor $v0 = sqrt($a0)
	addi $sp, $sp, -8			# Aloca espaco na pilha
	sw $a0, 0($sp)				# Guarda o primeiro argumento
	sw $ra, 4($sp)				# Guarda o endereço de retorno
 
	li $s0, 0				# $s0 = 0
	li $t0, 1				# $t0 = 1, erro de cada iteracao
	div $t1, $a0, 2				# $t1 = $a0 / 2, chute inicial
 
loop_raiz:   
	beq $t0, $s0, end_loop_raiz		# Finaliza repeticao quando o erro for igual a 0
	
	move $t2, $t1				# $t2 = $t1
	
	div $t3, $a0, $t1			# $t3 = $a0 / $t1
	add $t3, $t1, $t3			# $t3 = $t1 + $t3
	
	div $t1, $t3, 2				# $t1 = $t3 / 2
	
	sub $t0, $t1, $t2			# $t0 = $t1 - $t2
	
	j loop_raiz				# Reinicia loop
 
end_loop_raiz:
	move $v0, $t1				# $v0 = $t1
	
	lw $a0, 0($sp)				# Recupera o valor original de $a0
	lw $ra, 4($sp)				# Recupera o valor original de $ra
	addi $sp, $sp, 8			# Desaloca o espaco utilizado na pilha
 
	jr $ra					# Retorna para o endereco contido em $ra
	
#
#	PROCEDIMENTO: CALCULO DO IMC
#
 
calc_imc:
	addi $sp,$sp,-12	# Aloca espaco na pilha
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
	ble $a0, $t0, end_loop		# Finaliza repeticao se $a0 <= 1
	mul $v0, $v0, $a0		# $v0 = $v0 * $a0
	addi $a0, $a0, -1		# $a0 = $a0 - 1
	
	j loop_fat			# Reinicia loop
	
end_loop:
	lw $a0, 0($sp)			# Recupera o valor original de $a0
	lw $ra, 4($sp)			# Recupera o valor original de $ra
	addi $sp, $sp, 8		# Desaloca o espaco utilizado na pilha
 
	jr $ra				# Retorna para o endereco contido em $ra
	
#
#	FUNCOES AUXILIARES
#

lerInt:
	li $v0, 5
	syscall
	jr $ra
	
lerFloat:
	li $v0, 6
	syscall
	jr $ra
