within Modelica.Magnetic.QuasiStatic.FluxTubes.Sensors;
model MagneticPotentialDifferenceSensor
"Sensor to measure magnetic potential difference"
  extends FluxTubes.Interfaces.RelativeSensor;

equation
  Phi = Complex(0);
  y = V_m;

  annotation (defaultComponentName="magVoltageSensor",
    Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="A")}),    Documentation(info="<html>
<p>
This sensor can be used to measure the complex magnetic potential difference <code>V_m</code>
in a quasi-static magnetic system.
</p>
</html>"));
end MagneticPotentialDifferenceSensor;
