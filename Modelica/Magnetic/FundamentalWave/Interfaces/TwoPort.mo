within Modelica.Magnetic.FundamentalWave.Interfaces;
partial model TwoPort "Two magnetic ports for textual modeling"
  extends Magnetic.FundamentalWave.Interfaces.TwoPortExtended;
equation
  // Local flux balance
  port_p.Phi + port_n.Phi = Complex(0, 0);
  annotation (Documentation(info="<html>
<p>
This magnetic two port element only consists of a
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">positive</a> and a
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">negative magnetic port</a>.
This model is mainly used to extend from in order build more complex - equation based - models.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.TwoPortElementary\">TwoPortElementary</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.TwoPortExtended\">TwoPortExtended</a>
</p>
</html>"));
end TwoPort;
