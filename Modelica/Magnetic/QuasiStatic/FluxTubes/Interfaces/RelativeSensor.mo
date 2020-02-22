within Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces;
partial model RelativeSensor "Partial magnetic voltage or flux sensor"
  extends Modelica.Icons.RoundSensor;
  extends TwoPort;
  Modelica.ComplexBlocks.Interfaces.ComplexOutput y annotation (Placement(
        transformation(
        origin={0,-110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}}),
                   graphics={
        Line(points={{-70,0},{-90,0}}, color={255,170,85}),
        Line(points={{70,0},{90,0}}, color={255,170,85}),
        Text(
          extent={{-150,120},{150,80}},
          textColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={170,85,255},
          fillPattern=FillPattern.Solid,
          textString="%name"),
        Line(
          points={{0,-70},{0,-100}}, color={85,170,255})}),
      Documentation(info="<html>
<p>
The relative sensor partial model relies on the
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.TwoPort\">TwoPort</a>
to measure the complex magnetic voltage, flux or power. Additionally this model contains a base icon and a definition
of the angular frequency.
</p></html>"));
end RelativeSensor;
