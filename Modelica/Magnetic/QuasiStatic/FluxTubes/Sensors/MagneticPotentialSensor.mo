within Modelica.Magnetic.QuasiStatic.FluxTubes.Sensors;
model MagneticPotentialSensor "Potential sensor"
  extends FluxTubes.Interfaces.AbsoluteSensor;
  Modelica.ComplexBlocks.Interfaces.ComplexOutput y annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
equation
  y = port.V_m;
  annotation (defaultComponentName="magPotentialSensor",
  Documentation(info="<html>
<p>
This sensor can be used to measure the complex magnetic potential <code>V_m</code> in a quasi-static magnetic system.
</p>
</html>"),
    Icon(graphics={
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="A"), Line(points={{70,0},{100,0}}, color={85,170,255})}));
end MagneticPotentialSensor;
