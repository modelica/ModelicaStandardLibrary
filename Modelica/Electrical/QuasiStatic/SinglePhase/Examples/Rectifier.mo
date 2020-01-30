within Modelica.Electrical.QuasiStatic.SinglePhase.Examples;
model Rectifier "Rectifier example"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter SI.Voltage VAC=100 "AC rms voltage";
  parameter Real conversionFactor=1 "Ratio of DC voltage / AC rms voltage";
  output SI.Current Itr=iAC.y_rms "Transient current";
  output SI.Current Iqs=iQS.len "QS current";
  Sources.VoltageSource voltageQS(
    f=50,
    V=VAC,
    phi=0,
    i(re(start=0), im(start=0)),
    gamma(fixed=true, start=0)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,50})));
  Basic.Resistor resistorQS(R_ref=50E-3)
    annotation (Placement(transformation(extent={{-72,50},{-52,70}})));
  Sensors.CurrentSensor currentSensorQS
    annotation (Placement(transformation(extent={{-40,70},{-20,50}})));
  Modelica.ComplexBlocks.ComplexMath.ComplexToPolar iQS
    annotation (Placement(transformation(extent={{-20,70},{0,90}})));
  Basic.Ground groundQS
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Utilities.IdealACDCConverter rectifierQS(conversionFactor=
        conversionFactor)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Electrical.Analog.Basic.Ground groundDC1
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor iDC1
    annotation (Placement(transformation(extent={{20,70},{40,50}})));
  Modelica.Electrical.Analog.Basic.VariableConductor load1 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,50})));
  Modelica.Electrical.Analog.Sources.SineVoltage voltageAC(
    V=sqrt(2)*VAC,
    f=50,
    phase=pi/2) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-80,-50})));
  Modelica.Electrical.Analog.Basic.Resistor resistorAC(R=50E-3)
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensorAC
    annotation (Placement(transformation(extent={{-40,-30},{-20,-50}})));
  Modelica.Blocks.Math.Harmonic iAC(f=50, k=1)
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Modelica.Electrical.Analog.Basic.Ground groundAC
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
  Utilities.GraetzRectifier rectifierAC
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensorDC2
    annotation (Placement(transformation(extent={{20,-30},{40,-50}})));
  Modelica.Blocks.Math.RootMeanSquare iDC2(f=50)
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  Modelica.Electrical.Analog.Basic.VariableConductor load2 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,-50})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=1,
    duration=0.8,
    startTime=0.1)
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
equation
  connect(voltageQS.pin_p, resistorQS.pin_p) annotation (Line(
      points={{-80,60},{-72,60}}, color={85,170,255}));
  connect(voltageQS.pin_n, rectifierQS.pin_nQS) annotation (Line(
      points={{-80,40},{-10,40}}, color={85,170,255}));
  connect(rectifierQS.pin_nQS, groundQS.pin) annotation (Line(
      points={{-10,40},{-10,30}}, color={85,170,255}));
  connect(rectifierQS.pin_nDC, groundDC1.p) annotation (Line(
      points={{10,40},{10,30}}, color={0,0,255}));
  connect(load1.n, rectifierQS.pin_nDC) annotation (Line(
      points={{50,40},{10,40}}, color={0,0,255}));
  connect(voltageAC.p, resistorAC.p) annotation (Line(
      points={{-80,-40},{-70,-40}}, color={0,0,255}));
  connect(voltageAC.n, rectifierAC.pin_nAC) annotation (Line(
      points={{-80,-60},{-10,-60}}, color={0,0,255}));
  connect(rectifierAC.pin_nAC, groundAC.p) annotation (Line(
      points={{-10,-60},{-10,-70}}, color={0,0,255}));
  connect(rectifierAC.pin_nDC, load2.n) annotation (Line(
      points={{10,-60},{50,-60}}, color={0,0,255}));
  connect(ramp.y, load1.G) annotation (Line(
      points={{79,0},{70,0},{70,50},{62,50}}, color={0,0,127}));
  connect(ramp.y, load2.G) annotation (Line(
      points={{79,0},{70,0},{70,-50},{62,-50}}, color={0,0,127}));
  connect(resistorQS.pin_n, currentSensorQS.pin_p) annotation (Line(
      points={{-52,60},{-40,60}}, color={85,170,255}));
  connect(currentSensorQS.pin_n, rectifierQS.pin_pQS) annotation (Line(
      points={{-20,60},{-10,60}}, color={85,170,255}));
  connect(currentSensorQS.i, iQS.u) annotation (Line(
      points={{-30,71},{-30,80},{-22,80}}, color={85,170,255}));
  connect(rectifierQS.pin_pDC, iDC1.p) annotation (Line(
      points={{10,60},{20,60}}, color={0,0,255}));
  connect(iDC1.n, load1.p) annotation (Line(
      points={{40,60},{50,60}}, color={0,0,255}));
  connect(resistorAC.n, currentSensorAC.p) annotation (Line(
      points={{-50,-40},{-40,-40}}, color={0,0,255}));
  connect(currentSensorAC.n, rectifierAC.pin_pAC) annotation (Line(
      points={{-20,-40},{-10,-40}}, color={0,0,255}));
  connect(currentSensorAC.i, iAC.u) annotation (Line(
      points={{-30,-29},{-30,-20},{-22,-20}}, color={0,0,127}));
  connect(currentSensorDC2.i, iDC2.u) annotation (Line(
      points={{30,-29},{30,-20},{38,-20}}, color={0,0,127}));
  connect(currentSensorDC2.p, rectifierAC.pin_pDC) annotation (Line(
      points={{20,-40},{10,-40}}, color={0,0,255}));
  connect(currentSensorDC2.n, load2.p) annotation (Line(
      points={{40,-40},{50,-40}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>
This example demonstrates coupling a quasi-static circuit with a DC circuit.
The QS voltage is rectified (using an
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Utilities.IdealACDCConverter\">
ideal AC DC converter</a>), loaded by a variable load conductor.
The <em>conversionFactor = DC voltage / AC rms voltage</em> in this case is the root mean square of a rectified sine, i.e., 1.
You may compare the quasi-static results with that of a fully transient model (using a
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Utilities.GraetzRectifier\">
Graetz rectifier</a>), plotting:
</p>
<ul>
<li>QS: AC rms           current = iQS.len</li>
<li>AC: AC instantaneous current = iAC.u</li>
<li>AC: AC rms           current = iAC.y_rms</li>
<li>QS: DC current               = iDC1.i</li>
<li>AC: DC instantaneous current = iDC2.u</li>
<li>AC: DC rms           current = iDC2.y</li>
</ul>
<p>
It can be seen that at the DC side the current is represented by its averaged value, at the AC side by its rms value.
</p>
<h4>Note</h4>
<p>
The quasi-static model needs a grounding at the QS side as well as the DC side,
whereas the transient model may have only one ground since AC side and DC side are connected via the diodes.
</p>
</html>"),
       experiment(StopTime=1.0, Interval=0.0001));
end Rectifier;
