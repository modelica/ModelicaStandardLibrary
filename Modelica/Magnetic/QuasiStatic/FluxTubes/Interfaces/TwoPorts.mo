within Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces;
partial model TwoPorts "Two magnetic ports for textual modeling"
  extends TwoPortsElementary;

equation
  Complex(0) = port_p.Phi + port_n.Phi;

  annotation (Documentation(info="<html>
<p>
It is assumed that the magnetic flux flowing into <code>port_p</code>
is identical to the flux flowing out of <code>port_n</code>.
</p>
</html>"));
end TwoPorts;
