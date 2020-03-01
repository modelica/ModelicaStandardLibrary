within Modelica.Magnetic.FluxTubes.Interfaces;
partial model TwoPort "Interface component including flux balance equation"

  extends TwoPortExtended;

equation
  0 = port_p.Phi + port_n.Phi;

  annotation (Documentation(info="<html>
<p>
It is assumed that the magnetic flux flowing into port_p is identical to the flux flowing out of port_n.
This magnetic flux is provided explicitly as flux Phi.
</p>
</html>"));
end TwoPort;
