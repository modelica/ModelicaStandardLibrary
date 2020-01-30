within Modelica.Electrical.Machines.Losses;
record StrayLoadParameters "Parameter record for stray load losses"
  extends Modelica.Icons.Record;
  parameter SI.Power PRef(min=0) = 0
    "Reference stray load losses at IRef and wRef";
  parameter SI.Current IRef(min=Modelica.Constants.small)
    "Reference RMS current that PRef refers to";
  parameter SI.AngularVelocity wRef(displayUnit="rev/min", min=
        Modelica.Constants.small)
    "Reference angular velocity that PRef refers to";
  parameter Real power_w(min=Modelica.Constants.small) = 1
    "Exponent of stray load loss torque w.r.t. angular velocity";
  final parameter SI.Torque tauRef=if (PRef <= 0) then 0
       else PRef/wRef
    "Reference stray load torque at reference angular velocity and reference current";
  annotation (defaultComponentPrefixes="parameter ", Documentation(info="<html>
<p>
Parameter record for <a href=\"modelica://Modelica.Electrical.Machines.Losses.InductionMachines.StrayLoad\">three-phase</a> and
<a href=\"modelica://Modelica.Electrical.Machines.Losses.DCMachines.StrayLoad\">DC</a> stray load losses.
</p>
</html>"));
end StrayLoadParameters;
