
	processor 6502
        include "vcs.h"
        include "macro.h"
        include "xmacro.h"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Variables segment

        seg.u Variables
	org $80

Temp		.byte

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Code segment

	seg Code
        org $f000

Start
	CLEAN_START


Playfield
	lda #$aa
        sta COLUBK
        
        lda #$11
        sta COLUPF
        
        lda #%000011111
        sta PF0
        


NextFrame
        lsr SWCHB	; test Game Reset switch
        bcc Start	; reset?
; 1 + 3 lines of VSYNC
	VERTICAL_SYNC
; 37 lines of underscan
	TIMER_SETUP 37
        TIMER_WAIT
; 192 lines of frame
	TIMER_SETUP 192
        TIMER_WAIT
; 29 lines of overscan
	TIMER_SETUP 29
        TIMER_WAIT
; total = 262 lines, go to next frame
        jmp NextFrame

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Epilogue

	org $fffc
        .word Start	; reset vector
        .word Start	; BRK vector
