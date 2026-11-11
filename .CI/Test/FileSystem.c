#include "../../Modelica/Resources/C-Sources/ModelicaInternal.h"
#include "Common.c"

#include <assert.h>
#include <string.h>

typedef enum {
    FileType_NoFile = 1,
    FileType_Directory = 3
} ModelicaFileType;

int main(int argc, char **argv) {
    const char* dirName = "abc";
    const char* newName = "xyz";
    ModelicaFileType fileType = FileType_NoFile;
    ModelicaInternal_mkdir(dirName);
    fileType = ModelicaInternal_stat(dirName);
    assert(FileType_Directory == fileType);
    ModelicaInternal_rename(dirName, newName);
    fileType = ModelicaInternal_stat(dirName);
    assert(FileType_NoFile == fileType);
    fileType = ModelicaInternal_stat(newName);
    assert(FileType_Directory == fileType);
    ModelicaInternal_rmdir(newName);
    return 0;
}
