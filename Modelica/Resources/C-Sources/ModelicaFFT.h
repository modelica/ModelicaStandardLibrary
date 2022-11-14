/* ModelicaFFT.h - FFT functions header

   Copyright (C) 2015-2020, Modelica Association and contributors
   Copyright (C) 2003-2010, Mark Borgerding
   All rights reserved.

   SPDX-License-Identifier: BSD-3-Clause
*/

/* The following #define's are available.

   MODELICA_EXPORT: Prefix used for function calls. If not defined, blank is used
                    Useful definition:
                    - "__declspec(dllexport)" if included in a DLL and the
                      functions shall be visible outside of the DLL
*/

#ifndef MODELICA_FFT_H_
#define MODELICA_FFT_H_

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

MODELICA_EXPORT int ModelicaFFT_kiss_fftr(_In_ double* u, size_t nu, _In_ double* work, size_t nwork,
    _Out_ double *amplitudes, _Out_ double *phases) MODELICA_NONNULLATTR;

#endif
