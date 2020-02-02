within Modelica.Magnetic.FundamentalWave.Examples.Components;
model EddyCurrentLosses
  "Comparison of equivalent circuits of eddy current loss models"
  extends Modelica.Icons.Example;
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Resistance R=0.1
    "Resistance of leader cables";
  parameter SI.Conductance Gc=1 "Loss conductance";
  parameter SI.Reluctance R_m=1
    "Reluctance of the magnetic circuit";
  parameter Real N=1 "Number of turns";
  output SI.Power lossPower_e=sum(loss_e.conductor.LossPower);
  output SI.Power lossPower_m=loss_m.lossPower;
  Modelica.Electrical.Analog.Basic.Ground ground_e
    annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
  Modelica.Electrical.Analog.Basic.Ground ground_m
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));
  Modelica.Electrical.Polyphase.Basic.Star star_e(m=m) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,30})));
  Modelica.Electrical.Polyphase.Basic.Star star_m(m=m) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-60})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage_e(
    m=m,
    V=fill(1, m),
    f=fill(1, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,60})));
  Modelica.Electrical.Polyphase.Sources.SineVoltage sineVoltage_m(
    m=m,
    V=fill(1, m),
    f=fill(1, m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-30})));
  Modelica.Electrical.Polyphase.Basic.Resistor resistor_e(m=m, R=fill(R,
        m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-60,70})));
  Modelica.Electrical.Polyphase.Basic.Resistor resistor_m(m=m, R=fill(R,
        m)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-60,-20})));
  Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter converter_e(
    m=m,
    effectiveTurns=fill(N, m),
    orientation=Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m))
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Magnetic.FundamentalWave.Components.PolyphaseElectroMagneticConverter converter_m(
    m=m,
    effectiveTurns=fill(N, m),
    orientation=Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m))
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Magnetic.FundamentalWave.Components.Reluctance reluctance_e(R_m(d=R_m, q=R_m))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,60})));
  Magnetic.FundamentalWave.Components.Reluctance reluctance_m(R_m(d=R_m, q=R_m))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,-30})));
  Magnetic.FundamentalWave.Components.Ground mground_e
    annotation (Placement(transformation(extent={{30,0},{50,20}})));
  Magnetic.FundamentalWave.Components.Ground mground_m
    annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
  Modelica.Electrical.Polyphase.Basic.Conductor loss_e(m=m, G=fill(Gc, m))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,60})));
  Magnetic.FundamentalWave.Components.EddyCurrent loss_m(G=m*N^2*Gc/2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={60,
            -20})));
  Modelica.Electrical.Polyphase.Sensors.PowerSensor powerb_e(m=m)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Modelica.Electrical.Polyphase.Sensors.PowerSensor powerb_m(m=m)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
initial equation
  reluctance_e.Phi = Complex(0, 0);
  reluctance_m.Phi = Complex(0, 0);
equation
  connect(sineVoltage_e.plug_n, converter_e.plug_n) annotation (Line(
      points={{-80,50},{20,50}}, color={0,0,255}));
  connect(sineVoltage_e.plug_n, star_e.plug_p) annotation (Line(
      points={{-80,50},{-80,40}}, color={0,0,255}));
  connect(sineVoltage_m.plug_n, star_m.plug_p) annotation (Line(
      points={{-80,-40},{-80,-50}}, color={0,0,255}));
  connect(star_e.pin_n, ground_e.p) annotation (Line(
      points={{-80,20},{-80,20}}, color={0,0,255}));
  connect(star_m.pin_n, ground_m.p) annotation (Line(
      points={{-80,-70},{-80,-70}}, color={0,0,255}));
  connect(sineVoltage_m.plug_n, converter_m.plug_n) annotation (Line(
      points={{-80,-40},{20,-40}}, color={0,0,255}));
  connect(converter_e.port_p, reluctance_e.port_p) annotation (Line(
      points={{40,70},{80,70}}, color={255,128,0}));
  connect(converter_e.port_n, reluctance_e.port_n) annotation (Line(
      points={{40,50},{80,50}}, color={255,128,0}));
  connect(converter_e.port_n, mground_e.port_p) annotation (Line(
      points={{40,50},{40,20}}, color={255,128,0}));
  connect(converter_m.port_n, reluctance_m.port_n) annotation (Line(
      points={{40,-40},{80,-40}}, color={255,128,0}));
  connect(converter_m.port_p, loss_m.port_p) annotation (Line(
      points={{40,-20},{50,-20}}, color={255,128,0}));
  connect(loss_m.port_n, reluctance_m.port_p) annotation (Line(
      points={{70,-20},{80,-20}}, color={255,128,0}));
  connect(converter_m.port_n, mground_m.port_p) annotation (Line(
      points={{40,-40},{40,-70}}, color={255,128,0}));
  connect(resistor_e.plug_p, sineVoltage_e.plug_p) annotation (Line(
      points={{-70,70},{-80,70}}, color={0,0,255}));
  connect(sineVoltage_m.plug_p, resistor_m.plug_p) annotation (Line(
      points={{-80,-20},{-70,-20}}, color={0,0,255}));
  connect(resistor_e.plug_n, powerb_e.pc) annotation (Line(
      points={{-50,70},{-40,70}}, color={0,0,255}));
  connect(powerb_e.pv, powerb_e.pc) annotation (Line(
      points={{-30,80},{-40,80},{-40,70}}, color={0,0,255}));
  connect(powerb_e.nc, loss_e.plug_p) annotation (Line(
      points={{-20,70},{-10,70}}, color={0,0,255}));
  connect(powerb_e.nv, sineVoltage_e.plug_n) annotation (Line(
      points={{-30,60},{-30,50},{-80,50}}, color={0,0,255}));
  connect(resistor_m.plug_n, powerb_m.pc) annotation (Line(
      points={{-50,-20},{-40,-20}}, color={0,0,255}));
  connect(powerb_m.pc, powerb_m.pv) annotation (Line(
      points={{-40,-20},{-40,-10},{-30,-10}}, color={0,0,255}));
  connect(powerb_m.nc, converter_m.plug_p) annotation (Line(
      points={{-20,-20},{20,-20}}, color={0,0,255}));
  connect(powerb_m.nv, sineVoltage_m.plug_n) annotation (Line(
      points={{-30,-30},{-30,-40},{-80,-40}}, color={0,0,255}));
  connect(loss_e.plug_n, sineVoltage_e.plug_n) annotation (Line(
      points={{-10,50},{-80,50}}, color={0,0,255}));
  connect(loss_e.plug_p, converter_e.plug_p) annotation (Line(
      points={{-10,70},{20,70}}, color={0,0,255}));
  annotation (experiment(StopTime=40, Interval=0.01), Documentation(info="<html>
<p>
In this example the eddy current losses are implemented in two different ways. Compare the loss dissipation <code>powerb_e.power</code> and <code>powerb_m.power</code> of the two models indicated by power meters.</p>
</html>"));
end EddyCurrentLosses;
