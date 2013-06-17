MSLCSOURCES=../../C-Sources/
lib_LTLIBRARIES = libModelicaExternalC.la libModelicaStandardTables.la
libModelicaExternalC_la_SOURCES = $(MSLCSOURCES)/ModelicaInternal.c $(MSLCSOURCES)/ModelicaStrings.c
libModelicaStandardTables_la_SOURCES = $(MSLCSOURCES)/ModelicaStandardTables.c $(MSLCSOURCES)/ModelicaMatIO.c
# If the OS does not have zlib available, compile it and include it together with libModelicaStandardTables
if INCLUDEZLIB
libModelicaStandardTables_la_SOURCES += $(MSLCSOURCES)/zlib/adler32.c $(MSLCSOURCES)/zlib/compress.c $(MSLCSOURCES)/zlib/crc32.c $(MSLCSOURCES)/zlib/deflate.c $(MSLCSOURCES)/zlib/gzclose.c $(MSLCSOURCES)/zlib/gzlib.c $(MSLCSOURCES)/zlib/gzread.c $(MSLCSOURCES)/zlib/gzwrite.c $(MSLCSOURCES)/zlib/infback.c $(MSLCSOURCES)/zlib/inffast.c $(MSLCSOURCES)/zlib/inflate.c $(MSLCSOURCES)/zlib/inftrees.c $(MSLCSOURCES)/zlib/trees.c $(MSLCSOURCES)/zlib/uncompr.c $(MSLCSOURCES)/zlib/zutil.c
endif
