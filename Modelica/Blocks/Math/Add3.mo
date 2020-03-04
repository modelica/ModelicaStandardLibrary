within Modelica.Blocks.Math;
block Add3 "Output the sum of the three inputs"
  extends Modelica.Blocks.Icons.Block;

  parameter Real k1=+1 "Gain of input signal 1";
  parameter Real k2=+1 "Gain of input signal 2";
  parameter Real k3=+1 "Gain of input signal 3";
  Interfaces.RealInput u1 "Connector of Real input signal 1" annotation (
      Placement(transformation(extent={{-140,60},{-100,100}})));
  Interfaces.RealInput u2 "Connector of Real input signal 2" annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}})));
  Interfaces.RealInput u3 "Connector of Real input signal 3" annotation (
      Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Interfaces.RealOutput y "Connector of Real output signal" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));

equation
  y = k1*u1 + k2*u2 + k3*u3;
  annotation (
    Documentation(info="<html>
<p>
This blocks computes output <strong>y</strong> as <em>sum</em> of the
three input signals <strong>u1</strong>, <strong>u2</strong> and <strong>u3</strong>:
</p>
<blockquote><pre>
<strong>y</strong> = k1*<strong>u1</strong> + k2*<strong>u2</strong> + k3*<strong>u3</strong>;
</pre></blockquote>
<p>
Example:
</p>
<blockquote><pre>
   parameter:   k1= +2, k2= -3, k3=1;

results in the following equations:

   y = 2 * u1 - 3 * u2 + u3;
</pre></blockquote>

</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Text(
          extent={{-100,50},{5,90}},
          textString="%k1"),
        Text(
          extent={{-100,-20},{5,20}},
          textString="%k2"),
        Text(
          extent={{-100,-50},{5,-90}},
          textString="%k3"),
        Text(
          extent={{10,40},{90,-40}},
          textString="+")}));
end Add3;
