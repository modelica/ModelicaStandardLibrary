within Modelica.Magnetic.FluxTubes.Interfaces;
partial model TwoPortExtended "Extended TwoPort interface model with alias variables for magnetic voltage and flux"

  extends TwoPortElementary;
  SI.MagneticPotentialDifference V_m "Magnetic potential difference of ports";
  SI.MagneticFlux Phi(start=0) "Magnetic flux from port_p to port_n";

equation
  V_m = port_p.V_m - port_n.V_m;
  Phi = port_p.Phi;

  annotation (Documentation(info="<html>
<p>
It is assumed that the magnetic flux flowing into port_p is identical to the flux flowing out of port_n.
This magnetic flux is provided explicitly as flux Phi.
</p>
</html>"));
end TwoPortExtended;
