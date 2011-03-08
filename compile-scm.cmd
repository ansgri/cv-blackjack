@echo off
del *.c
del cv-blackjack\*.c
gsc -c cv-blackjack/cv.scm > gsc-out.txt
gsc -c utils.scm hello.scm >> gsc-out.txt
gsc -link cv-blackjack/cv.c utils.c hello.c >> gsc-out.txt
type gsc-out.txt
pause
