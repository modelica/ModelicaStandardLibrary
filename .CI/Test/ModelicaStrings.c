#include <string.h>
#include <assert.h>

#include "Common.c"

const char* ModelicaStrings_substring(const char* string,
                                      int startIndex, int endIndex);

int main(int argc, char **argv) {
  assert(0 == strcmp("bcd", ModelicaStrings_substring("abcdef",2,4)));
}
