within Modelica.Magnetic.FundamentalWave.Interfaces;
partial model TwoPortElementary "Two magnetic ports for graphical modeling"
  PositiveMagneticPort port_p "Positive magnetic port of fundamental wave machines" annotation (
      Placement(transformation(extent={{-110,-10},{-90,10}})));
  NegativeMagneticPort port_n "Negative magnetic port of fundamental wave machines" annotation (
      Placement(transformation(extent={{90,-10},{110,10}})));
  annotation (Documentation(info="<html>
<p>
This magnetic two port element consists of a
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">positive</a> and a
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">negative magnetic port</a> and
considers the flux balance of the two ports. Additionally the magnetic potential difference (of the positive and the negative port) and the magnetic flux (into the positive magnetic port) are defined. This model is mainly to used to extend from in order build more complex - graphical - models.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.TwoPortExtended\">TwoPortExtended</a>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.TwoPort\">TwoPort</a>
</p></html>"));
end TwoPortElementary;
