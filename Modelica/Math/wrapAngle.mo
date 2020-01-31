within Modelica.Math;
function wrapAngle "Wrap angle to interval ]-pi,pi] or [0,2*pi["
  extends Modelica.Math.Icons.AxisCenter;
  import Modelica.Constants.pi;
  input Modelica.Units.SI.Angle u "Input angle";
  input Boolean positiveRange=false "Use only positive output range, if true";
  output Modelica.Units.SI.Angle y "Wrapped output angle";

algorithm
  y :=mod(u, 2*pi);
  if y>pi and not positiveRange then
    y := y - 2*pi;
  end if;

  annotation (Icon(graphics={
        Line(points={{-90,0},{68,0}}, color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,54},{-80,54},{-60,80},{-60,-80},{60,80},{60,-80},{80,-52}})}),
    Documentation(info="<html>
<p>
This function wraps the input angle <code>u</code> to the interval ]-pi,pi], if <code>positiveRange == false</code>.
Otherwise the input angle <code>u</code> is wrapped to the interval [0,2*pi[.
</p>
</html>"));
end wrapAngle;
