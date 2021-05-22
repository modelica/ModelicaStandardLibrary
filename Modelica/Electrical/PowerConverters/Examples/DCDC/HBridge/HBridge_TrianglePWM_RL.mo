within Modelica.Electrical.PowerConverters.Examples.DCDC.HBridge;
model HBridge_TrianglePWM_RL "H bridge DC/DC converter with R-L load"
  extends ExampleTemplates.HBridge(signalPWM(refType=Modelica.Electrical.PowerConverters.Types.SingleReferenceType.Triangle));
  extends Modelica.Icons.Example;
  parameter SI.Resistance R=100 "Resistance";
  parameter SI.Inductance L=1 "Inductance";
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,50})));
  Modelica.Electrical.Analog.Basic.Inductor inductor(i(fixed=true,
        start=0), L=L) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,10})));
  Blocks.Discrete.ZeroOrderHold zeroOrderHold(samplePeriod=1/f, startTime=0.5/f)
    annotation (Placement(transformation(extent={{12,-30},{32,-10}})));
equation
  connect(resistor.n, inductor.p) annotation (Line(
      points={{20,40},{20,20}}, color={0,0,255}));
  connect(inductor.n, currentSensor.p) annotation (Line(
      points={{20,0},{20,-6},{0,-6}}, color={0,0,255}));
  connect(resistor.p, hbridge.dc_p2) annotation (Line(
      points={{20,60},{20,70},{-30,70},{-30,6},{-40,6}}, color={0,0,255}));
  connect(currentSensor.i, zeroOrderHold.u)
    annotation (Line(points={{-10,-17},{-10,-20},{10,-20}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>
This is the same example as <a href=\"modelica://Modelica.Electrical.PowerConverters.Examples.DCDC.HBridge.HBridge_RL\">HBridge_RL</a> 
but using a triangle (instead of a sawtooth) as pwm reference signal. 
This enables an easy sampling of the current in the middle of the pwm period, which delivers with good approximation the mean current: 
Compare <code>meanCurrent.y</code> and <code>zeroOrderHold.y</code>. 
For discrete or quasi-continuous control it is essential to sample the correct mean current with low effort once during the pwm period.
</p>
</html>"),
    experiment(
      StopTime=0.1,
      Interval=0.0002,
      Tolerance=1e-06));
end HBridge_TrianglePWM_RL;
