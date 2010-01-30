within Modelica.Electrical.QuasiStationary.Examples;
model ParallelResonance "Parallel resonance circuit"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant I 
    annotation (Placement(transformation(
        origin={-80,-50},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Sources.Constant phi(k=0) 
    annotation (Placement(transformation(
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
  SinglePhase.Sources.VariableCurrentSource currentSource 
    annotation (Placement(transformation(
        origin={-30,20},
        extent={{10,10},{-10,-10}},
        rotation=270)));
  SinglePhase.Basic.Ground ground 
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}}, rotation=0)));
  SinglePhase.Basic.Resistor resistor(R_ref=10) 
    annotation (Placement(transformation(
        origin={-10,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  SinglePhase.Basic.Inductor inductor(L=1/(2*Modelica.Constants.pi)) 
    annotation (Placement(transformation(
        origin={10,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  SinglePhase.Basic.Capacitor capacitor(C=1/(2*Modelica.Constants.pi)) 
    annotation (Placement(transformation(
        origin={30,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  SinglePhase.Sensors.VoltageSensor voltageSensor 
                                      annotation (Placement(transformation(
        origin={50,20},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.ComplexBlocks.ComplexMath.PolarToComplex polarToComplex 
    annotation (Placement(transformation(
        origin={-60,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.ComplexBlocks.ComplexMath.ComplexToPolar complexToPolar annotation (Placement(transformation(
          extent={{70,10},{90,30}}, rotation=0)));
equation
  connect(currentSource.pin_n, resistor.pin_p) annotation (Line(points={{-30,30},
          {-30,40},{-10,40},{-10,30}}, color={85,170,255}));
  connect(currentSource.pin_n, inductor.pin_p) annotation (Line(points={{-30,30},
          {-30,40},{10,40},{10,30}}, color={85,170,255}));
  connect(currentSource.pin_n, capacitor.pin_p) annotation (Line(points={{-30,30},
          {-30,40},{30,40},{30,30}}, color={85,170,255}));
  connect(currentSource.pin_n, voltageSensor.pin_p) annotation (Line(points={{-30,30},
          {-30,40},{50,40},{50,30}},     color={85,170,255}));
  connect(currentSource.pin_p, ground.pin) annotation (Line(points={{-30,10},{
          -30,5},{-30,0}},                color={85,170,255}));
  connect(resistor.pin_n, ground.pin) annotation (Line(points={{-10,10},{-10,0},
          {-30,0}}, color={85,170,255}));
  connect(inductor.pin_n, ground.pin) annotation (Line(points={{10,10},{10,0},{-30,
          0}}, color={85,170,255}));
  connect(capacitor.pin_n, ground.pin) annotation (Line(points={{30,10},{30,0},
          {-30,0}},color={85,170,255}));
  connect(voltageSensor.pin_n, ground.pin) annotation (Line(points={{50,10},{50,
          0},{-30,0}}, color={85,170,255}));
  connect(f.y, currentSource.f) annotation (Line(points={{-60,39},{-60,24},{-40,
          24}}, color={0,0,127}));
  connect(polarToComplex.y, currentSource.I) annotation (Line(points={{-60,1},{
          -60,16},{-40,16}},
                         color={85,170,255}));
  connect(phi.y, polarToComplex.phi) annotation (Line(points={{-40,-39},{-40,
          -32},{-54,-32},{-54,-22}},color={0,0,127}));
  connect(I.y, polarToComplex.len) annotation (Line(
      points={{-80,-39},{-80,-32},{-66,-32},{-66,-22}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(voltageSensor.y, complexToPolar.u) annotation (Line(
      points={{61,20},{68,20}},
      color={85,170,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end ParallelResonance;
