.data 
	# inisialisasi data yang ada di dalam program
	stringSpace: .space 11
	inputNama: .asciiz "Siapakah nama Anda? "
	inputAkt: .asciiz "\nTahun angkatan Anda? "
	inputSmt: .asciiz "Semester berapakah Anda? "
	myString1: .asciiz "Halo, mahasiswa dengan nama "
	myString2: .asciiz " dari angkatan "
	myString3: .asciiz ". Semoga Anda dapat menjalani semester ke-"
	myString4: .asciiz " di Fasilkom dengan baik!"	
	akt2020: .asciiz "Chronos"
	akt2021: .asciiz "Bakung"
	akt2022: .asciiz "Apollo"
	akt2023: .asciiz "Gaung"
	
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
	
	# mencetak prompt input angkatan
	li $v0, 4
	la $a0, inputAkt
	syscall
	
	# membaca input angkatan berupa integer
	li $v0, 5
	syscall
	move $t0, $v0
	
	# mencetak prompt input semester
	li $v0, 4
	la $a0, inputSmt
	syscall
	
	# membaca input semester berupa integer
	li $v0, 5
	syscall
	move $t1, $v0
	
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
	
	# branch perbandingan untuk mengecek nama angkatan
	beq $t0, 2023, equals2023
	beq $t0, 2022, equals2022
	beq $t0, 2021, equals2021
	beq $t0, 2020, equals2020
	
equals2021:
	# jika angkatan == 2021 maka akan mencetak nama angkatan 2021
	li $v0, 4
	la $a0, akt2021
	syscall
	j exit # jump ke bagian exit
	
equals2020:
	# jika angkatan == 2020 maka akan mencetak nama angkatan 2020
	li $v0, 4
	la $a0, akt2020
	syscall
	j exit # jump ke bagian exit
	
equals2022:
	# jika angkatan == 2022 maka akan mencetak nama angkatan 2022
	li $v0, 4
	la $a0, akt2022
	syscall
	j exit # jump ke bagian exit
	
equals2023:
	# jika angkatan == 2023 maka akan mencetak nama angkatan 2023
	li $v0, 4
	la $a0, akt2023
	syscall
	j exit # jump ke bagian exit
	
exit:
	# mencetak myString3
	li $v0, 4
	la $a0, myString3
	syscall
	
	# mencetak input semester dari user
	li $v0, 1
	move $a0, $t1
	syscall
	
	# mencetak mystring4
	li $v0, 4
	la $a0, myString4
	syscall
	
	# execute (exit)
	li $v0, 10
	syscall	
