.data
	output1: .asciiz "Nilai terendah = "
	output2: .asciiz "\nNilai tertinggi = "
	output3: .asciiz "\nRata-rata nilai = "
	output4: .asciiz "\nRange nilai = "
	divider: .asciiz "\n--------------------"
	output5: .asciiz "\nPeokra: \"Sepertinya soal lab perlu dipermudah\""
	output6: .asciiz "\nPeokra: \"Sepertinya soal lab perlu dipersulit\""
	scores: .word 80,75,89,60,70,85,90,83,40,66,-1

.text
.globl main
main:
	# inisialisasi index loop
	addi $s0, $zero, 0
	
	# inisialisasi max
	addi $s1, $zero, 0
	
	# inisialisasi min
	addi $s2, $zero, 100
	
	# inisialisasi sum
	addi $s3, $zero, 0
	
	# inisialisasi count
	addi $s4, $zero, 0
	
while:
	# loop array
	lw $t1, scores($s0)
	beq $t1, -1, exit # exit if score == -1
	# update nilai sum
	add $s3, $s3, $t1
	# update counter
	addi $s4, $s4, 1
		
	# branch untuk mengupdate nilai min dan max
	blt $t1, $s2, loadMin
	bgt $t1, $s1, loadMax
		
	# update index tiap iterasi
	addi $s0, $s0, 4	
	j while # jump ke while loop
	
loadMin:
	# update nilai min
	add $s2, $t1, $zero
	addi $s0, $s0, 4
	j while
	
loadMax:
 	# update nilai max
	add $s1, $t1, $zero
	addi $s0, $s0, 4
	j while

exit:	
	# print output1
	li $v0, 4		
	la $a0, output1
	syscall
	
	# print min
	li $v0, 1
	addi $a0, $s2, 0
	syscall
	
	# print output2
	li $v0, 4		
	la $a0, output2
	syscall
	
	# print max
	li $v0, 1
	addi $a0, $s1, 0
	syscall
		
	# print output3
	li $v0, 4		
	la $a0, output3
	syscall
	
	# print rata-rata
	div $s3, $s4
	mflo $a0
	li $v0, 1
	syscall
	
	# print output4
	li $v0, 4		
	la $a0, output4
	syscall
	
	# calculate and print range
	sub $a0, $s1, $s2
	li $v0, 1
	syscall
	
	# print divider
	li $v0, 4		
	la $a0, divider
	syscall
	
	# cek apakah lab sulit dengan mencari rata-rata
	div $s3, $s4
	mflo $a0
	addi $t0, $zero, 80
	bgt $a0, $t0, labSulit
	blt $a0, $t0, labMudah
	beq $a0, $t0, labSulit
	
labMudah: # branch ketika soal lab perlu dipermudah
	# print output5
	li $v0, 4		
	la $a0, output5
	syscall
	j exit2
	
labSulit: # branch ketika soal lab perlu dipersulit
	# print output6
	li $v0, 4		
	la $a0, output6
	syscall
	j exit2
	
exit2:
	# tell system this is end of program
	li $v0, 10
	syscall
