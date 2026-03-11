within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic;
record MaterialSettings "Gathers all settings for a softmagnetic material"
  extends Modelica.Icons.Record;
  import Modelica.Magnetic.FluxTubes.Types.Magnetization;
  parameter Boolean nonLinearPermeability=true
    "= true, if non-linear rel. permeability is used, otherwise constant rel. permeability"
    annotation (Evaluate=true);
  parameter SI.RelativePermeability mu_rConst=1
    "Constant relative permeability; used if nonLinearPermeability=false"
    annotation (Dialog(enable=not nonLinearPermeability));
  parameter Magnetization magnetization=Magnetization.Roschke
    "Choose the approximation of the magnetization characteristic"
    annotation (Evaluate=true, Dialog(enable=nonLinearPermeability));
  parameter Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData
    material=Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData()
    "Ferromagnetic material characteristics, approximation according to Roschke"
    annotation (choicesAllMatching=true, Dialog(enable=nonLinearPermeability and magnetization==Magnetization.Roschke));
  parameter Macfadyen.BaseData materialMacfadyen=Macfadyen.BaseData()
    "Ferromagnetic material characteristics, approximation according to Macfadyen"
    annotation (choicesAllMatching=true, Dialog(enable=nonLinearPermeability
           and magnetization == Magnetization.Macfadyen));
  annotation(defaultComponentPrefixes="parameter", Documentation(info="<html>
<p>
This parameter record gathers all settings for a softmagnetic material. 
It can be used once in an example to propagate to several components the same material settings. 
</p>
</html>"));
end MaterialSettings;
