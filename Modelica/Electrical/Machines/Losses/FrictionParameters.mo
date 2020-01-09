within Modelica.Electrical.Machines.Losses;
record FrictionParameters "Parameter record for friction losses"
  extends Modelica.Icons.Record;
  parameter Modelica.SIunits.Power PRef(min=0) = 0
    "Reference friction losses at wRef";
  parameter Modelica.SIunits.AngularVelocity wRef(displayUnit="rev/min", min=
        Modelica.Constants.small)
    "Reference angular velocity that the PRef refer to";
  parameter Real power_w(min=Modelica.Constants.small) = 2
    "Exponent of friction torque w.r.t. angular velocity";
  final parameter Modelica.SIunits.Torque tauRef=if (PRef <= 0) then 0
       else PRef/wRef
    "Reference friction torque at reference angular velocity";
  final parameter Real linear=0.001
    "Linear angular velocity range with respect to reference angular velocity";
  final parameter Modelica.SIunits.AngularVelocity wLinear=linear*wRef
    "Linear angular velocity range";
  final parameter Modelica.SIunits.Torque tauLinear=if (PRef <= 0) then 0
       else tauRef*(wLinear/wRef)^power_w
    "Torque corresponding with linear angular velocity range";
  annotation (defaultComponentPrefixes="parameter ", Documentation(info="<html>
<p>
Parameter record for <a href=\"modelica://Modelica.Electrical.Machines.Losses.Friction\">Friction</a> losses.
</p>
</html>"));
end FrictionParameters;
