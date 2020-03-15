#include <string.h>
#include <assert.h>

#include "Common.c"

void ModelicaInternal_mkdir(const char* string);
void ModelicaInternal_rmdir(const char* string);

int main(int argc, char **argv) {
    ModelicaInternal_mkdir("abc");
    ModelicaInternal_rmdir("abc");
    return 0;
}
