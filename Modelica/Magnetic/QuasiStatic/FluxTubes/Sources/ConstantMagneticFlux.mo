within Modelica.Magnetic.QuasiStatic.FluxTubes.Sources;
model ConstantMagneticFlux "Source of constant magnetic flux"

  extends FluxTubes.Interfaces.Source;
  parameter SI.Frequency f(start=1) "Frequency of the source";
  SI.ComplexMagneticPotentialDifference V_m
  "Magnetic potential difference between both ports";
  parameter SI.ComplexMagneticFlux Phi=Complex(1,0)
  "Magnetic flux";

equation
  omega = 2*Modelica.Constants.pi*f;
  V_m = port_p.V_m - port_n.V_m;
  Complex(0) = port_p.Phi + port_n.Phi;
  Phi = port_p.Phi;
  annotation (
    defaultComponentName="magFluxSource",
    Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
      Polygon(
        points={{80,0},{60,6},{60,-6},{80,0}},
        lineColor={255,170,85},
        fillColor={255,170,85},
        fillPattern=FillPattern.Solid),
      Line(points={{-90,0},{-50,0}},  color={255,170,85}),
      Line(points={{50,0},{90,0}},  color={255,170,85}),
      Ellipse(
        extent={{-50,-50},{50,50}},
        lineColor={255,170,85},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Line(points={{0,50},{0,-50}}, color={255,170,85})}),
    Documentation(info="<html>
<p>
This source provides a constant quasi-static magnetic flux <code>Phi</code> at fixed frequency, <code>f</code>.
</p>
</html>"));
end ConstantMagneticFlux;
