within Modelica.Electrical.PowerConverters.Examples.DCDC.ChopperStepDown;
model ChopperStepDown_RL "Step down chopper with R-L load"
  extends ExampleTemplates.ChopperStepDown(signalPWM(useConstantDutyCycle=false));
  extends Modelica.Icons.Example;
  parameter SI.Inductance LLoad=0.025 "Load inductance";
  Modelica.Electrical.Analog.Basic.Resistor loadResistor(R=RLoad)
    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,40})));
  Modelica.Electrical.Analog.Basic.Inductor loadInductor(i(fixed=true, start=0),
    L=LLoad) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,10})));
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
  connect(loadResistor.p, capacitor.p) annotation (Line(points={{40,50},{40,60},
          {0,60},{0,10}}, color={0,0,255}));
  connect(loadInductor.n, currentSensor.p)
    annotation (Line(points={{40,0},{40,-10},{30,-10}}, color={0,0,255}));
  connect(loadResistor.n, loadInductor.p)
    annotation (Line(points={{40,30},{40,20}}, color={0,0,255}));
  connect(adaptor.dutyCycle, signalPWM.dutyCycle)
    annotation (Line(points={{-70,-49},{-70,-40},{-42,-40}}, color={0,0,127}));
  connect(adaptor.v, vRef.y)
    annotation (Line(points={{-70,-72},{-70,-80},{79,-80}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=0.1,
      Interval=1e-05,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>This example demonstrates the switching on of an R-L load operated by a step down chopper.
DC output voltage is equal to <code>dutyCycle</code> times the input voltage.
Plot current <code>currentSensor.i</code>, averaged current <code>meanCurrent.y</code>, total voltage <code>voltageSensor.v</code> and voltage <code>meanVoltage.v</code>. The waveform the average current is determined by the time constant <code>L/R</code> of the load.</p>
</html>"));
end ChopperStepDown_RL;
