within Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces;
partial model TwoPortExtended "Partial two port for graphical programming with additional variables"
  extends Magnetic.QuasiStatic.FundamentalWave.Interfaces.TwoPortElementary;

  Modelica.SIunits.ComplexMagneticPotentialDifference V_m = port_p.V_m - port_n.V_m
    "Complex magnetic potential difference";
  Modelica.SIunits.MagneticPotentialDifference abs_V_m = Modelica.ComplexMath.'abs'(V_m)
    "Magnitude of complex magnetic potential difference";
  Modelica.SIunits.Angle arg_V_m = Modelica.ComplexMath.arg(V_m)
    "Argument of complex magnetic potential difference";
  Modelica.SIunits.ComplexMagneticFlux Phi = port_p.Phi
    "Complex magnetic flux";
  Modelica.SIunits.MagneticFlux abs_Phi = Modelica.ComplexMath.'abs'(Phi)
    "Magnitude of complex magnetic flux";
  Modelica.SIunits.Angle arg_Phi = Modelica.ComplexMath.arg(Phi)
    "Argument of complex magnetic flux";

  annotation (
    Documentation(info="<html>
<p>
The partial two port model consists of a positive and a negative magnetic port. The reference angles of the two ports are set equal and connected through <code>Connections.branch</code>.
</p>
<p>
This interface model contains an extended set of (output) variables compared to
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FundamentalWave.Interfaces.TwoPortElementary\">TwoPortElementary</a>.
</p>
</html>"));
end TwoPortExtended;
