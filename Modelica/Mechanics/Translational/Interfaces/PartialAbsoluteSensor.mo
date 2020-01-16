within Modelica.Mechanics.Translational.Interfaces;
partial model PartialAbsoluteSensor
  "Device to measure a single absolute flange variable"

  extends Modelica.Icons.RectangularSensor;

  Interfaces.Flange_a flange
    "Flange to be measured (flange axis directed into cut plane, e. g. from left to right)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

equation
  0 = flange.f;
  annotation (Documentation(info="<html>
<p>
This is the superclass of a 1D translational component with one flange and one
output signal in order to measure an absolute kinematic quantity in the flange
and to provide the measured signal as output signal for further processing
with the Modelica.Blocks blocks.
</p>
</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Line(points={{-100,-90},{-20,-90}}, color={95,127,95}),
                                                                       Polygon(
          points={{10,-90},{-20,-80},{-20,-100},{10,-90}},
          lineColor={95,127,95},
          fillColor={95,127,95},
          fillPattern=FillPattern.Solid),    Line(points={{-70,0},{-100,0}}, color={0,127,0}),
                                                                            Line(points={{70,0},{100,0}}, color={0,0,127}),
          Text(
              extent={{-150,80},{150,40}},
              textString="%name",
              textColor={0,0,255})}));
end PartialAbsoluteSensor;
