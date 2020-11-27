## warning
## you've to updated LDFLAGS with the real path to libpng
##
PUROOT="$(pwd)"
LIBPNGROOT="$(pwd)/../libpng"
./configure
./configure \
--host=i686-w64-mingw32 \
--target=i686-w64-mingw32 \
--prefix="$(pwd)/../plotutils27" \
--with-libpng=../libpng/lib/libpng16.a \
--without-x \
--enable-libplotter \
--enable-libxmi \
CC="i686-w64-mingw32-gcc" \
CXX="i686-w64-mingw32-g++" \
CPPFLAGS="-DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT  -DHAVE_LIBPNG=1  -I/mingw32/include -I$LIBPNGROOT/include/ -I$LIBPNGROOT/include/libpng16  -Iinclude -I../include -DMINGW=1 -DGNUC=1 " \
CFLAGS="-DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT=1 -DHAVE_LIBPNG=1  -I/mingw32/include -Iinclude -I/$LIBPNGROOT/include -I/$LIBPNGROOT/include/libpng16 -I$PUROOT/include -I../include -DMINGW=1" \
CXXFLAGS="-DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT=1 -DHAVE_LIBPNG=1  -I/mingw32/include -I/$LIBPNGROOT/include/libpng16 -I$PUROOT/include -Iinclude -I../include -DMINGW=1 " \
LDFLAGS="-L$LIBPNGROOT/lib -L$PUROOT/lib -L../libplot/.libs"
