/* usertab.c

   User-defined function to define static interpolation tables.
   The data for the user-defined tables are provided via
   include-file "usertab.h".

   USUALLY, THIS FILE (usertab.c) NEEDS NOT TO BE CHANGED.

   Author : Martin Otter, DLR.
   Version: 1.0, 1997-09-30: implemented.
            1.1, 2013-06-13; adapted to open source table implementations
*/

#include "usertab.h"
#include <string.h>
#include "ModelicaUtilities.h"

static int userTabFindName(const UsertabTableElement _tableDef[], int ntable, char *name) {

   /* Find table element with the given name. Return the index
      with respect to the found element or -1, in case it is
      not found
   */
      int  i;
      for (i=0; i<ntable; i++) {
         if ( strcmp(_tableDef[i].name, name) == 0 ) return i;
      }

   /* Error */
      ModelicaFormatError("Error in function usertab.c:\n"
                          "The table matrix \"%s\" was not found in the\n"
                          "user supplied function \"usertab\".\n",
                          name);
      return -1;
}

int usertab(char *tableName, int nipo, int dim[], int *colWise,
            double **table) {

   /* Define a table by statically storing the table in function usertab.
      This function can be adapted by the user to his/her needs.
      A 1D-table is defined as a matrix where
        - the first column is the abszissa data
        - the other columns are the ordinate data to
          be interpolated with respect to the first column.
      A 2D-table is defined as a matrix where
        - the first column (without first element), i.e., table(2:,1),
          is the first abscissa (u(1)),
        - the first row (without first element), i.e., table(1,2:),
          is the second abscissa (u(2)),
        - the other elements, i.e., table(i,j) with i>=2,j>=2,
          are the corresponding ordinate values.

      -> tableName  : Name of table.
      -> nipo       : = 0: time-table required (time interpolation).
                      = 1: 1D-table required.
                      = 2: 2D-table required.
      <- dim        : Actual values of dimensions.
      <- colWise    : = 0: table stored row-wise    (row_1, row_2, ..., row_n).
                    : = 1: table stored column-wise (column_1, column_2, ...).
      <- table      : Pointer to value vector.
      <- RETURN: = 0: No error.
                 = 1: An error occurred. An error message is printed
                      from "usertab" with function "ModelicaFormatError".
   */

      int  ID;

   /* Search table in static memory */
      ID = userTabFindName(tableDef, N_TABLEDEF, tableName);
      if ( ID < 0 ) {
         ModelicaFormatError(
                      "Error in function usertab.c:\n"
                      "Table \"%s\" is not defined in usertab.\n",
                      tableName);

         return 1;
      }

   /* Check interpolation type */
      if ( nipo != tableDef[ID].nipo ) {
         ModelicaFormatError(
                      "Error in function usertab.c:\n"
                      "Provided interpolation type nipo = %d for table \"%s\"\n"
                      "does not correspond to internal variable tableDef[%d].nipo = %d\n",
                      nipo, tableName, ID, tableDef[ID].nipo);
         return 1;
      }

   /* Return desired values */
      *table   = tableDef[ID].value;
      *colWise = 0;
      dim[0] = tableDef[ID].dim[0];
      dim[1] = tableDef[ID].dim[1];

      return 0;
}
