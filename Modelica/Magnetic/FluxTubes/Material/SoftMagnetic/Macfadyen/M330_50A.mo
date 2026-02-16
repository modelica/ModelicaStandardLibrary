within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.Macfadyen;
record M330_50A "M330-50A @ 50Hz 0/90 deg"
  extends Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.Macfadyen.BaseData(
    label="M330-50A",
    N=4,
    Hk={16.866, 189.0, 355.7, 11434},
    Chi_mk={49875, 204.73, 680.20, 41.012},
    Hc=30.407,
    Chi_mc= 46703);
  annotation (defaultComponentPrefixes="parameter");
end M330_50A;
