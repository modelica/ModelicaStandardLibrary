#include "ModelicaUtilities.h"
#include <assert.h>
#include <stdlib.h>
#include <stdio.h>

char* ModelicaAllocateString(size_t len) {
    void *data = malloc(len + 1); /* Never free'd in the test programs */
    assert(data);
    return data;
}

char* ModelicaAllocateStringWithErrorReturn(size_t len) {
    return malloc(len + 1); /* Never free'd in the test programs */
}

void ModelicaMessage(const char *string) {
    printf("%s\n", string);
}

void ModelicaWarning(const char *string) {
    printf("%s\n", string);
}

void ModelicaError(const char *string) {
    fputs(string, stderr);
    fputc('\n', stderr);
    assert(0);
}

void ModelicaFormatMessage(const char *string, ...) {
    va_list args;
    va_start(args, string);
    ModelicaVFormatMessage(string, args);
    va_end(args);
}

void ModelicaFormatWarning(const char *string, ...) {
    va_list args;
    va_start(args, string);
    ModelicaVFormatWarning(string, args);
    va_end(args);
}

void ModelicaFormatError(const char *string, ...) {
    va_list args;
    va_start(args, string);
    ModelicaVFormatError(string, args);
    va_end(args);
}

void ModelicaVFormatMessage(const char *string, va_list args) {
    vprintf(string, args);
}

void ModelicaVFormatWarning(const char *string, va_list args) {
    vprintf(string, args);
}

void ModelicaVFormatError(const char *string, va_list args) {
    vfprintf(stderr, string, args);
    assert(0);
}
