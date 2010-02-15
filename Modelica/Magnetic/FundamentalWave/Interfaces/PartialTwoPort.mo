within Modelica.Magnetic.FundamentalWave.Interfaces;
partial model PartialTwoPort "Two magnetic ports for textual modeling"

  extends Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPortElementary;

  Modelica.SIunits.ComplexMagneticPotentialDifference V_m
    "Complex magnetic potential difference";
  Modelica.SIunits.ComplexMagneticFlux Phi "Complex magnetic flux";

equation
  // Flux into positive port
  V_m = port_p.V_m - port_n.V_m;

  // Magneto motive force
  port_p.Phi = Phi;

  // Local flux balance
  port_p.Phi + port_n.Phi = Complex(0,0);

annotation (Documentation(info="<html>
<p>
This magnetic two port element consists of a  
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">positive</a> and a
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">negative magnetic port</a> and
considers the flux balance of the two ports. Additionally the magnetic potential difference (of the positive and the negative port) and the magnetic flux (into the positive magnetic port) are defined. This model is mainly to used to extend from in order build more complex - graphical - models.
</p>

<h4>See also</h4>
<p>
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>,
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>,
<a href=\"Modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPortElementary\">PartialTwoPortElementary</a>
</p></html>"));
end PartialTwoPort;
