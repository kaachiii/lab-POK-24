.data 
	# inisialisasi data yang ada di dalam program
	stringSpace: .space 11
	inputNama: .asciiz "Siapa nama Anda? "
	inputSmt: .asciiz "\nSemester berapakah Anda? "
	myString1: .asciiz "Halo, mahasiswa dengan nama "
	myString2: .asciiz ". Semoga Anda dapat menjalani semester ke-"
	myString3: .asciiz " di Fasilkom dengan baik :)."	
.text
.globl main
main:
	# mencetak prompt prompt input nama
	li $v0, 4
	la $a0, inputNama
	syscall
	
	# membaca input nama berupa string maksimal 20 karakter
	li $v0, 8
	la $a1, 11
	la $a0, stringSpace
	syscall
	
	# mencetak prompt input semester
	li $v0, 4
	la $a0, inputSmt
	syscall
	
	# membaca input semester berupa integer
	li $v0, 5
	syscall
	move $t0, $v0
	
	# mencetak myString1
	li $v0, 4
	la $a0, myString1
	syscall
	
	# mencetak input nama dari user
	li $v0, 4
	la $a0, stringSpace
	syscall
	
	# mencetak myString2
	li $v0, 4
	la $a0, myString2
	syscall
	
	# mencetak input semester dari user
	li $v0, 1
	move $a0, $t0
	syscall
	
	# mencetak mystring3
	li $v0, 4
	la $a0, myString3
	syscall
	
	# execute (exit)
	li $v0, 10
	syscall