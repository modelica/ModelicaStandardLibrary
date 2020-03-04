within Modelica.Blocks.Math;
block LinearDependency "Output a linear combination of the two inputs"
  extends Modelica.Blocks.Interfaces.SI2SO;
  parameter Real y0=0 "Initial value";
  parameter Real k1=0 "Gain of u1";
  parameter Real k2=0 "Gain of u2";
equation
  y = y0 + k1*u1 + k2*u2;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Line(
          points={{-100,60},{100,0},{-100,-60}},
          color={0,0,127}),
        Text(
          extent={{-14,88},{94,32}},
          textString="%k1"),
        Text(
          extent={{-40,-48},{96,-96}},
          textString="%k2"),
        Text(
          extent={{-94,26},{8,-30}},
          textString="%y0")}), Documentation(info="<html>
<p>Determine the linear combination of the two inputs: <code>y = y0 + k1*u1 + k2*u2</code></p>
</html>"));
end LinearDependency;
