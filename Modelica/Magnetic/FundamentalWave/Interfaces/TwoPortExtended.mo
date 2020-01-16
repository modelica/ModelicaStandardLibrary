within Modelica.Magnetic.FundamentalWave.Interfaces;
partial model TwoPortExtended "Two magnetic ports for graphical modeling with additional variables"
  extends TwoPortElementary;
  Modelica.SIunits.ComplexMagneticPotentialDifference V_m = port_p.V_m - port_n.V_m
    "Complex magnetic potential difference";
  Modelica.SIunits.MagneticPotentialDifference abs_V_m = Modelica.ComplexMath.abs(V_m)
    "Magnitude of complex magnetic potential difference";
  Modelica.SIunits.Angle arg_V_m = Modelica.ComplexMath.arg(V_m)
    "Argument of complex magnetic potential difference";
  Modelica.SIunits.ComplexMagneticFlux Phi = port_p.Phi
    "Complex magnetic flux";
  Modelica.SIunits.MagneticFlux abs_Phi = Modelica.ComplexMath.abs(Phi)
    "Magnitude of complex magnetic flux";
  Modelica.SIunits.Angle arg_Phi = Modelica.ComplexMath.arg(Phi)
    "Argument of complex magnetic flux";

  annotation (Documentation(info="<html>
<p>This magnetic two port element consists of a <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">positive</a> and a <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">negative magnetic port</a> and some additionally variables, but no physical balance equations.</p>
<h4>See also</h4>
<p><a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>, 
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>, 
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.TwoPort\">TwoPort</a>, 
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.TwoPortElementary\">TwoPortElementary</a></p>
</html>"));
end TwoPortExtended;
