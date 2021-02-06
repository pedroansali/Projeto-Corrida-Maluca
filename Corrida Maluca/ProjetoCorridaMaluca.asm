#ProjetoCorridaMaluca
.data
perguntaini: .asciiz "Insira a quantidade de jogadores: "
perguntanome: .asciiz "Insira o nome dos jogadores: "
msgjogo: .asciiz "Aperte enter para rodar dados!!! "
jogador: .space 40
msgdados: .asciiz "Resultado dos dados: "
j1: .asciiz "Vez do jogador 1: "
j2: .asciiz "Vez do jogador 2: "
j3: .asciiz "Vez do jogador 3: "
j4: .asciiz "Vez do jogador 4: "
.text
#Pergunta quantos jogadores
li $v0, 4
la $a0, perguntaini
syscall
#adiciona numero de jogadores em registrador t0
li $v0, 5
syscall
#salva numero de jogadores em $s0
add $s0, $s0, $v0
#Começo do loop de acordo com o numero de jogadores
LoopNome:
addi $t0, $t0, 1
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

Loopjogo:
addi $t0, $zero, 1
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
#exibir resultado dos dados
li $v0, 4
la $a0, msgdados
syscall
li $v0, 1
syscall
#adicionar numero de dados as casas

#se for vez do jogador 1, add na pontuação de 1

#se for vez do jogador 2, add na pontuação de 2

#se for vez do jogador 3, add na pontuação de 3

#se for vez do jogador 4, add na pontuação de 4

Fimloopjogo:
#fim do programa
addi $v0, $zero, 10
syscall
