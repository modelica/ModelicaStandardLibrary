within Modelica.Electrical.PowerConverters.Examples.DCDC.ChopperStepDown;
model ChopperStepDown_R "Step down chopper with resistive load"
  extends ExampleTemplates.ChopperStepDown(signalPWM(useConstantDutyCycle=false));
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Basic.Resistor loadResistor(R=RLoad)
    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,40})));
  PowerConverters.DCDC.Control.Voltage2DutyCycle adaptor(
    reciprocal=false,
    useBipolarVoltage=false,
    VLim=Vsource) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,-60})));
  Modelica.Blocks.Sources.Ramp vRef(
    height=V0,
    duration=0.05,
    offset=0,
    startTime=0.025)
    annotation (Placement(transformation(extent={{100,-90},{80,-70}})));
equation
  connect(loadResistor.n, currentSensor.p)
    annotation (Line(points={{40,30},{40,-10},{30,-10}}, color={0,0,255}));
  connect(loadResistor.p, capacitor.p) annotation (Line(points={{40,50},{40,60},
          {1.77636e-15,60},{1.77636e-15,10}}, color={0,0,255}));
  connect(adaptor.dutyCycle, signalPWM.dutyCycle)
    annotation (Line(points={{-70,-49},{-70,-40},{-42,-40}}, color={0,0,127}));
  connect(vRef.y, adaptor.v)
    annotation (Line(points={{79,-80},{-70,-80},{-70,-72}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=0.1,
      Interval=1e-05,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>This example demonstrates the switching on of a resistive load operated by a step down chopper.
DC output voltage is equal to <code>dutyCycle</code> times the input voltage.
Plot current <code>currentSensor.i</code>, averaged current <code>meanCurrent.y</code>, total voltage <code>voltageSensor.v</code> and voltage <code>meanVoltage.v</code>.</p>
</html>"));
end ChopperStepDown_R;
