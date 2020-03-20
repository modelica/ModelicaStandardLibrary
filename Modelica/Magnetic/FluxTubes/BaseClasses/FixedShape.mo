within Modelica.Magnetic.FluxTubes.BaseClasses;
partial model FixedShape "Base class for flux tubes with fixed shape during simulation; linear or non-linear material characteristics"

  extends Interfaces.TwoPort;

  parameter Boolean nonLinearPermeability=true
    "= true, if non-linear rel. permeability is used, otherwise constant rel. permeability"
    annotation (Dialog(group="Material"), Evaluate=true);
  parameter SI.RelativePermeability mu_rConst=1
    "Constant relative permeability; used if nonLinearPermeability = false"
    annotation (Dialog(group="Material", enable=not nonLinearPermeability));

  parameter FluxTubes.Material.SoftMagnetic.BaseData material=
      Material.SoftMagnetic.BaseData()
    "Ferromagnetic material characteristics; used if nonLinearPermeability = true"
    annotation (choicesAllMatching=true, Dialog(group="Material", enable=
          nonLinearPermeability));

  SI.Reluctance R_m "Magnetic reluctance";
  SI.Permeance G_m "Magnetic permeance";
  SI.MagneticFluxDensity B "Magnetic flux density";
  SI.CrossSection A "Cross-sectional area penetrated by magnetic flux";
  SI.MagneticFieldStrength H "Magnetic field strength";

  SI.RelativePermeability mu_r "Relative magnetic permeability";

protected
  Real B_N "Absolute value of normalized B";

equation
  B_N = abs(B/material.B_myMax);
  mu_r = if nonLinearPermeability then
    1 + (material.mu_i - 1 + material.c_a*B_N)/(1 + material.c_b*B_N + B_N^material.n) else mu_rConst;

  R_m = 1/G_m;
  V_m = Phi*R_m;
  B = Phi/A;
  H = B/(mu_0*mu_r);

  annotation (Documentation(info="<html>
<p>
Please refer to the description of  the sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">Shapes.FixedShape</a> for utilisation of this partial model.
</p>
</html>"));
end FixedShape;
