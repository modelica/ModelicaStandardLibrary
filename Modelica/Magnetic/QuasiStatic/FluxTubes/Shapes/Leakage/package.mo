within Modelica.Magnetic.QuasiStatic.FluxTubes.Shapes;
package Leakage "Leakage flux tubes with position-independent permeance and hence no force generation; mu_r=1"
  extends Modelica.Icons.VariantsPackage;
  annotation (Documentation(info="<html>
<p>
The permeances of all elements of this package are calculated from their geometry <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro41]</a>. These flux tube elements are intended for modelling of leakage fields through vacuum, air and other media with a relative permeability
<img src=\"modelica://Modelica/Resources/Images/Magnetic/QuasiStatic/FluxTubes/mu_r-1.png\">.
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.LeakageWithCoefficient\">Basic.LeakageWithCoefficient</a> accounts for leakage not by the geometry of flux tubes, but by a coupling coefficient <code>c_usefulFlux</code>.
</p></html>"));
end Leakage;
