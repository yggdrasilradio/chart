
       org     $1000

       orcc    #$50     * disable interrupts
       ldb     #$3e	* VSYNC use rising edge
       stb     $ff03
       ldb     #$35	* enable HSYNC IRQ
       stb     $ff01
       ldb     #$fb	* init keyboard
       stb     $ff02

loop   lda     #16	* going to change palettes 16 times
       ldx     #$0010	* initial palette values for columns 1 and 2
       ldu     #$2030	* initial palette values for columns 3 and 4
       ldb     #70	* initially wait for 70 HSYNCs before changing palettes

       * wait for VSYNC
       tst     $ff02	* dismiss VSYNC
vwait  tst     $ff03
       bpl     vwait

       * wait for 70 HSYNCs 1x, then wait for 8 HSYNCs 16x
hwait  tst     $ff00	* dismiss HSYNC
       sync

       decb		* count HSYNCs
       bne     hwait	* keep going

       * wait for HSYNC once more before changing palettes
       tst     $ff00	* dismiss HSYNC
       sync

       stx     $ffb8	* change palettes for columns 1 and 2
       stu     $ffba	* change palettes for columns 3 and 4
       leax    $0101,x	* increment palette values for columns 1 and 2
       leau    $0101,u	* increment palette values for columns 3 and 4

       ldb     #7	* done waiting for 70 HSYNCs, waiting for 8 from here on out

       deca		* count down from 16
       bne     hwait	* next series of HSYNCs

       * Is the BREAK key down?
       pshs b
       ldb $ff00
       bitb #$40
       beq reset	* BREAK key down
       puls b
       bra loop		* no BREAK key down, keep going

       * Hard reset to RSDOS
reset  clr     $71	* force hard reset
       jmp     [$fffe]	* jump thru reset vector


