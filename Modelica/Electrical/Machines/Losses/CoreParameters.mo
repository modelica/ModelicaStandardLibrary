within Modelica.Electrical.Machines.Losses;
record CoreParameters "Parameter record for core losses"
  extends Modelica.Icons.Record;
  parameter Integer m
    "Number of phases (1 for DC, 3 for induction machines)";
  parameter SI.Power PRef(min=0) = 0
    "Reference core losses at reference inner voltage VRef";
  parameter SI.Voltage VRef(min=Modelica.Constants.small)
    "Reference inner RMS voltage that reference core losses PRef refer to";
  parameter SI.AngularVelocity wRef(min=Modelica.Constants.small)
    "Reference angular velocity that reference core losses PRef refer to";
  // In the current implementation ratioHysterisis = 0 since hysteresis losses are not implemented yet
  final parameter Real ratioHysteresis(
    min=0,
    max=1,
    start=0.775) = 0
    "Ratio of hysteresis losses with respect to the total core losses at VRef and fRef";
  final parameter SI.Conductance GcRef=if (PRef <= 0) then 0
       else PRef/VRef^2/m
    "Reference conductance at reference frequency and voltage";
  final parameter SI.AngularVelocity wMin=1e-6*wRef "Angular velocity limit";
  annotation (defaultComponentPrefixes="parameter ", Documentation(info="<html>
<p>
Parameter record for <a href=\"modelica://Modelica.Electrical.Machines.Losses.InductionMachines.Core\">core losses of induction machines</a>
and <a href=\"modelica://Modelica.Electrical.Machines.Losses.DCMachines.Core\">core losses of DC machines</a>.
</p>
</html>"));
end CoreParameters;
