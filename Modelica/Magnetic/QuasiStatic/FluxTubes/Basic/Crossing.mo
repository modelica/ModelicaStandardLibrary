within Modelica.Magnetic.QuasiStatic.FluxTubes.Basic;
model Crossing "Crossing of two branches"

  FluxTubes.Interfaces.PositiveMagneticPort port_p1 "Positive port_p1 connected with port_p2" annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
  FluxTubes.Interfaces.PositiveMagneticPort port_p2 "Positive port_p2 connected with port_p1" annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
  FluxTubes.Interfaces.NegativeMagneticPort port_n1 "Negative port_n1 connected with port_n2" annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
  FluxTubes.Interfaces.NegativeMagneticPort port_n2 "Negative port_n2 connected with port_n1" annotation (Placement(transformation(extent={{90,90},{110,110}})));

equation
  Connections.branch(port_p1.reference, port_p2.reference);
  Connections.branch(port_n1.reference, port_n2.reference);
  port_p1.reference.gamma = port_p2.reference.gamma;
  port_n1.reference.gamma = port_n2.reference.gamma;

  port_p1.V_m = port_p2.V_m;
  port_p1.Phi + port_p2.Phi = Complex(0,0);
  port_n1.V_m = port_n2.V_m;
  port_n1.Phi + port_n2.Phi = Complex(0,0);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
      Line(
          points={{100,100},{40,100},{-40,-100},{-100,-100}},
          color={255,170,85}),
      Line(
          points={{-100,100},{-40,100},{40,-98},{100,-100}},
          color={255,170,85}),
        Text(
          extent={{-150,110},{150,150}},
          textColor={0,0,255},
          textString="%name")}), Documentation(
        info="<html>
<p>
This is a simple crossing of two branches. The ports <code>port_p1</code> and <code>port_p2</code> are connected, as well as <code>port_n1</code> and <code>port_n2</code>.
</p></html>",
      revisions="<html>
</html>"));
end Crossing;
