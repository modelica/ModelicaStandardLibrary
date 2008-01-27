/* userfunc.c
 *
 * To include user defined functions called from model equations.
 *
 * Version:  1.1  1999-01-20  Dag Bruck  Added documentation of RootFinder_,
 *                                       EventIterate_ and PrintEvent_.
 *           1.2  1999-02-01  Dag Bruck  Added TIME_EVENTS_DISABLED.
 *           1.3  1999-03-03  Dag Bruck  Definitions moved to userdefs.h.
 *           1. 4 2002-08-26  Hans Olsson Include #ifdef DYMOSIM
 *
 */

/*
 * Copyright (C) 1998-2002 Dynasim AB.
 * All rights reserved.
 *
 */

/* Include usertab.c if user defined static functions are used. */
/* The ifdef ensure that we do not get double-definition in Simulink. */
/* #ifdef DYMOSIM */

#include "ModelicaTables_Dymola.c"
