within Modelica.Magnetic.FluxTubes.Sensors;
model MagneticFluxSensor "Sensor to measure magnetic flux"
  extends Interfaces.TwoPortElementary;
  extends Modelica.Icons.RoundSensor;

  Modelica.Blocks.Interfaces.RealOutput Phi(final quantity="MagneticFlux",
      final unit="Wb")
    "Magnetic flux from port p to port n as output signal" annotation (
      Placement(transformation(
        origin={0,-100},
        extent={{10,-10},{-10,10}},
        rotation=90)));
equation
  port_p.V_m = port_n.V_m;
  Phi = port_p.Phi;
  0 = port_p.Phi + port_n.Phi;

  annotation (defaultComponentName="magFluxSensor",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Line(points={{0,-100},{0,-70}}),Line(points={{-70,0},{-90,0}}, color={255,128,0}),
                                                                                                        Line(
          points={{70,0},{90,0}}, color={255,128,0}),
                                   Text(
              extent={{-150,120},{150,80}},
              textString="%name",
              textColor={0,0,255}),Line(points={{0,-90},{0,-70}}, color={0,0,127}),
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="Wb"),
        Line(points={{100,0},{-100,0}},color={255,128,0})}));
end MagneticFluxSensor;
