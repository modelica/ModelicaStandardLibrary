within Modelica.Magnetic.QuasiStatic.FluxTubes.BaseClasses;
partial model FixedShape "Base class for flux tubes with fixed shape during simulation"

  extends Interfaces.TwoPort;

  parameter SI.RelativePermeability mu_rConst = 1 "Constant relative permeability";

  SI.Reluctance R_m "Magnetic reluctance";
  SI.Permeance G_m "Magnetic permeance";
  SI.ComplexMagneticFluxDensity B
  "Magnetic flux density (normal component)";
  SI.MagneticFluxDensity abs_B = Modelica.ComplexMath.abs(B)
  "Magnitude of complex magnetic flux density";
  SI.Angle arg_B = Modelica.ComplexMath.arg(B)
  "Argument of complex magnetic flux density";
  SI.CrossSection A "Area of cross section penetrated by magnetic flux";
  SI.ComplexMagneticFieldStrength H
  "Magnetic field strength (normal component)";
  SI.MagneticFieldStrength abs_H = Modelica.ComplexMath.abs(H)
  "Magnitude of complex magnetic field strength";
  SI.Angle arg_H = Modelica.ComplexMath.arg(H)
  "Argument of complex magnetic field strength";

  SI.RelativePermeability mu_r "Relative magnetic permeability";

equation
  mu_r = mu_rConst;
  R_m = 1/G_m;
  V_m = Phi*R_m;
  B = Phi/A;
  H = B/(mu_0*mu_r);

  annotation (Documentation(info="<html>
<p>
Please refer to the description of  the subpackage
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape\">Shapes.FixedShape</a>
for utilisation of this partial model.
</p>
</html>"));
end FixedShape;
