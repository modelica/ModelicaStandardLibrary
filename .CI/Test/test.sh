#!/bin/sh -x

export LIBRARIES="$PWD/../../Modelica/Resources/Library/$LIBDIR/"

test ! -z "$CC" || exit 1

if test ! "$1" = "nostatic"; then

"$CC" -L $LIBRARIES FileSystem.c -Wl,-Bstatic -lModelicaExternalC -Wl,-Bdynamic || exit 1
./a.out || exit 1
"$CC" -L $LIBRARIES ModelicaStrings.c -Wl,-Bstatic -lModelicaExternalC -Wl,-Bdynamic || exit 1
./a.out || exit 1
"$CC" -L $LIBRARIES ModelicaTime.c -Wl,-Bstatic -lModelicaExternalC -Wl,-Bdynamic || exit 1
./a.out || exit 1
"$CC" -L $LIBRARIES Streams.c -Wl,-Bstatic -lModelicaExternalC -Wl,-Bdynamic || exit 1
./a.out || exit 1
"$CC" -L $LIBRARIES Tables.c -Wl,-Bstatic -lModelicaStandardTables -lModelicaIO -lModelicaMatIO -lzlib -Wl,-Bdynamic -lm || exit 1
./a.out || exit 1
"$CC" -L $LIBRARIES TablesFromTxtFile.c -Wl,-Bstatic -lModelicaStandardTables -lModelicaIO -lModelicaMatIO -lzlib -Wl,-Bdynamic -lm || exit 1
./a.out || exit 1
"$CC" -L $LIBRARIES TablesFromMatFile.c -Wl,-Bstatic -lModelicaStandardTables -lModelicaIO -lModelicaMatIO -lzlib -Wl,-Bdynamic -lm || exit 1
./a.out || exit 1
"$CC" -L $LIBRARIES TablesNoUsertab.c -Wl,-Bstatic -lModelicaStandardTables -lModelicaIO -lModelicaMatIO -lzlib -Wl,-Bdynamic -lm || exit 1
./a.out || exit 1

fi

if test ! "$1" = "onlystatic"; then

"$CC" -L $LIBRARIES -Wl,-rpath $LIBRARIES FileSystem.c -lModelicaExternalC || exit 1
./a.out || exit 1
"$CC" -L $LIBRARIES -Wl,-rpath $LIBRARIES ModelicaStrings.c -lModelicaExternalC || exit 1
./a.out || exit 1
"$CC" -L $LIBRARIES -Wl,-rpath $LIBRARIES ModelicaTime.c -lModelicaExternalC || exit 1
./a.out || exit 1
"$CC" -L $LIBRARIES -Wl,-rpath $LIBRARIES Streams.c -lModelicaExternalC || exit 1
./a.out || exit 1
"$CC" -L $LIBRARIES -Wl,-rpath $LIBRARIES Tables.c -lModelicaStandardTables -lModelicaIO -lModelicaMatIO || exit 1
./a.out || exit 1
"$CC" -L $LIBRARIES -Wl,-rpath $LIBRARIES TablesFromMatFile.c -lModelicaStandardTables -lModelicaIO -lModelicaMatIO || exit 1
./a.out || exit 1
"$CC" -L $LIBRARIES -Wl,-rpath $LIBRARIES TablesFromTxtFile.c -lModelicaStandardTables -lModelicaIO -lModelicaMatIO || exit 1
./a.out || exit 1
"$CC" -L $LIBRARIES -Wl,-rpath $LIBRARIES TablesNoUsertab.c -lModelicaStandardTables -lModelicaIO -lModelicaMatIO || exit 1
./a.out || exit 1

fi
