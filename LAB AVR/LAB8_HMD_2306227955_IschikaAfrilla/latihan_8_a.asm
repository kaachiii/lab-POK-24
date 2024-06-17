;====================================================================
; Processor     : ATmega8515
; Compiler      : AVRASM
;====================================================================

;====================================================================
; DEFINITIONS
;====================================================================

.include "m8515def.inc"

;====================================================================
; RESET and INTERRUPT VECTORS
;====================================================================

.org 0x00    ; JUMP to MAIN to initialize
    rjmp MAIN
.org 0x01    ; When Button0 pressed, jump to ext_int0
    rjmp ext_int0
.org 0x02    ; When Button1 pressed, jump to ext_int1
    rjmp ext_int1
.org 0x07    ; When Timer0 overflows, jump to ISR_TOV0
    rjmp ISR_TOV0

;====================================================================
; DATA SEGMENT
;====================================================================

.dseg
.org 0x60
counter: .byte 1        ; Reserve one byte for the counter
speed_flag: .byte 1     ; Flag to indicate current speed

;====================================================================
; CODE SEGMENT
;====================================================================

.cseg
.org 0x100

; Initialize stack pointer
MAIN:
    ldi r16, low(RAMEND)
    out SPL, r16
    ldi r16, high(RAMEND)
    out SPH, r16

; Setup LED PORT
SET_LED:
    ser r16             ; Load $FF to temp      
    out DDRB, r16       ; Set PORTB to output  

; Setup Button Reset PORTD Bit 2 for INT0
SET_BUTTON_RESET:
    ; Set PORTD Bit 2 for input (Button)
    ldi r16, (0<<PD2)    ; Clear Bit 2
    out DDRD, r16        ; Set PORTD Bit 2 as input
    ldi r16, (1<<PD2)    ; Enable pull-up resistor on PORTD Bit 2
    out PORTD, r16

    ; Enable external interrupt INT0 on falling edge
    ldi r16, (1<<ISC01) | (0<<ISC00)   ; Falling edge
    out MCUCR, r16

    ; Enable INT0 interrupt
    ldi r16, (1<<INT0)
    out GICR, r16

; Setup Button Change Speed PORTD Bit 3 for INT1
SET_BUTTON_SPEED:
    ; Set PORTD Bit 3 for input (Button)
    ldi r16, (0<<PD3)    ; Clear Bit 3
    out DDRD, r16        ; Set PORTD Bit 3 as input
    ldi r16, (1<<PD3)    ; Enable pull-up resistor on PORTD Bit 3
    out PORTD, r16

    ; Enable external interrupt INT1 on falling edge
    ldi r16, (1<<ISC11) | (0<<ISC10)   ; Falling edge
    out MCUCR, r16

    ; Enable INT1 interrupt
    ldi r16, (1<<INT1)
    out GICR, r16

; Setup Timer0 for 1-second overflow
SET_TIMER:
    ; Timer speed = clock/1024 (set CS02 and CS00 in TCCR0)
    ldi r16, (1<<CS02) | (1<<CS00)
    out TCCR0, r16

    ; Clear Timer0 overflow flag
    ldi r16, (1<<TOV0)
    out TIFR, r16

    ; Enable Timer0 overflow interrupt
    ldi r16, (1<<TOIE0)
    out TIMSK, r16

    ; Set global interrupt flag
    sei

; Initialize counters and flag to 0
    ldi r16, 0
    sts counter, r16
    sts speed_flag, r16

; While waiting for interrupt, loop infinitely
FOREVER:
    rjmp FOREVER

; Program executed on button press (INT0) for reset
ext_int0:
    ; Reset counter to 0
    ldi r16, 0
    sts counter, r16

    ; Turn off all LEDs
    ldi r16, 0
    out PORTB, r16

    reti

; Program executed on button press (INT1) for speed change
ext_int1:
    push r16
    in r16, SREG
    push r16

    ; Toggle speed flag
    lds r16, speed_flag
    ldi r17, 1    ; Load immediate value 1 into register r17
	eor r16, r17  ; Perform XOR operation between r16 and r17
	sts speed_flag, r16

    ; Update timer speed
    cpi r16, 1
    brne SET_NORMAL_SPEED

    ; Set Timer0 to 4 times faster speed (clock/256)
    ldi r16, (1<<CS02)
    out TCCR0, r16
    rjmp DONE_SPEED_CHANGE

SET_NORMAL_SPEED:
    ; Set Timer0 to normal speed (clock/1024)
    ldi r16, (1<<CS02) | (1<<CS00)
    out TCCR0, r16

DONE_SPEED_CHANGE:
    pop r16
    out SREG, r16
    pop r16

    reti

; Program executed on timer overflow
ISR_TOV0:
    push r16
    in r16, SREG
    push r16

    ; Increment the binary counter
    lds r16, counter
    inc r16
    sts counter, r16

    ; Output counter to PORTB
    out PORTB, r16

    pop r16
    out SREG, r16
    pop r16

    reti