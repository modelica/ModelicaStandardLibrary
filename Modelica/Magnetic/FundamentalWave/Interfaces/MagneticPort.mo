within Modelica.Magnetic.FundamentalWave.Interfaces;
connector MagneticPort "Magnetic port of fundamental wave machines"
  SI.ComplexMagneticPotential V_m
    "Complex magnetic potential at the port";
  flow SI.ComplexMagneticFlux Phi
    "Complex magnetic flux into the port";
  annotation (Documentation(info="<html>
<p>
The potential quantity of the magnetic port is the complex magnetic potential difference <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/V_m.png\">. The corresponding flow quantity is the magnetic flux <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Phi.png\">.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>
</p>

</html>"));
end MagneticPort;
