within Modelica.Electrical.PowerConverters.Examples.ACAC;
model Dimmer_R "Dimmer with resistive load"
  extends PowerConverters.Examples.ACAC.ExampleTemplates.Dimmer(powerFactor=1);
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Basic.Resistor loadResistor(R=RLoad) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,10})));
equation
  connect(ground.p, loadResistor.n) annotation (Line(points={{-80,-20},{50,-20},
          {50,0}}, color={0,0,255}));
  connect(loadResistor.p, multiSensor.nc)
    annotation (Line(points={{50,20},{50,40},{30,40}}, color={0,0,255}));
  annotation (experiment(
      StopTime=8,
      Interval=0.0001,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>
This model demonstrates the behaviour of a dimmer with phase-angle control with resistive load.
</p>
<p>
The reference voltage is prescribed by a trapezoid between zero and full voltage.
The <a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.Control.VoltageToAngle\">voltageToAngle block</a>
calculates the necessary phase angle, which is processed by
the <a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control.Signal2mPulse\">Signal2mPulse adaptor</a>,
applying the firing signals to the
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.SinglePhaseTriac\">triac</a>.
</p>
</html>"));
end Dimmer_R;
