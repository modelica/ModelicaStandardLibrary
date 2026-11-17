within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic;
record MaterialSettings
  "Gathers all settings for a soft magnetic material"
  extends Modelica.Icons.Record;
  import Modelica.Magnetic.FluxTubes.Types.MagType;
  // The parameter nonLinearPermeability is kept for backwards compatibility reasons,
  // and will be replaced by a member "Linear" in the enumeration MagType in the next major release
  parameter Boolean nonLinearPermeability=true
    "= true, if non-linear rel. permeability is used, otherwise constant rel. permeability"
    annotation (Evaluate=true);
  parameter Modelica.Units.SI.RelativePermeability mu_rConst=1
    "Constant relative permeability; used if nonLinearPermeability=false"
    annotation (Dialog(enable=not nonLinearPermeability));
  parameter MagType magType=MagType.Roschke
    "Choose the approximation of the magnetization characteristic"
    annotation (Evaluate=true, Dialog(enable=nonLinearPermeability));
  parameter Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData material=
      Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.BaseData()
    "Ferromagnetic material characteristics, approximation according to Roschke"
    annotation (choicesAllMatching=true, Dialog(enable=nonLinearPermeability
           and magType==MagType.Roschke));
  parameter Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.BaseData
    materialSSEE=Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE.BaseData()
    "Ferromagnetic material characteristics, approximation SSEE"
    annotation (choicesAllMatching=true, Dialog(enable=nonLinearPermeability and
          magType==MagType.SSEE));
  annotation(defaultComponentPrefixes="parameter", Documentation(info="<html>
<p>
This parameter record gathers all settings for a soft magnetic material. 
It can be used once in an example to propagate the same material settings to several components. 
</p>
</html>"));
end MaterialSettings;
