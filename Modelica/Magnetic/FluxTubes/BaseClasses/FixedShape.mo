within Modelica.Magnetic.FluxTubes.BaseClasses;
partial model FixedShape "Base class for flux tubes with fixed shape during simulation; linear or non-linear material characteristics"
  import Modelica.Magnetic.FluxTubes.Types.MagType;
  import Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.Functions.app_J;
  import Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.Functions.app_mu_r;

  // Material
  // This parameter is kept for backwards compatibility reasons, might be replaced by a member "Linear" in the enumeration Magnetization
  parameter Boolean nonLinearPermeability=true
    "= true, if non-linear rel. permeability is used, otherwise constant rel. permeability"
    annotation (Dialog(tab="Material"), Evaluate=true);
  parameter Modelica.Units.SI.RelativePermeability mu_rConst=1
    "Constant relative permeability; used if nonLinearPermeability=false"
    annotation (Dialog(tab="Material", enable=not nonLinearPermeability));
  parameter MagType magType=MagType.Roschke
    "Choose the approximation of the magnetization characteristic"
    annotation (Evaluate=true, Dialog(tab="Material", enable=nonLinearPermeability));
  parameter Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData material=
      Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData()
    "Ferromagnetic material characteristics, approximation according to Roschke"
    annotation (choicesAllMatching=true, Dialog(tab="Material", enable=
          nonLinearPermeability and magType ==MagType.Roschke));
  parameter Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.BaseData
    materialSSEE=Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.BaseData()
    "Ferromagnetic material characteristics, approximation SSEE"
    annotation (choicesAllMatching=true, Dialog(tab="Material", enable=
          nonLinearPermeability and magType ==MagType.SSEE));

  extends FluxTubes.Interfaces.TwoPort;
  input Modelica.Units.SI.CrossSection A "Cross-sectional area";
  Modelica.Units.SI.Reluctance R_m "Magnetic reluctance";
  Modelica.Units.SI.Permeance G_m "Magnetic permeance";
  Modelica.Units.SI.MagneticFluxDensity B(start=0) "Magnetic flux density";
  Modelica.Units.SI.MagneticPolarization J "Magnetic polarization";
  Modelica.Units.SI.MagneticFieldStrength H(start=0) "Magnetic field strength";
  Modelica.Units.SI.RelativePermeability mu_r(start=mu_rConst)
    "Relative magnetic permeability";
protected
  Real B_N=abs(B/material.B_myMax) "Absolute value of normalized B";
  constant Real epsilon=1e3*Modelica.Constants.eps;
equation
  R_m = 1/G_m;
  V_m = Phi*R_m;
  if nonLinearPermeability then
    if magType==MagType.Roschke  then
      mu_r = 1 + (material.mu_i - 1 + material.c_a*B_N)/(1 + material.c_b*B_N + B_N^material.n);
      J = mu_0*(mu_r - 1)*H;
    else //if magType == MagType.SSEE then
      mu_r = app_mu_r(H, materialSSEE);
      J = app_J(H, materialSSEE);
    end if;
  else // not nonLinearPermeability i.e. magType == MagType.Linear
    mu_r = mu_rConst;
    J = mu_0*(mu_r - 1)*H;
  end if;
  B = mu_0*H + J;
  Phi = B*A;
  annotation (Documentation(info="<html>
<p>
Please refer to the description of  the sub-package <a href=\"modelica://Modelica.Magnetic.FluxTubes.Shapes.FixedShape\">Shapes.FixedShape</a> for utilisation of this partial model.
</p>
</html>"));
end FixedShape;
