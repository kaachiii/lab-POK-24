.include "m8515def.inc" ; mendefinisikan tipe prosesor yang digunakan 

.def result = R1 ; definisikan R1 sebagai result
.def value1 = R18 ; definisikan R18 sebagai value1
.def value2 = R19 ; definisikan R19 sebagai value2
.def temp = R24 ; definisikan R24 sebagai temp

MY_DATA: ; inisialisasi data
.db 32, 5 ; input data yang akan digunakan

Main: ; label program utama
	ldi ZL, LOW(MY_DATA*2) ; load low byte alamat MY_DATA ke ZL
	ldi ZH, HIGH(MY_DATA*2) ; load high byte alamat MY_DATA ke ZH
	lpm value1, Z+ ; load program memory dari Z += 1 ke value1
	lpm value2, Z ; load program memory dari Z ke value2

Loop: ; label Loop
	cp value1, value2 ; membandingkan value1 dan value2
	brlt Stop ; pindah ke stop jika value1 < value2
	sub value1, value2 ; value1 -= value2
	adiw temp, 1 ; pindahkan temp ke byte selanjutnya (temp += 1)
	rjmp Loop ; jump ke Loop

Stop: ; label Stop
	mov result, temp ; pindahkan isi temp ke result

Forever: ; label Forever
	rjmp Forever ; jump forever(infinite loop)

; Nilai Akhir Result = 6
