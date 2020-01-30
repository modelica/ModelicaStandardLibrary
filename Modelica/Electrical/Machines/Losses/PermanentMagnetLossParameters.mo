within Modelica.Electrical.Machines.Losses;
record PermanentMagnetLossParameters
  "Parameter record for permanent magnet losses"
  extends Modelica.Icons.Record;
  parameter SI.Power PRef(min=0) = 0
    "Reference permanent magnet losses at IRef and wRef";
  parameter Real c(
    min=0,
    max=1) = 0
    "Part of permanent magnet losses at current = 0, i.e. independent of current";
  parameter SI.Current IRef(min=Modelica.Constants.small)
    "Reference stator RMS current that PRef refers to";
  parameter Real power_I(min=Modelica.Constants.small) = 2
    "Exponent of permanent magnet loss torque w.r.t. stator current";
  parameter SI.AngularVelocity wRef(displayUnit="rev/min", min=
        Modelica.Constants.small)
    "Reference angular velocity that PRef refers to";
  parameter Real power_w(min=Modelica.Constants.small) = 1
    "Exponent of permanent magnet loss torque w.r.t. angular velocity";
  final parameter SI.Torque tauRef=if (PRef <= 0) then 0
       else PRef/wRef
    "Reference permanent magnet loss torque at reference angular velocity and reference current";
  annotation (defaultComponentPrefixes="parameter ", Documentation(info="<html>
<p>
Parameter record for <a href=\"modelica://Modelica.Electrical.Machines.Losses.InductionMachines.PermanentMagnetLosses\">permanent magnet losses</a>.
</p>
</html>"));
end PermanentMagnetLossParameters;
