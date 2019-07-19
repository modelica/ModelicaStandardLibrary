within Modelica.Magnetic.FundamentalWave.Sensors;
model MagneticPotentialSensor "Sensor to measure magnetic potential"
  extends Modelica.Icons.RoundSensor;
  Modelica.ComplexBlocks.Interfaces.ComplexOutput V_m
    "Complex magnetic potential as output signal" annotation (Placement(
        transformation(
        origin={0,-100},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Interfaces.PositiveMagneticPort port_p "Magnetic connector of sensor"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
equation
  // No magnetic flux through sensor
  port_p.Phi = Complex(0, 0);
  // Magnetic potential
  V_m = port_p.V_m;
  annotation (defaultComponentName="magPotentialSensor", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
                                Line(points={{-70,0},{-90,0}}, color={255,128,0}),
          Line(points={{0,-90},{0,-70}}, color={85,170,255}),
                                         Text(
              extent={{-140,120},{140,80}},
              textString="%name",
              textColor={0,0,255}),
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="A")}), Documentation(info="<html>
<p>Sensor for magnetic potential difference.</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sensors.MagneticFluxSensor\">MagneticFluxSensor</a>
</p></html>"));
end MagneticPotentialSensor;
