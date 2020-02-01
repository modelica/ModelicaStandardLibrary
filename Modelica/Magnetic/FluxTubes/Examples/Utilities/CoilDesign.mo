within Modelica.Magnetic.FluxTubes.Examples.Utilities;
record CoilDesign
  "Calculation of winding parameters (wire diameter, number of turns et al.) and recalculation with optionally chosen parameters; to be adapted to particular design tasks"
  extends Modelica.Icons.Record;

  parameter SI.Resistivity rho_20=0.0178e-6
    "Resistivity of conductor material at 20 degC (default: Copper)";
  parameter SI.LinearTemperatureCoefficient alpha_20=0.0039
    "Temperature coefficient of conductor material's resistivity at 20 degC (default: Copper)";
  parameter SI.Temperature T_op=293.15 "Operating temperature of winding";

  final parameter SI.Resistivity rho=rho_20*(1 + alpha_20*(T_op - (20 -
      Modelica.Constants.T_zero))) "Resistivity at operating temperature";

  parameter SI.Length h_w "Height of winding cross-section";
  parameter SI.Length b_w "Width of winding cross-section";

  final parameter SI.Area A_w=h_w*b_w "Cross-section area of winding";

  parameter SI.Length l_avg "Average length of one turn";

  parameter SI.Voltage V_op
    "Operating voltage (nominal/ minimum/ maximum voltage depending on design objective)";

  parameter SI.CurrentDensity J_desired=4e6
    "DESIRED current density at operating temperature and voltage resp.";

  parameter Real c_condFillChosen=0.6
    "CHOSEN conductor filling factor = total conductor area without insulation/ total winding area";

  final parameter Real N_calculated=V_op/(rho*l_avg*J_desired)
    "CALCULATED number of turns";

  final parameter SI.Diameter d_wireCalculated=sqrt(4*A_w*
      c_condFillChosen/(pi*N_calculated))
    "CALCULATED wire diameter (without insulation)";

  final parameter SI.Area A_wireCalculated=pi*d_wireCalculated^2/4
    "Calculated wire cross-section area";

  final parameter SI.Resistance R_calculated=rho*N_calculated*l_avg/
      A_wireCalculated
    "Winding resistance at operating temperature and voltage resp. with CALCULATED number of turns and wire diameter";

  final parameter SI.Power P_calculated=V_op^2/R_calculated
    "Winding's ohmic losses at operating temperature and voltage resp. with CALCULATED number of turns and wire diameter";

  parameter SI.Diameter d_wireChosen=d_wireCalculated
    "CHOSEN available wire diameter (without insulation)"
    annotation (Dialog(group="Chosen feasible parameters (optional)"));

  parameter Real N_chosen=N_calculated "CHOSEN number of turns"
    annotation (Dialog(group="Chosen feasible parameters (optional)"));

  final parameter SI.Area A_wireChosen=pi*d_wireChosen^2/4
    "Wire cross-section area resulting from CHOSEN wire diameter";

  final parameter SI.Resistance R_actual=rho*N_chosen*l_avg/A_wireChosen
    "Winding resistance at operating temperature and voltage resp. resulting from CHOSEN number of turns and wire diameter";

  final parameter SI.Power P_actual=V_op^2/R_actual
    "Winding's ohmic losses at operating temperature and voltage resp. resulting from CHOSEN number of turns and wire diameter";

  final parameter SI.CurrentDensity J_actual=V_op*4/(R_actual*pi*
      d_wireChosen^2)
    "Current density at operating temperature and voltage resp. resulting from CHOSEN number of turns and wire diameter";

  final parameter Real c_condFillActual=N_chosen*pi*d_wireChosen^2/(4*A_w)
    "Conductor filling factor resulting from CHOSEN number of turns and wire diameter";

  annotation (Documentation(info="<html>
<p>
This model example shows dimensioning of a winding (wire diameter, number of turns) based on desired operating conditions (voltage, temperature, current density, conductor filling factor) for a given cross-section area of the winding. It can be modified according to the parameters given and sought after for a particular design project.
</p>

<p>
The calculated winding resistance and number of turns can be used as input parameters to the electrical subsystem
of a device to be modelled. Operating voltage V_op can be minimum, nominal and maximum voltage respectively as specified for a particular design project. In conjunction with the setting of the operating temperature T_op, this enables for analysis of the device under worst-case conditions (e.g., minimum required magnetomotive force, maximum allowed ohmic losses, minimum and maximum force respectively).
</p>

<p>
For manufacturing of a winding, the obtained wire diameter d_wireCalculated must be rounded to that of an available wire. In order to analyse the influence of this rounding, one can enter the chosen wire diameter d_wireChosen and number of turns N_chosen as optional input. Calculation of the resulting winding parameters enables for comparison with the ones obtained otherwise.
</p>
</html>"));

end CoilDesign;
