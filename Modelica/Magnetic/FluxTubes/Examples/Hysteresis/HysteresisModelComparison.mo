within Modelica.Magnetic.FluxTubes.Examples.Hysteresis;
model HysteresisModelComparison
  "Comparison of the different hysteresis models"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.TimeTable timeTable(table=[0.0,0.0; 1,500; 3,-500;
        5,500; 6,-24; 7,24; 8,-24; 9,24; 10,-24; 11,24; 12,-24; 13,24; 14,
        -24; 15,24])
    annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
  Basic.ElectroMagneticConverterWithLeakageInductance winding1(i(fixed=true, start=0), N=1) "Winding 1" annotation (Placement(transformation(extent={{30,50},{50,70}})));
  Modelica.Electrical.Analog.Basic.Ground elGnd1
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Basic.Ground magGnd1
    annotation (Placement(transformation(extent={{60,30},{80,50}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R=1) annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage vSource1 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,60})));
  Basic.ElectroMagneticConverterWithLeakageInductance winding2(i(start=0, fixed=true), N=1) "Winding 2" annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Electrical.Analog.Basic.Ground elGnd2
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
  Shapes.HysteresisAndMagnets.GenericHystTellinenTable tellinenTable(
    includeEddyCurrents=false,
    sigma=1,
    K=100,
    mat=FluxTubes.Material.HysteresisTableData.M330_50A(),
    l=1,
    MagRel(fixed=true, start=0))
         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={70,10})));
  Basic.Ground magGnd2
    annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(R=1) annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage vSource2 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,0})));
  Basic.ElectroMagneticConverterWithLeakageInductance winding3(i(fixed=true, start=0), N=1) "Winding 3" annotation (Placement(transformation(extent={{30,-70},{50,-50}})));
  Modelica.Electrical.Analog.Basic.Ground elGnd3
    annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
  Shapes.HysteresisAndMagnets.GenericHystPreisachEverett preisachEverett(
    includeEddyCurrents=false,
    sigma=1,
    mat=FluxTubes.Material.HysteresisEverettParameter.M330_50A(),
    l=1,
    MagRel(fixed=true, start=0))
         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={70,-50})));
  Basic.Ground magGnd3
    annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor3(R=1) annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage vSource3 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,-60})));
  Modelica.Blocks.Math.Gain gain(k=1)
    annotation (Placement(transformation(extent={{-58,50},{-38,70}})));
  Shapes.HysteresisAndMagnets.GenericHystTellinenSoft tellinenSoft(
    l=1,
    Js=1.35,
    Br=1.0,
    Hc=40,
    K=100,
    MagRel(fixed=true, start=0))
    annotation (Placement(transformation(extent={{62,60},{82,80}})));
equation
  connect(winding1.port_n, magGnd1.port) annotation (Line(points={{50,50},{70,50}}, color={255,127,0}));
  connect(resistor1.n, winding1.p) annotation (Line(points={{20,70},{30,70}}, color={0,0,255}));
  connect(winding1.n, elGnd1.p) annotation (Line(points={{30,50.2},{30,50},{10,50}}, color={0,0,255}));
  connect(vSource1.p, resistor1.p) annotation (Line(points={{-10,70},{0,70}}, color={0,0,255}));
  connect(elGnd1.p, vSource1.n) annotation (Line(points={{10,50},{-10,50}}, color={0,0,255}));
  connect(winding2.port_n, magGnd2.port) annotation (Line(points={{50,-10},{70,-10}}, color={255,127,0}));
  connect(winding2.port_p, tellinenTable.port_p) annotation (Line(points={{50,10},{60,10}}, color={255,127,0}));
  connect(resistor2.n, winding2.p) annotation (Line(points={{20,10},{26,10},{26,10},{26,10},{26,10},{30,10}}, color={0,0,255}));
  connect(winding2.n, elGnd2.p) annotation (Line(points={{30,-9.8},{30,-10},{10,-10}}, color={0,0,255}));
  connect(vSource2.p, resistor2.p) annotation (Line(points={{-10,10},{-6,10},{-6,10},{-4,10},{-4,10},{0,10}}, color={0,0,255}));
  connect(elGnd2.p, vSource2.n) annotation (Line(points={{10,-10},{-10,-10}}, color={0,0,255}));
  connect(tellinenTable.port_n, magGnd2.port) annotation (Line(
      points={{80,10},{90,10},{90,-10},{70,-10}},
                                              color={255,127,0}));
  connect(vSource2.v, vSource1.v) annotation (Line(points={{-22,0},{-30,0},{-30,60},{-22,60}}, color={0,0,127}));
  connect(winding3.port_n, magGnd3.port) annotation (Line(points={{50,-70},{70,-70}}, color={255,127,0}));
  connect(winding3.port_p, preisachEverett.port_p) annotation (Line(points={{50,-50},{60,-50}}, color={255,127,0}));
  connect(resistor3.n, winding3.p) annotation (Line(points={{20,-50},{30,-50}}, color={0,0,255}));
  connect(winding3.n, elGnd3.p) annotation (Line(points={{30,-69.8},{30,-70},{10,-70}}, color={0,0,255}));
  connect(vSource3.p, resistor3.p) annotation (Line(points={{-10,-50},{0,-50}}, color={0,0,255}));
  connect(elGnd3.p, vSource3.n) annotation (Line(points={{10,-70},{-10,-70}}, color={0,0,255}));
  connect(preisachEverett.port_n, magGnd3.port) annotation (Line(
      points={{80,-50},{90,-50},{90,-70},{70,-70}}, color={255,127,0}));
  connect(vSource3.v, vSource1.v) annotation (Line(points={{-22,-60},{-30,-60},{-30,60},{-22,60}}, color={0,0,127}));
  connect(timeTable.y, gain.u) annotation (Line(
      points={{-69,60},{-60,60}},     color={0,0,127}));
  connect(gain.y, vSource1.v) annotation (Line(points={{-37,60},{-22,60}}, color={0,0,127}));
  connect(winding1.port_p, tellinenSoft.port_p) annotation (Line(points={{50,70},{62,70}}, color={255,127,0}));
  connect(magGnd1.port,tellinenSoft. port_n) annotation (Line(points={{70,50},{90,50},{90,70},{82,70}},
                                        color={255,127,0}));
  annotation (experiment(StartTime=0, StopTime=14, Interval=3e-3, Tolerance=1e-005), Documentation(info="<html>
<p>
Use the following simulation settings:
</p>
<ul>
  <li>Stop time: 14 s</li>
  <li>Number of intervals: 5000</li>
  <li>Tolerance: 1e-5</li>
</ul>
<p>
This example compares the behavior of three different hysteresis models due to the exact same input magnetic field strength. The three different models are:
</p>
<ol>
  <li>Model=GenericHystTellinenSoft, Tellinen hysteresis model, the upper and lower branch of the limiting hysteresis loop is roughly approximated with simple hyperbolic tangent functions (Fig1. c)</li>
  <li>Model=GenericHystTellinenTable, Tellinen hysteresis model, the upper and lower branch of the limiting hysteresis loop can be defined with almost arbitrary table data (Fig1. d)</li>
  <li>Model=GenericHystPreisachEverett,Preisach hysteresis model, the hysteresis shape is defined by the Everett function (Fig1. e)</li>
</ol>
<p>
Compared to the complex Preisach hysteresis model the Tellinen model is very simple and thus computationally more effective and stable. It is sufficient for many applications. But the Tellinen model has inherently a problem with small periodic input field variations at locations where the outer hysteresis loop has large slopes. In such a case, the simulated minor loops settle to the center of the hysteresis envelope curve, whereas the minor loops of the Preisach model stay constant ('property of equal vertical chords', <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ma03]</a>). The input signal of the example (Fig. 1 a) corresponds to that case and Fig. 1 b-e shows the behavior of the different models.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 1: </strong>Simulated magnetic flux densities B of different hysteresis models (b) due to an applied magnetic field strength shown in (a). Corresponding B(H) loops of the hysteresis models GenericHystTellinenSoft (c), GenericHystTellinenTable (d) and GenericHystPreisachEverett (e).</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FluxTubes/Examples/Hysteresis/HysteresisModelComparison/plot1.png\">
    </td>
  </tr>
</table>
</html>"));
end HysteresisModelComparison;
