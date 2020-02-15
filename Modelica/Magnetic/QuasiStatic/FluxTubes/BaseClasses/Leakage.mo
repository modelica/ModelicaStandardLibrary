within Modelica.Magnetic.QuasiStatic.FluxTubes.BaseClasses;
partial model Leakage "Base class for leakage flux tubes with position-independent permeance and hence no force generation; mu_r=1"

  extends Interfaces.TwoPort;
  extends Modelica.Magnetic.QuasiStatic.FluxTubes.Icons.Reluctance;

  SI.Reluctance R_m "Magnetic reluctance";
  SI.Permeance G_m "Magnetic permeance";

equation
  V_m = Phi*R_m;
  R_m = 1/G_m;

  annotation (Icon(coordinateSystem(
      preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}), graphics={
      Text(
        extent={{-150,50},{150,90}},
        textString="%name",
        textColor={0,0,255})}), Documentation(info="<html>
<p>
Please refer to the description of the subpackage
<a href=\"modelica://Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes.Leakage\">Shapes.Leakage</a>
for utilisation of this partial model.
</p>
</html>"));
end Leakage;
