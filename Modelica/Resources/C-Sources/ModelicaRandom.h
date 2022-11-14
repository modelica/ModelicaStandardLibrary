/* ModelicaRandom.h - External functions header for Modelica.Math.Random library

   Copyright (C) 2015-2020, Modelica Association and contributors
   All rights reserved.

   SPDX-License-Identifier: BSD-3-Clause
*/

/* The following #define's are available.

   NO_MUTEX       : Pthread mutex is not present (e.g. on dSPACE)
   MODELICA_EXPORT: Prefix used for function calls. If not defined, blank is used
                    Useful definition:
                    - "__declspec(dllexport)" if included in a DLL and the
                      functions shall be visible outside of the DLL
*/

#ifndef MODELICA_RANDOM_H_
#define MODELICA_RANDOM_H_

#include <stdlib.h>

#if !defined(MODELICA_EXPORT)
#if defined(__cplusplus)
#define MODELICA_EXPORT extern "C"
#else
#define MODELICA_EXPORT
#endif
#endif

/*
 * Non-null pointers need to be passed to external functions.
 *
 * The following macros handle nonnull attributes for GNU C and Microsoft SAL.
 */
#undef MODELICA_NONNULLATTR
#if defined(__GNUC__)
#define MODELICA_NONNULLATTR __attribute__((nonnull))
#else
#define MODELICA_NONNULLATTR
#endif
#if !defined(__ATTR_SAL)
#undef _In_
#undef _Out_
#define _In_
#define _Out_
#endif

MODELICA_EXPORT void ModelicaRandom_xorshift64star(_In_ int* state_in,
    _Out_ int* state_out, _Out_ double* y) MODELICA_NONNULLATTR;
MODELICA_EXPORT void ModelicaRandom_xorshift128plus(_In_ int* state_in,
    _Out_ int* state_out, _Out_ double* y) MODELICA_NONNULLATTR;
MODELICA_EXPORT void ModelicaRandom_xorshift1024star(_In_ int* state_in,
    _Out_ int* state_out, _Out_ double* y) MODELICA_NONNULLATTR;
MODELICA_EXPORT void ModelicaRandom_setInternalState_xorshift1024star(
    _In_ int* state, size_t nState, int id) MODELICA_NONNULLATTR;
MODELICA_EXPORT double ModelicaRandom_impureRandom_xorshift1024star(int id);
MODELICA_EXPORT int ModelicaRandom_automaticGlobalSeed(double dummy);
MODELICA_EXPORT void ModelicaRandom_convertRealToIntegers(double d,
    _Out_ int* i) MODELICA_NONNULLATTR;

#endif
