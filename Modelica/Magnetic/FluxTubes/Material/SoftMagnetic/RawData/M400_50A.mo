within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.RawData;
record M400_50A "M400-50A @ 50Hz 0/90 deg"
  extends M330_50A(
    label="M400-50A @ 50Hz 0/90 deg",
    Jsat=2.0,
    Hsat=50e3,
    J={0.5, 0.6, 0.7, 0.8, 0.9, 1.0,
      1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9},
    H={75, 84, 93, 104, 117, 134,
      159, 199, 282, 505, 1284, 3343, 6787, 11712, 19044});
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
<p>
M400-50A at 50Hz for 0/90 deg magnetization table taken from manufacturer's datasheet
</p>
</html>"));
end M400_50A;
