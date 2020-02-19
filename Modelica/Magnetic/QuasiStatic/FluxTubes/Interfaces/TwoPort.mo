within Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces;
partial model TwoPort "Two magnetic ports for textual modeling"
  extends TwoPortElementary;

equation
  Complex(0) = port_p.Phi + port_n.Phi;

  annotation (Documentation(info="<html>
<p>
It is assumed that the magnetic flux flowing into <code>port_p</code>
is identical to the flux flowing out of <code>port_n</code>.
</p>
</html>"));
end TwoPort;
