within Modelica.Blocks;
package Types
  "Library of constants, external objects and types with choices, especially to build menus"
  extends Modelica.Icons.TypesPackage;

  type Smoothness = enumeration(
      LinearSegments "Linear interpolation of table points",
      ContinuousDerivative
        "Akima spline interpolation of table points (such that the first derivative is continuous)",
      ConstantSegments
        "Piecewise constant interpolation of table points (the value from the previous abscissa point is returned)",
      MonotoneContinuousDerivative1
        "Fritsch-Butland spline interpolation (such that the monotonicity is preserved and the first derivative is continuous)",
      MonotoneContinuousDerivative2
        "Steffen spline interpolation of table points (such that the monotonicity is preserved and the first derivative is continuous)",
      ModifiedContinuousDerivative
        "Modified Akima spline interpolation of table points (such that the first derivative is continuous and shortcomings of the original Akima method are avoided)")
    "Enumeration defining the smoothness of table interpolation";

    type Extrapolation = enumeration(
      HoldLastPoint
        "Hold the first/last table point outside of the table scope",
      LastTwoPoints
        "Extrapolate by using the derivative at the first/last table points outside of the table scope",
      Periodic "Repeat the table scope periodically",
      NoExtrapolation "Extrapolation triggers an error")
    "Enumeration defining the extrapolation of table interpolation";

    type TimeEvents = enumeration(
      Always "Always generate time events at interval boundaries",
      AtDiscontinuities "Generate time events at discontinuities (defined by duplicated sample points)",
      NoTimeEvents "No time events at interval boundaries")
    "Enumeration defining the time event handling of time table interpolation";

    type Init = enumeration(
      NoInit
        "No initialization (start values are used as guess values with fixed=false)",
      SteadyState
        "Steady state initialization (derivatives of states are zero)",
      InitialState "Initialization with initial states",
      InitialOutput
        "Initialization with initial outputs (and steady state of the states if possible)")
    "Enumeration defining initialization of a block" annotation (Evaluate=true,
    Documentation(info="<html>
  <p>The following initialization alternatives are available:</p>
  <dl>
    <dt><code><strong>NoInit</strong></code></dt>
      <dd>No initialization (start values are used as guess values with <code>fixed=false</code>)</dd>
    <dt><code><strong>SteadyState</strong></code></dt>
      <dd>Steady state initialization (derivatives of states are zero)</dd>
    <dt><code><strong>InitialState</strong></code></dt>
      <dd>Initialization with initial states</dd>
    <dt><code><strong>InitialOutput</strong></code></dt>
      <dd>Initialization with initial outputs (and steady state of the states if possible)</dd>
  </dl>
</html>"));

   type SimpleController = enumeration(
      P "P controller",
      PI "PI controller",
      PD "PD controller",
      PID "PID controller")
    "Enumeration defining P, PI, PD, or PID simple controller type" annotation (
     Evaluate=true);

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

  type Regularization = enumeration(
      Exp "Exponential regularization (smooth)",
      Sine "Sinusoidal regularization (smooth 1st derivative)",
      Linear "Linear regularization",
      Cosine "Cosine regularization")
    "Enumeration defining the regularization around zero";

  type LimiterHomotopy = enumeration(
      NoHomotopy "Homotopy is not used",
      Linear "Simplified model without limits",
      UpperLimit "Simplified model fixed at upper limit",
      LowerLimit "Simplified model fixed at lower limit")
    "Enumeration defining use of homotopy in limiter components" annotation (Evaluate=true);

  type VariableLimiterHomotopy = enumeration(
      NoHomotopy "Simplified model = actual model",
      Linear "Simplified model: y = u",
      Fixed "Simplified model: y = ySimplified")
    "Enumeration defining use of homotopy in variable limiter components" annotation (Evaluate=true);

  class ExternalCombiTimeTable
    "External object of 1-dim. table where first column is time"
    extends ExternalObject;

    function constructor "Initialize 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input String tableName "Table name";
      input String fileName "File name";
      input Real table[:, :];
      input SI.Time startTime;
      input Integer columns[:];
      input Modelica.Blocks.Types.Smoothness smoothness;
      input Modelica.Blocks.Types.Extrapolation extrapolation;
      input SI.Time shiftTime=0.0;
      input Modelica.Blocks.Types.TimeEvents timeEvents=Modelica.Blocks.Types.TimeEvents.Always;
      input Boolean verboseRead=true "= true: Print info message; = false: No info message";
      input String delimiter="," "Column delimiter character for CSV file";
      input Integer nHeaderLines=0 "Number of header lines to ignore for CSV file";
      output ExternalCombiTimeTable externalCombiTimeTable;
    external "C" externalCombiTimeTable = ModelicaStandardTables_CombiTimeTable_init3(
            fileName,
            tableName,
            table,
            size(table, 1),
            size(table, 2),
            startTime,
            columns,
            size(columns, 1),
            smoothness,
            extrapolation,
            shiftTime,
            timeEvents,
            verboseRead,
            delimiter,
            nHeaderLines) annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end constructor;

    function destructor "Terminate 1-dim. table where first column is time"
      extends Modelica.Icons.Function;
      input ExternalCombiTimeTable externalCombiTimeTable;
    external "C" ModelicaStandardTables_CombiTimeTable_close(
        externalCombiTimeTable) annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
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
      input Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints;
      input Boolean verboseRead=true "= true: Print info message; = false: No info message";
      input String delimiter="," "Column delimiter character for CSV file";
      input Integer nHeaderLines=0 "Number of header lines to ignore for CSV file";
      output ExternalCombiTable1D externalCombiTable1D;
    external "C" externalCombiTable1D = ModelicaStandardTables_CombiTable1D_init3(
            fileName,
            tableName,
            table,
            size(table, 1),
            size(table, 2),
            columns,
            size(columns, 1),
            smoothness,
            extrapolation,
            verboseRead,
            delimiter,
            nHeaderLines) annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end constructor;

    function destructor "Terminate 1-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input ExternalCombiTable1D externalCombiTable1D;
    external "C" ModelicaStandardTables_CombiTable1D_close(externalCombiTable1D)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
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
      input Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints;
      input Boolean verboseRead=true "= true: Print info message; = false: No info message";
      input String delimiter="," "Column delimiter character for CSV file";
      input Integer nHeaderLines=0 "Number of header lines to ignore for CSV file";
      output ExternalCombiTable2D externalCombiTable2D;
    external "C" externalCombiTable2D = ModelicaStandardTables_CombiTable2D_init3(
            fileName,
            tableName,
            table,
            size(table, 1),
            size(table, 2),
            smoothness,
            extrapolation,
            verboseRead,
            delimiter,
            nHeaderLines) annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end constructor;

    function destructor "Terminate 2-dim. table defined by matrix"
      extends Modelica.Icons.Function;
      input ExternalCombiTable2D externalCombiTable2D;
    external "C" ModelicaStandardTables_CombiTable2D_close(externalCombiTable2D)
        annotation (IncludeDirectory="modelica://Modelica/Resources/C-Sources", Include="#include \"ModelicaStandardTables.h\"", Library={"ModelicaStandardTables", "ModelicaIO", "ModelicaMatIO", "zlib"});
    end destructor;

  end ExternalCombiTable2D;
  annotation (Documentation(info="<html>
<p>
In this package <strong>types</strong>, <strong>constants</strong> and <strong>external objects</strong> are defined that are used
in library Modelica.Blocks. The types have additional annotation choices
definitions that define the menus to be built up in the graphical
user interface when the type is used as parameter in a declaration.
</p>
</html>"));
end Types;
