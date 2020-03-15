#include <string.h>
#include <assert.h>

#include "Common.c"

int usertab(char* tableName, int nipo, int dim[], int* colWise,
                 double** table) {
    ModelicaFormatMessage("Requested tableName %s nipo %d\n", tableName, nipo);
    *colWise = 0;
    dim[0] = 2;
    dim[1] = 2;
    return 0; /* OK */
}

void* ModelicaStandardTables_CombiTimeTable_init(const char* tableName,
                                                 const char* fileName,
                                                 double* table, size_t nRow,
                                                 size_t nColumn,
                                                 double startTime,
                                                 int* columns,
                                                 size_t nCols, int smoothness,
                                                 int extrapolation);

int main(int argc, char **argv) {
    double tab[4] = {0.0, 1.0, 1.0, 2.0};
    int cols[1] = {1};
    void *table = ModelicaStandardTables_CombiTimeTable_init("abc", "NoName", tab, 2, 2, 0.0, cols, 1, 1, 0);
    assert(table);
    return 0;
}
