within Modelica.Electrical.PowerConverters.Examples.DCDC.ExampleTemplates;
partial model ChopperBuckBoost "Buck/boost converter example template"
  extends Modelica.Electrical.PowerConverters.Icons.ExampleTemplate;
  parameter Modelica.Units.SI.Voltage VLV=12 "LV voltage";
  parameter Modelica.Units.SI.Resistance RiLV=0.01 "LV inner resistance";
  parameter Modelica.Units.SI.Voltage VHV=24 "HV voltage";
  parameter Modelica.Units.SI.Resistance RiHV=0.01 "HV inner resistance";
  parameter Modelica.Units.SI.Capacitance CLV=500e-6 "Low voltage capacitance";
  parameter Modelica.Units.SI.Capacitance CHV=250e-6 "High voltage capacitance";
  parameter Modelica.Units.SI.Inductance L=10e-6 "Inductance";
  parameter Modelica.Units.SI.Resistance R=1e-3 "Resistance of inductor";
  parameter Modelica.Units.SI.Frequency fS=40e3 "Switching frequency";
  parameter Real idleDutyCycle=1 - VLV/VHV "Duty cycle for idle operation";
  Modelica.Electrical.PowerConverters.DCDC.ChopperBuckBost dcdc
    annotation (Placement(transformation(extent={{10,-8},{30,12}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltageLV(V=VLV)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-90,0})));
  Modelica.Electrical.Analog.Basic.Resistor resistorLV(R=RiLV)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitorLV(v(fixed=true, start=VLV), C=CLV)
    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,0})));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R, useHeatPort=false)
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(i(fixed=true),  L=L)
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitorHV(v(fixed=true, start=VHV), C=CHV)
    annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={50,0})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltageHV(V=VHV)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,0})));
  Modelica.Electrical.Analog.Basic.Resistor resistorHV(R=RiHV)
    annotation (Placement(transformation(extent={{80,10},{60,30}})));
  Modelica.Blocks.Sources.RealExpression vLV(y=capacitorLV.v)
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Modelica.Blocks.Sources.RealExpression iLV(y=resistorLV.i)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Sources.RealExpression vHV(y=capacitorHV.v)
    annotation (Placement(transformation(extent={{80,70},{60,90}})));
  Modelica.Blocks.Sources.RealExpression iHV(y=resistorHV.i)
    annotation (Placement(transformation(extent={{80,40},{60,60}})));
  Modelica.Blocks.Math.Mean mean_vLV(f=fS)
    annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
  Modelica.Blocks.Math.Mean mean_iLV(f=fS)
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Modelica.Blocks.Math.Mean mean_vHV(f=fS)
    annotation (Placement(transformation(extent={{50,70},{30,90}})));
  Modelica.Blocks.Math.Mean mean_iHV(f=fS)
    annotation (Placement(transformation(extent={{50,40},{30,60}})));
  Modelica.Electrical.PowerConverters.DCDC.Control.SignalPWM pwm(f=fS) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={20,-40})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(extent={{-60,-30},{-80,-10}})));
equation
  connect(constantVoltageLV.p, resistorLV.p)
    annotation (Line(points={{-90,10},{-90,20},{-80,20}}, color={0,0,255}));
  connect(constantVoltageLV.n, ground.p)
    annotation (Line(points={{-90,-10},{-90,-20}},           color={0,0,255}));
  connect(resistorHV.p, constantVoltageHV.p)
    annotation (Line(points={{80,20},{90,20},{90,10}}, color={0,0,255}));
  connect(vLV.y, mean_vLV.u)
    annotation (Line(points={{-59,80},{-52,80}}, color={0,0,127}));
  connect(iLV.y,mean_iLV. u)
    annotation (Line(points={{-59,50},{-52,50}}, color={0,0,127}));
  connect(mean_iHV.u, iHV.y)
    annotation (Line(points={{52,50},{59,50}}, color={0,0,127}));
  connect(vHV.y, mean_vHV.u)
    annotation (Line(points={{59,80},{52,80}}, color={0,0,127}));
  connect(capacitorHV.n, dcdc.dc_n2) annotation (Line(points={{50,-10},{50,-20},
          {40,-20},{40,-4},{30,-4}}, color={0,0,255}));
  connect(dcdc.dc_p2, resistorHV.n)
    annotation (Line(points={{30,8},{40,8},{40,20},{60,20}}, color={0,0,255}));
  connect(capacitorHV.p, resistorHV.n)
    annotation (Line(points={{50,10},{50,20},{60,20}},
                                               color={0,0,255}));
  connect(capacitorHV.n, constantVoltageHV.n) annotation (Line(points={{50,-10},
          {50,-20},{90,-20},{90,-10}}, color={0,0,255}));
  connect(resistorLV.n, resistor.p)
    annotation (Line(points={{-60,20},{-50,20}}, color={0,0,255}));
  connect(resistor.n, inductor.p)
    annotation (Line(points={{-30,20},{-20,20}}, color={0,0,255}));
  connect(dcdc.dc_p1, inductor.n)
    annotation (Line(points={{10,8},{0,8},{0,20}},          color={0,0,255}));
  connect(dcdc.fire_p, pwm.fire)
    annotation (Line(points={{14,-10},{14,-29}}, color={255,0,255}));
  connect(dcdc.fire_n, pwm.notFire)
    annotation (Line(points={{26,-10},{26,-29}}, color={255,0,255}));
  connect(resistor.p, capacitorLV.p)
    annotation (Line(points={{-50,20},{-50,10}}, color={0,0,255}));
  connect(ground.p, currentSensor.n)
    annotation (Line(points={{-90,-20},{-80,-20}}, color={0,0,255}));
  connect(currentSensor.p, capacitorLV.n)
    annotation (Line(points={{-60,-20},{-50,-20},{-50,-10}}, color={0,0,255}));
  connect(capacitorLV.n, dcdc.dc_n1) annotation (Line(points={{-50,-10},{-50,-20},
          {0,-20},{0,-4},{10,-4}},   color={0,0,255}));
  annotation (experiment(
      StopTime=1,
      Interval=1e-05,
      Tolerance=1e-06), Documentation(info="<html>
<p>
Buck/boost chopper example template including both voltage sources; control not included.
</p>
</html>"));
end ChopperBuckBoost;
