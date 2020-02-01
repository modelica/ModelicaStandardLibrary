within Modelica.Mechanics.Rotational.Sources;
model Move
  "Forced movement of a flange according to an angle, speed and angular acceleration signal"
  extends
    Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;

  SI.Angle phi
    "Rotation angle of flange with respect to support";
  Modelica.Blocks.Interfaces.RealInput u[3]
    "Angle, angular velocity and angular acceleration of flange with respect to support as input signals"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
protected
  function position
    extends Modelica.Icons.Function;
    input Real q_qd_qdd[3]
      "Required values for position, speed, acceleration";
    input Real dummy
      "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
    output Real q;
  algorithm
    q := q_qd_qdd[1];
    annotation (derivative(noDerivative=q_qd_qdd) = position_der, InlineAfterIndexReduction=true);
  end position;

  function position_der
    extends Modelica.Icons.Function;
    input Real q_qd_qdd[3]
      "Required values for position, speed, acceleration";
    input Real dummy
      "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
    input Real dummy_der;
    output Real qd;
  algorithm
    qd := q_qd_qdd[2];
    annotation (derivative(
        noDerivative=q_qd_qdd,
        order=2) = position_der2, InlineAfterIndexReduction=true);
  end position_der;

  function position_der2
    extends Modelica.Icons.Function;
    input Real q_qd_qdd[3]
      "Required values for position, speed, acceleration";
    input Real dummy
      "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
    input Real dummy_der;
    input Real dummy_der2;
    output Real qdd;
  algorithm
    qdd := q_qd_qdd[3];
  end position_der2;
equation
  phi = flange.phi - phi_support;
  phi = position(u, time);
  annotation (
    Documentation(info="<html>
<p>
Flange <strong>flange</strong> is <strong>forced</strong> to move relative to flange support with a predefined motion
according to the input signals:
</p>
<blockquote><pre>
u[1]: angle of flange
u[2]: angular velocity of flange
u[3]: angular acceleration of flange
</pre></blockquote>
<p>
The user has to guarantee that the input signals are consistent to each other,
i.e., that u[2] is the derivative of u[1] and that
u[3] is the derivative of u[2]. There are, however,
also applications where by purpose these conditions do not hold. For example,
if only the position dependent terms of a mechanical system shall be
calculated, one may provide angle = angle(t) and set the angular velocity
and the angular acceleration to zero.
</p>
<p>
The input signals can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Sources.
</p>
</html>"),
       Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
    Rectangle(lineColor={64,64,64},
      fillColor={192,192,192},
      fillPattern=FillPattern.HorizontalCylinder,
      extent={{-100.0,-20.0},{100.0,20.0}}),
    Line(points={{-30.0,-32.0},{30.0,-32.0}}),
    Line(points={{0.0,52.0},{0.0,32.0}}),
    Line(points={{-29.0,32.0},{30.0,32.0}}),
    Line(points={{0.0,-32.0},{0.0,-100.0}}),
    Text(textColor={0,0,255},
      extent={{-150.0,60.0},{150.0,100.0}},
      textString="%name"),
    Text(extent={{-140,-60},{-40,-30}},
          textColor={128,128,128},
          horizontalAlignment=TextAlignment.Right,
          textString="phi,w,a")}));
end Move;
