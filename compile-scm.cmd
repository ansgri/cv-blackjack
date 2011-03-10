@echo off
pushd cv-blackjack
del gsc-build.tmp\*.c
gsc -o gsc-build.tmp/ -c cv.scm >> ..\gsc-out.tmp
popd

del gsc-build.tmp\*.c
gsc -o gsc-build.tmp/ -c utils.scm hello.scm >> gsc-out.tmp
gsc -o gsc-build.tmp/ -link cv-blackjack/gsc-build.tmp/cv.c gsc-build.tmp/utils.c gsc-build.tmp/hello.c >> gsc-out.tmp

type gsc-out.tmp
pause
