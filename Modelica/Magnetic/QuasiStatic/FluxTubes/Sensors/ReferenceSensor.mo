within Modelica.Magnetic.QuasiStatic.FluxTubes.Sensors;
model ReferenceSensor "Sensor of reference angle gamma"
  extends FluxTubes.Interfaces.AbsoluteSensor;
  Modelica.Blocks.Interfaces.RealOutput y(unit="rad") "Reference angle" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));
equation
  y = port.reference.gamma;
  annotation (Documentation(info="<html>
<p>This sensor determines the reference angle of the connected quasi-static magnetic system.
The integral of the angular frequency of the quasi-static magnetic system is equal to the reference angle.
</p>
</html>"),
    Icon(graphics={
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="rad"), Line(points={{70,0},{100,0}}, color={0,0,127})}));
end ReferenceSensor;
