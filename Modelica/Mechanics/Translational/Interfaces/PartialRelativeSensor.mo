within Modelica.Mechanics.Translational.Interfaces;
partial model PartialRelativeSensor
  "Device to measure a single relative variable between two flanges"

  extends Modelica.Icons.RectangularSensor;
  extends Translational.Interfaces.PartialTwoFlanges;
equation
  0 = flange_a.f + flange_b.f;
  annotation (Documentation(info="<html>
<p>
This is a superclass for 1D translational components with two rigidly connected
flanges and one output signal in order to measure relative kinematic quantities
between the two flanges or the cut-force in the flange and
to provide the measured signal as output signal for further processing
with the Modelica.Blocks blocks.
</p>
</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Line(points={{-51,34},{29,34}}, color={95,127,95}),
          Polygon(
          points={{59,34},{29,44},{29,24},{59,34}},
          fillColor={95,127,95},
          fillPattern=FillPattern.Solid,
          lineColor={95,127,95}),            Line(points={{-70,0},{-100,0}}, color={0,127,0}),
                                                                            Line(points={{70,0},{100,0}}, color={0,127,0}),
                                                                                                         Text(
              extent={{-150,100},{150,60}},
              textString="%name",
              textColor={0,0,255})}));
end PartialRelativeSensor;
