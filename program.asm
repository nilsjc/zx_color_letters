Start:
    .model Spectrum48
.org #7530              ;; börja på address 30000
;; skriva ut tecken
ld b, 8 ;; vi vill att det här ska loopas 64 gånger
ld ix, mydataarray
ld a, 2 ;; vi vill skriva ut i channel 2, övre delen av specturms skärm(undre delen är där man textinmatar
call 5633 ;; kan också skrivas som #1601 CHANOPEN
textloop push bc ;; lägg bc på stacken
ld b, 8;; ladda b med 8 för att skrivut1 ska loopas 8a gånger
skrivut1 ld a, (ix) ;; 127 = copyright-tecken
rst 16 ;; utför kommandot
inc ix
djnz skrivut1 ;; B = B - 1. Om B==0 passera, annars gå till skrivut1
ld a, 13 ;;skriv ut enter för radbryt (newline)
rst 16 ;; utför kommandot
pop bc ;; hämta från stacken till bc
djnz textloop ;; minska bc med 1 och hoppa till textloop om inte noll
;; fylla på med färg - modifiera attributen
attributeblock ld hl,22528  ;; ladda hl med 22528 - där börjar första attributet i videominnet
                        ;; pixlarna börjar på 16384
ld a, 4                 ;; ladda a med 4. Används i loop
ld ix, myattributearray          ;; låt ix peka på myattributearray
loop ld b, 4            ;; loopstart och ladda b med 4
row1 ld c, (ix) ;; starta loop "row1" och ladda C med innehållet som pekas på av ix
ld (hl), c         ;; rita ut innehållet i C
inc ix ;; räkna upp ix
ld c, (ix) ;; ladda C med innehållet som pekas på av ix
inc hl
ld (hl),c ;; rita ut GRÖN (100) ruta
inc hl
inc ix
djnz row1           ;; räkna ner b, hoppa till row1 om b INTE är 0
call spacesub       ;; goto subrutin som heter spacesub och som ska rita ut tomma rutor
ld b, 4            ;; ladda b med 4
row2 ld c, (ix) ;; starta loop "row2" och ladda C med innehållet som pekas på av ix
ld (hl), c  ;; rita ut VIT ruta
inc hl              ;; räkna upp hl
inc ix  ;; räkna upp index på arrayen
ld c,(ix)
ld (hl),c           ;; ladda minnet som h1 pekar på med innehållet i C
inc hl              ;; räkna upp h1
inc ix
djnz row2           ;; räkna ner register b och hoppa till row2 om b inte är 0
call spacesub
dec a               ;; räkna ner register a
jr nz, loop         ;; kolla om senaste förändringen blev 0, om inte hoppa till loop
theend jp theend
;; subrutiner
spacesub  ld b, 24  ;; subrutin 'spacesub' sätt b till 24
                    ;; 24 är alltså de tomma rutorna till höger
space3 inc hl       ;; räkna till 24
djnz space3         ;; hoppa tillbaka om inte 0
ret                 ;; glöm aldrig ret = return!

myattributearray db 8, 16, 24, 32, 40, 48, 56, 72, 80, 88, 96, 104, 112, 120,  8, 16, 8,  16, 24, 32, 40, 48, 56, 72, 80, 88, 96, 104, 112, 120, 8, 16, 8, 16, 24, 32, 40, 48, 56, 72, 80, 88, 96, 104, 112, 120, 8, 16, 8, 16, 24, 32, 40, 48, 56, 72, 80, 88, 96, 104, 112, 120, 8, 16                                    
mydataarray db     65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75,  76, 77,   78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 121
