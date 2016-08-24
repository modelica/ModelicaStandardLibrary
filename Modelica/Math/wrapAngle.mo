within Modelica.Math;
function wrapAngle "Wrap angle to interval ]-pi,pi]"
  extends Modelica.Math.Icons.AxisCenter;
  import Modelica.Constants.pi;
  input SI.Angle u;
  output SI.Angle y;

algorithm
  y :=mod(u, 2*pi);
  if y>pi then
    y := y - 2*pi;
  end if;

  annotation (Icon(graphics={
        Line(points={{-90,0},{68,0}},     color={192,192,192}),
        Polygon(
          points={{90,0},{68,8},{68,-8},{90,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,54},{-80,54},{-60,80},{-60,-80},{60,80},{60,-80},{80,-52}},
            color={0,0,0})}));
end wrapAngle;
