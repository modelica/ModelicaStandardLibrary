within Modelica.Electrical.QuasiStatic.SinglePhase.Examples;
model SeriesResonance "Series resonance circuit"
  extends Modelica.Icons.Example;
  output SI.Current I_abs=complexToPolar.len "Current";
  output SI.Angle I_arg=complexToPolar.phi "Current phase";
  Modelica.Blocks.Sources.Constant V(k=1) annotation (Placement(
        transformation(
        origin={-40,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Constant phi(k=0) annotation (Placement(
        transformation(
        origin={-80,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Sources.Ramp f(
    height=2,
    duration=1,
    offset=1e-6) annotation (Placement(transformation(
        origin={-60,-50},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  QuasiStatic.SinglePhase.Sources.VariableVoltageSource voltageSource(gamma(
        fixed=true, start=0)) annotation (Placement(transformation(
        origin={-30,-20},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  QuasiStatic.SinglePhase.Basic.Ground ground
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  QuasiStatic.SinglePhase.Basic.Resistor resistor(R_ref=0.1)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  QuasiStatic.SinglePhase.Basic.Inductor inductor(L=1/(2*Modelica.Constants.pi))
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  QuasiStatic.SinglePhase.Basic.Capacitor capacitor(C=1/(2*Modelica.Constants.pi))
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  QuasiStatic.SinglePhase.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(extent={{-20,10},{0,-10}})));
  Modelica.ComplexBlocks.ComplexMath.PolarToComplex polarToComplex
    annotation (Placement(transformation(
        origin={-60,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.ComplexBlocks.ComplexMath.ComplexToPolar complexToPolar
    annotation (Placement(transformation(
        origin={-10,30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  connect(f.y, voltageSource.f) annotation (Line(points={{-60,-39},{-60,-26},{-42,-26}}, color={0,0,127}));
  connect(polarToComplex.y, voltageSource.V) annotation (Line(points={{-60,-1},{-60,-14},{-42,-14}}, color={85,170,255}));
  connect(ground.pin, voltageSource.pin_n) annotation (Line(points={{-30,-40},
          {-30,-35},{-30,-30}}, color={85,170,255}));
  connect(voltageSource.pin_p, currentSensor.pin_p) annotation (Line(points=
         {{-30,-10},{-30,0},{-20,0}}, color={85,170,255}));
  connect(currentSensor.pin_n, resistor.pin_p) annotation (Line(points={{0,
          0},{2.5,0},{5,0},{10,0}}, color={85,170,255}));
  connect(resistor.pin_n, inductor.pin_p) annotation (Line(points={{30,0},{
          32.5,0},{35,0},{40,0}}, color={85,170,255}));
  connect(inductor.pin_n, capacitor.pin_p) annotation (Line(points={{60,0},
          {62.5,0},{65,0},{70,0}}, color={85,170,255}));
  connect(capacitor.pin_n, ground.pin) annotation (Line(points={{90,0},{90,
          -40},{-30,-40}}, color={85,170,255}));
  connect(phi.y, polarToComplex.phi) annotation (Line(points={{-80,39},{-80,
          30},{-66,30},{-66,22}}, color={0,0,127}));
  connect(V.y, polarToComplex.len) annotation (Line(
      points={{-40,39},{-40,30},{-54,30},{-54,22}}, color={0,0,127}));
  connect(currentSensor.i, complexToPolar.u) annotation (Line(
      points={{-10,11},{-10,18}}, color={85,170,255}));
  annotation (Documentation(info="<html>
<p>
The frequency of the voltage source is varied by a ramp.
Plot length and angle of the current phasor, i.e., complexToPolar.len and .phi, versus time resp. frequency.
</p>
</html>"),
       experiment(StopTime=1.0, Interval=0.001));
end SeriesResonance;
