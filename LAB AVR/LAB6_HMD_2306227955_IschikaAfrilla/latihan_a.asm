.include "m8515def.inc" ; definisikan tipe processor

; P(n) = 3*P(n-2)+2*P(n-1)
; P(0) = 1
; P(1) = 2

.def input = r16 ; definisikan "input" sebagai register r16
.def hasil = r17 ; definisikan "hasil" sebagai register r17
.def min1 = r18 ; definisikan "min1" sebagai register r18
.def min2 = r19 ; definisikan "min2" sebagai register r19
.def temp = r20 ; definisikan "temp" sebagai register r20
.def count = r21 ; definisikan "count" sebagai register r21
.def n = r22; definisikan "n" sebagai register r22

DATA:
.db 4, 0 ; padding zero byte inserted for alignment

main:
	; memastikan stack pointer pada akhir RAM
	ldi temp, low(RAMEND)
	out SPL, temp
	ldi temp, high(RAMEND)
	out SPH, temp

	ldi XL, $90 ; XLow = 0x90 untuk menyimpan hasil mulai dari alamat 0x90
	ldi input, DATA ; simpan input data
	ldi count, 0 ; inisialisasi count = 0

loop:
	cp input, count ; bandingkan input dengan count
	brlt forever ; jika input < counter, selesaikan program
	mov n, count ; n = count
	rcall sequence ; call rekursif sequence P(n)
	st X+, hasil ; store hasil ke pointer X, lalu pointer X++
	inc count ; count++
	rjmp loop ; jump ke loop

sequence:
	push n ; push n ke stack
	push min1 ; push min1 ke stack
	push min2 ; push min2 ke stack
	push temp ; push temp ke stack

	cpi n, 0 ; cek apakah n == 0
	breq baseCase0 ; jika iya, lompat ke base case n = 0
	cpi n, 1 ; cek apakah n == 1
	breq baseCase1 ; jika iya, lompat ke base case n = 1

	mov min1, n ; min1 = n
	subi min1, 1 ; min1 -= 1
	mov min2, n ; min2 = n
	subi min2, 2 ; min2 -= 2

	mov n, min1 ; n = min1
	rcall sequence ; call P(n-1)
	add hasil, hasil ; karena P(n-1)*2
	mov temp, hasil ; temp = hasil*2 = P(n-1)*2

	mov n, min2 ; n = min2
	rcall sequence ; call P(n-2)
	mov r23, hasil
	add hasil, r23
	add hasil, r23 ; karena P(n-2)*3
	add hasil, temp ; P(n-1)*2 + P(n-2)*3
	rjmp stop ; selesaikan rekursi

	baseCase0:
		ldi hasil, 1 ; hasil = 1
		rjmp stop ; selesaikan rekursi

	baseCase1:
		ldi hasil, 2 ; hasil = 2
		rjmp stop ; selesaikan rekursi

stop:
	pop temp ; pop temp dari stack
	pop min2 ; pop min2 dari stack
	pop min1 ; pop min1 dari stack
	pop n ; pop n dari stack
	ret ; kembali ke main

forever:
	rjmp forever ; infinite loop
