within Modelica.Magnetic.FluxTubes.BaseClasses;
partial model FixedShape "Base class for flux tubes with fixed shape during simulation; linear or non-linear material characteristics"
  import Modelica.Magnetic.FluxTubes.Types.Magnetization;

  // Material
  // This parameter is kept for backwards compatibility reasons, might be replaced by a member "Linear" in the enumeration Magnetization
  parameter Boolean nonLinearPermeability=true
    "= true, if non-linear rel. permeability is used, otherwise constant rel. permeability"
    annotation (Dialog(tab="Material"), Evaluate=true);
  parameter SI.RelativePermeability mu_rConst=1
    "Constant relative permeability; used if nonLinearPermeability=false"
    annotation (Dialog(tab="Material", enable=not nonLinearPermeability));
  parameter Magnetization magnetization=Magnetization.Roschke
    "Choose the approximation of the magnetization characteristic"
    annotation (Evaluate=true, Dialog(tab="Material", enable=nonLinearPermeability));
  parameter Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData
    material=Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData()
    "Ferromagnetic material characteristics, approximation according to Roschke"
    annotation (choicesAllMatching=true, Dialog(tab="Material", enable=nonLinearPermeability and magnetization==Magnetization.Roschke));
  parameter
    Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.Macfadyen.BaseData
    materialMacfadyen=
      Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.Macfadyen.BaseData()
    "Ferromagnetic material characteristics, approximation according to Macfadyen"
    annotation (choicesAllMatching=true, Dialog(tab="Material", enable=
          nonLinearPermeability and magnetization == Magnetization.Macfadyen));
  extends Modelica.Magnetic.FluxTubes.Interfaces.TwoPort;
  input SI.CrossSection A "Cross-sectional area";
  SI.Reluctance R_m "Magnetic reluctance";
  SI.Permeance G_m "Magnetic permeance";
  SI.MagneticFluxDensity B(start=0) "Magnetic flux density";
  SI.MagneticPolarization J "Magnetic polarization";
  SI.MagneticFieldStrength H(start=0) "Magnetic field strength";
  SI.RelativePermeability mu_r(start=mu_rConst) "Relative magnetic permeability";
protected
  Real B_N=abs(B/material.B_myMax) "Absolute value of normalized B";
  Real epsilon=1e3*Modelica.Constants.eps;
equation
  R_m = 1/G_m;
  V_m = Phi*R_m;
  if nonLinearPermeability then
    if magnetization == Magnetization.Roschke then
      mu_r = 1 + (material.mu_i - 1 + material.c_a*B_N)/(1 + material.c_b*B_N + B_N^material.n);
    else // if magnetization == Magnetization.Macfadyen then
      mu_r = smooth(1, (if noEvent(abs(H)<epsilon) then materialMacfadyen.mu_ri else
        (1 + sum({materialMacfadyen.Chi_mk[k]*materialMacfadyen.Hk[k]/max(epsilon, abs(H))*(1 - exp(-abs(H)/materialMacfadyen.Hk[k])) for k in 1:materialMacfadyen.N}) -
        materialMacfadyen.Chi_mc*exp(-abs(H)/materialMacfadyen.Hc))));
    end if;
  else // not nonLinearPermeability i.e. magnetization == Magnetization.Linear
    mu_r = mu_rConst;
  end if;
  Phi = B*A;
  B = mu_0*mu_r*H;
  J = mu_0*(mu_r - 1)*H;
  annotation (Documentation(info="<html>
<p>
Please refer to the description of  the sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">Shapes.FixedShape</a> for utilisation of this partial model.
</p>
</html>"));
end FixedShape;
