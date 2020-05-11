within Modelica.Electrical.QuasiStatic.SinglePhase.Ideal;
model IdealIntermediateSwitch "Ideal intermediate switch"
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.conj;
  parameter SI.Resistance Ron(final min=0) = 1e-5 "Closed switch resistance";
  parameter SI.Conductance Goff(final min=0) = 1e-5 "Opened switch conductance";
  extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
       293.15);
  QuasiStatic.SinglePhase.Interfaces.PositivePin p1 annotation (Placement(
        transformation(extent={{-110,30},{-90,50}}), iconTransformation(extent=
            {{-110,30},{-90,50}})));
  QuasiStatic.SinglePhase.Interfaces.PositivePin p2
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  QuasiStatic.SinglePhase.Interfaces.NegativePin n1 annotation (Placement(
        transformation(extent={{90,30},{110,50}}), iconTransformation(extent={{
            90,30},{110,50}})));
  QuasiStatic.SinglePhase.Interfaces.NegativePin n2
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.BooleanInput control "true => p1--n2, p2--n1 connected, otherwise p1--n1, p2--n2  connected"
    annotation (Placement(transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270)));
protected
  Complex s1(re(final unit="1"), im(final unit="1"));
  Complex s2(re(final unit="1"), im(final unit="1"));
  Complex s3(re(final unit="1"), im(final unit="1"));
  Complex s4(re(final unit="1"), im(final unit="1")) "Auxiliary variables";
  constant SI.ComplexVoltage unitVoltage=Complex(1, 0)
    annotation (HideResult=true);
  constant SI.ComplexCurrent unitCurrent=Complex(1, 0)
    annotation (HideResult=true);
equation
  Connections.branch(p1.reference, n1.reference);
  p1.reference.gamma = n1.reference.gamma;
  Connections.branch(p2.reference, n2.reference);
  p2.reference.gamma = n2.reference.gamma;
  Connections.branch(n1.reference, n2.reference);
  n1.reference.gamma = n2.reference.gamma;

  p1.v - n1.v = (s1*unitCurrent)*(if (control) then 1 else Ron);
  p2.v - n2.v = (s2*unitCurrent)*(if (control) then 1 else Ron);
  p1.v - n2.v = (s3*unitCurrent)*(if (control) then Ron else 1);
  p2.v - n1.v = (s4*unitCurrent)*(if (control) then Ron else 1);

  p1.i = if control then s1*unitVoltage*Goff + s3*unitCurrent else s1*
    unitCurrent + s3*unitVoltage*Goff;
  p2.i = if control then s2*unitVoltage*Goff + s4*unitCurrent else s2*
    unitCurrent + s4*unitVoltage*Goff;
  n1.i = if control then -s1*unitVoltage*Goff - s4*unitCurrent else -s1*
    unitCurrent - s4*unitVoltage*Goff;
  n2.i = if control then -s2*unitVoltage*Goff - s3*unitCurrent else -s2*
    unitCurrent - s3*unitVoltage*Goff;

  LossPower = real(p1.v*conj(p1.i)) + real(p2.v*conj(p2.i)) + real(n1.v*
    conj(n1.i)) + real(n2.v*conj(n2.i));
  annotation (defaultComponentName="switch",
    Documentation(info="<html>
<p>
The intermediate switch has four switching contact pins p1, p2, n1, and n2.
The switching behaviour is controlled by the input signal control. If control
is true, the pin p1 is connected to pin n2, and the pin p2 is
connected to the pin n2. Otherwise, the pin p1 is connected to n1, and
p2 is connected to n2.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Ideal/IdealIntermediateSwitch1.png\" alt=\"IdealIntermediateSwitch1\">
</div>

<p>
In order to prevent singularities during switching, the opened
switch has a (very low) conductance Goff
and the closed switch has a (very low) resistance Ron.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStatic/SinglePhase/Ideal/IdealIntermediateSwitch2.png\" alt=\"IdealIntermediateSwitch2\">
</div>

<p>
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
        Ellipse(extent={{-4,24},{4,16}}, lineColor={85,170,255}),
        Line(points={{-90,0},{-40,0}}, color={85,170,255}),
        Line(points={{-90,40},{-40,40}}, color={85,170,255}),
        Line(points={{-40,0},{40,40}}, color={85,170,255}),
        Line(points={{-40,40},{40,2}}, color={85,170,255}),
        Line(points={{40,40},{90,40}}, color={85,170,255}),
        Line(points={{40,0},{90,0}}, color={85,170,255}),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255})}));
end IdealIntermediateSwitch;
