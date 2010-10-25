within Modelica.Electrical.Analog.Examples;
model ThyristorBehaviourTest "Thyristor demonstration example"
  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{18,-40},{38,-20}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(          V=30, freqHz=
        10000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-72,4})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=10)  annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={8,20})));
  Modelica.Electrical.Analog.Sources.PulseCurrent pulseCurrent(
    width=10,
    period=0.0001,
    startTime=0.00002,
    I=0.005)       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-8,70})));
  Modelica.Electrical.Analog.Semiconductors.Thyristor thyristor_v4_1
    annotation (Placement(transformation(extent={{-44,30},{-24,50}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(L=2e-6) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={8,-4})));
equation
  connect(sineVoltage.n, ground.p) annotation (Line(
      points={{-72,-6},{-72,-20},{28,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sineVoltage.p, thyristor_v4_1.Anode) annotation (Line(
      points={{-72,14},{-72,40},{-43,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(resistor.p, thyristor_v4_1.Cathode) annotation (Line(
      points={{8,30},{8,40},{-25,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pulseCurrent.n, thyristor_v4_1.Gate) annotation (Line(
      points={{-18,70},{-26,70},{-26,49},{-27,49}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(resistor.p, pulseCurrent.p) annotation (Line(
      points={{8,30},{8,70},{2,70}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(resistor.n, inductor.p) annotation (Line(
      points={{8,10},{8,8},{8,6},{8,6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inductor.n, ground.p) annotation (Line(
      points={{8,-14},{8,-20},{28,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics),
    experiment(StopTime=0.0002),
    Documentation(info="<html>
<p>This is a simple testcircuit, to test the behavior of the thysistor model.</p><p>Interesting values to plot are Cathode.v, Gate.v and sineVoltage.p.v. and in another plot window pulseCurrent.p.i</p><p>The simulation time should be trom 0 seconds to 2e-4 seconds.</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end ThyristorBehaviourTest;
