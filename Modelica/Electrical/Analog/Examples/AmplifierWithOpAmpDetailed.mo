within Modelica.Electrical.Analog.Examples;
model AmplifierWithOpAmpDetailed
  "Simple Amplifier circuit which uses OpAmpDetailed"
  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Basic.OpAmpDetailed opAmp
    annotation (Placement(transformation(extent={{-26,-4},{2,24}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=10000)
    annotation (Placement(transformation(extent={{-74,8},{-56,26}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor1(R=20000)
    annotation (Placement(transformation(extent={{-22,46},{-4,64}})));
  Modelica.Electrical.Analog.Basic.Resistor resistor2(R=10000) annotation (
      Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=270,
        origin={21,-23})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V=12, freqHz=1000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-30})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=15)
    annotation (Placement(transformation(extent={{48,10},{68,30}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage1(V=-15)
    annotation (Placement(transformation(extent={{48,-10},{68,10}})));
initial equation
  resistor2.i = 0;
  opAmp.q_fp1 = 0;
  opAmp.q_fr1 = 0;
  opAmp.q_fr2 = 0;
  opAmp.q_fr3 = 0;

equation
  connect(resistor.n, opAmp.m) annotation (Line(
      points={{-56,17},{-34,17},{-34,17.07},{-26.07,17.07}}, color={0,0,255}));
  connect(resistor1.n, resistor2.p) annotation (Line(
      points={{-4,55},{21,55},{21,-14}}, color={0,0,255}));
  connect(resistor.p, sineVoltage.p) annotation (Line(
      points={{-74,17},{-80,17},{-80,-20}}, color={0,0,255}));
  connect(resistor1.p, opAmp.m) annotation (Line(
      points={{-22,55},{-26.07,55},{-26.07,17.07}}, color={0,0,255}));
  connect(sineVoltage.n, ground.p) annotation (Line(
      points={{-80,-40},{-10,-40},{-10,-50}}, color={0,0,255}));
  connect(opAmp.p, ground.p) annotation (Line(
      points={{-26.07,2.93},{-26.07,-20},{-10,-20},{-10,-50}}, color={0,0,255}));
  connect(resistor2.n, ground.p) annotation (Line(
      points={{21,-32},{21,-40},{-10,-40},{-10,-50}}, color={0,0,255}));
  connect(opAmp.p_supply, constantVoltage.p) annotation (Line(
      points={{-11.93,20.29},{18.035,20.29},{18.035,20},{48,20}}, color={0,0,255}));
  connect(opAmp.m_supply, constantVoltage1.p) annotation (Line(
      points={{-12,-0.36},{18,-0.36},{18,0},{48,0}}, color={0,0,255}));
  connect(constantVoltage.n, constantVoltage1.n) annotation (Line(
      points={{68,20},{80,20},{80,0},{68,0}}, color={0,0,255}));
  connect(constantVoltage1.n, ground.p) annotation (Line(
      points={{68,0},{80,0},{80,-40},{-10,-40},{-10,-50}}, color={0,0,255}));
  connect(opAmp.outp, resistor2.p) annotation (Line(
      points={{2,10},{21,10},{21,-14}}, color={0,0,255}));

  annotation (
    experiment(
      StopTime=0.003,
      Interval=1.2e-6,
      Tolerance=2e-007),
    Documentation(revisions="<html>
<dl>
<dt>June 17, 2009</dt>
<dd>by Susann Wolf realized</dd>
</dl>
</html>", info="<html>
<p>With the test circuit AmplifierWithOpAmpDetailed a time domain analysis of the example arrangement with a sinusoidal input voltage (12 V amplitude, frequency 1 kHz) using the operational amplifier model OpAmpDetailed is carried out. The working voltages are 15 V and -15 V.</p>
</html>"));
end AmplifierWithOpAmpDetailed;
