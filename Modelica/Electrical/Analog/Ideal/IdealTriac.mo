within Modelica.Electrical.Analog.Ideal;
model IdealTriac "Ideal triac, based on ideal thyristors"

  parameter SI.Resistance Ron(final min=0) = 1e-5 "Closed triac resistance";
  parameter SI.Conductance Goff(final min=0) = 1e-5
    "Opened triac conductance";
  parameter SI.Voltage Vknee(
    final min=0,
    start=0) = 0.8 "Threshold voltage for positive and negative phase";

  parameter SI.Resistance Rdis=100 "Resistance of disturbance elimination";
  parameter SI.Capacitance Cdis=0.005 "Capacity of disturbance elimination";

  Modelica.Electrical.Analog.Ideal.IdealThyristor idealThyristor(
    Ron=Ron,
    Goff=Goff,
    Vknee=Vknee) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-10,32})));
  Modelica.Electrical.Analog.Ideal.IdealThyristor idealThyristor1(
    Ron=Ron,
    Goff=Goff,
    Vknee=Vknee) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-10,-32})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=Rdis)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C=Cdis)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Interfaces.BooleanInput fire1 "Gate"
    annotation (Placement(transformation(extent={{-14,-14},{14,14}},
        rotation=90,
        origin={-100,-114}), iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=90,
        origin={-100,-114})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n "Cathode"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p "Anode"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation

  connect(idealThyristor.n, capacitor.n) annotation (Line(
      points={{0,32},{40,32},{40,0}}, color={0,0,255}));
  connect(capacitor.n, idealThyristor1.p) annotation (Line(
      points={{40,0},{40,-32},{0,-32}}, color={0,0,255}));
  connect(idealThyristor1.n, resistor.p) annotation (Line(
      points={{-20,-32},{-60,-32},{-60,0}}, color={0,0,255}));
  connect(resistor.p, idealThyristor.p) annotation (Line(
      points={{-60,0},{-60,32},{-20,32}}, color={0,0,255}));
  connect(resistor.n, capacitor.p) annotation (Line(
      points={{-40,0},{20,0}}, color={0,0,255}));
  connect(idealThyristor1.fire, fire1) annotation (Line(
      points={{-20,-44},{-20,-100},{-100,-100},{-100,-114},{-100,-114}}, color={255,0,255}));
  connect(idealThyristor.fire, fire1) annotation (Line(
      points={{0,44},{0,60},{-80,60},{-80,-100},{-100,-100},{-100,-114},{-100,-114}}, color={255,0,255}));
  connect(n, idealThyristor.p) annotation (Line(
      points={{-100,0},{-90,0},{-90,40},{-20,40},{-20,32}}, color={0,0,255}));
  connect(idealThyristor1.p, p) annotation (Line(
      points={{0,-32},{0,-40},{80,-40},{80,0},{100,0}}, color={0,0,255}));
  annotation (defaultComponentName="triac",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Text(
          extent={{-150,130},{150,90}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          points={{-100,-100},{-100,-80}},
          color={255,0,255},
          pattern=LinePattern.Dash),
        Line(points={{-40,-70},{-40,70}}, color={0,0,255}),
        Line(points={{40,-72},{40,70}}, color={0,0,255}),
        Polygon(points={{-40,-70},{40,-30},{-40,10},{-40,-70}},
                                                             lineColor={0,0,
              255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(points={{40,-10},{-40,30},{40,70},{40,-10}}, lineColor={0,0,
              255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-40,0},{-90,0}}, color={0,0,255}),
        Line(points={{100,0},{40,0}},color={0,0,255}),
        Line(points={{-100,-100},{-100,-60},{-40,-30}},
                                                    color={255,0,255})}),
                                  Documentation(info="<html>
<p>This is an ideal triac model based on an ideal thyristor model.</p>

<p>Two ideal thyristors (Modelica.Electrical.Analog.Ideal.IdealThyristor) are contrarily connected in parallel and additionally eliminated interference with a resistor (Rdis=100) and a capacitor (Cdis=0.005), which are connected in series.</p>

<p>The electrical component triac (TRIode Alternating Current switch) is, due to whose complex structure, a multifunctional applicable construction unit. The application area of this element is the manipulation of alternating current signals in frequency, voltage and/or current and also general blocking or filtering. However, compared to a thyristor the triac is only applied for substantial lesser currents, what is justified by whose sensitive structure. Generally one is limited to maximal voltages from 800 volt and currents from 40 ampere. For comparison maximal voltages of a thyristor are 8.000 volt and currents 5.000 ampere.</p>

<p>Structure and functionality:</p>

<p>Functionality of a triac is in principle the same like functionality of a thyristor, even connecting through of current starting from a certain voltage (knee voltage), but only if the current at anode and cathode is caused by a impulse current in the gate electrode. In case of the triac this process is also possible with reverse polarity, wherefore it is possible to control both half-waves of alternating currents. By means of gate electrodes, which are connected in a triac and why only one gate electrode is necessary, the point of time can be determined, at which the triac lets the alternating current signal pass. Thereby it is possible to affect the phase, at which the alternating current signal is cut. One speaks also of phase-angle control. Also depending on doping and specific structure knee voltage and maximal current carrying are alterable.</p>

<p>Characteristics:</p>
<ul>
<li>high switching times between on-state and off state up to activation of the reverse current phase</li>
<li>gate electrode are activated with (positive) impulse (called thyristor/triac firing), after firing thyristor path holds itself in state of low resistance or conductive state up to holding voltage is fallen below, it follows change to off state and next thyristor path can fire</li>
<li>in particular by switching of inductive components triacs generate harmonic waves, whose frequency ranges into broadcast sector and could there cause transmission disturbances; therefore triacs have to eliminate interference by inductors and capacitors</li>
</ul>
<p>Applications:</p>
<ul>
<li>any stepless exposure (dimmer)</li>
<li>engine speed adjustment of electric motors</li>
<li>further applications of phase-angle control (power electronics)</li>
<li>power packs</li>
</ul>
<p>As an additional information: this model is based on the Modelica.Electrical.Analog.Ideal.IdealThyristor.</p>
</html>",
        revisions="<html>
<ul>
<li><em>November 25, 2009   </em><br>

       by Susann Wolf<br><br>
       </li>
</ul>
</html>"));
end IdealTriac;
