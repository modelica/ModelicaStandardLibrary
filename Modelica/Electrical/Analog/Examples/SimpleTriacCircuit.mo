within Modelica.Electrical.Analog.Examples;
model SimpleTriacCircuit "Simple triac test circuit"
  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
  Modelica.Electrical.Analog.Basic.Inductor L(L=2e-6)
    annotation (Placement(transformation(extent={{10,60},{30,80}})));
  Modelica.Electrical.Analog.Basic.Resistor R(R=10)         annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,48})));
  Modelica.Electrical.Analog.Sources.SineVoltage V(V=30, freqHz=10000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,2})));
  Modelica.Electrical.Analog.Semiconductors.SimpleTriac simpleTriac(VDRM=400, VRRM=400)
                          annotation (Placement(transformation(
        extent={{-13,-13},{11,11}},
        rotation=270,
        origin={-19,43})));
  Modelica.Electrical.Analog.Sources.PulseCurrent pulseCurrent(
    I=0.005,
    width=10,
    startTime=0.00002,
    period=0.00005)
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-66,28})));
equation
  connect(L.n, R.p)               annotation (Line(
      points={{30,70},{40,70},{40,58}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(R.n, V.p)                  annotation (Line(
      points={{40,38},{40,12}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(V.n, ground.p)           annotation (Line(
      points={{40,-8},{40,-20},{-20,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(simpleTriac.p, ground.p) annotation (Line(
      points={{-20,31.52},{-20,5.76},{-20,5.76},{-20,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(simpleTriac.n, L.p)        annotation (Line(
      points={{-20,56},{-20,70},{10,70}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pulseCurrent.n, simpleTriac.g) annotation (Line(
      points={{-66,38},{-58,38},{-58,51.44},{-31.52,51.44}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pulseCurrent.p, ground.p) annotation (Line(
      points={{-66,18},{-66,-20},{-20,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics),
    experiment(
      StopTime=0.001,
      NumberOfIntervals=2000,
      Tolerance=1e-012),
    experimentSetupOutput,
    Documentation(revisions="<html>
<ul>
<li><i>November 25, 2009   </i> <br>

       by Susann Wolf <br><br>
       </li>
</ul>
</html>", info="<html>
<p>The simple TRIAC example shows how the SimpleTriac is used within an alternating current circuit.</p>
<p>The TRIAC is not conductiong until the Gate input g becomes positive. Then it becomes &QUOT;conducting&QUOT;. If the TRIAC voltage changes its direction, the TRIAC becomes blocking. Due to the antiparallel connection of the internal two thyristors the same behavior is repeated in the negative half-wave.</p>
<p>Simulate until 0.001 seconds. Display V.p.v (input voltage), simpleTriac.g.i  (gate input), and both simplelTriac.n.v and simpleTriac.n.i, which demonstrate the TRIAC behavior.</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end SimpleTriacCircuit;
