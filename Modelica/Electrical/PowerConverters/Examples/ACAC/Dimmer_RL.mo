within Modelica.Electrical.PowerConverters.Examples.ACAC;
model Dimmer_RL "Dimmer with resistive-inductive load"
  extends PowerConverters.Examples.ACAC.ExampleTemplates.Dimmer(powerFactor=
        0.87);
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Basic.Resistor loadResistor(R=RLoad) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,30})));
  Modelica.Electrical.Analog.Basic.Inductor loadInductor(i(start=0, fixed=true),
      L=LLoad) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,-10})));
equation
  connect(loadResistor.p, multiSensor.nc)
    annotation (Line(points={{50,40},{30,40}},         color={0,0,255}));
  connect(ground.p, loadInductor.n)
    annotation (Line(points={{-80,-20},{50,-20}}, color={0,0,255}));
  connect(loadInductor.p, loadResistor.n)
    annotation (Line(points={{50,0},{50,20}}, color={0,0,255}));
  annotation (experiment(
      StopTime=8,
      Interval=0.0001,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>
This model demonstrates the behaviour of a dimmer with phase-angle control with resistive-inductive load.
Note that due to the inductance the current is not zero at the points in time where zero-crossing of the voltage occurs,
and the triac stays conducting until the current becomes zero.
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
end Dimmer_RL;
