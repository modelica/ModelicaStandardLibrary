within Modelica;
package Thermal "Library of thermal system components to model heat transfer and simple thermo-fluid pipe flow"
  extends Modelica.Icons.Package;


  annotation(
  	Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
  		Line(
		  origin={-47.5,11.6667},
		  points={{-2.5,-91.6667},{17.5,-71.6667},{-22.5,-51.6667},{17.5,-31.6667},{-22.5,-11.667},{17.5,8.3333},{-2.5,28.3333},{-2.5,48.3333}},
  		  smooth=Smooth.Bezier),
  		Polygon(
		  origin={-50.0,68.333},
		  pattern=LinePattern.None,
		  fillPattern=FillPattern.Solid,
  		  points={{0.0,21.667},{-10.0,-8.333},{10.0,-8.333}}),
  		Line(
		  origin={2.5,11.6667},
		  points={{-2.5,-91.6667},{17.5,-71.6667},{-22.5,-51.6667},{17.5,-31.6667},{-22.5,-11.667},{17.5,8.3333},{-2.5,28.3333},{-2.5,48.3333}},
  		  smooth=Smooth.Bezier),
  		Polygon(
		  origin={0.0,68.333},
		  pattern=LinePattern.None,
		  fillPattern=FillPattern.Solid,
  		  points={{0.0,21.667},{-10.0,-8.333},{10.0,-8.333}}),
  		Line(
		  origin={52.5,11.6667},
		  points={{-2.5,-91.6667},{17.5,-71.6667},{-22.5,-51.6667},{17.5,-31.6667},{-22.5,-11.667},{17.5,8.3333},{-2.5,28.3333},{-2.5,48.3333}},
  		  smooth=Smooth.Bezier),
  		Polygon(
		  origin={50.0,68.333},
		  pattern=LinePattern.None,
		  fillPattern=FillPattern.Solid,
  		  points={{0.0,21.667},{-10.0,-8.333},{10.0,-8.333}})}),
    Documentation(info="<html>
<p>
This package contains libraries to model heat transfer
and fluid heat flow.
</p>
</html>"));
end Thermal;
