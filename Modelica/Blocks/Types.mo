within Modelica.Blocks;
package Types
  "Library of constants and types with choices, especially to build menus"
  extends Modelica.Icons.TypesPackage;

  type Smoothness = enumeration(
      LinearSegments "Table points are linearly interpolated",
      ContinuousDerivative
        "Table points are interpolated such that the first derivative is continuous",
      ConstantSegments
        "Table points are not interpolated, but the value from the previous abscissa point is returned")
    "Enumeration defining the smoothness of table interpolation";

  type Extrapolation = enumeration(
      HoldLastPoint "Hold the first/last table point outside of the table scope",
      LastTwoPoints
        "Extrapolate by using the derivative at the first/last table points outside of the table scope",
      Periodic "Repeat the table scope periodically",
      NoExtrapolation "Extrapolation triggers an error")
    "Enumeration defining the extrapolation of time table interpolation";

  type Init = enumeration(
      NoInit
        "No initialization (start values are used as guess values with fixed=false)",
      SteadyState
        "Steady state initialization (derivatives of states are zero)",
      InitialState "Initialization with initial states",
      InitialOutput
        "Initialization with initial outputs (and steady state of the states if possible)")
    "Enumeration defining initialization of a block" annotation (Evaluate=true);

  type InitPID = enumeration(
      NoInit
        "No initialization (start values are used as guess values with fixed=false)",
      SteadyState
        "Steady state initialization (derivatives of states are zero)",
      InitialState "Initialization with initial states",
      InitialOutput
        "Initialization with initial outputs (and steady state of the states if possible)",
      DoNotUse_InitialIntegratorState
        "Don not use, only for backward compatibility (initialize only integrator state)")
    "Enumeration defining initialization of PID and LimPID blocks" annotation (
      Evaluate=true, Documentation(info="<html>
<p>
This initialization type is identical to Types.Init and has just one
additional option <b>DoNotUse_InitialIntegratorState</b>. This option
is introduced in order that the default initialization for the
Continuous.PID and Continuous.LimPID blocks are backward
compatible. In Modelica 2.2, the integrators have been initialized
with their given states where as the D-part has not been initialized.
The option \"DoNotUse_InitialIntegratorState\" leads to this
initialization definition.
</p>

</html>"));

  type SimpleController = enumeration(
      P "P controller",
      PI "PI controller",
      PD "PD controller",
      PID "PID controller")
    "Enumeration defining P, PI, PD, or PID simple controller type" annotation
    (Evaluate=true);

  type AnalogFilter = enumeration(
      CriticalDamping "Filter with critical damping",
      Bessel "Bessel filter",
      Butterworth "Butterworth filter",
      ChebyshevI "Chebyshev I filter")
    "Enumeration defining the method of filtering" annotation (Evaluate=true);

  type FilterType = enumeration(
      LowPass "Low pass filter",
      HighPass "High pass filter",
      BandPass "Band pass filter",
      BandStop "Band stop / notch filter")
    "Enumeration of analog filter types (low, high, band pass or band stop filter)"
    annotation (Evaluate=true);

  class ExternalCombiTimeTable
    "External object of 1-dim. table where first column is time"
    extends ExternalObject;

    function constructor "Initialize 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input String tableName "Table name";
      input String fileName "File name";
      input Real table[:, :];
      input Modelica.SIunits.Time startTime;
      input Integer columns[:];
      input Modelica.Blocks.Types.Smoothness smoothness;
      input Modelica.Blocks.Types.Extrapolation extrapolation;
      output ExternalCombiTimeTable externalCombiTimeTable;
    external"C" externalCombiTimeTable =
        ModelicaStandardTables_CombiTimeTable_init(
            tableName,
            fileName,
            table,
            size(table, 1),
            size(table, 2),
            startTime,
            columns,
            size(columns, 1),
            smoothness,
            extrapolation) annotation (Library={"ModelicaStandardTables"});
    end constructor;

    function destructor "Terminate 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input ExternalCombiTimeTable externalCombiTimeTable;
    external"C" ModelicaStandardTables_CombiTimeTable_close(
        externalCombiTimeTable) annotation (Library={"ModelicaStandardTables"});
    end destructor;

  end ExternalCombiTimeTable;

  class ExternalCombiTable1D
    "External object of 1-dim. table defined by matrix"
    extends ExternalObject;

    function constructor "Initialize 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input String tableName "Table name";
      input String fileName "File name";
      input Real table[:, :];
      input Integer columns[:];
      input Modelica.Blocks.Types.Smoothness smoothness;
      output ExternalCombiTable1D externalCombiTable1D;
    external"C" externalCombiTable1D = ModelicaStandardTables_CombiTable1D_init(
            tableName,
            fileName,
            table,
            size(table, 1),
            size(table, 2),
            columns,
            size(columns, 1),
            smoothness) annotation (Library={"ModelicaStandardTables"});
    end constructor;

    function destructor "Terminate 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input ExternalCombiTable1D externalCombiTable1D;
    external"C" ModelicaStandardTables_CombiTable1D_close(externalCombiTable1D)
        annotation (Library={"ModelicaStandardTables"});
    end destructor;

  end ExternalCombiTable1D;

  class ExternalCombiTable2D
    "External object of 2-dim. table defined by matrix"
    extends ExternalObject;

    function constructor "Initialize 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input String tableName "Table name";
      input String fileName "File name";
      input Real table[:, :];
      input Modelica.Blocks.Types.Smoothness smoothness;
      output ExternalCombiTable2D externalCombiTable2D;
    external"C" externalCombiTable2D = ModelicaStandardTables_CombiTable2D_init(
            tableName,
            fileName,
            table,
            size(table, 1),
            size(table, 2),
            smoothness) annotation (Library={"ModelicaStandardTables"});
    end constructor;

    function destructor "Terminate 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input ExternalCombiTable2D externalCombiTable2D;
    external"C" ModelicaStandardTables_CombiTable2D_close(externalCombiTable2D)
        annotation (Library={"ModelicaStandardTables"});
    end destructor;

  end ExternalCombiTable2D;
  annotation (Documentation(info="<HTML>
<p>
In this package <b>types</b>, <b>constants</b> and <b>external objects</b> are defined that are used
in library Modelica.Blocks. The types have additional annotation choices
definitions that define the menus to be built up in the graphical
user interface when the type is used as parameter in a declaration.
</p>
</HTML>"));
end Types;