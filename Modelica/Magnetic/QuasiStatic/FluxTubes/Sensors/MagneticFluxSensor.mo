within Modelica.Magnetic.QuasiStatic.FluxTubes.Sensors;
model MagneticFluxSensor "Sensor to measure magnetic flux"
  extends FluxTubes.Interfaces.RelativeSensor;

equation
  V_m = Complex(0);
  y = Phi;

  annotation (defaultComponentName="magFluxSensor",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="Wb"),
        Line(points={{100,0},{-100,0}},color={255,170,85})}),
    Documentation(info="<html>
<p>
This sensor can be used to measure the complex magnetic flux <code>Phi</code> of a quasi-static magnetic system.
</p>
</html>"));
end MagneticFluxSensor;
