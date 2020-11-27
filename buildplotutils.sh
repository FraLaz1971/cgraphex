LIBPNGDIR=src/libpng-1.6.37
LIBZDIR=src/libpng-1.6.37/zlib-1.2.11
PUDIR=src/plotutils
LIBPNGROOT="$(pwd)/src/libpng"
export CC="";export CXX="";export LIBS=""; export LDFLAGS="";
export CPPFLAGS=""; export CFLAGS="";
# build plotutils
CPPFLAGS="-DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT  -DHAVE_LIBPNG=1  -I/$MINGW_BASE/include -I$LIBPNGROOT/include/ -I$LIBPNGROOT/include/libpng16 -I$(pwd)/src/plotutils/include -Iinclude -DMINGW=1 -DGNUC=1 "
CFLAGS="-DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT=1 -DHAVE_LIBPNG=1  -I/$MINGW_BASE/include -Iinclude -I$(pwd)/src/plotutils/include -I/$LIBPNGROOT/include -DMINGW=1"
CXXFLAGS="-DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT=1 -DHAVE_LIBPNG=1  -I/$MINGW_BASE/include -I/$LIBPNGROOT/include/libpng16 -I$(pwd)/src/plotutils/include -Iinclude -DMINGW=1 "
LDFLAGS="-L$LIBPNGROOT/lib -L$(pwd)/src/plotutils/libplot/.libs -L$(pwd)/src/plotutils27"
if   [[ "$OS" == "Windows_NT" ]]
then
        echo "detected Microsoft $OS $(uname)"
        arch=$(uname -m)
        if [[ $arch == i686 ]]
        then
            echo 'ex. build-plotutils-win-mingw-i686.sh'
            CC="i686-w64-mingw32-gcc"
            CXX="i686-w64-mingw32-g++"
            MINGW_BASE="mingw32"
            LIBPNGROOT="$(pwd)/src/libpng"
            CPPFLAGS="-DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT  -DHAVE_LIBPNG=1  -I/$MINGW_BASE/include -I$LIBPNGROOT/include/ -I$LIBPNGROOT/include/libpng16 -I$(pwd)/src/plotutils/include -Iinclude -DMINGW=1 -DGNUC=1 "
            CFLAGS="-DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT=1 -DHAVE_LIBPNG=1  -I/$MINGW_BASE/include -Iinclude -I$(pwd)/src/plotutils/include -I/$LIBPNGROOT/include -DMINGW=1"
            CXXFLAGS="-DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT=1 -DHAVE_LIBPNG=1  -I/$MINGW_BASE/include -I/$LIBPNGROOT/include/libpng16 -I$(pwd)/src/plotutils/include -Iinclude -DMINGW=1 "
            LDFLAGS="-L$LIBPNGROOT/lib -L$(pwd)/src/plotutils/libplot/.libs -L$(pwd)/src/plotutils27"
            bash buildlibpng-win-mingw-i686.sh
            cd $PUDIR
            bash configure-win-i686.sh 2>&1 | tee configure_pu_$(date --iso).log
            sed -e 's/libplot.la/.libs\/libplot.a/g' -e 's/-lm/-lplot -lm -lpng/g'  Makefile > Makefile.mingw32
            cp Makefile.mingw32 Makefile
            mingw32-make -j4 2>&1 | tee build_pu_$(date --iso).log
            for progr in $(ls -d graph plot plotfont pic2plot spline tek2plot test ode-examples hersheydemo ) 
            do 
                cd $progr
                sed -e 's/libplot.la/.libs\/libplot.a/g' -e 's/-lm/-lplot -lm -lpng/g' Makefile > Makefile.mingw32
                cp Makefile.mingw32 Makefile
                MINGW_BASE="mingw32"
                LIBPNGROOT="$(pwd)/../libpng"
                CPPFLAGS="-DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT  -DHAVE_LIBPNG=1  -I/$MINGW_BASE/include -I$LIBPNGROOT/include/ -I$LIBPNGROOT/include/libpng16 -Iinclude -I$(pwd)/../include -DMINGW=1 -DGNUC=1 "
                CFLAGS="-DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT=1 -DHAVE_LIBPNG=1  -I/$MINGW_BASE/include -Iinclude -I/$LIBPNGROOT/include -I$(pwd)/../plotutils/include -DMINGW=1"
                CXXFLAGS="-DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT=1 -DHAVE_LIBPNG=1  -I/$MINGW_BASE/include -I/$LIBPNGROOT/include/libpng16 -I$(pwd)/../include -Iinclude -DMINGW=1 "
                LDFLAGS="-L$LIBPNGROOT/lib -L$(pwd)/../libplot/.libs -L$(pwd)/../../plotutils27/lib"
                mingw32-make -j4 2>&1 | tee build_pu_$progr_$(date --iso).log
                mingw32-make -j4 2>&1 | tee build_pu_$progr_2_$(date --iso).log
                cd $OLDPWD
            done;
            cd graph
            $CC  -DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT=1 -DHAVE_LIBPNG=1  -I/$MINGW_BASE/include -Iinclude -I../../libpng/include -I../../libpng/include/libpng16 -I../include -I../include -DMINGW=1  -L../../libpng/lib -L../lib -L../libplot/.libs -o graph.exe graph-graph.o graph-misc.o graph-linemode.o graph-reader.o graph-plotter.o graph-fontlist.o ../lib/libcommon.a ../libplot/.libs/libplot.a -lplot -lm -lpng 2>&1 | tee build_graph_$(date --iso).log
            cd $OLDPWD
            cd hersheydemo
            $CC  -DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT=1 -DHAVE_LIBPNG=1  -I/$MINGW_BASE/include -Iinclude -I../../libpng/include -I../../libpng/include/libpng16 -I../include -I../include -DMINGW=1  -L../../libpng/lib -L../lib -L../libplot/.libs -o hersheydemo.exe hersheydemo-hersheydemo.o ../lib/libcommon.a ../libplot/.libs/libplot.a -lplot -lm -lpng
            cd $OLDPWD
            mingw32-make install | tee install_pu_$(date --iso).log
        elif [[ $arch == x86_64 ]]
        then
            echo 'ex. build-plotutils-win-mingw-x86-64.sh'
            CC=x86_64-w64-mingw32-gcc
            CXX=x86_64-w64-mingw32-g++
            bash buildlibpng-win-mingw-x86_64.sh
            cd $PUDIR
            bash configure-win-x86_64.sh 2>&1 | tee configure_pu_$(date --iso).log
            sed -e 's/libplot.la/.libs\/libplot.a/g' -e 's/-lm/-lplot -lm -lpng/g' Makefile > Makefile.mingw64
            cp Makefile.mingw64 Makefile
            mingw32-make -j4 2>&1 | tee build_pu_$(date --iso).log
            for progr in $(ls -d graph plot plotfont pic2plot spline tek2plot test ode-examples hersheydemo) 
            do 
                cd $progr; 
                sed -e 's/libplot.la/.libs\/libplot.a/g' -e 's/-lm/-lplot -lm -lpng/g' Makefile > Makefile.mingw64
                cp Makefile.mingw64 Makefile
                MINGW_BASE="mingw64"
                LIBPNGROOT="$(pwd)/../libpng"
                CPPFLAGS="-DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT  -DHAVE_LIBPNG=1  -I/$MINGW_BASE/include -I$LIBPNGROOT/include/ -I$LIBPNGROOT/include/libpng16 -Iinclude -I$(pwd)/../include -DMINGW=1 -DGNUC=1 "
                CFLAGS="-DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT=1 -DHAVE_LIBPNG=1  -I/$MINGW_BASE/include -Iinclude -I/$LIBPNGROOT/include -I$(pwd)/../plotutils/include -DMINGW=1"
                CXXFLAGS="-DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT=1 -DHAVE_LIBPNG=1  -I/$MINGW_BASE/include -I/$LIBPNGROOT/include/libpng16 -I$(pwd)/../include -Iinclude -DMINGW=1 "
                LDFLAGS="-L$LIBPNGROOT/lib -L$(pwd)/../libplot/.libs -L$(pwd)/../../plotutils27/lib"
                mingw32-make -j4 2>&1 | tee build_pu_$progr_$(date --iso).log
                mingw32-make -j4 2>&1 | tee build_pu_$progr_2_$(date --iso).log
                cd $OLDPWD
            done;
            cd graph
            $CC  -DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT=1 -DHAVE_LIBPNG=1  -I/$MINGW_BASE/include -Iinclude -I../../libpng/include -I../../libpng/include/libpng16 -I../include -I../include -DMINGW=1  -L../../libpng/lib -L../lib -L../libplot/.libs -o graph.exe graph-graph.o graph-misc.o graph-linemode.o graph-reader.o graph-plotter.o graph-fontlist.o ../lib/libcommon.a ../libplot/.libs/libplot.a -lplot -lm -lpng 2>&1 | tee build_graph_$(date --iso).log
            cd $OLDPWD
            cd hersheydemo
            $CC  -DDEBUG=1 -DPNG_PTR=1 -DINCLUDE_PNG_SUPPORT=1 -DHAVE_LIBPNG=1  -I/$MINGW_BASE/include -Iinclude -I../../libpng/include -I../../libpng/include/libpng16 -I../include -I../include -DMINGW=1  -L../../libpng/lib -L../lib -L../libplot/.libs -o hersheydemo.exe hersheydemo-hersheydemo.o ../lib/libcommon.a ../libplot/.libs/libplot.a -lplot -lm -lpng
            cd $OLDPWD
            mingw32-make -j4 2>&1 | tee build_pu_3_$(date --iso).log
            mingw32-make install 2>&1 | tee install_pu_$(date --iso).log
        else
                echo "unhandled arch"
        fi
	elif [[ $(uname) == "Linux" ]]
	then
        	echo "detected GNU/linux $OS"
        	uname -a
        	lsb_release -a
		bash buildlibpng.sh
		cd $PUDIR
		bash configure-linux.sh 2>&1 | tee configure_pu_$(date --iso).log
		make -j4 2>&1 | tee build_pu_$(date --iso).log
		make install 2>&1 | tee install_pu_$(date --iso).log
	elif [[ $(uname) == "Darwin" ]]
	then
        echo "detected Apple $OS $(uname)"
        bash configure-mac.sh 2>&1 | tee configure_pu_$(date --iso).log
		make -j4 2>&1 | tee build_pu_$(date --iso).log
		make install 2>&1 | tee install_pu_$(date --iso).log
	else
        	echo "unknow OS"
	fi
cd $OLDPWD
