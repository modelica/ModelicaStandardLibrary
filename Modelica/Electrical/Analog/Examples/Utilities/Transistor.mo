within Modelica.Electrical.Analog.Examples.Utilities;
model Transistor "Transistor with resistance an capacitance"

  Basic.Resistor rtb(R=0.05) annotation (Placement(transformation(extent={{-80,
            -10},{-60,10}}, rotation=0)));
  Basic.Resistor rtc(R=0.1) annotation (Placement(transformation(extent={{40,0},
            {60,20}}, rotation=0)));
  Basic.Capacitor ct(C=1e-10) annotation (Placement(transformation(
        origin={-40,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Semiconductors.NPN Tr(
    Bf=50,
    Br=0.1,
    Is=1e-16,
    Vak=0.02,
    Tauf=0.12e-9,
    Taur=5e-9,
    Ccs=1e-12,
    Cje=0.4e-12,
    Cjc=0.5e-12,
    Phie=0.8,
    Me=0.4,
    Phic=0.8,
    Mc=0.333,
    Gbc=1e-15,
    Gbe=1e-15,
    Vt=0.02585) annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          rotation=0)));
  Basic.Ground Ground1 annotation (Placement(transformation(extent={{-50,-80},{
            -30,-60}}, rotation=0)));
  Interfaces.Pin c annotation (Placement(transformation(extent={{90,50},{110,70}},
          rotation=0)));
  Interfaces.Pin b annotation (Placement(transformation(extent={{-110,-10},{-90,
            10}}, rotation=0)));
  Interfaces.Pin e annotation (Placement(transformation(extent={{90,-70},{110,
            -50}}, rotation=0)));
equation
  connect(rtb.n, Tr.B) annotation (Line(points={{-60,0},{-20,0}}));
  connect(rtb.n, ct.p) annotation (Line(points={{-60,0},{-40,0},{-40,-20}}));
  connect(ct.n, Ground1.p) annotation (Line(points={{-40,-40},{-40,-60}}));
  connect(Tr.C, rtc.p) annotation (Line(points={{20,10},{40,10}}));
  connect(rtc.n, c) annotation (Line(points={{60,10},{80,10},{80,60},{100,60}}));
  connect(b, rtb.p) annotation (Line(points={{-100,0},{-80,0}}));
  connect(Tr.E, e) annotation (Line(points={{20,-10},{80,-10},{80,-60},{100,-60}}));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{80,60},{100,60}}, color={0,0,255}),
        Line(points={{80,-60},{100,-60}}, color={0,0,255}),
        Line(points={{-100,0},{-80,0}}, color={0,0,255}),
        Line(points={{-60,0},{-10,0}}, color={0,0,255}),
        Line(points={{-10,40},{-10,-40}}, color={0,0,255}),
        Line(points={{60,60},{40,60},{-10,10}}, color={0,0,255}),
        Line(points={{-10,-10},{40,-60},{60,-60}}, color={0,0,255}),
        Text(
          extent={{-150,120},{150,90}},
          lineColor={0,0,255},
          textString="%name")}),
    Documentation(info="<html>
<p>Since the simple bipolar transistor model does not have base or collector resistances both are added in this component. Additionally, a capacity is added to the base pin. See the schematic for more detailes.  In such a way the transistor model can be enhanced to become more common.</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Text(
          extent={{-76,82},{-2,54}},
          lineColor={0,0,255},
          textString="Transistor")}));
end Transistor;
