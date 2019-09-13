within Modelica.Magnetic.QuasiStatic.FundamentalWave.BasicMachines.Components;
model PermanentMagnet
  "Permanent magnet model without intrinsic reluctance, represented by magnetic potential difference"
  extends FundamentalWave.Losses.PermanentMagnetLosses;
  extends Magnetic.QuasiStatic.FundamentalWave.Interfaces.TwoPortElementary;
  parameter Modelica.SIunits.ComplexMagneticPotentialDifference V_m=
      Complex(re=1, im=0)
    "Complex magnetic potential difference w.r.t. the rotor fixed reference frame";
  Modelica.SIunits.MagneticPotentialDifference abs_V_m=
      Modelica.ComplexMath.'abs'(V_m)
    "Magnitude of complex magnetic potential difference";
  Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
    "Argument of complex magnetic potential difference w.r.t. reference frame";

  Modelica.SIunits.Angle gamma "Angle of V_m fixed reference frame";
  Modelica.SIunits.ComplexMagneticFlux Phi "Complex magnetic flux";
  Modelica.SIunits.MagneticPotentialDifference abs_Phi=
      Modelica.ComplexMath.'abs'(Phi)
    "Magnitude of complex magnetic flux";
  Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
    "Argument of complex magnetic flux";
  Modelica.SIunits.ComplexMagneticPotentialDifference V_mGamma=V_m*
      Modelica.ComplexMath.fromPolar(1, -gamma)
    "Magnetic potential difference w.r.t. the reference frame";
equation
  // Magnetomotive force with respect to rotor fixed reference
  port_p.V_m - port_n.V_m = V_mGamma;
  // Flux into positive port with respect to rotor fixed reference
  port_p.Phi = Phi;
  // Local flux balance
  port_p.Phi + port_n.Phi = Complex(0, 0);
  // Reference angular speed and angle
  gamma = port_p.reference.gamma;
  // Connections.root(port_p.reference);
  annotation (defaultComponentName="magnet",
    Documentation(info="<html>
<p>Permanent magnet model with magnetic, mechanical and thermal connector including losses. The PM model is source  of constant magnetic potential difference. The PM loss is calculated by
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Losses.PermanentMagnetLosses\">PermanentMagnetLosses</a>.
</p>
</html>"),
     Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Line(
          points={{-100,0},{100,0}},
          color={255,170,85}), Ellipse(extent={{-50,50},{50,-50}},
            lineColor={255,170,85})}));
end PermanentMagnet;
