within Modelica.Mechanics.Translational.Sources;
model Move
  "Forced movement of a flange according to a position, velocity and acceleration signal"
  extends
    Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2;
  Modelica.Blocks.Interfaces.RealInput u[3]
    "Position, velocity and acceleration of flange as input signals"
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
  s = position(u, time);

  annotation (
    Documentation(info="<html>
<p>
Flange <strong>flange</strong> is <strong>forced</strong> to move relative to the support connector with a predefined motion
according to the input signals:
</p>
<blockquote><pre>
u[1]: position of flange
u[2]: velocity of flange
u[3]: acceleration of flange
</pre></blockquote>
<p>
The user has to guarantee that the input signals are consistent to each other,
i.e., that u[2] is the derivative of u[1] and that
u[3] is the derivative of u[2]. There are, however,
also applications where by purpose these conditions do not hold. For example,
if only the position dependent terms of a mechanical system shall be
calculated, one may provide position = position(t) and set the velocity
and the acceleration to zero.
</p>
<p>
The input signals can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Sources.
</p>

</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
        Line(points={{-30,-32},{30,-32}}, color={0,127,0}),
        Line(points={{0,-32},{0,-100}}, color={0,127,0}),
        Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor={0,127,0},
          fillColor={160,215,160},
          fillPattern=FillPattern.Solid),
        Line(points={{0,52},{0,32}}, color={0,127,0}),
        Line(points={{-29,32},{30,32}}, color={0,127,0}),
      Text(
        extent={{150,60},{-150,100}},
        textString="%name",
        textColor={0,0,255}),
      Text(extent={{-140,-60},{-40,-30}},
        textColor={128,128,128},
        horizontalAlignment=TextAlignment.Right,
        textString="s,v,a")}));
end Move;
