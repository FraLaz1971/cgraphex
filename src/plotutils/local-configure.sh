export CC=""; export CXX=""; export CPPFLAGS=""; export LDFLAGS=""
export CFLAGS=""; export CXXFLAGS=""; export AM_LDFLAGS=""
export CC="gcc"
export CXX="g++"
./configure \
--build=x86_64-ubuntu-linux-gnu \
--host=x86_64-ubuntu-linux-gnu \
--disable-libplotter \
--enable-libxmi 
