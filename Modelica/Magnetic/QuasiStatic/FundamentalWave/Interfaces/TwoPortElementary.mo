within Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces;
partial model TwoPortElementary "Partial two port for graphical programming"
  SI.AngularVelocity omega=der(port_p.reference.gamma)
    "Reference angular velocity (= der(port_p.reference.gamma))";
  FundamentalWave.Interfaces.PositiveMagneticPort port_p
    "Positive quasi-static magnetic port of fundamental wave machines" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  FundamentalWave.Interfaces.NegativeMagneticPort port_n
    "Negative quasi-static magnetic port of fundamental wave machines" annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
equation
  Connections.branch(port_p.reference, port_n.reference);
  port_p.reference.gamma = port_n.reference.gamma;
  annotation (
    Documentation(info="<html>
<p>
The partial two port model consists of a positive and a negative magnetic port. The reference angles of the two ports are set equal and connected through <code>Connections.branch</code>.
</p>
</html>"));
end TwoPortElementary;
