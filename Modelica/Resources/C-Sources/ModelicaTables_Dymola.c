
/*
   The content of this file is free software; it can be redistributed
   and/or modified under the terms of the Modelica License 2, see the
   license conditions and the accompanying disclaimer in file
   Modelica/ModelicaLicense2.html or in Modelica.UsersGuide.ModelicaLicense2.
*/

#include "ModelicaTables.h"
#include "dymtable.h"


int ModelicaTables_CombiTimeTable_init(const char* tableName, const char* fileName,
                                        double const *table, int nRow, int nColumn,
                                        double startTime, int smoothness,
                                        int extrapolation) {
  int tableID = (int) dymTableTimeIni2(0.0, startTime, smoothness-1, extrapolation-1,
                                       tableName, fileName, table, nRow, nColumn, 0.0);
  return tableID;
}

void ModelicaTables_CombiTimeTable_close(int tableID) {
  ;
};

double ModelicaTables_CombiTimeTable_interpolate(int tableID, int icol, double u) {
  return dymTableTimeIpo2(tableID, icol, u);
}

double ModelicaTables_CombiTimeTable_minimumTime(int tableID) {
  int tableID2 = (int) tableID;
  return dymTableTimeTmin(tableID2);
}

double ModelicaTables_CombiTimeTable_maximumTime(int tableID) {
  return dymTableTimeTmax(tableID);
}






int ModelicaTables_CombiTable1D_init(const char* tableName, const char* fileName,
                                       double const *table, int nRow, int nColumn,
                                       int smoothness) {
  int tableID = (int) dymTableInit(1.0, smoothness-1, tableName, fileName, table, nRow, nColumn, 0.0);
  return tableID;
}

void ModelicaTables_CombiTable1D_close(int tableID) {
  ;
};

double ModelicaTables_CombiTable1D_interpolate(int tableID, int icol, double u) {
  return dymTableIpo1((double) tableID, icol, u);
}






int ModelicaTables_CombiTable2D_init(const char* tableName, const char* fileName,
                                       double const *table, int nRow, int nColumn,
                                       int smoothness) {
  int tableID = (int) dymTableInit(2.0, smoothness-1, tableName, fileName, table, nRow, nColumn, 0.0);
  return tableID;
}

void ModelicaTables_CombiTable2D_close(int tableID) {
  ;
};

double ModelicaTables_CombiTable2D_interpolate(int tableID, double u1, double u2) {
  return dymTableIpo2((double) tableID, u1, u2);
}

