within Modelica.Electrical.QuasiStatic.SinglePhase.Examples;
model ParallelResonance "Parallel resonance circuit"
  extends Modelica.Icons.Example;
  output SI.Voltage V_abs=complexToPolar.len "Voltage";
  output SI.Angle V_arg=complexToPolar.phi "Voltage phase";
  Modelica.Blocks.Sources.Constant I(k=1) annotation (Placement(
        transformation(
        origin={-80,-50},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Sources.Constant phi(k=0) annotation (Placement(
        transformation(
        origin={-40,-50},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Sources.Ramp f(
    height=2,
    duration=1,
    offset=1e-6) annotation (Placement(transformation(
        origin={-60,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  QuasiStatic.SinglePhase.Sources.VariableCurrentSource currentSource(gamma(
        fixed=true, start=0)) annotation (Placement(transformation(
        origin={-30,20},
        extent={{10,10},{-10,-10}},
        rotation=270)));
  QuasiStatic.SinglePhase.Basic.Ground ground
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  QuasiStatic.SinglePhase.Basic.Resistor resistor(R_ref=10) annotation (
      Placement(transformation(
        origin={-10,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  QuasiStatic.SinglePhase.Basic.Inductor inductor(L=1/(2*Modelica.Constants.pi))
    annotation (Placement(transformation(
        origin={10,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  QuasiStatic.SinglePhase.Basic.Capacitor capacitor(C=1/(2*Modelica.Constants.pi))
    annotation (Placement(transformation(
        origin={30,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  QuasiStatic.SinglePhase.Sensors.VoltageSensor voltageSensor annotation (
      Placement(transformation(
        origin={50,20},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.ComplexBlocks.ComplexMath.PolarToComplex polarToComplex
    annotation (Placement(transformation(
        origin={-60,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.ComplexBlocks.ComplexMath.ComplexToPolar complexToPolar
    annotation (Placement(transformation(extent={{70,10},{90,30}})));
equation
  connect(currentSource.pin_n, resistor.pin_p) annotation (Line(points={{-30,
          30},{-30,40},{-10,40},{-10,30}}, color={85,170,255}));
  connect(currentSource.pin_n, inductor.pin_p) annotation (Line(points={{-30,
          30},{-30,40},{10,40},{10,30}}, color={85,170,255}));
  connect(currentSource.pin_n, capacitor.pin_p) annotation (Line(points={{-30,
          30},{-30,40},{30,40},{30,30}}, color={85,170,255}));
  connect(currentSource.pin_n, voltageSensor.pin_p) annotation (Line(points=
         {{-30,30},{-30,40},{50,40},{50,30}}, color={85,170,255}));
  connect(currentSource.pin_p, ground.pin) annotation (Line(points={{-30,10},
          {-30,5},{-30,0}}, color={85,170,255}));
  connect(resistor.pin_n, ground.pin) annotation (Line(points={{-10,10},{-10,
          0},{-30,0}}, color={85,170,255}));
  connect(inductor.pin_n, ground.pin)
    annotation (Line(points={{10,10},{10,0},{-30,0}}, color={85,170,255}));
  connect(capacitor.pin_n, ground.pin)
    annotation (Line(points={{30,10},{30,0},{-30,0}}, color={85,170,255}));
  connect(voltageSensor.pin_n, ground.pin)
    annotation (Line(points={{50,10},{50,0},{-30,0}}, color={85,170,255}));
  connect(f.y, currentSource.f) annotation (Line(points={{-60,39},{-60,26},{-42,26}}, color={0,0,127}));
  connect(polarToComplex.y, currentSource.I) annotation (Line(points={{-60,1},{-60,14},{-42,14}}, color={85,170,255}));
  connect(phi.y, polarToComplex.phi) annotation (Line(points={{-40,-39},{-40,
          -32},{-54,-32},{-54,-22}}, color={0,0,127}));
  connect(I.y, polarToComplex.len) annotation (Line(
      points={{-80,-39},{-80,-32},{-66,-32},{-66,-22}}, color={0,0,127}));
  connect(voltageSensor.v, complexToPolar.u) annotation (Line(
      points={{61,20},{68,20}}, color={85,170,255}));
  annotation (Documentation(info="<html>
<p>
The frequency of the current source is varied by a ramp.
Plot length and angle of the voltage phasor, i.e., complexToPolar.len and .phi, versus time resp. frequency.
</p>
</html>"),
       experiment(StopTime=1.0, Interval=0.001));
end ParallelResonance;
