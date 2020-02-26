within Modelica.Electrical.PowerConverters.Examples.DCDC.ExampleTemplates;
partial model ChopperStepUp "Step up chopper including control"
  extends Icons.ExampleTemplate;
  parameter SI.Frequency f=1000 "Switching frequency";
  parameter SI.Voltage Vsource=60 "Source voltage";
  parameter SI.Inductance L=25e-3 "Source inductance";
  parameter SI.Capacitance C=20e-6 "Smoothing capacitance";
  parameter Real dutyCycle=0.20 "Duty cycle";
  parameter SI.Current ILoad=1.2 "Load current";
  parameter SI.Resistance RLoad=V0/ILoad "Load resistance";
  parameter SI.Voltage V0=Vsource/(1 - dutyCycle) "No-load output voltage";
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=Vsource)
             annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-80,0})));
  PowerConverters.DCDC.ChopperStepUp chopperStepUp
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(extent={{30,-20},{10,0}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={60,10})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
        transformation(extent={{-90,-40},{-70,-20}})));
  PowerConverters.DCDC.Control.SignalPWM signalPWM(constantDutyCycle=dutyCycle,
      f=f) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          origin={-30,-40})));
  Modelica.Blocks.Math.Mean meanCurrent(f=f, x0=0) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={90,-40})));
  Modelica.Blocks.Math.Mean meanVoltage(f=f, x0=0) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={90,10})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(i(fixed=true, start=0),
      final L=L)
    annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
  Modelica.Electrical.Analog.Basic.Capacitor capacitor(C=C, v(fixed=true, start=V0))
                                                       annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(constantVoltage.n, chopperStepUp.dc_n1) annotation (Line(points={{-80,
          -10},{-50,-10},{-50,-6},{-40,-6}}, color={0,0,255}));
  connect(voltageSensor.n, currentSensor.p) annotation (Line(
      points={{60,0},{60,-10},{30,-10}},
                                      color={0,0,255}));
  connect(constantVoltage.n, ground.p) annotation (Line(
      points={{-80,-10},{-80,-20}}, color={0,0,255}));
  connect(voltageSensor.v, meanVoltage.u) annotation (Line(
      points={{71,10},{78,10}}, color={0,0,127}));
  connect(currentSensor.i, meanCurrent.u) annotation (Line(
      points={{20,-21},{20,-40},{78,-40}},
                                    color={0,0,127}));
  connect(signalPWM.fire, chopperStepUp.fire_p)
    annotation (Line(points={{-36,-29},{-36,-12}}, color={255,0,255}));
  connect(constantVoltage.p, inductor.p)
    annotation (Line(points={{-80,10},{-70,10}}, color={0,0,255}));
  connect(inductor.n, chopperStepUp.dc_p1) annotation (Line(points={{-50,
          10},{-50,6},{-40,6}}, color={0,0,255}));
  connect(voltageSensor.p, capacitor.p)
    annotation (Line(points={{60,20},{60,60},{1.77636e-15,60},{
          1.77636e-15,10}},                                  color={0,0,255}));
  connect(capacitor.p, chopperStepUp.dc_p2) annotation (Line(points={{
          1.77636e-15,10},{-10,10},{-10,6},{-20,6}},
                                color={0,0,255}));
  connect(chopperStepUp.dc_n2, capacitor.n) annotation (Line(points={{-20,-6},
          {-10,-6},{-10,-10},{-1.77636e-15,-10}},
                                  color={0,0,255}));
  connect(capacitor.n, currentSensor.n)
    annotation (Line(points={{-1.77636e-15,-10},{10,-10}},
                                                color={0,0,255}));
  annotation (Documentation(
        info="<html>
<p>Step up chopper example template including supply and sensors; load is not yet included</p>
</html>"));
end ChopperStepUp;
