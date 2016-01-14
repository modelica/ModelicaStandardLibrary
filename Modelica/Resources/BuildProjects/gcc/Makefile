CC = gcc
AR = ar -ru
RM = rm -f

CFLAGS = -O3
CPPFLAGS = -DNDEBUG
INC = -I"zlib"

TARGETDIR = linux64

TABLES_OBJS = \
	ModelicaStandardTables.o

MATIO_OBJS = \
	ModelicaMatIO.o

IO_OBJS = \
	ModelicaIO.o

ZLIB_OBJS = \
	adler32.o \
	compress.o \
	crc32.o \
	deflate.o \
	gzclose.o \
	gzlib.o \
	gzread.o \
	gzwrite.o \
	infback.o \
	inffast.o \
	inflate.o \
	inftrees.o \
	trees.o \
	uncompr.o \
	zutil.o

ALL_OBJS = $(TABLES_OBJS) $(MATIO_OBJS) $(IO_OBJS) $(ZLIB_OBJS)

all: clean libModelicaStandardTables.a libModelicaIO.a libModelicaMatIO.a libzlib.a

libModelicaStandardTables.a: $(TABLES_OBJS)
	$(AR) $@ $(TABLES_OBJS)
	cp $@ ../Library/$(TARGETDIR)/$@

libModelicaMatIO.a: $(MATIO_OBJS)
	$(AR) $@ $(MATIO_OBJS)
	cp $@ ../Library/$(TARGETDIR)/$@

libModelicaIO.a: $(IO_OBJS)
	$(AR) $@ $(IO_OBJS)
	cp $@ ../Library/$(TARGETDIR)/$@

libzlib.a: $(ZLIB_OBJS)
	$(AR) $@ $(ZLIB_OBJS)
	cp $@ ../Library/$(TARGETDIR)/$@

ModelicaStandardTables.o: ModelicaStandardTables.c
	$(CC) $(CPPFLAGS) -DTABLE_SHARE=1 -DDUMMY_FUNCTION_USERTAB $(CFLAGS) $(INC) -c -o $@ $<

ModelicaMatIO.o: ModelicaMatIO.c
	$(CC) $(CPPFLAGS) -DHAVE_ZLIB=1 $(CFLAGS) $(INC) -c -o $@ $<

ModelicaIO.o: ModelicaIO.c
	$(CC) $(CPPFLAGS) $(CFLAGS) $(INC) -c -o $@ $<

%.o: zlib/%.c
	$(CC) $(CPPFLAGS) $(CFLAGS) $(INC) -c -o $@ $<

clean:
	$(RM) $(ALL_OBJS)
	$(RM) *.a
	$(RM) ../Library/$(TARGETDIR)/*.a
