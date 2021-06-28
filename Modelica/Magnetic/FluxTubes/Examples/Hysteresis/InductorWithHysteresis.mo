within Modelica.Magnetic.FluxTubes.Examples.Hysteresis;
model InductorWithHysteresis
  extends Modelica.Icons.Example;
  Basic.Ground mag_ground
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
  Basic.ElectroMagneticConverterWithLeakageInductance winding(i(fixed=
          true), N=10)
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Modelica.Electrical.Analog.Basic.Ground el_ground
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=0.1) annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Electrical.Analog.Sources.SineVoltage vSource(f=200, V=5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,10})));
  Shapes.HysteresisAndMagnets.GenericHystTellinenEverett core(
    mat=FluxTubes.Material.HysteresisEverettParameter.M330_50A(),
    A=4e-4,
    MagRel(fixed=true, start=0),
    includeEddyCurrents=true,
    derHstat(fixed=true),
    l=0.1)
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
equation
  connect(winding.port_n, mag_ground.port) annotation (Line(
      points={{10,0},{10,-10}}, color={255,127,0}));
  connect(vSource.p, resistor.p) annotation (Line(points={{-50,20},{-50,30},{-40,30}}, color={0,0,255}));
  connect(vSource.n, el_ground.p) annotation (Line(points={{-50,0},{-50,-10}}, color={0,0,255}));
  connect(winding.n, el_ground.p) annotation (Line(
      points={{-10,0.2},{-10,-10},{-50,-10}},
                                            color={0,0,255}));
  connect(resistor.n, winding.p) annotation (Line(points={{-20,30},{-10,30},{-10,20},{-10,20}}, color={0,0,255}));
  connect(winding.port_p,core. port_p) annotation (Line(points={{10,20},{10,30},{20,30}},
                           color={255,127,0}));
  connect(mag_ground.port,core. port_n) annotation (Line(points={{10,-10},{46,-10},{46,30},{40,30}},
                                     color={255,127,0}));
  annotation (experiment(StartTime=0, StopTime=0.02, Interval=4e-6, Tolerance=1e-004), Documentation(info="<html>
<p>
This is a simple model of an inductor with a ferromagnetic core. The used GenericHystTellinenEverett model considers the ferromagnetic hysteresis, eddy currents and remanence of the core material. For example you can simulate the model for 0.02s and plot Core.B vs. Core.H to visualize the resulting hysteresis loops.
</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 1: </strong>Results Core.B(t) and Core.B(H) of the magnetic Core.</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/InductorWithHysteresis/plot1.png\">
    </td>
  </tr>
</table>
</html>"));
end InductorWithHysteresis;
