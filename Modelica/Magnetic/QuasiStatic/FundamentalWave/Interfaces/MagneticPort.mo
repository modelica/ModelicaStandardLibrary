within Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces;
connector MagneticPort "Quasi-static magnetic port of fundamental wave machines"
  SI.ComplexMagneticPotential V_m
    "Complex magnetic potential at the port";
  flow SI.ComplexMagneticFlux Phi
    "Complex magnetic flux flowing into the port";
  annotation (Documentation(info="<html>
<p>Base definition of complex quasi-static magnetic port. The potential variable is the complex magnetic potential
<code>V_m</code> and the flow variable is the complex magnetic flux <code>Phi</code>.</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>
</p>

</html>"));
end MagneticPort;
