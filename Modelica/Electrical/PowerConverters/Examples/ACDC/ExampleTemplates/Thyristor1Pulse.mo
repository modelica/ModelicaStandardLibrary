within Modelica.Electrical.PowerConverters.Examples.ACDC.ExampleTemplates;
partial model Thyristor1Pulse "Template of single pulse rectifier"
  extends Icons.ExampleTemplate;
  import Modelica.Constants.pi;
  parameter SI.Voltage Vrms=110 "RMS supply voltage";
  parameter SI.Frequency f=50 "Frequency";

  Modelica.Electrical.Analog.Sensors.VoltageSensor voltagesensor
    annotation (Placement(transformation(
        origin={50,10},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Sources.SineVoltage sinevoltage(V=sqrt(2)*
        Vrms, f=f) annotation (Placement(transformation(
        origin={-80,0},
        extent={{-10,-10},{10,10}},
        rotation=-90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(
        origin={-80,-50},
        extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,-40})));
  Modelica.Blocks.Math.Mean meanVoltage(f=f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={80,40})));
  Modelica.Blocks.Math.RootMeanSquare rootMeanSquareVoltage(f=f)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={80,10})));
  Modelica.Blocks.Math.Mean meanCurrent(f=f) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={80,-60})));
  PowerConverters.ACDC.Control.VoltageBridge2Pulse pulse2(f=f, useFilter=false)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-40,
            0})));
  Modelica.Electrical.Analog.Ideal.IdealThyristor idealthyristor(off(
        fixed=true)) annotation (Placement(transformation(
        origin={-10,40},
        extent={{-10,10},{10,-10}})));
equation
  connect(meanCurrent.u, currentSensor.i) annotation (Line(
      points={{68,-60},{0,-60},{0,-51}}, color={0,0,127}));
  connect(ground.p, sinevoltage.n) annotation (Line(
      points={{-80,-40},{-80,-10}}, color={0,0,255}));
  connect(voltagesensor.v, meanVoltage.u) annotation (Line(
      points={{61,10},{64,10},{64,40},{68,40}}, color={0,0,127}));
  connect(voltagesensor.v, rootMeanSquareVoltage.u) annotation (Line(
      points={{61,10},{68,10}}, color={0,0,127}));
  connect(sinevoltage.p, idealthyristor.p) annotation (Line(
      points={{-80,10},{-80,40},{-20,40}}, color={0,0,255}));
  connect(ground.p, currentSensor.n) annotation (Line(
      points={{-80,-40},{-10,-40}}, color={0,0,255}));
  connect(pulse2.fire_p, idealthyristor.fire) annotation (Line(
      points={{-46,11},{-46,20},{0,20},{0,28}},   color={255,0,255}));
  connect(voltagesensor.n, currentSensor.p) annotation (Line(
      points={{50,0},{50,-40},{10,-40}}, color={0,0,255}));
  connect(idealthyristor.n, voltagesensor.p) annotation (Line(
      points={{0,40},{50,40},{50,20}}, color={0,0,255}));
  connect(sinevoltage.p, pulse2.ac_p) annotation (Line(
      points={{-80,10},{-80,10},{-80,20},{-60,20},{-60,6},{-50,6}}, color={0,0,255}));
  connect(sinevoltage.n, pulse2.ac_n) annotation (Line(
      points={{-80,-10},{-80,-10},{-80,-20},{-60,-20},{-60,-6},{-50,-6}}, color={0,0,255}));
  annotation (
    Documentation(info="<html>
<p>Template of
<a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.ACDC.Rectifier1Pulse\">
single pulse rectifiers</a>; load is not yet included.</p>
</html>"));
end Thyristor1Pulse;
