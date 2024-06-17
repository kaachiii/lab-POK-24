.include "m8515def.inc" ; mendefinisikan tipe prosesor

.def result = R1     ; mendefinisikan R1 sebagai result
.def i = R18         ; mendefinisikan R18 sebagai variabel loop i
.def N = R19         ; mendefinisikan R19 sebagai input N

DATA:
    .db 7         ; mendefinisikan input data

Main:
    ldi ZH, high(DATA)   ; Load high byte alamat data ke ZH
    ldi ZL, low(DATA)    ; Load low byte alamat data ke ZL
    lpm N, Z               ; Load program memori dari Z ke N
	ldi result, 0          ; Inisialisasi result = 0
    ldi i, 2               ; Inisialisasi i = 2

Loop:
    cp i, N                	; bandingkan i dengan N
    breq SetResult1      	; Jika i = N, result = 1
    cp N, i               	; bandingkan N dengan i
    brne CheckModulo      	; jika N tidak sama dengan i, cek modulo
    rjmp SetResult0			; jika N % i = 0, set result = 0 dan break loop

CheckModulo:
    movw r0, N             ; Move N ke pasangan register r0:r1
    clr r1                 ; Clear r1
    mov r2, i              ; Move i ke r2
    ldi r3, 0              ; Load immediate 0 ke r3
    call Divide            ; Call Divide
    tst r1                 ; Test remainder (r1)
    breq SetResult0		; Jika remainder = 0, set result = 0 dan break loop
    inc i                  ; Increment i
    rjmp Loop        ; Ulangi Loop

Divide:
    ldi r24, 0              ; Clear r24 (quotient)

DivideLoop:
    sub r0, r2              ; Kurangi i dari N
    sbc r1, r3              ; Kurangi carry dari remainder
    brcc DivideDone        ; jika carry tidak diset, division selesai
    inc r24                 ; Increment quotient
    rjmp DivideLoop        ; Ulangi DivideLoop

DivideDone:
    mov r25, r24            ; Move quotient ke r25 (high byte)
    ret

SetResult0:
    ldi result, 0           ; Set result = 0
    rjmp LoopEnd           ; Break loop

SetResult1:
    ldi result, 1           ; Set result = 1

LoopEnd:
    rjmp LoopEnd ; infinite loop
