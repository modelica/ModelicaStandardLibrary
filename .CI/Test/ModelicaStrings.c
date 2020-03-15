#include <string.h>
#include <assert.h>

#include "Common.c"

const char* ModelicaStrings_substring(const char* string,
                                      int startIndex, int endIndex);

int main(int argc, char **argv) {
    assert(0 == strcmp("a", ModelicaStrings_substring("abc",-1,-1)));
    assert(0 == strcmp("b", ModelicaStrings_substring("abc",2,-1)));
    assert(0 == strcmp("", ModelicaStrings_substring("abc",2,0)));
    assert(0 == strcmp("", ModelicaStrings_substring("abc",2,1)));
    assert(0 == strcmp("b", ModelicaStrings_substring("abc",2,2)));
    assert(0 == strcmp("bc", ModelicaStrings_substring("abc",2,3)));
    assert(0 == strcmp("bc", ModelicaStrings_substring("abc",2,4)));
    assert(0 == strcmp("", ModelicaStrings_substring("abc",4,4)));
}
