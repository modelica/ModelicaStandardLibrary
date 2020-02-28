within Modelica.Magnetic.QuasiStatic;
package FluxTubes "Library for modelling of quasi-static electromagnetic devices with lumped magnetic networks"

  import Modelica.Constants.pi;
  import Modelica.Constants.mu_0;

  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>
<p>
This library is intended to provide models for the investigation of
quasi-static electromagnetic devices with lumped magnetic networks.
</p>
</html>"),
           Icon(coordinateSystem(preserveAspectRatio=false), graphics={
    Polygon(
        origin={-3.75,0.0},
        fillColor={255,170,85},
        fillPattern=FillPattern.Solid,
        points={{33.75,50.0},{-46.25,50.0},{-46.25,-50.0},{33.75,-50.0},{33.75,
            -30.0},{-21.25,-30.0},{-21.25,30.0},{33.75,30.0}}),
    Ellipse(
      origin={10.4708,41.6771},
      extent={{-86.0,-24.0},{-78.0,-16.0}}),
    Line(
      origin={10.4708,41.6771},
      points={{-64.0,-20.0},{-78.0,-20.0}}),
    Line(
      origin={10.4708,41.6771},
      points={{-64.1812,-31.6229},{-32.0,-40.0}}),
    Line(
      origin={10.4708,41.6771},
      points={{-64.0,-20.0},{-32.0,-28.0}}),
    Ellipse(
      origin={10.4708,41.6771},
      extent={{-86.0,-60.0},{-78.0,-52.0}}),
    Line(
      origin={10.4708,41.6771},
      points={{-64.0,-56.0},{-78.0,-56.0}}),
    Line(
      origin={10.4708,41.6771},
      points={{-64.0,-44.0},{-32.0,-52.0}}),
    Line(
      origin={10.4708,41.6771},
      points={{-64.0,-56.0},{-32.0,-64.0}}),
    Rectangle(
        origin={62.5,0.0},
        fillColor={255,170,85},
        fillPattern=FillPattern.Solid,
        extent={{-12.5,-50.0},{12.5,50.0}}),
      Line(
        points={{-86,4},{-84,8},{-80,10},{-76,8},{-72,2},{-68,0},{-64,2},{-62,6}},
        color={85,170,255})}));
end FluxTubes;
