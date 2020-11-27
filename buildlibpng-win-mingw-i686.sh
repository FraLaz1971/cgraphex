LIBPNGDIR=src/libpng-1.6.37
LIBZDIR=src/libpng-1.6.37/zlib-1.2.11
export CC=i686-w64-mingw32-gcc
# build zlib
cd $LIBZDIR
ZROOTDIR=$(pwd); ZPREFIX="$ZROOTDIR"/../../libpng
mingw32-make -f win32/Makefile.i686-w64-mingw32-gcc SHARED_MODE=1 2>&1 | tee build_zlib_$(date --iso).log
/mingw32/bin/i686-w64-mingw32-gcc-ar rcs libz.a adler32.o compress.o crc32.o deflate.o gzclose.o gzlib.o gzread.o gzwrite.o infback.o inffast.o inflate.o inftrees.o trees.o uncompr.o zutil.o 2>&1 | tee ar_zlib_$(data --iso)
mingw32-make -f win32/Makefile.i686-w64-mingw32-gcc SHARED_MODE=1 2>&1 | tee build_zlib_2_$(date --iso).log
mingw32-make -f win32/Makefile.i686-w64-mingw32-gcc install SHARED_MODE=1 2>&1 | tee install_zlib_$(date --iso).log
# build libpng
cd $OLDPWD
cd $LIBPNGDIR
PNGROOTDIR=$(pwd); PNGPREFIX="$PNGROOTDIR"/../libpng
./configure --prefix="$PNGPREFIX" --with-sysroot=$PREFIX --with-zlib-prefix=$ZPREFIX
mingw32-make 2>&1 | tee build_libpng_$(date --iso).log
mingw32-make install 2>&1 | tee install_libpng_$(date --iso).log
cd $OLDPWD
