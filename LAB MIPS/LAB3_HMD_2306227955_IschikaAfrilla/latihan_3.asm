# Latihan A: Kok bikin Matriks?? Bukannya di Lab ICO Perkalian :p
.data
	# masukkan data yang akan digunakan dalam program
	String1: .asciiz "Kolom Matriks Pertama: "
	String2: .asciiz "Baris Matriks Pertama: "
	String3: .asciiz "\nKolom Matriks Kedua: "
	String4: .asciiz "Baris Matriks Kedua: "
	String5: .asciiz "Matriks: \n"
	String6: .asciiz "Yahh, matriks memiliki ordo beda D:"
	String7: .asciiz "Yeyy matriks memiliki ordo sama :DD"
	barrier: .asciiz "| "
	space: .asciiz " "
	enter: .asciiz "\n"
	nextLine: .asciiz "|\n"
	baris1: .word 1, 2, 3, 4
	kolom1: .word 2, 3, 4, 5
	baris2: .word 3, 4, 5, 6
	kolom2: .word 4, 5, 6, 7
	matriks1: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	matriks2: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	hasilMatriks: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	
.text
.globl main
main:
	# mencetak String1
	li $v0, 4
	la $a0, String1
	syscall
	
	# meminta kolom matriks pertama
	li $v0, 5
	syscall
	add $t0, $v0, $zero
	
	# mencetak String2
	li $v0, 4
	la $a0, String2
	syscall
	
	# meminta baris matriks pertama
	li $v0, 5
	syscall
	add $t1, $v0, $zero
	
	# mencetak String5
	li $v0, 4
	la $a0, String5
	syscall
	
	# inisialisasi index = 0
	# index = $t0
	addi $s0, $zero, 0
	
while: 
	# loop untuk mencetak matriks1
	beq $s0, 12, matriksKedua
		
	# load isi array
	lw $t6, baris1($s0)
		
	# update offset tiap pengulangan
	addi $s0, $s0, 4 # s0 += 4
		
	# print current number
	li $v0, 1
	addi $a0, $t6, 0
	syscall
		
	# print a barrier atau pemisah
	li $v0, 4
	la $a0, barrier
	syscall
		
	j while # jump ke while
	  
matriksKedua: 
	# mencetak String3
	li $v0, 4
	la $a0, String3
	syscall
	
	# meminta kolom matriks kedua
	li $v0, 5
	syscall
	add $t2, $v0, $zero
	
	# mencetak String4
	li $v0, 4
	la $a0, String4
	syscall
	
	# meminta baris matriks kedua
	li $v0, 5
	syscall
	add $t3, $v0, $zero
	
	# mencetak String5
	li $v0, 4
	la $a0, String5
	syscall
	
	# inisialisasi index = 0
	# index = $t0
	addi $s0, $zero, 0
	
while2:
	# loop untuk mencetak matriks2
	beq $s0, 12, perbandingan
		
	# load isi araray
	lw $t6, baris2($s0)
		
	# update offset tiap pengulangan
	addi $s0, $s0, 4 # #t0 += 4
		
	# print current number
	li $v0, 1
	addi $a0, $t6, 0
	syscall
		
	# print a barrier atau pemisah
	li $v0, 4
	la $a0, barrier
	syscall
		
	j while
	  
perbandingan: 
	# cek apakah kolom kedua matriks sama
	beq $t0, $t2, Baris
	
	# program akan mencetak String6, ketika ordo kedua matriks tidak sama
	li $v0, 4 
	la $a0, String6
	syscall
	j exit

Baris:
	# cek apakah baris kedua matriks sama
	beq $t1, $t3, ordoSama
	
ordoSama:
	# program akan mencetak String7, ketika ordo kedua matriks sama
	li $v0, 4
	la $a0, String7
	syscall
	j exit
	
exit:
	# keluar dari program
	li $v0, 10 # load immediate code 10 ke register $v0 untuk exit (end of program)
	syscall