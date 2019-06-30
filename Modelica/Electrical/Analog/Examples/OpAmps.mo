within Modelica.Electrical.Analog.Examples;
package OpAmps "Examples with operational amplifiers"
  extends Modelica.Icons.ExamplesPackage;
  model NonInvertingAmp "Non-inverting amplifier"
    extends Modelica.Icons.Example;
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
    Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
      V=2*Vin,
      rising=0.2/f,
      width=0.3/f,
      falling=0.2/f,
      period=1/f,
      nperiod=-1,
      offset=-Vin,
      startTime=-(vIn.rising + vIn.width/2)) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,0})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={40,0})));
    OpAmpCircuits.Buffer buffer(k=2)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  equation
    connect(vIn.n, buffer.n1)
      annotation (Line(points={{-40,-10},{-10,-10}}, color={0,0,255}));
    connect(vIn.p, buffer.p1)
      annotation (Line(points={{-40,10},{-10,10}}, color={0,0,255}));
    connect(buffer.p2, vOut.p)
      annotation (Line(points={{10,10},{40,10}}, color={0,0,255}));
    connect(buffer.n2, vOut.n)
      annotation (Line(points={{10,-10},{40,-10}}, color={0,0,255}));
    connect(buffer.n1, ground.p)
      annotation (Line(points={{-10,-10},{-10,-20}}, color={0,0,255}));
    annotation (Documentation(info="<html>
<p>This is a non inverting amplifier.</p>
</html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end NonInvertingAmp;

  model InvertingAmp "Inverting amplifier"
    extends Modelica.Icons.Example;
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
    Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
      V=2*Vin,
      rising=0.2/f,
      width=0.3/f,
      falling=0.2/f,
      period=1/f,
      nperiod=-1,
      offset=-Vin,
      startTime=-(vIn.rising + vIn.width/2)) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,0})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={40,0})));
    OpAmpCircuits.Gain gain(k=2)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  equation
    connect(vIn.p, gain.p1)
      annotation (Line(points={{-40,10},{-10,10}}, color={0,0,255}));
    connect(gain.n1, ground.p)
      annotation (Line(points={{-10,-10},{-10,-20}}, color={0,0,255}));
    connect(gain.n1, vIn.n)
      annotation (Line(points={{-10,-10},{-40,-10}}, color={0,0,255}));
    connect(gain.p2, vOut.n)
      annotation (Line(points={{10,10},{40,10}}, color={0,0,255}));
    connect(gain.n2, vOut.p)
      annotation (Line(points={{10,-10},{40,-10}}, color={0,0,255}));
    annotation (
      Documentation(info="<html>
<p>This is an inverting amplifier.</p>
<p>Note: <code>vOut</code> measure the negative output voltage.</p>
</html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end InvertingAmp;

  model Adder "Inverting adder"
    extends Modelica.Icons.Example;
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
    Sources.SineVoltage vIn1(V=Vin, freqHz=f) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-60,0})));
    Sources.ConstantVoltage vIn2(V=Vin) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,-10})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={40,0})));
    OpAmpCircuits.Add add(p1_2(i(start=0)))
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  equation
    connect(add.n1, ground.p)
      annotation (Line(points={{-10,-10},{-10,-20}}, color={0,0,255}));
    connect(vIn1.p, add.p1)
      annotation (Line(points={{-60,10},{-10,10}}, color={0,0,255}));
    connect(vIn2.p, add.p1_2)
      annotation (Line(points={{-40,0},{-10,0}}, color={0,0,255}));
    connect(ground.p, vIn2.n)
      annotation (Line(points={{-10,-20},{-40,-20}}, color={0,0,255}));
    connect(ground.p, vIn1.n)
      annotation (Line(points={{-10,-20},{-60,-20},{-60,-10}}, color={0,0,255}));
    connect(add.p2, vOut.n)
      annotation (Line(points={{10,10},{40,10}}, color={0,0,255}));
    connect(add.n2, vOut.p)
      annotation (Line(points={{10,-10},{40,-10}}, color={0,0,255}));
    annotation (Documentation(info="<html>
<p>This is an inverting adder.</p>
<p>Note: <code>vOut</code> measure the negative output voltage.</p>
</html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end Adder;

  model Subtracter "Inverting subtractor"
    extends Modelica.Icons.Example;
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
    Sources.SineVoltage vIn1(V=Vin, freqHz=f) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-60,0})));
    Sources.ConstantVoltage vIn2(V=Vin) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,-10})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={40,0})));
    OpAmpCircuits.Feedback feedback(p1_2(i(start=0)))
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  equation
    connect(feedback.n1, ground.p)
      annotation (Line(points={{-10,-10},{-10,-20}}, color={0,0,255}));
    connect(vIn1.p, feedback.p1)
      annotation (Line(points={{-60,10},{-10,10}}, color={0,0,255}));
    connect(vIn2.p, feedback.p1_2)
      annotation (Line(points={{-40,0},{-10,0}}, color={0,0,255}));
    connect(ground.p, vIn2.n)
      annotation (Line(points={{-10,-20},{-40,-20}}, color={0,0,255}));
    connect(ground.p, vIn1.n)
      annotation (Line(points={{-10,-20},{-60,-20},{-60,-10}}, color={0,0,255}));
    connect(feedback.p2, vOut.n)
      annotation (Line(points={{10,10},{40,10}}, color={0,0,255}));
    connect(feedback.n2, vOut.p)
      annotation (Line(points={{10,-10},{40,-10}}, color={0,0,255}));
    annotation (Documentation(info="<html>
<p>This is an inverting subtracter.</p>
<p>Note: <code>vOut</code> measure the negative output voltage.</p>
</html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end Subtracter;

  model Differentiator "Differentiating amplifier"
    extends Modelica.Icons.Example;
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
    Sources.SineVoltage                                 vIn(V=Vin,
               freqHz=f)                     annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,0})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={40,0})));
    OpAmpCircuits.Der der_(f=f, v(fixed=true))
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  equation
    connect(vIn.p, der_.p1)
      annotation (Line(points={{-40,10},{-10,10}}, color={0,0,255}));
    connect(vIn.n, der_.n1)
      annotation (Line(points={{-40,-10},{-10,-10}}, color={0,0,255}));
    connect(der_.n1, ground.p)
      annotation (Line(points={{-10,-10},{-10,-20}}, color={0,0,255}));
    connect(der_.p2, vOut.n)
      annotation (Line(points={{10,10},{40,10}}, color={0,0,255}));
    connect(der_.n2, vOut.p)
      annotation (Line(points={{10,-10},{40,-10}}, color={0,0,255}));
    annotation (Documentation(info="<html>
<p>This is a (inverting) differentiating amplifier. Resistance R can be chosen, capacitance C is defined by the desired time constant resp. frequency.</p>
<p>Note: <code>vOut</code> measure the negative output voltage.</p>
</html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end Differentiator;

  model Integrator "Integrating amplifier"
    extends Modelica.Icons.Example;
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
    Sources.SineVoltage vIn(V=Vin, freqHz=f)
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

  model LowPass "Low-pass filter"
    extends Modelica.Icons.Example;
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
    Sources.PulseVoltage vIn(
      width=50,
      period=1/f,
      V=2*Vin,
      offset=-Vin)
                annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,0})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={40,0})));
    OpAmpCircuits.FirstOrder firstOrder(
      v2(fixed=true),
      T=0.1/f,
      opAmp(v_in(start=0)))
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  equation
    connect(vIn.n, firstOrder.n1)
      annotation (Line(points={{-40,-10},{-10,-10}}, color={0,0,255}));
    connect(vIn.p, firstOrder.p1)
      annotation (Line(points={{-40,10},{-10,10}}, color={0,0,255}));
    connect(firstOrder.p2, vOut.n)
      annotation (Line(points={{10,10},{40,10}}, color={0,0,255}));
    connect(firstOrder.n2, vOut.p)
      annotation (Line(points={{10,-10},{40,-10}}, color={0,0,255}));
    connect(firstOrder.n1, ground.p)
      annotation (Line(points={{-10,-10},{-10,-20},{-10,-20}}, color={0,0,255}));
    annotation (Documentation(info="<html>
<p>This is a (inverting) low pass filter. Resistance R1 can be chosen, resistance R2 is defined by the desired amplification k, capacitance C is defined by the desired cut-off frequency.</p>
<p>The example is taken from: U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 13.3</p>
<p>Note: <code>vOut</code> measure the negative output voltage.</p>
</html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end LowPass;

  model HighPass "High-pass filter"
    extends Modelica.Icons.Example;
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
    Sources.PulseVoltage  vIn(
      width=50,
      period=1/f,
      V=2*Vin,
      offset=-Vin)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,0})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={40,0})));
    OpAmpCircuits.Derivative derivative(T=0.1/f, v(fixed=true))
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  equation
    connect(vIn.p, derivative.p1) annotation (Line(points={{-40,10},{-26,10},{-26,
            10},{-10,10}}, color={0,0,255}));
    connect(vIn.n, derivative.n1)
      annotation (Line(points={{-40,-10},{-10,-10}}, color={0,0,255}));
    connect(derivative.p2, vOut.n)
      annotation (Line(points={{10,10},{40,10}}, color={0,0,255}));
    connect(derivative.n2, vOut.p)
      annotation (Line(points={{10,-10},{40,-10}}, color={0,0,255}));
    connect(derivative.n1, ground.p)
      annotation (Line(points={{-10,-10},{-10,-20},{-10,-20}}, color={0,0,255}));
    annotation (Documentation(info="<html>
<p>This is a (inverting) high pass filter. Resistance R1 can be chosen, resistance R2 is defined by the desired amplification k, capacitance C is defined by the desired cut-off frequency.</p>
<p>The example is taken from: U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 13.3</p>
<p>Note: <code>vOut</code> measure the negative output voltage.</p>
</html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end HighPass;

  model ControlCircuit "Control circuit"
    extends Modelica.Icons.Example;
    parameter Modelica.SIunits.Time T1=0.01 "Small time constant";
    parameter Modelica.SIunits.Time T2=0.01 "Large time constant";
    parameter Modelica.SIunits.Time Ti=T2 "Integral time constant";
    parameter Real kp=T2/(2*T1) "Proportional gain";
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
    Sources.StepVoltage stepA(V=10, startTime=0.1) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-90,-62})));
    OpAmpCircuits.Feedback feedbackA(p1(i(start=0)))
      annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
    OpAmpCircuits.PI PIA(
      v2(fixed=true),
      k=kp,
      T=Ti,
      opAmp(v_in(start=0)))
      annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
    OpAmpCircuits.FirstOrder firstOrder1A(
      v2(fixed=true),
      T=T1,
      opAmp(v_in(start=0)))
      annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
    OpAmpCircuits.Add addA(i1_2(start=0), r(i(start=0)))
      annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
    Sources.StepVoltage step1A(V=1, startTime=0.5) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={20,-60})));
    OpAmpCircuits.FirstOrder firstOrder2A(
      v2(fixed=true),
      T=T2,
      opAmp(v_in(start=0)))
      annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
    Blocks.Sources.Step stepB(height=10, startTime=0.1)
      annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
    Blocks.Math.Feedback feedbackB
      annotation (Placement(transformation(extent={{-70,60},{-50,80}})));
    Blocks.Continuous.PI PIB(
      k=kp,
      T=Ti,
      initType=Modelica.Blocks.Types.Init.InitialOutput)
      annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
    Blocks.Continuous.FirstOrder firstOrder1B(T=T1, initType=Modelica.Blocks.Types.Init.InitialOutput)
      annotation (Placement(transformation(extent={{-10,60},{10,80}})));
    Blocks.Math.Add addB
      annotation (Placement(transformation(extent={{30,60},{50,80}})));
    Blocks.Sources.Step step1B(height=1, startTime=0.5)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,30})));
    Blocks.Continuous.FirstOrder firstOrder2B(T=T2, initType=Modelica.Blocks.Types.Init.InitialOutput)
      annotation (Placement(transformation(extent={{60,60},{80,80}})));
  equation
    connect(stepA.n, ground.p)
      annotation (Line(points={{-90,-72},{-90,-80}}, color={0,0,255}));
    connect(feedbackA.p2, PIA.p1)
      annotation (Line(points={{-50,-20},{-40,-20}}, color={0,0,255}));
    connect(feedbackA.n2, PIA.n1)
      annotation (Line(points={{-50,-40},{-40,-40}}, color={0,0,255}));
    connect(PIA.p2, firstOrder1A.p1)
      annotation (Line(points={{-20,-20},{-10,-20}}, color={0,0,255}));
    connect(PIA.n2, firstOrder1A.n1)
      annotation (Line(points={{-20,-40},{-10,-40}}, color={0,0,255}));
    connect(stepB.y,feedbackB. u1)
      annotation (Line(points={{-79,70},{-68,70}}, color={0,0,127}));
    connect(feedbackB.y,PIB. u)
      annotation (Line(points={{-51,70},{-42,70}}, color={0,0,127}));
    connect(PIB.y,firstOrder1B. u)
      annotation (Line(points={{-19,70},{-12,70}},
                                                 color={0,0,127}));
    connect(firstOrder1B.y, addB.u1) annotation (Line(points={{11,70},{19.5,70},{19.5,
            76},{28,76}}, color={0,0,127}));
    connect(addB.y, firstOrder2B.u)
      annotation (Line(points={{51,70},{58,70}}, color={0,0,127}));
    connect(step1B.y, addB.u2)
      annotation (Line(points={{20,41},{20,64},{28,64}}, color={0,0,127}));
    connect(firstOrder2B.y, feedbackB.u2) annotation (Line(points={{81,70},{90,70},
            {90,50},{-60,50},{-60,62}}, color={0,0,127}));
    connect(stepA.p, feedbackA.p1_2)
      annotation (Line(points={{-90,-52},{-90,-30},{-70,-30}}, color={0,0,255}));
    connect(firstOrder2A.p2, feedbackA.p1) annotation (Line(points={{80,-20},{80,-10},
            {-70,-10},{-70,-20}}, color={0,0,255}));
    connect(ground.p, feedbackA.n1)
      annotation (Line(points={{-90,-80},{-70,-80},{-70,-40}}, color={0,0,255}));
    connect(ground.p, step1A.n)
      annotation (Line(points={{-90,-80},{20,-80},{20,-70}}, color={0,0,255}));
    connect(firstOrder1A.n2, addA.n1)
      annotation (Line(points={{10,-40},{30,-40}}, color={0,0,255}));
    connect(firstOrder1A.p2, addA.p1)
      annotation (Line(points={{10,-20},{30,-20}}, color={0,0,255}));
    connect(step1A.p, addA.p1_2)
      annotation (Line(points={{20,-50},{20,-30},{30,-30}}, color={0,0,255}));
    connect(addA.p2, firstOrder2A.p1)
      annotation (Line(points={{50,-20},{60,-20}}, color={0,0,255}));
    connect(addA.n2, firstOrder2A.n1)
      annotation (Line(points={{50,-40},{60,-40}}, color={0,0,255}));
    annotation (Documentation(info="<html>
<p>This is an analog control circuit with operational amplifiers.</p>
<p>Compare the analog solution with the block circuit, e.g. <code>firstOrder2B.y</code> and <code>firstOrder2A.v2</code>.
</html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end ControlCircuit;

  model VoltageFollower "Reproduce input voltage"
    extends Modelica.Icons.Example;
    parameter SI.Voltage Vps=+15 "Positive supply";
    parameter SI.Voltage Vns=-15 "Negative supply";
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    parameter SI.Resistance Ri=1
      "Inner resistance of input voltage source";
    parameter SI.Resistance Rl=1 "Load resistance";
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited opAmp(
      Vps=Vps,
      Vns=Vns,
      v_in(start=0))
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
    Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
      V=2*Vin,
      rising=0.2/f,
      width=0.3/f,
      falling=0.2/f,
      period=1/f,
      nperiod=-1,
      offset=-Vin,
      startTime=-(vIn.rising + vIn.width/2)) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,0})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={60,-20})));
    Modelica.Electrical.Analog.Basic.Resistor ri(R=Ri)
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    Modelica.Electrical.Analog.Basic.Resistor rl(R=Rl) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={30,-18})));
  equation
    connect(ground.p, vIn.n) annotation (Line(
        points={{-10,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
    connect(opAmp.out, vOut.p) annotation (Line(
        points={{20,0},{60,0},{60,-10}}, color={0,0,255}));
    connect(ground.p, vOut.n) annotation (Line(
        points={{-10,-80},{60,-80},{60,-30}}, color={0,0,255}));
    connect(opAmp.out, opAmp.in_n) annotation (Line(
        points={{20,0},{30,0},{30,20},{-10,20},{-10,6},{0,6}}, color={0,0,255}));
    connect(vIn.p, ri.p) annotation (Line(
        points={{-80,10},{-60,10}}, color={0,0,255}));
    connect(ri.n, opAmp.in_p) annotation (Line(
        points={{-40,10},{-20,10},{-20,-6},{0,-6}}, color={0,0,255}));
    connect(opAmp.out, rl.p) annotation (Line(
        points={{20,0},{30,0},{30,-8}}, color={0,0,255}));
    connect(ground.p, rl.n) annotation (Line(
        points={{-10,-80},{30,-80},{30,-28}}, color={0,0,255}));
    annotation (Documentation(info="<html>
<p>This is a voltage follower. It reproduces the input voltage at the output without loading the input voltage source with a stiff output.</p>
</html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end VoltageFollower;

  model Comparator "Comparator"
    extends Modelica.Icons.Example;
    parameter SI.Voltage Vps=+15 "Positive supply";
    parameter SI.Voltage Vns=-15 "Negative supply";
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    parameter SI.Voltage Vref=0 "Reference voltage";
    parameter Real k=(Vref - Vns)/(Vps - Vns) "Calculated potentiometer ratio to reach Vref";
    parameter SI.Resistance R=1000 "Resistance of potentiometer";
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited opAmp(Vps=Vps, Vns=
          Vns) annotation (Placement(transformation(extent={{0,10},{20,-10}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
    Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
      rising=0.2/f,
      width=0.3/f,
      falling=0.2/f,
      period=1/f,
      nperiod=-1,
      startTime=-(vIn.rising + vIn.width/2),
      V=2*Vin,
      offset=-Vin) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,0})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={50,-20})));
    Modelica.Electrical.Analog.Basic.Potentiometer potentiometer(R=R, rConstant=
         k) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          origin={-10,-30})));
    Modelica.Electrical.Analog.Sources.SupplyVoltage supplyVoltage(Vps=Vps, Vns=
         Vns) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          origin={-10,-50})));
  equation
    connect(vIn.p, opAmp.in_p) annotation (Line(
        points={{-80,10},{-10,10},{-10,6},{0,6}}, color={0,0,255}));
    connect(opAmp.out, vOut.p) annotation (Line(
        points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
    connect(ground.p, vOut.n) annotation (Line(
        points={{-10,-80},{50,-80},{50,-30}}, color={0,0,255}));
    connect(ground.p, vIn.n) annotation (Line(
        points={{-10,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
    connect(potentiometer.contact, opAmp.in_n) annotation (Line(
        points={{0,-20},{0,-6}}, color={0,0,255}));
    connect(potentiometer.pin_p, supplyVoltage.pin_p) annotation (Line(
        points={{-20,-30},{-20,-50}}, color={0,0,255}));
    connect(potentiometer.pin_n, supplyVoltage.pin_n) annotation (Line(
        points={{0,-30},{0,-50}}, color={0,0,255}));
    connect(ground.p, supplyVoltage.ground) annotation (Line(
        points={{-10,-80},{-10,-50}}, color={0,0,255}));
    annotation (Documentation(info="<html>
<p>This is a comparator. Resistance R1 can be chosen, resistance R2 is defined by the desired reference voltage Vref (between Vn and Vp). The output switches between Vn for input voltage &lt; Vref and Vp for input voltage &gt; Vref.</p>
</html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end Comparator;

  model InvertingSchmittTrigger "Inverting Schmitt trigger with hysteresis"
    extends Modelica.Icons.Example;
    parameter SI.Voltage Vps=+15 "Positive supply";
    parameter SI.Voltage Vns=-15 "Negative supply";
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    parameter SI.Voltage vHys=1 "(Positive) hysteresis voltage";
    parameter Real k=vHys/Vps "Auxiliary calculated parameter to be used in R2 calculation";
    parameter SI.Resistance R1=1000 "Arbitrary resistance";
    parameter SI.Resistance R2=(1 - k)/k*R1 "Calculated resistance to reach hysteresis voltage";
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited opAmp(
      Vps=Vps,
      Vns=Vns,
      out(i(start=0)),
      homotopyType=Modelica.Blocks.Types.LimiterHomotopy.LowerLimit)
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
    Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
      rising=0.2/f,
      width=0.3/f,
      falling=0.2/f,
      period=1/f,
      nperiod=-1,
      startTime=-(vIn.rising + vIn.width/2),
      V=2*Vin,
      offset=-Vin) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,0})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={50,-20})));
    Modelica.Electrical.Analog.Basic.Resistor r1(R=R1) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={30,-60})));
    Modelica.Electrical.Analog.Basic.Resistor r2(R=R2) annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={30,-20})));
  equation
    connect(r2.n, r1.p) annotation (Line(
        points={{30,-30},{30,-50}}, color={0,0,255}));
    connect(ground.p, r1.n) annotation (Line(
        points={{-10,-80},{30,-80},{30,-80},{30,-80},{30,-70},{30,-70}}, color={0,0,255}));
    connect(opAmp.out, r2.p) annotation (Line(
        points={{20,0},{30,0},{30,-10}}, color={0,0,255}));
    connect(r2.n, opAmp.in_p) annotation (Line(
        points={{30,-30},{30,-40},{-10,-40},{-10,-6},{0,-6}}, color={0,0,255}));
    connect(vIn.p, opAmp.in_n) annotation (Line(
        points={{-80,10},{-20,10},{-20,6},{0,6}}, color={0,0,255}));
    connect(ground.p, vIn.n) annotation (Line(
        points={{-10,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
    connect(ground.p, vOut.n) annotation (Line(
        points={{-10,-80},{50,-80},{50,-30}}, color={0,0,255}));
    connect(opAmp.out, vOut.p) annotation (Line(
        points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
    annotation (Documentation(info="<html>
<p>This is a (inverting) Schmitt trigger. Resistance R1 can be chosen, resistance R2 is defined by the desired hysteresis. The output gets Vn for input voltage &gt; 0 + vHys and Vp for input voltage &lt; vHys*Vns/Vps.</p>
<p>The example is taken from: U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 6.5.2</p>
</html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end InvertingSchmittTrigger;

  model SchmittTrigger "Schmitt trigger with hysteresis"
    extends Modelica.Icons.Example;
    parameter SI.Voltage Vps=+15 "Positive supply";
    parameter SI.Voltage Vns=-15 "Negative supply";
    parameter SI.Voltage Vin=5 "Amplitude of input voltage";
    parameter SI.Frequency f=10 "Frequency of input voltage";
    parameter SI.Voltage vHys=1 "(Positive) hysteresis voltage";
    parameter Real k=vHys/Vps "Auxiliary calculated parameter to be used in R2 calculation";
    parameter SI.Resistance R1=1000 "Arbitrary resistance";
    parameter SI.Resistance R2=R1/k "Calculated resistance to reach hysteresis voltage";
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited opAmp(
      Vps=Vps,
      Vns=Vns,
      out(i(start=0)),
      homotopyType=Modelica.Blocks.Types.LimiterHomotopy.UpperLimit)
      annotation (Placement(transformation(extent={{0,10},{20,-10}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
    Modelica.Electrical.Analog.Sources.TrapezoidVoltage vIn(
      rising=0.2/f,
      width=0.3/f,
      falling=0.2/f,
      period=1/f,
      nperiod=-1,
      startTime=-(vIn.rising + vIn.width/2),
      V=2*Vin,
      offset=-Vin) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,0})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={50,-20})));
    Modelica.Electrical.Analog.Basic.Resistor r1(R=R1) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          origin={-30,20})));
    Modelica.Electrical.Analog.Basic.Resistor r2(R=R2) annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={10,20})));
  equation
    connect(ground.p, vIn.n) annotation (Line(
        points={{-10,-80},{-80,-80},{-80,-10}}, color={0,0,255}));
    connect(ground.p, vOut.n) annotation (Line(
        points={{-10,-80},{50,-80},{50,-30}}, color={0,0,255}));
    connect(opAmp.out, vOut.p) annotation (Line(
        points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
    connect(opAmp.in_n, ground.p) annotation (Line(
        points={{0,-6},{-10,-6},{-10,-80}}, color={0,0,255}));
    connect(opAmp.out, r2.n) annotation (Line(
        points={{20,0},{30,0},{30,20},{20,20}}, color={0,0,255}));
    connect(r2.p, opAmp.in_p) annotation (Line(
        points={{0,20},{-10,20},{-10,6},{0,6}}, color={0,0,255}));
    connect(r2.p, r1.n) annotation (Line(
        points={{0,20},{-20,20}}, color={0,0,255}));
    connect(r1.p, vIn.p) annotation (Line(
        points={{-40,20},{-80,20},{-80,10}}, color={0,0,255}));
    annotation (Documentation(info="<html>
<p>This is a (non-inverting) Schmitt trigger. Resistance R1 can be chosen, resistance R2 is defined by the desired hysteresis. The output gets Vp for input voltage &gt; vHys and Vn for input voltage &lt; vHys*Vns/Vps.</p>
<p>The example is taken from: U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 6.5.2</p>
</html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end SchmittTrigger;

  model Multivibrator "Multivibrator with Schmitt trigger"
    extends Modelica.Icons.Example;
    parameter SI.Voltage Vps=+15 "Positive supply";
    parameter SI.Voltage Vns=-15 "Negative supply";
    parameter SI.Frequency f=10 "Desired frequency";
    parameter SI.Resistance R1=1000 "Resistance 1 for adjusting the Schmitt trigger voltage level";
    parameter SI.Resistance R2=1000 "Resistance 2 for adjusting the Schmitt trigger voltage level";
    parameter SI.Resistance R=1000 "Arbitrary resistance";
    parameter SI.Capacitance C=1/f/(2*R*log(1 + 2*R1/R2)) "Calculated capacitance to reach the desired frequency f";
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited opAmp(
      Vps=Vps,
      Vns=Vns) annotation (Placement(transformation(extent={{0,-10},{20,10}})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={50,-20})));
    Modelica.Electrical.Analog.Basic.Resistor r1(R=R1, i(start=0)) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-10,-40})));
    Modelica.Electrical.Analog.Basic.Resistor r2(R=R2) annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          origin={10,-20})));
    Modelica.Electrical.Analog.Basic.Resistor r(R=R)
      annotation (Placement(transformation(extent={{20,20},{0,40}})));
    Modelica.Electrical.Analog.Basic.Capacitor c(C=C, v(start=1, fixed=true))
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-30,-40})));
  equation
    connect(ground.p, r1.n) annotation (Line(
        points={{-10,-60},{-10,-50}}, color={0,0,255}));
    connect(ground.p, vOut.n) annotation (Line(
        points={{-10,-60},{50,-60},{50,-30}}, color={0,0,255}));
    connect(opAmp.out, vOut.p) annotation (Line(
        points={{20,0},{50,0},{50,-10}}, color={0,0,255}));
    connect(ground.p, c.n) annotation (Line(
        points={{-10,-60},{-30,-60},{-30,-50}}, color={0,0,255}));
    connect(opAmp.out, r.p) annotation (Line(
        points={{20,0},{30,0},{30,30},{20,30}}, color={0,0,255}));
    connect(r.n, opAmp.in_n) annotation (Line(
        points={{0,30},{-10,30},{-10,6},{0,6}}, color={0,0,255}));
    connect(opAmp.out, r2.p) annotation (Line(
        points={{20,0},{30,0},{30,-20},{20,-20}}, color={0,0,255}));
    connect(r2.n, opAmp.in_p) annotation (Line(
        points={{0,-20},{-10,-20},{-10,-6},{0,-6}}, color={0,0,255}));
    connect(opAmp.in_p, r1.p) annotation (Line(
        points={{0,-6},{-10,-6},{-10,-30}}, color={0,0,255}));
    connect(r.n, c.p) annotation (Line(
        points={{0,30},{-30,30},{-30,-30}}, color={0,0,255}));
    annotation (Documentation(info="<html>
<p>This is a Multivibrator with Schmitt trigger according to:</p>
<p>U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 6.5.3</p>
</html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end Multivibrator;

  model SignalGenerator "Rectangle-Triangle generator"
    extends Modelica.Icons.Example;
    import Modelica.Constants.pi;
    parameter SI.Voltage Vps=+15 "Positive supply";
    parameter SI.Voltage Vns=-Vps "Negative supply";
    parameter SI.Voltage VAmp=10 "Desired amplitude of output";
    parameter SI.Resistance R1=1000 "Arbitrary resistance for Schmitt trigger part";
    parameter SI.Resistance R2=R1*Vps/VAmp "Calculated resistance for Schmitt trigger to reach VAmp";
    parameter SI.Frequency f=10 "Desired frequency";
    parameter SI.Resistance R=1000 "Arbitrary resistance of integrator part";
    parameter SI.Capacitance C=Vps/VAmp/(4*f*R) "Calculated capacitance of integrator part to reach f";
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited opAmp1(
      Vps=Vps,
      Vns=Vns,
      strict=false,
      homotopyType=Modelica.Blocks.Types.LimiterHomotopy.UpperLimit)
      annotation (Placement(transformation(extent={{-60,10},{-40,-10}})));
    Modelica.Electrical.Analog.Basic.Resistor r2(R=R2, i(start=Vps/R2))
      annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-50,30})));
    Modelica.Electrical.Analog.Basic.Resistor r1(R=R1) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          origin={-50,50})));
    Modelica.Electrical.Analog.Basic.Ground ground
      annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited opAmp2(
      Vps=Vps,
      Vns=Vns,
      v_in(start=0),
      strict=false)
      annotation (Placement(transformation(extent={{30,-10},{50,10}})));
    Modelica.Electrical.Analog.Basic.Capacitor c(C=C, v(fixed=true, start=0))
      annotation (Placement(transformation(extent={{50,20},{30,40}})));
    Modelica.Electrical.Analog.Basic.Resistor r(R=R)
      annotation (Placement(transformation(extent={{-10,20},{10,40}})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOutRectangle annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={-30,-20})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOutTriangle annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={60,-18})));
  equation
    connect(opAmp1.out, r2.n) annotation (Line(
        points={{-40,0},{-30,0},{-30,30},{-40,30}}, color={0,0,255}));
    connect(opAmp1.in_p, r2.p) annotation (Line(
        points={{-60,6},{-70,6},{-70,30},{-60,30}}, color={0,0,255}));
    connect(opAmp1.in_n, ground.p) annotation (Line(
        points={{-60,-6},{-70,-6},{-70,-40},{0,-40}}, color={0,0,255}));
    connect(opAmp1.out, r.p) annotation (Line(
        points={{-40,0},{-30,0},{-30,30},{-10,30}}, color={0,0,255}));
    connect(r.n, c.n) annotation (Line(
        points={{10,30},{30,30}}, color={0,0,255}));
    connect(c.p, opAmp2.out) annotation (Line(
        points={{50,30},{60,30},{60,0},{50,0}}, color={0,0,255}));
    connect(ground.p, opAmp2.in_p) annotation (Line(
        points={{0,-40},{20,-40},{20,-6},{30,-6}}, color={0,0,255}));
    connect(c.n, opAmp2.in_n) annotation (Line(
        points={{30,30},{20,30},{20,6},{30,6}}, color={0,0,255}));
    connect(r2.p, r1.p) annotation (Line(
        points={{-60,30},{-70,30},{-70,50},{-60,50}}, color={0,0,255}));
    connect(opAmp2.out, r1.n) annotation (Line(
        points={{50,0},{60,0},{60,50},{-40,50}}, color={0,0,255}));
    connect(opAmp1.out, vOutRectangle.p) annotation (Line(
        points={{-40,0},{-30,0},{-30,-10}}, color={0,0,255}));
    connect(ground.p, vOutRectangle.n) annotation (Line(
        points={{0,-40},{-30,-40},{-30,-30}}, color={0,0,255}));
    connect(opAmp2.out, vOutTriangle.p) annotation (Line(
        points={{50,0},{60,0},{60,-8}}, color={0,0,255}));
    connect(ground.p, vOutTriangle.n) annotation (Line(
        points={{0,-40},{60,-40},{60,-28}}, color={0,0,255}));
    annotation (Documentation(info="<html>
<p>This signal generator consists of a Schmitt trigger and an integrator. The output of the Schmitt trigger part opamp (opAmp1) is a rectangular signal with the amplitude VAmp and the frequency f.
The output of the integrator part opamp (opAmp2) is a triangular signal of also the amplitude Vamp and the frequency f.</p>
<p>Source:</p>
<p>U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 14.5.2</p>
</html>"),
      experiment(
        StartTime=0,
        StopTime=1,
        Tolerance=1e-006,
        Interval=0.001));
  end SignalGenerator;

  model LCOscillator "LC oscillator"
    extends Modelica.Icons.Example;
    import Modelica.Constants.pi;
    parameter SI.Voltage VAmp=10 "Amplitude of output";
    parameter SI.Frequency f=1000 "Desired frequency";
    parameter Real A=1.001 "Amplification constant: A > 1 amplification, A = 1 pure sinusoidal oscillation, A < 0 damping";
    parameter SI.Inductance L=0.001 "Arbitrary inductance > 0";
    parameter SI.Capacitance C=1/((2*pi*f)^2*L) "Calculated capacitance to reach frequency f";
    parameter SI.Resistance R=10000.0 "Damping resistance";
    parameter SI.Resistance R1=10000.0 "Arbitrary high resistance";
    parameter SI.Resistance R2=(A - 1)*R1 "Calculated resistance to reach amplification A";
    parameter Real gamma=(1 - A)/(2*R*C) "Calculated characteristical parameter";
    Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
          transformation(
          origin={20,-50},
          extent={{-10,-10},{10,10}})));
    Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited opAmp
      annotation (Placement(transformation(extent={{-50,10},{-30,-10}})));
    Modelica.Electrical.Analog.Basic.Resistor r(R=R)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Electrical.Analog.Basic.Resistor r2(R=R2, i(start=0)) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-20,-20})));
    Modelica.Electrical.Analog.Basic.Resistor r1(R=R1) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          origin={0,-40})));
    Modelica.Electrical.Analog.Basic.Capacitor c(C=C, v(start=VAmp, fixed=true))
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={40,-20})));
    Modelica.Electrical.Analog.Basic.Inductor l(L=L, i(fixed=true, start=0))
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={20,-20})));
    Modelica.Electrical.Analog.Sensors.VoltageSensor vOut annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={60,-20})));
  equation
    connect(opAmp.out, r.p) annotation (Line(
        points={{-30,0},{-10,0}}, color={0,0,255}));
    connect(opAmp.out, r2.p) annotation (Line(
        points={{-30,0},{-20,0},{-20,-10}}, color={0,0,255}));
    connect(r2.n, r1.p) annotation (Line(
        points={{-20,-30},{-20,-40},{-10,-40}}, color={0,0,255}));
    connect(r2.n, opAmp.in_n) annotation (Line(
        points={{-20,-30},{-20,-40},{-60,-40},{-60,-6},{-50,-6}}, color={0,0,255}));
    connect(r1.n, ground.p) annotation (Line(
        points={{10,-40},{20,-40}}, color={0,0,255}));
    connect(r.n, opAmp.in_p) annotation (Line(
        points={{10,0},{20,0},{20,20},{-60,20},{-60,6},{-50,6}}, color={0,0,255}));
    connect(l.n, ground.p) annotation (Line(
        points={{20,-30},{20,-40}}, color={0,0,255}));
    connect(r.n, l.p) annotation (Line(
        points={{10,0},{20,0},{20,-10}}, color={0,0,255}));
    connect(c.p, l.p) annotation (Line(
        points={{40,-10},{20,-10}}, color={0,0,255}));
    connect(c.n, l.n) annotation (Line(
        points={{40,-30},{20,-30}}, color={0,0,255}));
    connect(ground.p, vOut.n) annotation (Line(
        points={{20,-40},{60,-40},{60,-30}}, color={0,0,255}));
    connect(r.n, vOut.p) annotation (Line(
        points={{10,0},{60,0},{60,-10}}, color={0,0,255}));
    annotation (Documentation(info="<html>
<p>This is an LC oscillator according to:</p>
<p>U. Tietze and C. Schenk, Halbleiter-Schaltungstechnik (German), 11th edition, Springer 1999, Chapter 14.1</p>
</html>"),
      experiment(
        StartTime=0,
        StopTime=0.01,
        Tolerance=0.0001,
        Interval=1e-005));
  end LCOscillator;

  package OpAmpCircuits "Different circuits with operational amplifiers"
    partial model PartialOpAmp
      "Partial circuit of operational amplifiers"
      extends Modelica.Electrical.Analog.Interfaces.FourPin;
      parameter SI.Voltage Vps=+15 "Positive supply";
      parameter SI.Voltage Vns=-15 "Negative supply";
      parameter Real V0=15000.0 "No-load amplification";
      Ideal.IdealizedOpAmpLimited opAmp(
        V0=V0,
        final useSupply=false,
        final Vps=Vps,
        final Vns=Vns,
        out(i(start=0, fixed=false)))
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255}), Polygon(
              points={{-60,70},{70,0},{-60,-72},{-60,70}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),                      Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>
Partial model for operational amplifier circuits, based on the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a> model. 
Different functionality is achieved by different circuits.
</p>
</html>"));
    end PartialOpAmp;

    model Buffer "Non inverting operational amplifier circuit"
      extends PartialOpAmp;
      parameter Real k(final min=0)=1 "Desired amplification";
      parameter SI.Resistance R1=1000 "Resistance at negative pin(s)";
      parameter SI.Resistance R2=(k - 1)*R1 "Calculated resistance to reach desired amplification k";
      Basic.Resistor                            r1(final R=R1)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={10,-70})));
      Basic.Resistor                            r2(final R=R2)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={10,-30})));
    equation
      connect(opAmp.out, p2) annotation (Line(points={{10,0},{80,0},{80,100},{100,100}},
            color={0,0,255}));
      connect(n1, n2)
        annotation (Line(points={{-100,-100},{100,-100}}, color={0,0,255}));
      connect(n1, r1.n) annotation (Line(points={{-100,-100},{10,-100},{10,-80}},
            color={0,0,255}));
      connect(opAmp.out, r2.p)
        annotation (Line(points={{10,0},{10,-20}}, color={0,0,255}));
      connect(r2.n, r1.p)
        annotation (Line(points={{10,-40},{10,-60}}, color={0,0,255}));
      connect(r2.n, opAmp.in_n) annotation (Line(points={{10,-40},{10,-50},{-20,-50},
              {-20,6},{-10,6}}, color={0,0,255}));
      connect(opAmp.in_p, p1) annotation (Line(points={{-10,-6},{-80,-6},{-80,100},{
              -100,100}}, color={0,0,255}));
      annotation (Documentation(info="<html>
<p>Non-inverting amplifier = buffer, based on the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a> model.</p>
<p><code>vOut = k*vIn</code></p>
</html>"), Icon(graphics={
            Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
            Line(points={{-80,-80},{-80,40},{60,40}},                color = {0,0,127}),
            Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
            Polygon(
              points={{90,-80},{68,-72},{68,-88},{90,-80}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-100,10},{100,-10}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.None,
              textString="non-inverting")}));
    end Buffer;
    extends Icons.VariantsPackage;

    model Gain "Inverting operational amplifier circuit"
      extends PartialOpAmp;
      parameter Real k(final min=0)=1 "Desired amplification";
      parameter SI.Resistance R1=1000 "Resistance at negative input of OpAmp";
      parameter SI.Resistance R2=k*R1 "Calculated resistance to reach desired amplification k";
      Basic.Resistor                            r1(final R=R1)
        annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
      Basic.Resistor                            r2(final R=R2)
        annotation (Placement(transformation(extent={{30,20},{10,40}})));
    equation
      connect(opAmp.out, r2.p)
        annotation (Line(points={{10,0},{30,0},{30,30}}, color={0,0,255}));
      connect(opAmp.out, p2) annotation (Line(points={{10,0},{80,0},{80,100},{100,100}},
            color={0,0,255}));
      connect(r1.n, opAmp.in_n)
        annotation (Line(points={{-30,30},{-10,30},{-10,6}},
                                                    color={0,0,255}));
      connect(r1.n, r2.n)
        annotation (Line(points={{-30,30},{10,30}}, color={0,0,255}));
      connect(r1.p, p1) annotation (Line(points={{-50,30},{-80,30},{-80,100},{
              -100,100}},
            color={0,0,255}));
      connect(n1, opAmp.in_p) annotation (Line(points={{-100,-100},{-10,-100},{-10,-6}},
            color={0,0,255}));
      connect(n1, n2)
        annotation (Line(points={{-100,-100},{100,-100}}, color={0,0,255}));
      annotation (Documentation(info="<html>
<p>Inverting amplifier = gain, based on the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a> model.</p>
<p><code>vOut = -k*vIn</code></p>
</html>"), Icon(graphics={
            Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
            Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{90,-80},{68,-72},{68,-88},{90,-80}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
            Line(points={{-80,-80},{-80,40},{60,40}},                color = {0,0,127})}));
    end Gain;

    model Add "Adding operational amplifier circuit"
      extends PartialOpAmp;
      Modelica.SIunits.Voltage v1_2=p1_2.v - n1.v "Voltage drop of port 1_2 (= p1_2.v - n1.v)";
      Modelica.SIunits.Current i1_2=p1_2.i "Current flowing from pos. to neg. pin of port 1_2";
      parameter Real k1(final min=0)=1 "Weight of input 1";
      parameter Real k2(final min=0)=1 "Weight of input 2";
      parameter SI.Resistance R=1000 "Resistance at output of OpAmp";
      parameter SI.Resistance R1=R/k1 "Calculated resistance to reach desired weight 1";
      parameter SI.Resistance R2=R/k2 "Calculated resistance to reach desired weight 2";
      Basic.Resistor  r1(final R=R1)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-40,70})));
      Basic.Resistor  r2(final R=R2)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-40,30})));
      Interfaces.PositivePin p1_2 "Positive electrical pin 1.2" annotation (
          Placement(transformation(extent={{-110,-10},{-90,10}}),
            iconTransformation(extent={{-110,-10},{-90,10}})));
      Basic.Resistor r(final R=R) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={20,30})));
    equation
      connect(n1, n2)
        annotation (Line(points={{-100,-100},{100,-100}}, color={0,0,255}));
      connect(p1, r1.p) annotation (Line(points={{-100,100},{-80,100},{-80,70},{-50,
              70}}, color={0,0,255}));
      connect(p1_2, r2.p) annotation (Line(points={{-100,0},{-80,0},{-80,30},{-50,30}},
            color={0,0,255}));
      connect(n1, opAmp.in_p) annotation (Line(points={{-100,-100},{-10,-100},{-10,-6}},
            color={0,0,255}));
      connect(r2.n, opAmp.in_n)
        annotation (Line(points={{-30,30},{-10,30},{-10,6}}, color={0,0,255}));
      connect(opAmp.in_n, r1.n)
        annotation (Line(points={{-10,6},{-10,70},{-30,70}}, color={0,0,255}));
      connect(opAmp.in_n, r.n)
        annotation (Line(points={{-10,6},{-10,30},{10,30}}, color={0,0,255}));
      connect(opAmp.out, r.p)
        annotation (Line(points={{10,0},{30,0},{30,30}}, color={0,0,255}));
      connect(opAmp.out, p2) annotation (Line(points={{10,0},{80,0},{80,100},{100,100}},
            color={0,0,255}));
      annotation (Documentation(info="<html>
<p>Inverting adder, based on the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a> model.</p>
<p><code>-vOut = k1*vIn1 + k2*vIn2</code></p>
</html>"),     Icon(graphics={Text(
              extent={{-40,40},{40,-40}},
              lineColor={0,0,255},
              textString="+")}));
    end Add;

    model Feedback "Subtracting operational amplifier circuit"
      extends PartialOpAmp;
      Modelica.SIunits.Voltage v1_2=p1_2.v - n1.v "Voltage drop of port 1_2 (= p1_2.v - n1.v)";
      Modelica.SIunits.Current i1_2=p1_2.i "Current flowing from pos. to neg. pin of port 1_2";
      parameter Real k(final min=0)=1 "Desired amplification";
      parameter SI.Resistance R1=1000 "Resistance at inputs of OpAmp";
      parameter SI.Resistance R3=R1/k "Calculated resistance to reach desired amplification k";
      Basic.Resistor                            r1(final R=R1)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-40,70})));
      Basic.Resistor                            r2(final R=R1)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-40,-70})));
      Interfaces.PositivePin p1_2 "Positive electrical pin 1.2" annotation (
          Placement(transformation(extent={{-110,-10},{-90,10}}),
            iconTransformation(extent={{-110,-10},{-90,10}})));
      Basic.Resistor                            r3(final R=R3)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=0,
            origin={20,70})));
      Basic.Resistor                            r4(final R=R3)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=180,
            origin={20,-70})));
    equation
      connect(n1, n2)
        annotation (Line(points={{-100,-100},{100,-100}}, color={0,0,255}));
      connect(p1, r1.p) annotation (Line(points={{-100,100},{-80,100},{-80,70},{-50,
              70}}, color={0,0,255}));
      connect(r1.n, opAmp.in_n)
        annotation (Line(points={{-30,70},{-10,70},{-10,6}}, color={0,0,255}));
      connect(r1.n, r3.n)
        annotation (Line(points={{-30,70},{10,70}}, color={0,0,255}));
      connect(opAmp.out, r3.p)
        annotation (Line(points={{10,0},{30,0},{30,70}}, color={0,0,255}));
      connect(opAmp.out, p2) annotation (Line(points={{10,0},{80,0},{80,100},{100,100}},
            color={0,0,255}));
      connect(p1_2, r2.p) annotation (Line(points={{-100,0},{-80,0},{-80,-70},{-50,-70}},
            color={0,0,255}));
      connect(r2.n, opAmp.in_p)
        annotation (Line(points={{-30,-70},{-10,-70},{-10,-6}}, color={0,0,255}));
      connect(opAmp.in_p, r4.p)
        annotation (Line(points={{-10,-6},{-10,-70},{10,-70}}, color={0,0,255}));
      connect(n1, r4.n) annotation (Line(points={{-100,-100},{30,-100},{30,-70}},
            color={0,0,255}));
      annotation (Documentation(info="<html>
<p>Inverting subtracter = feedback, based on the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a> model.</p>
<p><code>vOut = -k*(vIn1 - vIn2)</code></p>
</html>"),     Icon(graphics={Text(
              extent={{-40,40},{40,-40}},
              lineColor={0,0,255},
              textString="-")}));
    end Feedback;

    model Der "Differentiating operational amplifier circuit"
      extends PartialOpAmp;
      import Modelica.Constants.pi;
      parameter Real k(final min=0)=1 "Desired amplification at frequency f";
      parameter Modelica.SIunits.Frequency f "Frequency";
      parameter SI.Resistance R=1000 "Resistance at output of OpAmp";
      parameter SI.Capacitance C=k/(2*pi*f*R) "Calculated capacitance to reach desired amplification k";
      Modelica.SIunits.Voltage v(start=0)=c.v "Capacitor voltage = state";
      Basic.Capacitor                            c(final C=C)
        annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
      Basic.Resistor                            r(final R=R)
        annotation (Placement(transformation(extent={{30,20},{10,40}})));
    equation
      connect(n1, n2)
        annotation (Line(points={{-100,-100},{100,-100}}, color={0,0,255}));
      connect(opAmp.out, p2) annotation (Line(points={{10,0},{80,0},{80,100},{100,100}},
            color={0,0,255}));
      connect(c.n, opAmp.in_n)
        annotation (Line(points={{-30,30},{-10,30},{-10,6}}, color={0,0,255}));
      connect(opAmp.in_n, r.n)
        annotation (Line(points={{-10,6},{-10,30},{10,30}}, color={0,0,255}));
      connect(opAmp.out, r.p)
        annotation (Line(points={{10,0},{30,0},{30,30}}, color={0,0,255}));
      connect(c.p, p1) annotation (Line(points={{-50,30},{-80,30},{-80,100},{
              -100,100}}, color={0,0,255}));
      connect(n1, opAmp.in_p) annotation (Line(points={{-100,-100},{-10,-100},{
              -10,-6}}, color={0,0,255}));
      annotation (Documentation(info="<html>
<p>Inverting differentiator = der, based on the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a> model.</p>
<p><code>vOut = -k*der(vIn)</code></p>
</html>"),     Icon(graphics={Text(
              extent={{-60,40},{20,-40}},
              lineColor={0,0,255},
              textString="der")}));
    end Der;

    model Integrator "Integrating operational amplifier circuit"
      extends PartialOpAmp(v2(start=0));
      import Modelica.Constants.pi;
      parameter Real k(final min=0)=1 "Desired amplification at frequency f";
      parameter Modelica.SIunits.Frequency f "Frequency";
      parameter SI.Resistance R=1000 "Resistance at negative input of OpAmp";
      parameter SI.Capacitance C=1/k/(2*pi*f*R) "Calculated capacitance to reach desired amplification k";
      Basic.Capacitor  c(final C=C)
        annotation (Placement(transformation(extent={{30,20},{10,40}})));
      Basic.Resistor r(final R=R)
        annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
    equation
      connect(n1, n2)
        annotation (Line(points={{-100,-100},{100,-100}}, color={0,0,255}));
      connect(opAmp.out, p2) annotation (Line(points={{10,0},{80,0},{80,100},{100,100}},
            color={0,0,255}));
      connect(n1, opAmp.in_p) annotation (Line(points={{-100,-100},{-10,-100},{-10,-6}},
            color={0,0,255}));
      connect(r.p, p1) annotation (Line(points={{-50,30},{-80,30},{-80,100},{-100,100}},
            color={0,0,255}));
      connect(r.n, opAmp.in_n)
        annotation (Line(points={{-30,30},{-10,30},{-10,6}}, color={0,0,255}));
      connect(opAmp.in_n, c.n)
        annotation (Line(points={{-10,6},{-10,30},{10,30}}, color={0,0,255}));
      connect(opAmp.out, c.p)
        annotation (Line(points={{10,0},{30,0},{30,30}}, color={0,0,255}));
      annotation (Documentation(info="<html>
<p>Inverting integrator, based on the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a> model.</p>
<p><code>k*vin = -der(dvOut)</code></p>
</html>"), Icon(graphics={
              Polygon(
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid,
                points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}),
              Line(
                points={{-80.0,78.0},{-80.0,-90.0}},
                color={192,192,192}),
              Line(
                points=DynamicSelect({{-80.0,-80.0},{80.0,80.0}}, if use_reset then {{-80.0,-80.0},{60.0,60.0},{60.0,-80.0},{80.0,-60.0}} else {{-80.0,-80.0},{80.0,80.0}}),
                color={0,0,127}),
              Line(
                points={{-90.0,-80.0},{82.0,-80.0}},
                color={192,192,192}),
              Polygon(
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid,
                points={{90.0,-80.0},{68.0,-72.0},{68.0,-88.0},{90.0,-80.0}}),
                              Text(
              extent={{-80,40},{0,-40}},
              lineColor={0,0,255},
              textString="I")}));
    end Integrator;

    model FirstOrder "Lowpass filter operational amplifier circuit"
      extends PartialOpAmp(v2(start=0));
      import Modelica.Constants.pi;
      parameter Real k(final min=0)=1 "Desired amplification";
      parameter SI.Resistance R1=1000 "Resistance at negative input of OpAmp";
      parameter SI.Resistance R2=k*R1 "Calculated resistance to reach k";
      parameter SI.Time T "Time constant";
      parameter SI.Capacitance C=T/R2 "Calculated capacitance to reach T";
      Basic.Resistor                            r1(R=R1)
        annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
      Basic.Resistor                            r2(R=R2)
        annotation (Placement(transformation(extent={{30,20},{10,40}})));
      Basic.Capacitor                            c(C=C)
        annotation (Placement(transformation(extent={{30,40},{10,60}})));
    equation
      connect(n1, n2)
        annotation (Line(points={{-100,-100},{100,-100}}, color={0,0,255}));
      connect(opAmp.out, p2) annotation (Line(points={{10,0},{80,0},{80,100},{100,100}},
            color={0,0,255}));
      connect(n1, opAmp.in_p) annotation (Line(points={{-100,-100},{-10,-100},{-10,-6}},
            color={0,0,255}));
      connect(r1.p, p1) annotation (Line(points={{-50,30},{-80,30},{-80,100},{-100,100}},
            color={0,0,255}));
      connect(r1.n, opAmp.in_n)
        annotation (Line(points={{-30,30},{-10,30},{-10,6}}, color={0,0,255}));
      connect(opAmp.in_n, r2.n)
        annotation (Line(points={{-10,6},{-10,30},{10,30}}, color={0,0,255}));
      connect(opAmp.in_n, c.n)
        annotation (Line(points={{-10,6},{-10,50},{10,50}}, color={0,0,255}));
      connect(opAmp.out, r2.p)
        annotation (Line(points={{10,0},{30,0},{30,30}}, color={0,0,255}));
      connect(opAmp.out, c.p)
        annotation (Line(points={{10,0},{30,0},{30,50}}, color={0,0,255}));
      annotation (Documentation(info="<html>
<p>Inverting lowpass filter = first order, based on the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a> model.</p>
<p>Transfer function: <code>vOut/vIn = -k/(1 + s*T)</code></p>
</html>"), Icon(graphics={
      Polygon(lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid,
        points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}),
      Line(points={{-80.0,78.0},{-80.0,-90.0}},
        color={192,192,192}),
      Line(origin = {-26.667,6.667},
          points = {{106.667,43.333},{-13.333,29.333},{-53.333,-86.667}},
          color = {0,0,127},
          smooth = Smooth.Bezier),
      Line(points={{-90.0,-80.0},{82.0,-80.0}},
        color={192,192,192}),
      Polygon(lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid,
        points={{90.0,-80.0},{68.0,-72.0},{68.0,-88.0},{90.0,-80.0}})}));
    end FirstOrder;

    model Derivative "Lowpass filter operational amplifier circuit"
      extends PartialOpAmp;
      import Modelica.Constants.pi;
      parameter Real k(final min=0)=1 "Desired amplification";
      parameter SI.Resistance R1=1000 "Resistance at negative input of OpAmp";
      parameter SI.Resistance R2=k*R1 "Calculated resistance to reach k";
      parameter SI.Time T "Time constant";
      parameter SI.Capacitance C=T/R1 "Calculated capacitance to reach T";
      Modelica.SIunits.Voltage v(start=0)=c.v "Capacitor voltage = state";
      Basic.Resistor                            r1(R=R1)
        annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
      Basic.Resistor                            r2(R=R2)
        annotation (Placement(transformation(extent={{30,20},{10,40}})));
      Basic.Capacitor                            c(C=C)
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    equation
      connect(n1, n2)
        annotation (Line(points={{-100,-100},{100,-100}}, color={0,0,255}));
      connect(opAmp.out, p2) annotation (Line(points={{10,0},{80,0},{80,100},{100,100}},
            color={0,0,255}));
      connect(n1, opAmp.in_p) annotation (Line(points={{-100,-100},{-10,-100},{-10,-6}},
            color={0,0,255}));
      connect(r1.n, opAmp.in_n)
        annotation (Line(points={{-30,30},{-10,30},{-10,6}}, color={0,0,255}));
      connect(opAmp.in_n, r2.n)
        annotation (Line(points={{-10,6},{-10,30},{10,30}}, color={0,0,255}));
      connect(opAmp.out, r2.p)
        annotation (Line(points={{10,0},{30,0},{30,30}}, color={0,0,255}));
      connect(c.n, r1.p)
        annotation (Line(points={{-60,30},{-50,30}}, color={0,0,255}));
      connect(c.p, p1)
        annotation (Line(points={{-80,30},{-80,100},{-100,100}}, color={0,0,255}));
      annotation (Documentation(info="<html>
<p>Inverting highpass filter = derivative, based on the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a> model.</p>
<p>Transfer function: <code>vOut/vIn = -k*s/(1 + s*T)</code></p>
</html>"), Icon(graphics={
      Polygon(lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid,
        points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}),
        Line(points={{-80.0,78.0},{-80.0,-90.0}},
          color={192,192,192}),
      Line(origin = {-24.667,-27.333},
        points = {{-55.333,87.333},{-19.333,-40.667},{86.667,-52.667}},
        color = {0,0,127},
        smooth = Smooth.Bezier),
      Line(points={{-90.0,-80.0},{82.0,-80.0}},
        color={192,192,192}),
      Polygon(lineColor={192,192,192},
        fillColor={192,192,192},
        fillPattern=FillPattern.Solid,
        points={{90.0,-80.0},{68.0,-72.0},{68.0,-88.0},{90.0,-80.0}})}));
    end Derivative;

    model PI "PI controller operational amplifier circuit"
      extends PartialOpAmp(v2(start=0));
      import Modelica.Constants.pi;
      parameter Real k(final min=0)=1 "Desired amplification";
      parameter SI.Resistance R1=1000 "Resistance at negative input of OpAmp";
      parameter SI.Resistance R2=k*R1 "Calculated resistance to reach k";
      parameter SI.Time T "Time constant";
      parameter SI.Capacitance C=T/k/R1 "Calculated capacitance to reach T";
      Basic.Resistor                            r1(R=R1)
        annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
      Basic.Resistor                            r2(R=R2)
        annotation (Placement(transformation(extent={{30,20},{10,40}})));
      Basic.Capacitor                            c(C=C)
        annotation (Placement(transformation(extent={{60,20},{40,40}})));
    equation
      connect(n1, n2)
        annotation (Line(points={{-100,-100},{100,-100}}, color={0,0,255}));
      connect(opAmp.out, p2) annotation (Line(points={{10,0},{80,0},{80,100},{100,100}},
            color={0,0,255}));
      connect(n1, opAmp.in_p) annotation (Line(points={{-100,-100},{-10,-100},{-10,-6}},
            color={0,0,255}));
      connect(r1.n, opAmp.in_n)
        annotation (Line(points={{-30,30},{-10,30},{-10,6}}, color={0,0,255}));
      connect(opAmp.in_n, r2.n)
        annotation (Line(points={{-10,6},{-10,30},{10,30}}, color={0,0,255}));
      connect(p1, r1.p) annotation (Line(points={{-100,100},{-80,100},{-80,30},{-50,
              30}}, color={0,0,255}));
      connect(r2.p, c.n)
        annotation (Line(points={{30,30},{40,30}}, color={0,0,255}));
      connect(opAmp.out, c.p)
        annotation (Line(points={{10,0},{60,0},{60,30}}, color={0,0,255}));
      annotation (defaultComponentName="PI", Documentation(info="<html>
<p>Inverting proportional-integral controller = PI, based on the <a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealizedOpAmpLimited\">IdealizedOpAmpLimited</a> model.</p>
<p>Transfer function: <code>vOut/vIn = -k*s/(1 + s*T)</code></p>
</html>"),     Icon(graphics={
            Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
            Line(points = {{-80.0,-80.0},{-80.0,-20.0},{60.0,80.0}}, color = {0,0,127}),
            Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
            Polygon(
              points={{90,-80},{68,-72},{68,-88},{90,-80}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid)}));
    end PI;
    annotation (Documentation(info="<html>
<p>This package provides some fully connected operational amplifiers circuts.
</p>
</html>"));
  end OpAmpCircuits;
  annotation (Documentation(info="<html>
<p>This package contains applications examples of the components provided in the package
<a href=\"Modelica.Electrical.Analog.Examples.OpAmps.OpAmpCircuits\">OpAmpCircuits</a>.
</p>
</html>"));
end OpAmps;
