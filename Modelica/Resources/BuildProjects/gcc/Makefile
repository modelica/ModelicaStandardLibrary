CC ?= cc
AR = ar -ru
RM = rm -f

TARGETDIR ?= linux64
BUILDDIR ?= build

OBJDIR := $(BUILDDIR)/obj
LIBDIR := $(BUILDDIR)/lib

INSTALLDIR := ../../Library/$(TARGETDIR)

CFLAGS = -O3 -Wno-attributes -fno-delete-null-pointer-checks
CPPFLAGS = -DNDEBUG -DHAVE_UNISTD_H -DHAVE_STDARG_H -DHAVE_HIDDEN -DHAVE_MEMCPY
INC      = -I"../../C-Sources/zlib"

SRC := ../../C-Sources
ZLIBSRC := $(SRC)/zlib

EXTC_OBJS = \
	$(OBJDIR)/ModelicaFFT.o \
	$(OBJDIR)/ModelicaInternal.o \
	$(OBJDIR)/ModelicaRandom.o \
	$(OBJDIR)/ModelicaStrings.o

TABLES_OBJS = \
	$(OBJDIR)/ModelicaStandardTables.o \
	$(OBJDIR)/ModelicaStandardTablesUsertab.o

MATIO_OBJS = \
	$(OBJDIR)/ModelicaMatIO.o \
	$(OBJDIR)/snprintf.o

IO_OBJS = \
	$(OBJDIR)/ModelicaIO.o

ZLIB_OBJS = \
	$(OBJDIR)/adler32.o \
	$(OBJDIR)/compress.o \
	$(OBJDIR)/crc32.o \
	$(OBJDIR)/deflate.o \
	$(OBJDIR)/gzclose.o \
	$(OBJDIR)/gzlib.o \
	$(OBJDIR)/gzread.o \
	$(OBJDIR)/gzwrite.o \
	$(OBJDIR)/infback.o \
	$(OBJDIR)/inffast.o \
	$(OBJDIR)/inflate.o \
	$(OBJDIR)/inftrees.o \
	$(OBJDIR)/trees.o \
	$(OBJDIR)/uncompr.o \
	$(OBJDIR)/zutil.o

LIBS = \
	$(LIBDIR)/libModelicaExternalC.a \
	$(LIBDIR)/libModelicaStandardTables.a \
	$(LIBDIR)/libModelicaIO.a \
	$(LIBDIR)/libModelicaMatIO.a \
	$(LIBDIR)/libzlib.a

.PHONY: all install clean

all: $(LIBS)

install: all | $(INSTALLDIR)
	cp $(LIBDIR)/*.a $(INSTALLDIR)/

clean:
	$(RM) -r $(BUILDDIR)

$(OBJDIR) $(LIBDIR) $(INSTALLDIR):
	mkdir -p $@

$(LIBDIR)/libModelicaExternalC.a: $(EXTC_OBJS) | $(LIBDIR)
	$(AR) $@ $^

$(LIBDIR)/libModelicaStandardTables.a: $(TABLES_OBJS) | $(LIBDIR)
	$(AR) $@ $^

$(LIBDIR)/libModelicaMatIO.a: $(MATIO_OBJS) | $(LIBDIR)
	$(AR) $@ $^

$(LIBDIR)/libModelicaIO.a: $(IO_OBJS) | $(LIBDIR)
	$(AR) $@ $^

$(LIBDIR)/libzlib.a: $(ZLIB_OBJS) | $(LIBDIR)
	$(AR) $@ $^

$(OBJDIR)/%.o: $(SRC)/%.c | $(OBJDIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) $(INC) -c -o $@ $<

$(OBJDIR)/%.o: $(ZLIBSRC)/%.c | $(OBJDIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) $(INC) -c -o $@ $<

$(OBJDIR)/ModelicaStandardTables.o: $(SRC)/ModelicaStandardTables.c | $(OBJDIR)
	$(CC) $(CPPFLAGS) -DTABLE_SHARE=1 $(CFLAGS) $(INC) -c -o $@ $<

$(OBJDIR)/ModelicaStandardTablesUsertab.o: $(SRC)/ModelicaStandardTablesUsertab.c | $(OBJDIR)
	$(CC) $(CPPFLAGS) -DDUMMY_FUNCTION_USERTAB $(CFLAGS) $(INC) -c -o $@ $<

$(OBJDIR)/ModelicaMatIO.o: $(SRC)/ModelicaMatIO.c | $(OBJDIR)
	$(CC) $(CPPFLAGS) -DHAVE_ZLIB=1 $(CFLAGS) $(INC) -c -o $@ $<
