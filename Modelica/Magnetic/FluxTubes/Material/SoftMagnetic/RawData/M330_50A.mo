within Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.RawData;
record M330_50A "M330-50A @ 50Hz 0/90 deg"
  extends BaseData(
    label="M330-50A @ 50Hz 0/90 deg",
    rho=7650,
    p1=3.30,
    f1=50,
    p2=1.9/lb2kg,
    f2=60,
    Jsat=2.0,
    Hsat=1e5,
    J={0.5, 0.6, 0.7, 0.8, 0.9, 1.0,
       1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9},
    H={53, 60, 69, 79, 93, 112,
       141, 192, 313, 698, 1932, 4284, 7750, 13318, 19610});
  annotation (defaultComponentPrefixes="parameter", Documentation(info="<html>
<p>
M330-50A at 50Hz for 0/90 deg magnetization table <code>H(J)</code>taken from manufacturer's datasheet
</p>
</html>"),
    Icon(graphics={Text(
          extent={{-100,-10},{100,-40}},
          textColor={0,0,0},
          textString="     %label     ")}));
end M330_50A;
