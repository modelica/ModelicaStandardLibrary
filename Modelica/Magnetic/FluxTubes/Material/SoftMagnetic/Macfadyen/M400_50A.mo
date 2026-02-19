within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.Macfadyen;
record M400_50A "M400-50A @ 50Hz 0/90 deg"
  extends Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.Macfadyen.BaseData(
    label="M400-50A",
    N=4,
    Hk={120.579, 65.806, 81.813, 10979.9},
    Chi_mk={6845.6, 3908.6, 754.75, 40.6525},
    Hc=44.32,
    Chi_mc=9403.3);
  annotation (defaultComponentPrefixes="parameter");
end M400_50A;
