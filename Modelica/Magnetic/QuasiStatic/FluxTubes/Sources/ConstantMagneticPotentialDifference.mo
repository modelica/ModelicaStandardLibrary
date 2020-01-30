within Modelica.Magnetic.QuasiStatic.FluxTubes.Sources;
model ConstantMagneticPotentialDifference "Constant magnetomotive force"

  extends FluxTubes.Interfaces.Source;
  parameter SI.Frequency f(start=1) "Frequency of the source";
  parameter SI.ComplexMagneticPotentialDifference V_m
  "Magnetic potential difference";
  SI.ComplexMagneticFlux Phi(re(start=0),im(start=0))
  "Magnetic flux from port_p to port_n";

equation
  omega = 2*Modelica.Constants.pi*f;
  V_m = port_p.V_m - port_n.V_m;
  Complex(0) = port_p.Phi + port_n.Phi;
  Phi = port_p.Phi;

  annotation (
    defaultComponentName="magVoltageSource",
    Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
      Line(points={{90,0},{50,0}}, color={255,170,85}),
      Line(points={{-50,0},{-90,0}}, color={255,170,85}),
      Line(points={{-50,0},{50,0}}, color={255,170,85}),
        Line(points={{-80,20},{-60,20}}, color={255,170,85}),
        Line(points={{-70,30},{-70,10}}, color={255,170,85}),
        Line(points={{60,20},{80,20}}, color={255,170,85})}),
    Documentation(info="<html>
<p>
This source provides a constant quasi-static magnetic potential difference <code>V_m</code> (or magnetomotive force, mmf),
at fixed frequency, <code>f</code>.
</p>
</html>"));
end ConstantMagneticPotentialDifference;
