within Modelica.Electrical.Analog.Examples;
encapsulated model DifferenceAmplifier
  "Simple NPN transistor amplifier circuit"
  import Modelica.Electrical.Analog.Basic;
  import Modelica.Electrical.Analog.Sources;
  import Modelica.Electrical.Analog.Examples.Utilities;
  import Modelica.Icons;
  extends Icons.Example;

  Sources.ExpSineVoltage V1(
    V=0.2,
    freqHz=0.2e9,
    damping=0.1e8) annotation (Placement(transformation(
        origin={-90,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Sources.RampVoltage V2(V=15, duration=1e-9) annotation (Placement(
        transformation(
        origin={80,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Sources.RampCurrent I1(I=0.16, duration=1e-9) annotation (Placement(
        transformation(
        origin={-10,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Basic.Resistor R1(R=0.0001) annotation (Placement(transformation(extent={{-90,
            -20},{-70,0}})));
  Basic.Resistor R2(R=100) annotation (Placement(transformation(
        origin={-40,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Basic.Resistor R3(R=0.0001) annotation (Placement(transformation(extent={{70,
            -20},{90,0}})));
  Basic.Resistor R4(R=100) annotation (Placement(transformation(
        origin={40,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Basic.Capacitor C1(C=1e-10, v(start=0, fixed=true)) annotation (Placement(transformation(
        origin={-60,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Basic.Capacitor C4(C=1e-10, v(start=0, fixed=true)) annotation (Placement(transformation(extent={{10,
            -14},{30,6}})));
  Basic.Capacitor C5(C=1e-10, v(start=0, fixed=true)) annotation (Placement(transformation(
        origin={10,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Basic.Capacitor C2(C=1e-10, v(start=0, fixed=true)) annotation (Placement(transformation(extent={{-30,
            -14},{-10,6}})));
  Basic.Capacitor C3(C=1e-10, v(start=0, fixed=true)) annotation (Placement(transformation(
        origin={60,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Basic.Ground Gnd1 annotation (Placement(transformation(extent={{-95,-80},{-85,
            -70}})));
  Basic.Ground Gnd9 annotation (Placement(transformation(extent={{75,20},{85,30}})));
  Basic.Ground Gnd3 annotation (Placement(transformation(extent={{-15,-20},{-5,
            -10}})));
  Basic.Ground Gnd2 annotation (Placement(transformation(extent={{-65,-80},{-55,
            -70}})));
  Basic.Ground Gnd6 annotation (Placement(transformation(extent={{5,-20},{15,
            -10}})));
  Basic.Ground Gnd7 annotation (Placement(transformation(extent={{-15,-80},{-5,
            -70}})));
  Basic.Ground Gnd8 annotation (Placement(transformation(extent={{5,-80},{15,
            -70}})));
  Basic.Ground Gnd5 annotation (Placement(transformation(extent={{55,-80},{65,
            -70}})));
  Basic.Ground Gnd4 annotation (Placement(transformation(extent={{85,-50},{95,
            -40}})));
  Utilities.Transistor Transistor1(ct(v(start=0, fixed=true))) annotation (Placement(transformation(extent=
            {{-60,-20},{-40,0}})));
  Utilities.Transistor Transistor2(ct(v(start=0, fixed=true))) annotation (Placement(transformation(extent=
            {{60,-20},{40,0}})));
equation
  connect(V1.n, Gnd1.p) annotation (Line(points={{-90,-60},{-90,-70}}, color={0,
          0,255}));
  connect(C1.n, Gnd2.p) annotation (Line(points={{-60,-60},{-60,-70}}, color={0,
          0,255}));
  connect(I1.n, Gnd7.p) annotation (Line(points={{-10,-60},{-10,-65},{-10,-70}}, color={0,0,255}));
  connect(C5.n, Gnd8.p) annotation (Line(points={{10,-60},{10,-70}}, color={0,0,
          255}));
  connect(C3.n, Gnd5.p) annotation (Line(points={{60,-60},{60,-70}}, color={0,0,
          255}));
  connect(R3.n, Gnd4.p) annotation (Line(points={{90,-10},{90,-40}}, color={0,0,
          255}));
  connect(C2.n, Gnd3.p) annotation (Line(points={{-10,-4},{-10,-10}}, color={0,0,
          255}));
  connect(C4.p, Gnd6.p) annotation (Line(points={{10,-4},{10,-10}}, color={0,0,255}));
  connect(I1.p, C5.p) annotation (Line(points={{-10,-40},{10,-40}}, color={0,0,255}));
  connect(R1.p, V1.p) annotation (Line(points={{-90,-10},{-90,-40}}, color={0,0,
          255}));
  connect(R2.p, V2.p) annotation (Line(points={{-40,40},{-40,70},{80,70},{80,60}}, color={0,0,255}));
  connect(R4.p, V2.p) annotation (Line(points={{40,40},{40,70},{80,70},{80,60}}, color={0,0,255}));
  connect(V2.n, Gnd9.p) annotation (Line(points={{80,40},{80,30}}, color={0,0,255}));
  connect(R1.n, Transistor1.b) annotation (Line(points={{-70,-10},{-60,-10}}, color={0,0,255}));
  connect(Transistor1.b, C1.p) annotation (Line(points={{-60,-10},{-60,-40}}, color={0,0,255}));
  connect(Transistor1.c, C2.p) annotation (Line(points={{-40,-4},{-30,-4}}, color={0,0,255}));
  connect(R2.n, Transistor1.c) annotation (Line(points={{-40,20},{-40,-4}}, color={0,0,255}));
  connect(Transistor1.e, I1.p) annotation (Line(points={{-40,-16},{-30,-16},{
          -30,-40},{-10,-40}}, color={0,0,255}));
  connect(Transistor2.b, R3.p) annotation (Line(points={{60,-10},{70,-10}}, color={0,0,255}));
  connect(Transistor2.b, C3.p) annotation (Line(points={{60,-10},{60,-40}}, color={0,0,255}));
  connect(C4.n, Transistor2.c) annotation (Line(points={{30,-4},{40,-4}}, color={0,0,255}));
  connect(R4.n, Transistor2.c) annotation (Line(points={{40,20},{40,-4}}, color={0,0,255}));
  connect(C5.p, Transistor2.e) annotation (Line(points={{10,-40},{30,-40},{30,
          -16},{40,-16}}, color={0,0,255}));
  annotation (
    Documentation(info="<html>
<p>It is a simple NPN transistor amplifier circuit. The voltage difference between R1.p and R3.n is amplified. The output signal is the voltage between R2.n and R4.n. In this example the voltage at V1 is amplified because R3.n is grounded.</p>
<p>The simulation end time should be set to 1e- 8. Please plot the input voltage V1.v, and the output voltages R2.n.v, and R4.n.v.</p>
<p><strong>Reference:</strong></p>
<p>Tietze, U.; Schenk, Ch.: Halbleiter-Schaltungstechnik. Springer-Verlag Berlin Heidelberg NewYork 1980, p. 59</p>
</html>",
   revisions="<html>
<dl>
<dt>
<strong>Main Authors:</strong>
</dt>
<dd>
Christoph Clau&szlig;
    &lt;<a href=\"mailto:christoph@clauss-it.com\">christoph@clauss-it.com</a>&gt;<br>
    Andr&eacute; Schneider
    &lt;<a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden
</dd>
</dl>
</html>"),
    experiment(StopTime=1),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Text(
          extent={{-98,106},{22,60}},
          lineColor={0,0,255},
          textString="Difference Amplifier")}));
end DifferenceAmplifier;
