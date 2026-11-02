* Native QDOS service ABI. A4 points at original stack arguments.
* A5 points at saved D0-D7/A0-A6 (four bytes each).
ql_Call_BackHLine:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_BackHLine
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_BlitBmp:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_BlitBmp
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_BlitCursor:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_BlitCursor
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_DrawStr:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_DrawStr
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_DrawStrShadowed:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_DrawStrShadowed
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_Fdelete:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_Fdelete
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_FillLine:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_FillLine
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_GetKeyboardEvent:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_GetKeyboardEvent
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_GetMouseInput:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_GetMouseInput
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_HLine:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_HLine
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_InformScreens:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_InformScreens
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_MakeExtPalette:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_MakeExtPalette
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_MemSet:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_MemSet
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_MemSetBlue:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_MemSetBlue
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_Memcpy:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_Memcpy
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_NotifyMousePos:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_NotifyMousePos
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_NotifyOfScrFlip:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_NotifyOfScrFlip
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_OldHLine:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_OldHLine
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_PlaySFX:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_PlaySFX
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_PutPix:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_PutPix
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_RestoreUnderCursor:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_RestoreUnderCursor
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_SetCtrlPalette:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_SetCtrlPalette
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_SetMainPalette:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_SetMainPalette
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_SetScreenBase:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_SetScreenBase
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_Call_UpdateScreen:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_Call_UpdateScreen
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
ql_gemdos:
 move.w sr,-(a7)
 movem.l d0-d7/a0-a6,-(a7)
 lea 66(a7),a4
 lea (a7),a5
 jsr impl_gemdos
 movem.l (a7)+,d0-d7/a0-a6
 move.w (a7)+,ccr
 rts
