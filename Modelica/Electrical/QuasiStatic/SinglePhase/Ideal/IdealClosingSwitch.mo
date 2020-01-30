within Modelica.Electrical.QuasiStatic.SinglePhase.Ideal;
model IdealClosingSwitch "Ideal electrical closer"
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.conj;
  extends QuasiStatic.SinglePhase.Interfaces.OnePort;
  parameter SI.Resistance Ron(final min=0) = 1e-5 "Closed switch resistance";
  parameter SI.Conductance Goff(final min=0) = 1e-5 "Opened switch conductance";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=293.15);
  Modelica.Blocks.Interfaces.BooleanInput control "true => p--n connected, false => switch open"
                                                   annotation (Placement(
        transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
protected
  Complex s(re(final unit="1"), im(final unit="1")) "Auxiliary variable";
  constant SI.ComplexVoltage unitVoltage=Complex(1, 0)
    annotation (HideResult=true);
  constant SI.ComplexCurrent unitCurrent=Complex(1, 0)
    annotation (HideResult=true);
equation
  v = (s*unitCurrent)*(if control then Ron else 1);
  i = (s*unitVoltage)*(if control then 1 else Goff);

  LossPower = real(v*conj(i));
  annotation (defaultComponentName="switch",
    Documentation(info="<html>
<p>
The ideal closing switch has a positive pin p and a negative pin n.
The switching behaviour is controlled by input signal control.
If control is true, pin p is connected
with negative pin n. Otherwise, pin p is not connected
with negative pin n.
</p>
<p>
In order to prevent singularities during switching, the opened
switch has a (very low) conductance Goff
and the closed switch has a (very low) resistance Ron.
The limiting case is also allowed, i.e., the resistance Ron of the
closed switch could be exactly zero and the conductance Goff of the
open switch could be also exactly zero. Note, there are circuits,
where a description with zero Ron or zero Goff is not possible.
<br><br>
<strong>Please note:</strong>
In case of useHeatPort=true the temperature dependence of the electrical
behavior is <strong>not</strong> modelled. The parameters are not temperature dependent.
</p>
<p>
<strong>Use with care:</strong>
This switch is only intended to be used for structural changes, not for fast switching sequences, due to the quasi-static formulation.
</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Ellipse(extent={{-44,4},{-36,-4}}, lineColor={85,170,255}),
        Line(points={{-90,0},{-44,0}}, color={85,170,255}),
        Line(points={{-37,2},{40,40}}, color={85,170,255}),
        Line(points={{40,0},{90,0}}, color={85,170,255}),
        Line(
          visible=useHeatPort,
          points={{0,-100},{0,25}},
          color={127,0,0},
          pattern=LinePattern.Dot),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255})}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Text(
          extent={{-100,-40},{100,-79}},
          textString="%name",
          textColor={0,0,255})}));
end IdealClosingSwitch;
