within Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces;
connector MagneticPort "Quasi-static magnetic port"
  SI.ComplexMagneticPotential V_m
  "Complex magnetic potential at the port";
  flow SI.ComplexMagneticFlux Phi
  "Complex magnetic flux flowing into the port";
  annotation (Documentation(info="<html>
<p>Base definition of complex quasi-static magnetic port.
The potential variable is the complex magnetic potential difference <code>V_m</code> and the flow variable
is the complex magnetic flux <code>Phi</code>.</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Interfaces.MagneticPort\">Magnetic.FluxTubes.Interfaces.MagneticPort</a>
</p>

</html>"));
end MagneticPort;
