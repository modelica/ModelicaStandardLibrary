#include "../../Modelica/Resources/C-Sources/ModelicaStandardTables.h"
#include "Common.c"

#include <assert.h>
#include <string.h>

int main(int argc, char **argv) {
    double tab[4] = {0.0, 1.0, 1.0, 2.0};
    int cols[1] = {1};
    void *table = ModelicaStandardTables_CombiTimeTable_init("NoName", "NoName", tab, 2, 2, 0.0, cols, 1, 1, 0);
    assert(table);
    return 0;
}
