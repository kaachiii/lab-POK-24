.data
	inputJumlah: .asciiz "Banyak name tag: "
	inputNameTag: .asciiz "Name Tag "
	spasi: .asciiz ": \n"
	inputBentuk: .asciiz ":\nDaftar bentuk name tag:\n[1] Persegi Panjang \n[2] Segitiga\nPilih bentuk name tag: "
	inputAlas: .asciiz "Masukkan alas: "
	inputTinggi: .asciiz "Masukkan tinggi: "
	pemisah: .asciiz "-------------------\n"
	output: .asciiz "Total biaya untuk memproduksi name tag tersebut yaitu Rp"
	
.text
.globl main
main: # label main program utama
	# mencetak prompt input jumlah
	li $v0, 4 # load immediate code 4 ke register $v0 untuk print string
	la $a0, inputJumlah # load address dari label inputJumlah ke register $a0
	syscall
	
	# membaca input jumlah berupa integer
	li $v0, 5 # load immediate code 5 ke register $v0 untuk read integer
	syscall
	add $t0, $v0, $zero 
	
	# inisialisais luas
	add $t4, $zero, $zero
	
	# inisialisasi loop
	add $s0, $zero, $zero
	
loop: 
	beq $s0, $t0, exit
	
	li $v0, 4 # load immediate code 4 ke register $v0 untuk print string
	la $a0, pemisah # load address dari label pemisah ke register $a0
	syscall
	
	li $v0, 4 # load immediate code 4 ke register $v0 untuk print string
	la $a0, inputNameTag # load address dari label inputNameTag ke register $a0
	syscall
	
	addi $s1, $s0, 1
	li $v0, 1 # load immediate code 1 ke register $v0 untuk print integer
	add $a0, $s1, $zero # memindahkan nilai dari register $t1 ke $a0 agar bisa diprint
	syscall
	
	li $v0, 4 # load immediate code 4 ke register $v0 untuk print string
	la $a0, inputBentuk # load address dari label inputBentuk ke register $a0
	syscall
	
	li $v0, 5 # load immediate code 5 ke register $v0 untuk read integer
	syscall
	add $t1, $v0, $zero
	
	li $v0, 4 # load immediate code 4 ke register $v0 untuk print string
	la $a0, inputAlas # load address dari label inputAlas ke register $a0
	syscall
	
	li $v0, 5 # load immediate code 5 ke register $v0 untuk read integer
	syscall
	add $t2, $v0, $zero
	
	li $v0, 4 # loads immediate code 4 ke register $v0 untuk print string
	la $a0, inputTinggi # load address dari label inputAlas ke register $a0
	syscall
	
	li $v0, 5 # load immediate code 5 ke register $v0 untuk read integer
	syscall
	add $t3, $v0, $zero
	
	addi $s0, $s0, 1
	
	# cabang
	beq $t1, 1, persegiPanjang
	beq $t1, 2, segitiga
	
	j loop
	
persegiPanjang: # t4 buat nyimpen luas
# calculate luas persegipanjang
	mult $t2, $t3
	mflo $t5
	add $t4, $t4, $t5
	j loop
	
segitiga:
# calculate luas segitiga
	mult $t2, $t3
	mflo $t6
	li $t5, 2             
    	div $t6, $t5      
    	mflo $t7
    	add $t4, $t4, $t7
    	j loop
	
exit:
# exit (keluar dr program)
	li $t5, 4
	mult $t4, $t5
	mflo $t4
	
	li $t6, 25
	mult $t4, $t6
	mflo $t4
	
	li $v0, 4 # load immediate code 4 ke register $v0 untuk print string
	la $a0, output # load address dari label output ke register $a0
	syscall
	
	li $v0, 1 # load immediate code 1 ke register $v0 untuk print integer
	add $a0, $t4, $zero # memindahkan nilai dari register $t1 ke $a0 agar bisa diprint
	syscall
	
	li $v0, 10 # load immediate code 10 ke register $v0 untuk exit (end of program)
	syscall	
