within Modelica.Electrical.Analog.Examples.OpAmps;
model Integrator "Integrating amplifier"
  extends Modelica.Icons.Example;
  parameter SI.Voltage Vin=5 "Amplitude of input voltage";
  parameter SI.Frequency f=10 "Frequency of input voltage";
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Sources.SineVoltage vIn(V=Vin, f=f)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,0})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={40,0})));
  OpAmpCircuits.Integrator integrator(
    v2(fixed=true, start=Vin),        f=f,
    opAmp(v_in(start=0)))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(vIn.p, integrator.p1)
    annotation (Line(points={{-40,10},{-10,10}}, color={0,0,255}));
  connect(vIn.n, integrator.n1)
    annotation (Line(points={{-40,-10},{-10,-10}}, color={0,0,255}));
  connect(integrator.n1, ground.p)
    annotation (Line(points={{-10,-10},{-10,-20}}, color={0,0,255}));
  connect(integrator.p2, vOut.n)
    annotation (Line(points={{10,10},{40,10}}, color={0,0,255}));
  connect(integrator.n2, vOut.p)
    annotation (Line(points={{10,-10},{40,-10}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<p>This is an (inverting) integrating amplifier. Resistance R can be chosen, capacitance C is defined by the desired time constant resp. frequency.</p>
<p>Note: <code>vOut</code> measure the negative output voltage.</p>
</html>"),
    experiment(
      StartTime=0,
      StopTime=1,
      Tolerance=1e-006,
      Interval=0.001));
end Integrator;
