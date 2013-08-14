#ifndef USERTAB_H
#define USERTAB_H

typedef struct {
   char   *name;    /* Name of table                         */
   double *value;   /* Pointer to value matrix               */
   int     nipo;    /* = 0: 1D-table with time as abszissa   */
                    /* = 1: 1D-table                         */
                    /* = 2: 2D-table                         */
   int     dim[2];  /* Actual number of dimensions           */
} UsertabTableElement;


/* ------------------------------------------------------------------------- */
/* Static definitions of all tables. Adapt to your needs.                    */
/* ------------------------------------------------------------------------- */

/* A 1D-table is defined as a matrix where
     - the first column is the abszissa data
     - the other columns are the ordinate data to
       be interpolated with respect to the first column.
   A 1D-table with time as abszissa may have discontinuities, i.e.,
   the abszissa data needs to be only monotonically increasing.
   In all other cases, the abszissa data needs to be strict
   monotonically increasing.

   A 2D-table is defined as a matrix where
     - the first column (without first element), i.e., table(2:,1),
       is the first abscissa (u(1)),
     - the first row (without first element), i.e., table(1,2:),
       is the second abscissa (u(2)),
     - the other elements, i.e., table(i,j) with i>=2,j>=2,
       are the corresponding ordinate values.
   ------------------------------------------------------------------------ */

   /* Definition of all tables (default: test tables) */
      static double TestTable_1D_Time[] = {0.0,  0.0,    /* 1D-table with time as abszissa*/
                                           1.0,  1.5,
                                           2.0,  4.0,
                                           2.0,  6.0,
                                           3.0,  9.0,
                                           4.0, 16.0};

      static double TestTable_1D_a[] = {0.0,  0.0,         /* 1D-table */
                                        1.0,  2.0,
                                        4.0, 12.0,
                                        5.0, 16.0};

      static double TestTable_1D_b[] = {0.0, 0.0, 0.0,      /* 1D-table */
                                        1.0, 2.0, 0.5,
                                        2.0, 3.0, 1.0,
                                        3.0, 5.0, 2.0,
                                        4.0, 7.0, 4.5};


      static double TestTable_2D[] = {0.0, 0.0,  3.0,  6.0,   /* 2D-table */
                                      0.0, -1.0,  4.0, 11.0,
                                      1.0,  3.0, 10.0, 20.0,
                                      1.5,  4.0, 13.0, 20.5,
                                      2.0,  6.0, 15.0, 21.0};

  /* Definition of the tables
       N_TABLEDEF: Number of tables.
       name      : Name of table.
       nipo      : = 0: time-table (first axis is time; discontinuous points
                                    are allowed).
                   = 1: 1D-table.
                   = 2: 2D-table.
       dim1      : Number of rows.
       dim2      : Number of columns.
  */
#define N_TABLEDEF  4
      static UsertabTableElement tableDef[N_TABLEDEF] = {
          /* name                pointer to value    nipo,  dim1, dim2 */
           {"TestTable_1D_Time", TestTable_1D_Time,     0,    {6,  2}}
          ,{"TestTable_1D_a"   , TestTable_1D_a,        1,    {4,  2}}
          ,{"TestTable_1D_b"   , TestTable_1D_b,        1,    {5,  3}}
          ,{"TestTable_2D"     , TestTable_2D,          2,    {5,  4}}
      };

#endif
