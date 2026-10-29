# Routines

The routines run both in Matlab and in Octave.
Using Matlab, you need the toolboxes CurveFitting and Optimization.
Using Octave, you need the packages splines and io.

In future, more routines might be added for different approximation methods.

To use the routines, copy the routine together with the directories *functions* and *rawData* in your working directory.

### showRd

should give an overview over the data set under investigation.

Usage: `par=showRD(`'*material*'`)`

*material* refers to the name of the text-file RD_*material*.txt or the name of the sheet *material* in RD.xlsx or RD.ods.

With an optional parameter 'fT' it is possible to choose the filetype to be used:

* 'txt' (default) uses the text file.

* 'ods' uses the open document spreadsheet.

* 'xlsx' uses the Excel spreadsheet.

The function produces 4 figures described separately in the Description of Results.

## SSEE

calculates the parameters for **Smoothing Splines** with **Exponential Extrapolation**.

Usage: `par=SSEE(`'*material*'`)`

*material* refers to the name of the text-file RD_*material*.txt or the name of the sheet *material* in RD.xlsx or RD.ods.

With an optional parameter 'fT' it is possible to choose the filetype to be used:

- 'txt' (default) uses the text file.

- 'ods' uses the open document spreadsheet.

- 'xlsx' uses the Excel spreadsheet.

There are optional parameters to control the parameter calculation and the determination of &mu;<sub>rMax</sub>:

| argument | default | limits  | description                                     |
| -------- | ------- | ------- | ----------------------------------------------- |
| p        | 0.005   | 0<=p<=1 | smoothing parameter                             |
| H0       | 2000    | 0<H0    | root of exponential extrapolation               |
| H1       | 5000    | 0<H1<H2 | begin of switch-over from *SS* to *EE*          |
| H2       | 20000   | 0<H1<H2 | end   of switch-over from *SS* to *EE*          |
| markMax  | true    | logical | &mu;<sub>rMax</sub> is marked in figure 2 and 4 |

Bear in mind that you have to inspect the results and adapt the parameters, 
especially p, H0, H1, H2.

p=1 defines no smooting, p=0 maximum smoothing.

Optional parameters are specified using `('argument', value)`, e.g. 

`par=SSEE('M330-50A', 'p', 0.01, 'markMax', true);`

The function produces 4 figures described separately in the [Description of Results](3Results.md).

The routine's output is a struct par, the structure is explained separately in the [Description of Results](3Results.md).

Additionally, the routine stores a file named Par_*material*.txt containing the parameters that can be used in a Modelica record (just copy and paste).
