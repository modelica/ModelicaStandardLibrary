within Modelica.Magnetic.QuasiStatic.FluxTubes.Interfaces;
partial model TwoPortElementary "Two magnetic ports for graphical modeling"

  FluxTubes.Interfaces.PositiveMagneticPort port_p "Positive quasi-static magnetic port" annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  FluxTubes.Interfaces.NegativeMagneticPort port_n "Negative quasi-static magnetic port" annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  SI.ComplexMagneticPotentialDifference V_m
  "Magnetic potential difference of both ports";
  SI.MagneticPotentialDifference abs_V_m = Modelica.ComplexMath.abs(V_m)
  "Magnitude of complex magnetic potential difference";
  SI.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
  "Argument of complex magnetic potential difference";
  SI.ComplexMagneticFlux Phi(re(start=0),im(start=0))
  "Magnetic flux from port_p to port_n";
  SI.MagneticFlux abs_Phi=
      Modelica.ComplexMath.abs(Phi) "Magnitude of complex magnetic flux";
  SI.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
  "Argument of complex magnetic flux";
  SI.AngularVelocity omega;
equation
  Connections.branch(port_p.reference, port_n.reference);
  port_p.reference.gamma = port_n.reference.gamma;
  omega = der(port_p.reference.gamma);

  V_m = port_p.V_m - port_n.V_m;
  Phi = port_p.Phi;

  annotation (Documentation(info="<html>
<p>
Partial model of a flux tube component with two magnetic ports:
the positive port connector <code>port_p</code>, and the negative port
connector <code>port_n</code>. The total magnetic potential difference
<code>V_m</code> and the flux flowing into the positive port,
<code>Phi</code> are also defined in this model.
</p></html>"));
end TwoPortElementary;
