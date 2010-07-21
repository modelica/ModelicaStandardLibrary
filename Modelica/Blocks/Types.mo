within Modelica.Blocks;
package Types
  "Library of constants and types with choices, especially to build menus"
  extends Modelica.Icons.Package;
  type Smoothness = enumeration(
      LinearSegments "Table points are linearly interpolated",
      ContinuousDerivative
        "Table points are interpolated such that the first derivative is continuous")
    "Enumeration defining the smoothness of table interpolation";

  type Extrapolation = enumeration(
      HoldLastPoint "Hold the last table point outside of the table scope",
      LastTwoPoints
        "Extrapolate linearly through the last two table points outside of the table scope",

      Periodic "Repeat the table scope periodically")
    "Enumeration defining the extrapolation of time table interpolation";

  type Init = enumeration(
      NoInit
        "No initialization (start values are used as guess values with fixed=false)",

      SteadyState
        "Steady state initialization (derivatives of states are zero)",
      InitialState "Initialization with initial states",
      InitialOutput
        "Initialization with initial outputs (and steady state of the states if possibles)")
    "Enumeration defining initialization of a block"
      annotation (Evaluate=true);

  type InitPID = enumeration(
      NoInit
        "No initialization (start values are used as guess values with fixed=false)",

      SteadyState
        "Steady state initialization (derivatives of states are zero)",
      InitialState "Initialization with initial states",
      InitialOutput
        "Initialization with initial outputs (and steady state of the states if possibles)",

      DoNotUse_InitialIntegratorState
        "Don't use, only for backward compatibility (initialize only integrator state)")
    "Enumeration defining initialization of PID and LimPID blocks"
    annotation (Documentation(info="<html>
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

</html>"),   Evaluate=true);

  type SimpleController = enumeration(
      P "P controller",
      PI "PI controller",
      PD "PD controller",
      PID "PID controller")
    "Enumeration defining P, PI, PD, or PID simple controller type"
      annotation (Evaluate=true);

type AnalogFilter = enumeration(
      CriticalDamping "Filter with critical damping",
      Bessel "Bessel filter",
      Butterworth "Butterworth filter",
      ChebyshevI "Chebyshev I filter")
    "Enumeration defining the method of filtering"
      annotation (Evaluate=true);
type FilterType = enumeration(
      LowPass "Low pass filter",
      HighPass "High pass filter",
      BandPass "Band pass filter",
      BandStop "Band stop / notch filter")
    "Enumeration of analog filter types (low, high, band pass or band stop filter"
    annotation (Evaluate=true);
  annotation ( Documentation(info="<HTML>
<p>
In this package <b>types</b> and <b>constants</b> are defined that are used
in library Modelica.Blocks. The types have additional annotation choices
definitions that define the menus to be built up in the graphical
user interface when the type is used as parameter in a declaration.
</p>
</HTML>"));
end Types;
