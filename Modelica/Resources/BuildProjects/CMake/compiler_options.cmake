include(CheckSymbolExists)
check_symbol_exists(memcpy "string.h" HAVE_MEMCPY)
check_symbol_exists(fseeko "stdio.h" HAVE_FSEEKO)
check_symbol_exists(ftello "stdio.h" HAVE_FTELLO)
check_symbol_exists(fseeko64 "stdio.h" HAVE_FSEEKO64)
check_symbol_exists(ftello64 "stdio.h" HAVE_FTELLO64)

include(CheckIncludeFile)
check_include_file("dirent.h" HAVE_DIRENT_H)
check_include_file("io.h" HAVE_IO_H)
check_include_file("locale.h" HAVE_LOCALE_H)
check_include_file("pthread.h" HAVE_PTHREAD_H)
check_include_file("stdarg.h" HAVE_STDARG_H)
check_include_file("time.h" HAVE_TIME_H)
check_include_file("unistd.h" HAVE_UNISTD_H)
check_include_file("winapifamily.h" HAVE_WINAPIFAMILY_H)

include(CheckCSourceCompiles)
check_c_source_compiles(
  "
    #include <stdlib.h>
    static void f(void) __attribute__ ((visibility(\"hidden\")));
    int main(void) {return 0;}
  "
  HAVE_ATTRIBUTE_VISIBILITY_HIDDEN
)
if(HAVE_UNISTD_H)
  check_c_source_compiles(
    "
      #include <unistd.h>
      int main(void) {getpid(); return 0;}
    "
    HAVE_GETPID
  )
endif()
