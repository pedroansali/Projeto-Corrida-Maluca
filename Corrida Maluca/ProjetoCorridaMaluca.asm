#ProjetoCorridaMaluca
.data
perguntaini: .asciiz "Insira a quantidade de jogadores: "
perguntanome: .asciiz "Insira o nome dos jogadores: "
msgjogo: .asciiz "\nAperte enter para rodar dados!!! "
jogador: .space 40
msgdados: .asciiz "Resultado dos dados: "
j1: .asciiz "\nVez do jogador 1: "
j2: .asciiz "\nVez do jogador 2: "
j3: .asciiz "\nVez do jogador 3: "
j4: .asciiz "\nVez do jogador 4: "
casa6: .asciiz "\nEntrou em casa com sapatos que usou na rua, volte 1 casa!"
casa10: .asciiz "\nVocê comprou mais do que precisava, volte 3 casas!"
casa13: .asciiz "\nUsou lenço descartável ao espirrar, avance 2 casas!"
casa16: .asciiz "\nVocê ajudou a familia, avance 3 casas!"
casa17: .asciiz "\nVovô saiu de casa, volte 5 casas!"
casa20: .asciiz "\nVocê está com febre e saiu para passear, volte ao inicio do jogo!"
casa25: .asciiz "\nTossiu sem cobrir a boca, volte 3 casas!"
casa33: .asciiz "\nUsou álcool gel nas mãos, avance 2 casas!"
casa36: .asciiz "\nMantem os ambientes ventilados, avance 4 casas!"
casa38: .asciiz "\nAntes de jogar você lavou as mãos, avance 2 casas!"
casa41: .asciiz "\nApos jogar voce lavou as mãos, avance 4 casas!"
casa46: .asciiz "\nVoce cumprimentou com as maos, volte 4 casas!"
casa49: .asciiz "\nVoce foi a uma festa, volte 5 casas!"
mensagemfinal: .asciiz "\nJogo encerrado! "

.text
main: 
 jal iniciojogo
 jal loopjogo

#fim do programa
addi $v0, $zero, 10
syscall



#-------------------
#FUNÇÕES
#-------------------




iniciojogo:
#Pergunta quantos jogadores
li $v0, 4
la $a0, perguntaini
syscall
#adiciona numero de jogadores em registrador v0
li $v0, 5
syscall
#salva numero de jogadores em $s0
add $s0, $s0, $v0
#Começo do loop de acordo com o numero de jogadores
LoopNome:
addi $t0, $t0, 1 #Contador para loop
#Pergunta nomes dos jogadores
li $v0, 4
la $a0, perguntanome
syscall
#leitura do nome
li $v0, 8
la $a0, jogador
li $a1, 40
syscall
#se for o jogador 1, salva o nome em $s1
bne $t0, 1, else1
add $s1, $s1, $a0
else1:
#se for o jogador 2, salva o nome em $s2
bne $t0, 2, else2
add $s2, $s2, $a0
else2:
#se for o jogador 3, salva o nome em $s3
bne $t0, 3, else3
add $s3, $s3, $a0
else3:
#se for o jogador 4, salva o nome em $s4
bne $t0, 4, else4
add $s4, $s4, $a0
else4:
#enquanto contador nao chegar no numero de jogadores, continuará o loop
beq $s0, $t0, FimdoLoop
 j LoopNome 
FimdoLoop:
jr $ra

#---------------------------
loopjogo: #NOME DA FUNÇÃO
addi $t0, $zero, 0
Loopjogo: #NOME DO LOOP
addi $t0, $t0, 1
#exibir de quem é a vez
bne $t0, 1, vai2
li $v0, 4
la $a0, j1
syscall
vai2:
bne $t0, 2, vai3
li $v0, 4
la $a0, j2
syscall
vai3:
bne $t0, 3, vai4
li $v0, 4
la $a0, j3
syscall
vai4:
bne $t0, 4, vai
li $v0, 4
la $a0, j4
syscall
vai:
#apertar enter pra jogar dados
li $v0, 4
la $a0, msgjogo
syscall
li $v0, 8
la $a0, jogador
li $a1, 40
syscall
#criar numero aleatorio entre 1 e 12
li $v0, 42
li $a1, 12
syscall
addi $a0, $a0, 1
add $k0, $zero, $a0 #salvando resultado dos dados em $k0
#exibir resultado dos dados
li $v0, 4
la $a0, msgdados
syscall
add $a0, $zero, $k0
li $v0, 1
syscall
#adicionar numero de dados as casas
#se for vez do jogador 1, add na pontuação de t1
bne $t0,1, vez2
add $t1, $t1, $k0
add $s7, $zero, $t1
jal VerificaCasa
add $t1, $zero, $s7
vez2:
#se for vez do jogador 2, add na pontuação de t2
bne $t0, 2, vez3
add $t2, $t2, $k0
add $s7, $zero, $t2
jal VerificaCasa
add $t2, $zero, $s7
vez3:
#se for vez do jogador 3, add na pontuação de t3
bne $t0, 3, vez4
add $t3, $t3, $k0
add $s7, $zero, $t3
jal VerificaCasa
add $t3, $zero, $s7
vez4:
#se for vez do jogador 4, add na pontuação de t4
bne $t0, 4, acabavez
add $t4, $t4, $k0
add $s7, $zero, $t4
jal VerificaCasa
add $t4, $zero, $s7
acabavez:
#contador para loop da ordem do jogador
bne $s0, $t0, contador
addi $t0, $zero,0 
contador:
#verifica se ganhou
bge $t1, 50, Fimloopjogo
j Loopjogo
Fimloopjogo:
li $v0, 4
la $a0, mensagemfinal
syscall
jr $ra


#-------------

#Função para verificar as casas especiais

VerificaCasa:
#Casa 6 
bne $s7, 6 , else6
li $v0 , 4
la $a0, casa6
syscall
addi $s7, $s7, -1
else6:

#Casa 10
bne $s7, 10, else10
li $v0 , 4
la $a0, casa10
syscall
addi $s7, $s7, -3
else10:

#Casa 13
bne $s7, 13, else13
li $v0 , 4
la $a0, casa13
syscall
addi $s7, $s7, 2
else13:

#Casa 16
bne $s7, 16, else16
li $v0 , 4
la $a0, casa16
syscall
addi $s7, $s7, 3
else16:

#Casa 17
bne $s7, 17, else17
li $v0 , 4
la $a0, casa17
syscall
addi $s7,$s7, -5
else17:

#Casa 20
bne $s7, 20, else20
li $v0 , 4
la $a0, casa20
syscall
add $s7, $zero, $zero
else20:

#Casa 25
bne $s7, 25, else25
li $v0 , 4
la $a0, casa25
syscall
add $s7, $s7, -3
else25:

#Casa 33
bne $s7, 33, else33
li $v0 , 4
la $a0, casa33
syscall
add $s7, $s7, 2
else33:

#Casa 36
bne $s7, 36, else36
li $v0 , 4
la $a0, casa36
syscall
add $s7, $s7, 2
else36:

#Casa 38
bne $s7, 38, else38
li $v0 , 4
la $a0, casa38
syscall
add $s7, $s7, 2
else38:

#Casa 41
bne $s7, 41, else41
li $v0 , 4
la $a0, casa41
syscall
add $s7, $s7, 2
else41:

#Casa 46
bne $s7, 46, else46
li $v0 , 4
la $a0, casa46
syscall
add $s7, $s7, -4
else46:

#Casa 49
bne $s7, 49, else49
li $v0 , 4
la $a0, casa49
syscall
add $s7, $s7, -5
else49:

jr $ra