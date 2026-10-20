# # Description of Raw Data

Raw data are provided either as text-file *.txt*, open document format *.ods* or Excel *.xlsx*.

As single text file is named RD_*material*.txt and contains the same information as a single sheet named *material* in one of the two spreadsheet formats. Both spreadsheet formats contain a template sheet that could be used to store new data.  

In order to focus on the parameter determination, the process of importing the raw data into the routines was deliberately kept simple. Therefore it is necessary to follow a specific structure:

1. \#`1` *necessary to import a text file into Modelica.Tables*

2. \# `type       =`*material*

3. \# `vRef[W/kg] =`*specific losses*

4. \# `Bref[T]    =`*measured at this peak flux density*

5. \# `fRef[Hz]   =`*measured at this frequency*

6. \# `dens[kg/m3]=`*density of material*

7. \# `table J [T] vs. H [A/m]`*just a description*

8. \# `N          =`*number of data pairs J H*

9. `double JH(`*N*`,2)`*necessary to import a text file into Modelica.Tables*

Lines 2 to 6 are additional parameters not used for the magnetic chracteristic, but they enable a later loss calculation.

In the spreadsheets, line 8 and 9 are calculated automatically.

In the text file, count the data pairs and store the number in line 8 and 9.

Starting in line 10, pairs of measured sata J and H are stored. Bear in mind to include the origin (0,0) as first row. Recommendation: Separate J and H by a tab.

The structure of the spreadsheets is designed to be exported as tab-separated text file to get a text file with correct structure. Bear in mind to use the name RD_*material*.txt.
