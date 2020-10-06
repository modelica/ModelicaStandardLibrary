#include "../../Modelica/Resources/C-Sources/ModelicaInternal.h"
#include "Common.c"

#include <assert.h>
#include <string.h>

int main(int argc, char **argv) {
    ModelicaInternal_mkdir("abc");
    ModelicaInternal_rmdir("abc");
    return 0;
}
