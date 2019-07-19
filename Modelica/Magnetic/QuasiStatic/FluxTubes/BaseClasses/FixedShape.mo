within Modelica.Magnetic.QuasiStatic.FluxTubes.BaseClasses;
partial model FixedShape "Base class for flux tubes with fixed shape during simulation"

  extends Interfaces.TwoPorts;

  parameter SI.RelativePermeability mu_rConst = 1 "Constant relative permeability";

  Modelica.SIunits.Reluctance R_m "Magnetic reluctance";
  Modelica.SIunits.Permeance G_m "Magnetic permeance";
  Modelica.SIunits.ComplexMagneticFluxDensity B
  "Magnetic flux density (normal component)";
  Modelica.SIunits.MagneticFluxDensity abs_B = Modelica.ComplexMath.'abs'(B)
  "Magnitude of complex magnetic flux density";
  Modelica.SIunits.Angle arg_B = Modelica.ComplexMath.arg(B)
  "Argument of complex magnetic flux density";
  SI.CrossSection A "Area of cross section penetrated by magnetic flux";
  Modelica.SIunits.ComplexMagneticFieldStrength H
  "Magnetic field strength (normal component)";
  Modelica.SIunits.MagneticFieldStrength abs_H = Modelica.ComplexMath.'abs'(H)
  "Magnitude of complex magnetic field strength";
  Modelica.SIunits.Angle arg_H = Modelica.ComplexMath.arg(H)
  "Argument of complex magnetic field strength";

  SI.RelativePermeability mu_r "Relative magnetic permeability";

equation
  mu_r = mu_rConst;
  R_m = 1/G_m;
  V_m = Phi*R_m;
  B = Phi/A;
  H = B/(mu_0*mu_r);

  annotation (Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
      Rectangle(
          extent={{-70,30},{70,-30}},
          lineColor={255,170,85},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
      Line(points={{-70,0},{-90,0}}, color={255,170,85}),
      Line(points={{70,0},{90,0}}, color={255,170,85}),
      Text(
        extent={{-150,50},{150,90}},
        textString="%name",
        textColor={0,0,255})}), Documentation(info="<html>
<p>
Please refer to the description of  the subpackage
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.FixedShape\">Shapes.FixedShape</a>
for utilisation of this partial model.
</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end FixedShape;
