## warning
## you've to updated LDFLAGS with the real path to libpng
##
LIBPNGROOT="$(pwd)/../libpng"
PUROOT="$(pwd)"
./configure
./configure \
--host=x86_64-w64-mingw32 \
--target=x86_64-w64-mingw32 \
--prefix=$(pwd)/../plotutils27 \
--with-libpng="$LIBPNGROOT"/lib/libpng16.a \
--without-x \
--enable-libplotter \
--enable-libxmi \
CC="x86_64-w64-mingw32-gcc" \
CXX="x86_64-w64-mingw32-g++" \
CPPFLAGS="-DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT  -DHAVE_LIBPNG=1  -I/mingw64/include -I../include -I$LIBPNGROOT/include/ -I$LIBPNGROOT/include/libpng16 -I$(PUROOT)/include -Iinclude -DMINGW=1 -DGNUC=1 " \
CFLAGS="-DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT=1 -DHAVE_LIBPNG=1  -I/mingw64/include -Iinclude -I../include -I/$LIBPNGROOT/include -I$LIBPNGROOT/include/libpng16 -I$(PUROOT)/include -DMINGW=1" \
CXXFLAGS="-DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT=1 -DHAVE_LIBPNG=1  -I/mingw64/include -I/$LIBPNGROOT/include/libpng16 -I$(PUROOT)/include -Iinclude -I../include -DMINGW=1 " \
LDFLAGS="-L$LIBPNGROOT/lib -L$PUROOT/lib"

