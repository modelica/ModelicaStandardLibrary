within Modelica.Electrical.Analog.Examples.Utilities;
model Nand "CMOS NAND Gate (see Tietze/Schenk, page 157)"

  Semiconductors.PMOS TP1(
    W=6.5e-6,
    L=3.1e-6,
    Beta=1.05e-5,
    Vt=-1,
    K2=0.41,
    K5=0.8385,
    dW=-2.5e-6,
    dL=-2.1e-6) annotation (Placement(transformation(extent={{10,60},{30,80}},
          rotation=0)));
  Semiconductors.PMOS TP2(
    W=6.5e-6,
    L=3.1e-6,
    Beta=1.05e-5,
    Vt=-1,
    K2=0.41,
    K5=0.8385,
    dW=-2.5e-6,
    dL=-2.1e-6) annotation (Placement(transformation(extent={{-40,45},{-20,65}},
          rotation=0)));
  Semiconductors.NMOS TN1(
    W=6.5e-6,
    L=3.1e-6,
    Beta=4.1e-5,
    Vt=0.8,
    K2=1.144,
    K5=0.7311,
    dW=-2.5e-6,
    dL=-1.5e-6) annotation (Placement(transformation(extent={{10,15},{30,35}},
          rotation=0)));
  Semiconductors.NMOS TN2(
    W=6.5e-6,
    L=3.1e-6,
    Beta=4.1e-5,
    Vt=0.8,
    K2=1.144,
    K5=0.7311,
    dW=-2.5e-6,
    dL=-1.5e-6) annotation (Placement(transformation(extent={{10,-25},{30,-5}},
          rotation=0)));
  Basic.Capacitor C4(C=0.4e-13) annotation (Placement(transformation(
        origin={60,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Basic.Capacitor C7(C=0.4e-13) annotation (Placement(transformation(
        origin={55,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Basic.Ground Gnd annotation (Placement(transformation(extent={{40,-25},{50,
            -15}}, rotation=0)));
  Basic.Ground Gnd2 annotation (Placement(transformation(extent={{55,0},{65,10}},
          rotation=0)));
  Basic.Ground Gnd3 annotation (Placement(transformation(extent={{50,-80},{60,
            -70}}, rotation=0)));
  Basic.Ground Gnd6 annotation (Placement(transformation(extent={{-15,30},{-5,
            40}}, rotation=0)));
  Basic.Ground Gnd7 annotation (Placement(transformation(extent={{40,15},{50,25}},
          rotation=0)));
  Basic.Ground Gnd8 annotation (Placement(transformation(extent={{40,60},{50,70}},
          rotation=0)));
  Interfaces.Pin x1 annotation (Placement(transformation(extent={{-110,40},{-90,
            60}}, rotation=0)));
  Interfaces.Pin x2 annotation (Placement(transformation(extent={{-110,-60},{
            -90,-40}}, rotation=0)));
  Interfaces.Pin Vdd annotation (Placement(transformation(extent={{-10,90},{10,
            110}}, rotation=0)));
  Interfaces.Pin y annotation (Placement(transformation(extent={{90,-10},{110,
            10}}, rotation=0)));
equation
  connect(TN1.S, TN2.D) annotation (Line(points={{30,20},{30,-10}}));
  connect(TN2.B, Gnd.p) annotation (Line(points={{30,-15},{38,-15},{38,-15},{45,
          -15}}));
  connect(TN2.D, C7.p) annotation (Line(points={{30,-10},{55,-10},{55,-40}}));
  connect(TN2.S, Gnd.p) annotation (Line(points={{30,-20},{38,-20},{38,-15},{45,
          -15}}));
  connect(TP1.S, TN1.D) annotation (Line(points={{30,65},{30,30}}));
  connect(TP1.G, TN1.G) annotation (Line(points={{10,65},{10,20}}));
  connect(C4.n, Gnd2.p) annotation (Line(points={{60,20},{60,10}}));
  connect(C7.n, Gnd3.p) annotation (Line(points={{55,-60},{55,-70}}));
  connect(TP2.B, Gnd6.p) annotation (Line(points={{-20,55},{-10,55},{-10,40}}));
  connect(TN1.B, Gnd7.p) annotation (Line(points={{30,25},{45,25}}));
  connect(TP1.B, Gnd8.p) annotation (Line(points={{30,70},{45,70}}));
  connect(TP2.G, x1) annotation (Line(points={{-40,50},{-100,50}}));
  connect(TP2.G, TN2.G) annotation (Line(points={{-40,50},{-40,-20},{10,-20}}));
  connect(TN1.G, x2) annotation (Line(points={{10,20},{-70,20},{-70,-50},{-100,
          -50}}));
  connect(TP2.S, TN1.D) annotation (Line(points={{-20,50},{30,50},{30,30}}));
  connect(TN1.D, C4.p) annotation (Line(points={{30,30},{30,50},{60,50},{60,40}}));
  connect(Vdd, TP1.D) annotation (Line(points={{0,100},{0,80},{30,80},{30,75}}));
  connect(TP2.D, Vdd) annotation (Line(points={{-20,60},{-20,80},{0,80},{0,100}}));
  connect(C4.p, y) annotation (Line(points={{60,40},{60,50},{80,50},{80,0},{100,
          0}}));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Rectangle(
          extent={{-50,70},{50,-70}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{50,5},{60,-5}},
          lineColor={0,0,0},
          pattern=LinePattern.None),
        Text(
          extent={{-16,50},{14,20}},
          lineColor={0,0,0},
          textString="&"),
        Line(points={{60,0},{100,0}}, color={0,0,255}),
        Line(points={{0,70},{0,100}}, color={0,0,255}),
        Line(points={{-50,50},{-100,50}}, color={0,0,255}),
        Line(points={{-50,-50},{-100,-50}}, color={0,0,255}),
        Ellipse(extent={{50,5},{60,-5}}, lineColor={0,0,0}),
        Text(
          extent={{-100,34},{-90,24}},
          textString="x1",
          lineColor={0,0,255}),
        Text(
          extent={{-100,-65},{-90,-75}},
          textString="x2",
          lineColor={0,0,255}),
        Text(
          extent={{90,-15},{100,-25}},
          textString="y",
          lineColor={0,0,255}),
        Text(
          extent={{-151,-81},{149,-111}},
          lineColor={0,0,255},
          textString="%name")}),
    Documentation(info="<html>
<p>The nand gate is a basic CMOS building block. It consists of four CMOS transistors.</p>
<p><b>Reference:</b></p>
<p>Tietze, U.; Schenk, Ch.: Halbleiter-Schaltungstechnik. Springer-Verlag Berlin Heidelberg NewYork 1980, p. 157</p>
</html>",
   revisions="<html>
<dl>
<dt>
<b>Main Authors:</b>
<dd>
Christoph Clau&szlig;
    &lt;<a href=\"mailto:Christoph.Clauss@eas.iis.fraunhofer.de\">Christoph.Clauss@eas.iis.fraunhofer.de</a>&gt;<br>
    Andr&eacute; Schneider
    &lt;<a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden<br>
<p>
<dt>
<b>Copyright:</b>
<dd>
Copyright &copy; 1998-2010, Modelica Association and Fraunhofer-Gesellschaft.<br>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".</i><br>
<p>
</dl>
</html>"),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={Text(
          extent={{-94,93},{-44,70}},
          lineColor={0,0,255},
          textString="NAND")}));
end Nand;
