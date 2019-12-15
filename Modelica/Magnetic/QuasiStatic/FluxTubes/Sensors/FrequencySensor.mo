within Modelica.Magnetic.QuasiStatic.FluxTubes.Sensors;
model FrequencySensor "Frequency sensor"
  extends FluxTubes.Interfaces.AbsoluteSensor;
  import Modelica.Constants.pi;
  Modelica.Blocks.Interfaces.RealOutput y(unit="Hz") annotation (Placement(transformation(
          extent={{100,-10},{120,10}})));
equation
  2*pi*y = omega;
  annotation (Documentation(info="<html>
<p>
This sensor can be used to measure the frequency of the reference system.
The integral of the angular frequency of the quasi-static magnetic system is equal to the reference angle.
</p>
</html>"),
       Icon(graphics={
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="Hz")}));
end FrequencySensor;
