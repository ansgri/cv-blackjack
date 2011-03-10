@echo off
gsc -c cv-blackjack/cv.scm > gsc-out.txt
del *.c
gsc -c utils.scm hello.scm >> gsc-out.txt
gsc -link cv-blackjack/cv.c utils.c hello.c >> gsc-out.txt
type gsc-out.txt
pause
