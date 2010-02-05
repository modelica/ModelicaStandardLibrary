within Modelica.Magnetic.FundamentalWave.Interfaces;
partial model PartialTwoPortElementary
  "Two magnetic ports for textual modeling"

  PositiveMagneticPort port_p "Positive complex magnetic port" 
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  NegativeMagneticPort port_n "Negative complex magnetic port" 
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));

annotation (Documentation(info="<html>
<p>
This magnetic two port element only consists of a  
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">positive</a> and a
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">negative magnetic port</a>. 
This model is mainly used to extend from in order build more complex - equation based - models.
</p>

<h4>See also</h4>
<p>
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>,
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>,
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPort\">PartialTwoPort</a>
</p>
</html>"));
end PartialTwoPortElementary;
