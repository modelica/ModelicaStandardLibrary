within Modelica.Magnetic.FluxTubes.Examples.Hysteresis;
model SinglePhaseTransformerWithHysteresis1
  extends Modelica.Icons.Example;
  Basic.Ground mag_ground
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Basic.ElectroMagneticConverterWithLeakageInductance winding1(N=10, i(fixed=true)) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Electrical.Analog.Basic.Ground el_ground1
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R=0.05) annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Modelica.Electrical.Analog.Sources.SineVoltage vSource(f=400, V=8) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,0})));
  Basic.ElectroMagneticConverterWithLeakageInductance winding2(N=10, i(fixed=true)) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={30,0})));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(R=2) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={62,20})));
  Modelica.Electrical.Analog.Basic.Ground el_ground2
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  Shapes.HysteresisAndMagnets.GenericHystTellinenTable core(
    asc(fixed=false),
    mat=FluxTubes.Material.HysteresisTableData.M330_50A(),
    includeEddyCurrents=true,
    l=0.2,
    A=5e-4,
    MagRel(start=0.5, fixed=true))
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
initial equation
  core.derHstat = 0.0;
equation
  connect(winding1.port_n, mag_ground.port) annotation (Line(points={{-20,-10},{-20,-20},{0,-20}}, color={255,127,0}));
  connect(vSource.p, resistor1.p) annotation (Line(points={{-80,10},{-80,20},{-70,20}}, color={0,0,255}));
  connect(vSource.n, el_ground1.p) annotation (Line(points={{-80,-10},{-80,-20},{-60,-20}}, color={0,0,255}));
  connect(winding1.n, el_ground1.p) annotation (Line(points={{-40,-9.8},{-40,-20},{-60,-20}}, color={0,0,255}));
  connect(resistor1.n, winding1.p) annotation (Line(points={{-50,20},{-40,20},{-40,10}}, color={0,0,255}));
  connect(winding2.port_n, mag_ground.port) annotation (Line(points={{20,-10},{20,-20},{0,-20}}, color={255,127,0}));
  connect(winding2.p, resistor2.p) annotation (Line(points={{40,10},{40,20},{52,20}}, color={0,0,255}));
  connect(winding2.n, el_ground2.p) annotation (Line(points={{40,-9.8},{40,-20},{60,-20}}, color={0,0,255}));
  connect(resistor2.n, el_ground2.p) annotation (Line(points={{72,20},{80,20},{80,-20},{60,-20}}, color={0,0,255}));
  connect(winding1.port_p, core.port_p) annotation (Line(points={{-20,10},{-20,20},{-10,20}}, color={255,127,0}));
  connect(core.port_n, winding2.port_p) annotation (Line(points={{10,20},{20,20},{20,10}}, color={255,127,0}));
  annotation (experiment(StartTime=0, StopTime=0.02, Interval=4e-6, Tolerance=1e-006), Documentation(info="<html>
<p>
This simple model of an single-phase transformer shows the inrush currents due to the remanence of the core material (M330-50A). For an accurate modelling of the core material the GenericHystTellinenTable hysteresis flux tube element is used. The initial magnetization MagRel of the Core component is set to 80%. Simulation settings:
</p>
<ul>
  <li>Stop time: 0.02 s</li>
  <li>Number of intervals: 5000</li>
  <li>Tolerance: 1e-6</li>
</ul>
<p>
Then plot the flux density of the Core Core.B over the magnetic field strength Core.H and additionally the time course of the primary and secondary current and e.g. the power consumption of the iron core Core.LossPower (see the following figures).
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/SinglePhaseTransformerWithHysteresis1/plot01.png\" hspace=\"10\" vspace=\"10\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/SinglePhaseTransformerWithHysteresis1/plot02.png\" hspace=\"10\" vspace=\"10\">
    </td>
  </tr>
</table>

</html>"));
end SinglePhaseTransformerWithHysteresis1;
