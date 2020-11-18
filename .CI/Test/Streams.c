#include "../../Modelica/Resources/C-Sources/ModelicaInternal.h"
#include "Common.c"

#include <assert.h>
#include <string.h>

int main(int argc, char **argv) {
    const char* fileName = "test.txt";
    const char* line;
    const char* lines[5];
    int endOfFile;
    ModelicaInternal_print("Modelica\nStandard\nLibrary\nCI\n", fileName);
    assert(5 == ModelicaInternal_countLines(fileName));
    line = ModelicaInternal_readLine(fileName, 3, &endOfFile);
    assert(0 == strcmp("Library", line));
    assert(0 == endOfFile);
    line = ModelicaInternal_readLine(fileName, 6, &endOfFile);
    assert(0 == strcmp("", line));
    assert(1 == endOfFile);
    ModelicaStreams_closeFile(fileName);
    ModelicaInternal_readFile(fileName, lines, 5);
    assert(0 == strcmp("Modelica", lines[0]));
    assert(0 == strcmp("Standard", lines[1]));
    assert(0 == strcmp("Library", lines[2]));
    assert(0 == strcmp("CI", lines[3]));
    assert(0 == strcmp("", lines[4]));
    ModelicaInternal_removeFile(fileName);
    return 0;
}
