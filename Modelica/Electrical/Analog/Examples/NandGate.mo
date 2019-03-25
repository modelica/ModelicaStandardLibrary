within Modelica.Electrical.Analog.Examples;
encapsulated model NandGate "CMOS NAND Gate (see Tietze/Schenk, page 157)"
  import Modelica.Electrical.Analog.Basic;
  import Modelica.Electrical.Analog.Sources;
  import Modelica.Electrical.Analog.Examples.Utilities;
  import Modelica.Icons;
  extends Icons.Example;

  Sources.TrapezoidVoltage VIN1(
    V=3.5,
    startTime=20e-9,
    rising=1e-9,
    width=19e-9,
    falling=1e-9,
    period=40e-9,
    nperiod=-1) annotation (Placement(transformation(
        origin={-70,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Sources.TrapezoidVoltage VIN2(
    V=3.5,
    startTime=10e-9,
    rising=1e-9,
    width=19e-9,
    falling=1e-9,
    period=40e-9,
    nperiod=-1) annotation (Placement(transformation(
        origin={-70,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Sources.RampVoltage VDD(V=5, duration=1e-9) annotation (Placement(
        transformation(
        origin={50,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Basic.Ground Gnd1 annotation (Placement(transformation(extent={{45,43},{55,53}})));
  Basic.Ground Gnd4 annotation (Placement(transformation(extent={{-75,-5},{-65,
            5}})));
  Basic.Ground Gnd5 annotation (Placement(transformation(extent={{-75,-55},{-65,
            -45}})));
  Utilities.Nand Nand(C4(v(start=0, fixed=true)),C7(v(start=0, fixed=true))) annotation (Placement(transformation(extent={{-40,-45},{
            40,55}})));
equation
  connect(VDD.n, Gnd1.p) annotation (Line(points={{50,60},{50,53}}, color={0,0,255}));
  connect(VIN1.n, Gnd4.p) annotation (Line(points={{-70,10},{-70,5}}, color={0,0,255}));
  connect(VIN2.n, Gnd5.p) annotation (Line(points={{-70,-40},{-70,-45}}, color={0,0,255}));
  connect(Nand.Vdd, VDD.p) annotation (Line(points={{0,55},{0,90},{50,90},{50,
          80}}, color={0,0,255}));
  connect(VIN1.p, Nand.x1) annotation (Line(points={{-70,30},{-40,30}}, color={0,
          0,255}));
  connect(VIN2.p, Nand.x2) annotation (Line(points={{-70,-20},{-40,-20}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>The nand gate is a basic CMOS building block. It consists of four CMOS transistors. The output voltage Nand.y.v is low if and only if the two input voltages at Nand.x1.v and Nand.x2.v are both high. In this way the nand functionality is realized.</p>
<p>The simulation end time should be set to 1e-7. Please plot the input voltages Nand.x1.v, d Nand.x2.v, and the output voltage Nand.y.v.</p>
<p><strong>Reference:</strong></p>
<p>Tietze, U.; Schenk, Ch.: Halbleiter-Schaltungstechnik. Springer-Verlag Berlin Heidelberg NewYork 1980, p. 157</p>
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
    experiment(StopTime=1e-007),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Text(
          extent={{-90,98},{-12,66}},
          lineColor={0,0,255},
          textString="NAND Gate")}));
end NandGate;
