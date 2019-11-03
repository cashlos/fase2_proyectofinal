

	BITS 16
 	%INCLUDE "mikedev.inc"
	ORG 32768


start:
	call os_hide_cursor

	call os_clear_screen

	mov ax, mus_kbd_title_msg		; preparar pantalla

	mov bx, mus_kbd_footer_msg
	;mov cx, WHITE_ON_LIGHT_RED
	call os_draw_background

.retry:
	call os_wait_for_key


.s:
	cmp al, 's'
	jne .space
	mov ax, 3800
	mov bx, 0
	call os_speaker_tone
	jmp .retry

.space:
	cmp al, ' '
	jne .esc
	call os_speaker_off
	jmp .retry

.esc:
	cmp al, 27
	je .end
	jmp .nowt

.nowt:
	jmp .retry

.end:
	call os_speaker_off

	call os_clear_screen

	call os_show_cursor

	ret			; Regresa a SO


	mus_kbd_title_msg	db 'Presione S para sonido, barra espaciadora para silencio, ESC para salir', 0
	mus_kbd_footer_msg	db 'Grupo Manjaro', 0


; ------------------------------------------------------------------

