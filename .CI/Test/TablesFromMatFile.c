#include "../../Modelica/Resources/C-Sources/ModelicaStandardTables.h"
#include "Common.c"

#include <assert.h>
#include <math.h>
#include <string.h>

int main(int argc, char **argv) {
    double dummy = 0.0;
    int cols[1] = {2};
    double tmin, tmax, te, y;
    void *table = ModelicaStandardTables_CombiTimeTable_init2("../../Modelica/Resources/Data/Tables/test_v6.mat", "s.tab1", &dummy, 0, 0, 0.0, cols, 1, 1, 3, 0.0, 3, 0);
    assert(table);
    tmin = ModelicaStandardTables_CombiTimeTable_minimumTime(table);
    assert(fabs(tmin - 0.0) < 1e-6);
    tmax = ModelicaStandardTables_CombiTimeTable_maximumTime(table);
    assert(fabs(tmax - 4.0) < 1e-6);
    te = ModelicaStandardTables_CombiTimeTable_nextTimeEvent(table, 1.5);
    y = ModelicaStandardTables_CombiTimeTable_getValue(table, 1, 1.5, te, te);
    assert(fabs(y - (1.0 + 4.0)/2) < 1e-6);
    ModelicaStandardTables_CombiTimeTable_close(table);
    return 0;
}
