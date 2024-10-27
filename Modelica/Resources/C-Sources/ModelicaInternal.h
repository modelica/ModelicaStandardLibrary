/* ModelicaInternal.h - External functions header for Modelica.Utilities

   Copyright (C) 2002-2024, Modelica Association and contributors
   All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are met:

   1. Redistributions of source code must retain the above copyright notice,
      this list of conditions and the following disclaimer.

   2. Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.

   3. Neither the name of the copyright holder nor the names of its
      contributors may be used to endorse or promote products derived from
      this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
   ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
   DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
   FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
   DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
   CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
   OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

/* The following #define's are available.

   NO_FILE_SYSTEM : A file system is not present (e.g. on dSPACE or xPC).
   NO_MUTEX       : Pthread mutex is not present (e.g. on dSPACE)
   NO_PID         : Function getpid is not present (e.g. on dSPACE)
   NO_TIME        : Function gettimeofday is not present (e.g. on dSPACE)
   MODELICA_EXPORT: Prefix used for function calls. If not defined, blank is used
                    Useful definition:
                    - "__declspec(dllexport)" if included in a DLL and the
                      functions shall be visible outside of the DLL
*/

#ifndef MODELICA_INTERNAL_H_
#define MODELICA_INTERNAL_H_

#include <stdlib.h>

#if !defined(MODELICA_EXPORT)
#if defined(__cplusplus)
#define MODELICA_EXPORT extern "C"
#else
#define MODELICA_EXPORT
#endif
#endif

/*
  Some of the functions never return to the caller. In order to compile
  external Modelica C-code in most compilers, noreturn attributes need to
  be present to avoid warnings or errors.

  The following macros handle noreturn attributes according to the
  C11/C++11 standard with fallback to GNU, Clang or MSVC extensions if using
  an older compiler.
*/
#undef MODELICA_NORETURN
#undef MODELICA_NORETURNATTR
#if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 201112L
#define MODELICA_NORETURN _Noreturn
#define MODELICA_NORETURNATTR
#elif defined(__cplusplus) && __cplusplus >= 201103L
#if (defined(__GNUC__) && __GNUC__ >= 5) || \
    (defined(__GNUC__) && defined(__GNUC_MINOR__) && __GNUC__ == 4 && __GNUC_MINOR__ >= 8)
#define MODELICA_NORETURN [[noreturn]]
#define MODELICA_NORETURNATTR
#elif (defined(__GNUC__) && __GNUC__ >= 3) || \
      (defined(__GNUC__) && defined(__GNUC_MINOR__) && __GNUC__ == 2 && __GNUC_MINOR__ >= 8)
#define MODELICA_NORETURN
#define MODELICA_NORETURNATTR __attribute__((noreturn))
#elif defined(__GNUC__)
#define MODELICA_NORETURN
#define MODELICA_NORETURNATTR
#else
#define MODELICA_NORETURN [[noreturn]]
#define MODELICA_NORETURNATTR
#endif
#elif defined(__clang__)
/* Encapsulated for Clang since GCC fails to process __has_attribute */
#if __has_attribute(noreturn)
#define MODELICA_NORETURN
#define MODELICA_NORETURNATTR __attribute__((noreturn))
#else
#define MODELICA_NORETURN
#define MODELICA_NORETURNATTR
#endif
#elif (defined(__GNUC__) && __GNUC__ >= 3) || \
      (defined(__GNUC__) && defined(__GNUC_MINOR__) && __GNUC__ == 2 && __GNUC_MINOR__ >= 8) || \
      (defined(__SUNPRO_C) && __SUNPRO_C >= 0x5110)
#define MODELICA_NORETURN
#define MODELICA_NORETURNATTR __attribute__((noreturn))
#elif (defined(_MSC_VER) && _MSC_VER >= 1200) || \
       defined(__BORLANDC__)
#define MODELICA_NORETURN __declspec(noreturn)
#define MODELICA_NORETURNATTR
#else
#define MODELICA_NORETURN
#define MODELICA_NORETURNATTR
#endif

/*
 * Non-null pointers and esp. null-terminated strings need to be passed to
 * external functions.
 *
 * The following macros handle nonnull attributes for GNU C and Microsoft SAL.
 */
#undef MODELICA_NONNULLATTR
#undef MODELICA_RETURNNONNULLATTR
#if defined(__GNUC__)
#define MODELICA_NONNULLATTR __attribute__((nonnull))
#if defined(__GNUC_MINOR__) && (__GNUC__ > 3 && __GNUC_MINOR__ > 8)
#define MODELICA_RETURNNONNULLATTR __attribute__((returns_nonnull))
#else
#define MODELICA_RETURNNONNULLATTR
#endif
#elif defined(__ATTR_SAL)
#define MODELICA_NONNULLATTR
#define MODELICA_RETURNNONNULLATTR _Ret_z_ /* _Ret_notnull_ and null-terminated */
#else
#define MODELICA_NONNULLATTR
#define MODELICA_RETURNNONNULLATTR
#endif
#if !defined(__ATTR_SAL)
#undef _In_
#undef _In_z_
#undef _Out_
#undef _Ret_z_
#define _In_
#define _In_z_
#define _Out_
#define _Ret_z_
#endif

MODELICA_EXPORT MODELICA_NORETURN void ModelicaInternal_error(_In_z_ const char* string) MODELICA_NORETURNATTR MODELICA_NONNULLATTR;
MODELICA_EXPORT void ModelicaInternal_mkdir(_In_z_ const char* directoryName) MODELICA_NONNULLATTR;
MODELICA_EXPORT void ModelicaInternal_rmdir(_In_z_ const char* directoryName) MODELICA_NONNULLATTR;
MODELICA_EXPORT int ModelicaInternal_stat(_In_z_ const char* name) MODELICA_NONNULLATTR;
MODELICA_EXPORT void ModelicaInternal_rename(_In_z_ const char* oldName,
    _In_z_ const char* newName) MODELICA_NONNULLATTR;
MODELICA_EXPORT void ModelicaInternal_removeFile(_In_z_ const char* file) MODELICA_NONNULLATTR;
MODELICA_EXPORT void ModelicaInternal_copyFile(_In_z_ const char* oldFile,
    _In_z_ const char* newFile) MODELICA_NONNULLATTR;
MODELICA_EXPORT void ModelicaInternal_readDirectory(_In_z_ const char* directory, int nFiles,
    _Out_ const char** files) MODELICA_NONNULLATTR;
MODELICA_EXPORT int ModelicaInternal_getNumberOfFiles(_In_z_ const char* directory) MODELICA_NONNULLATTR;
MODELICA_EXPORT MODELICA_RETURNNONNULLATTR const char* ModelicaInternal_fullPathName(
    _In_z_ const char* name) MODELICA_NONNULLATTR;
MODELICA_EXPORT MODELICA_RETURNNONNULLATTR const char* ModelicaInternal_temporaryFileName(void);
MODELICA_EXPORT void ModelicaStreams_closeFile(_In_z_ const char* fileName) MODELICA_NONNULLATTR;
MODELICA_EXPORT void ModelicaInternal_print(_In_z_ const char* string,
    _In_z_ const char* fileName) MODELICA_NONNULLATTR;
MODELICA_EXPORT int ModelicaInternal_countLines(_In_z_ const char* fileName) MODELICA_NONNULLATTR;
MODELICA_EXPORT void ModelicaInternal_readFile(_In_z_ const char* fileName,
    _Out_ const char** string, size_t nLines) MODELICA_NONNULLATTR;
MODELICA_EXPORT MODELICA_RETURNNONNULLATTR const char* ModelicaInternal_readLine(_In_z_ const char* fileName,
    int lineNumber, _Out_ int* endOfFile) MODELICA_NONNULLATTR;
MODELICA_EXPORT void ModelicaInternal_chdir(_In_z_ const char* directoryName) MODELICA_NONNULLATTR;
MODELICA_EXPORT MODELICA_RETURNNONNULLATTR const char* ModelicaInternal_getcwd(int dummy);
MODELICA_EXPORT void ModelicaInternal_getenv(_In_z_ const char* name, int convertToSlash,
    _Out_ const char** content, _Out_ int* exist) MODELICA_NONNULLATTR;
MODELICA_EXPORT void ModelicaInternal_setenv(_In_z_ const char* name,
    _In_z_ const char* value, int convertFromSlash) MODELICA_NONNULLATTR;
MODELICA_EXPORT void ModelicaInternal_getTime(_Out_ int* ms, _Out_ int* sec, _Out_ int* min, _Out_ int* hour,
    _Out_ int* mday, _Out_ int* mon, _Out_ int* year) MODELICA_NONNULLATTR;
MODELICA_EXPORT int ModelicaInternal_getpid(void);

#endif
