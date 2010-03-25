within Modelica.Electrical.Analog.Examples;
model IdealTriacCircuit "Ideal triac test circuit"
  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-12,-40},{8,-20}})));
  Modelica.Electrical.Analog.Basic.Resistor R(R=20)         annotation (
      Placement(transformation(
        extent={{-10,-10},{12,12}},
        rotation=0,
        origin={-44,32})));
  Modelica.Electrical.Analog.Sources.SineVoltage V(V=5, freqHz=2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-42,-20})));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(width=50,
    period=0.25,
    startTime=0.1)
    annotation (Placement(transformation(extent={{-22,0},{-6,16}})));
 Modelica.Electrical.Analog.Ideal.IdealTriac idealTriac
    annotation (Placement(transformation(extent={{6,20},{32,46}})));
equation
  connect(V.n, ground.p)            annotation (Line(
      points={{-32,-20},{-2,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(R.p, V.p)                   annotation (Line(
      points={{-54,33},{-60,33},{-60,-20},{-52,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(R.n, idealTriac.n)                      annotation (Line(
      points={{-32,33},{6,33}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(idealTriac.p, ground.p)               annotation (Line(
      points={{32.52,33},{42,33},{42,-20},{-2,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(idealTriac.fire1, booleanPulse.y)               annotation (Line(
      points={{11.2,21.04},{0,21.04},{0,8},{-5.2,8}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics),
    experiment(StopTime=2),
    experimentSetupOutput,
    Documentation(revisions="<html>
<ul>
<li><i>November 25, 2009   </i> <br>

       by Susann Wolf <br><br>
       </li>
</ul>
</html>", info="<html>
<p>The simple ideal TRIAC example shows how a triac is used within an alternating current circuit.</p>
<p>The TRIAC is not conductiong until the Boolean input becomes true (internally coded by 1, therefore the input is called fire<b>1</b>). Then it becomes &QUOT;conducting&QUOT;, the knee voltage is reached. If the TRIAC voltage falls below the knee voltage, the TRIAC becomes blocking. Due to the antiparallel connection of the internal two thyristors the same behavior is repeated in the negative half-wave.</p>
<p>Simulate until 2 seconds. Display V.p.v (input voltage), booleanPulse.y (fire1 input), and both idealTriac.n.v and idealTriac.n.i, which demonstrate the TRIAC behavior.</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end IdealTriacCircuit;
