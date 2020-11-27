CC=i686-w64-mingw32-gcc -g -O2
MAKE = mingw32-make
MAKEFILE = Makefile.mingw
EEXT = .exe
OEXT = .o
SRC = $(wildcard src/*.c)
OBJ = src/*.o
CPPFLAGS = -Iinclude -Isrc -I/src/fun
LIBS = src/fun/libfun.a
LDFLAGS = -lm
TARGET0 = mycb
TARGET1 = read_first_fitsfile
TARGETS = read_first_fitsfile mycb
RMTARGETS = src/read_first_fitsfile.exe src/mycb.exe src/fun/libfun.a
all: libfun $(TARGETS)
#creating libfun
libfun: src/fun/functions.o
	cd src/fun && $(MAKE) -f $(MAKEFILE)
cleanlibfun:
	cd src/fun && $(MAKE) -f $(MAKEFILE) clean
$(TARGET0).o: src/mycb.c
	$(CC) -c   $< -o src/mycb.o $(CPPFLAGS)
$(TARGET0): src/mycb.o
	$(CC) $< $(LIBS) -o src/mycb $(LDFLAGS)
$(TARGET1).o: src/read_first_fitsfile.c
	$(CC) -c   $< -o src/read_first_fitsfile.o $(CPPFLAGS)
$(TARGET1): src/read_first_fitsfile.o
	$(CC) $< $(LIBS) -o src/read_first_fitsfile $(LDFLAGS)
install: all
	mv $(TARGETS) bin
.PHONY: clean distclean cleanlibfun
clean: cleanlibfun
	rm -f $(OBJ) $(RMTARGETS)
distclean: clean
	rm -f bin/* Makefile* *.fit *.fits *.csv *.ssv *.tsv *.dat *.txt *.log
