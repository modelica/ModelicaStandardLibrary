within Modelica.Blocks.Logical;
block Less "Output y is true, if input u1 is less than input u2"
  extends Blocks.Interfaces.partialBooleanComparison;

equation
  y = u1 < u2;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false,extent={{-100,
            -100},{100,100}}), graphics={
        Ellipse(extent={{32,10},{52,-10}}, lineColor={0,0,127}),
        Line(points={{-100,-80},{42,-80},{42,0}}, color={0,0,127}),
        Line(points={{-8,20},{-54,0},{-8,-20}}, thickness=0.5)}), Documentation(info="<html>
<p>
The output is <strong>true</strong> if Real input u1 is less than
Real input u2, otherwise the output is <strong>false</strong>.
</p>
</html>"));
end Less;
