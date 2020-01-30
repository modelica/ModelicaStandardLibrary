within Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces;
partial model AbsoluteSensor "Partial potential sensor"
  extends Modelica.Icons.RoundSensor;
  SI.AngularVelocity omega;
  FluxTubes.Interfaces.PositiveMagneticPort port "Quasi-static magnetic port" annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
equation
  omega = der(port.reference.gamma);
  port.Phi = Complex(0);
  annotation (Icon(graphics={
        Line(points={{-70,0},{-90,0}}, color={255,170,85}),
        Text(
          extent={{-150,120},{150,80}},
          textColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={170,85,255},
          fillPattern=FillPattern.Solid,
          textString="%name")}), Documentation(info="<html>
<p>
The absolute sensor partial model provides a single
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>
to measure the complex magnetic potential. Additionally this model contains a base icon and a definition
of the angular frequency.
</p></html>"));
end AbsoluteSensor;
