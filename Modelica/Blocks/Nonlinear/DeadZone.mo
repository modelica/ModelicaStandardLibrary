within Modelica.Blocks.Nonlinear;
block DeadZone "Provide a region of zero output"
  parameter Real uMax(start=1) "Upper limits of dead zones";
  parameter Real uMin=-uMax "Lower limits of dead zones";
  extends Interfaces.SISO;

equation
  assert(uMax >= uMin, "DeadZone: Limits must be consistent. However, uMax (=" + String(uMax) +
                       ") < uMin (=" + String(uMin) + ")");

  y = homotopy(actual=smooth(0,if u > uMax then u - uMax else if u < uMin then u - uMin else 0), simplified=u);

  annotation (
    Documentation(info="<html>
<p>
The DeadZone block defines a region of zero output.
</p>
<p>
If the input is within uMin ... uMax, the output
is zero. Outside of this zone, the output is a linear
function of the input with a slope of 1.
</p>
</html>"),
     Icon(coordinateSystem(
    preserveAspectRatio=true,
    extent={{-100,-100},{100,100}}), graphics={
    Line(points={{0,-90},{0,68}}, color={192,192,192}),
    Polygon(
      points={{0,90},{-8,68},{8,68},{0,90}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{-90,0},{68,0}}, color={192,192,192}),
    Polygon(
      points={{90,0},{68,-8},{68,8},{90,0}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{-80,-60},{-20,0},{20,0},{80,60}}),
    Text(
      extent={{-150,-150},{150,-110}},
      textColor={160,160,164},
      textString="uMax=%uMax")}));
end DeadZone;
