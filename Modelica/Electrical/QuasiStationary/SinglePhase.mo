within Modelica.Electrical.QuasiStationary;
package SinglePhase "Single phase AC components"
  extends Modelica.Icons.Package;

  package Examples "Test examples"
    extends Modelica.Icons.ExamplesPackage;

    model SeriesBode "Series circuit with Bode analysis"
      extends Modelica.Icons.Example;
      output Real abs_y = bode.abs_y "Magnitude of voltage ratio";
      output Modelica.SIunits.AmplitudeLevelDifference dB_y = bode.dB_y "Log10 of magnitude of voltage ratio in dB";
      output Modelica.SIunits.Angle arg_y = bode.arg_y "Angle of voltage ratio";
      ComplexBlocks.Sources.LogFrequencySweep frequencySweep(duration=1,wMin=0.01,wMax=100) annotation (Placement(transformation(
            origin={-70,-40},
            extent={{-10,-10},{10,10}})));
      QuasiStationary.SinglePhase.Sources.VariableVoltageSource voltageSource(gamma(fixed=true, start=0)) annotation (Placement(transformation(
            origin={-30,-20},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      QuasiStationary.SinglePhase.Basic.Ground ground annotation (Placement(
            transformation(extent={{-40,-60},{-20,-40}})));
      QuasiStationary.SinglePhase.Basic.Resistor resistor(R_ref=1)   annotation (Placement(transformation(extent={{20,-10},{40,10}})));
      QuasiStationary.SinglePhase.Basic.Inductor inductor(L=1/(2*Modelica.Constants.pi)) annotation (Placement(transformation(extent={{50,-10},{70,10}})));
      ComplexBlocks.Sources.ComplexConstant complexConst(k=Complex(1, 0)) annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      Sensors.CurrentSensor currentSensor annotation (Placement(transformation(extent={{10,10},{-10,-10}},
            rotation=180,
            origin={-10,0})));
      Sensors.VoltageSensor voltageSensor annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            origin={30,20})));
      ComplexBlocks.ComplexMath.Bode bode annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=180,
            origin={-70,30})));
    equation
      connect(frequencySweep.y, voltageSource.f) annotation (Line(points={{-59,-40},{-50,-40},{-50,-26},{-42,-26}}, color={0,0,127}));
      connect(ground.pin, voltageSource.pin_n) annotation (Line(points={{-30,-40},
              {-30,-35},{-30,-30}}, color={85,170,255}));
      connect(resistor.pin_n, inductor.pin_p) annotation (Line(points={{40,0},{50,0}},
                                      color={85,170,255}));
      connect(complexConst.y, voltageSource.V) annotation (Line(points={{-59,0},{-50,0},{-50,-14},{-42,-14}}, color={85,170,255}));
      connect(voltageSensor.pin_p, resistor.pin_p) annotation (Line(points={{20,20},{10,20},{10,0},{20,0}},
                                                                                                   color={85,170,255}));
      connect(voltageSensor.pin_n, inductor.pin_p) annotation (Line(points={{40,20},{50,20},{50,0}}, color={85,170,255}));
      connect(ground.pin, inductor.pin_n) annotation (Line(points={{-30,-40},{80,-40},{80,0},{70,0}}, color={85,170,255}));
      connect(bode.divisor, complexConst.y) annotation (Line(points={{-58,24},{-50,24},{-50,0},{-59,0}}, color={85,170,255}));
      connect(bode.u, voltageSensor.y) annotation (Line(points={{-58,36},{30,36},{30,31}}, color={85,170,255}));
      connect(currentSensor.pin_p, voltageSource.pin_p) annotation (Line(points={{-20,0},{-30,0},{-30,-10}}, color={85,170,255}));
      connect(currentSensor.pin_n, resistor.pin_p) annotation (Line(points={{0,0},{20,0}}, color={85,170,255}));
      annotation (Documentation(info="<html>
<p>
The frequency of the voltage source is varied by a logarithmic ramp, the supply voltage magnitude is constant.</p>
<p>Plot versus <code>voltageSource.f</code> on a logarithmic scale in order to determine the Bode diagrams of the ratio of
the voltage of the resistor divided by the supply voltage:</p>
<ul>
<li>Gain response: <code>dB_y</code></li>
<li>Phase response: <code>arg_y</code></li>
</ul>
</html>"), experiment(StopTime=1.0, Interval=0.001));
    end SeriesBode;

    model SeriesResonance "Series resonance circuit"
      extends Modelica.Icons.Example;
      output Modelica.SIunits.Current I_abs=complexToPolar.len "Current";
      output Modelica.SIunits.Angle I_arg=complexToPolar.phi "Current phase";
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
      QuasiStationary.SinglePhase.Sources.VariableVoltageSource voltageSource(
          gamma(fixed=true, start=0)) annotation (Placement(transformation(
            origin={-30,-20},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      QuasiStationary.SinglePhase.Basic.Ground ground annotation (Placement(
            transformation(extent={{-40,-60},{-20,-40}})));
      QuasiStationary.SinglePhase.Basic.Resistor resistor(R_ref=0.1)
        annotation (Placement(transformation(extent={{10,-10},{30,10}})));
      QuasiStationary.SinglePhase.Basic.Inductor inductor(L=1/(2*Modelica.Constants.pi))
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      QuasiStationary.SinglePhase.Basic.Capacitor capacitor(C=1/(2*Modelica.Constants.pi))
        annotation (Placement(transformation(extent={{70,-10},{90,10}})));
      QuasiStationary.SinglePhase.Sensors.CurrentSensor currentSensor
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
      connect(currentSensor.y, complexToPolar.u) annotation (Line(
          points={{-10,11},{-10,18}}, color={85,170,255}));
      annotation (Documentation(info="<html>
<p>
The frequency of the voltage source is varied by a ramp.
Plot length and angle of the current phasor, i.e., complexToPolar.len and .phi, versus time resp. frequency.
</p>
</html>"), experiment(StopTime=1.0, Interval=0.001));
    end SeriesResonance;

    model ParallelResonance "Parallel resonance circuit"
      extends Modelica.Icons.Example;
      output Modelica.SIunits.Voltage V_abs=complexToPolar.len "Voltage";
      output Modelica.SIunits.Angle V_arg=complexToPolar.phi "Voltage phase";
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
      QuasiStationary.SinglePhase.Sources.VariableCurrentSource currentSource(
          gamma(fixed=true, start=0)) annotation (Placement(transformation(
            origin={-30,20},
            extent={{10,10},{-10,-10}},
            rotation=270)));
      QuasiStationary.SinglePhase.Basic.Ground ground annotation (Placement(
            transformation(extent={{-40,-20},{-20,0}})));
      QuasiStationary.SinglePhase.Basic.Resistor resistor(R_ref=10) annotation (
         Placement(transformation(
            origin={-10,20},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      QuasiStationary.SinglePhase.Basic.Inductor inductor(L=1/(2*Modelica.Constants.pi))
        annotation (Placement(transformation(
            origin={10,20},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      QuasiStationary.SinglePhase.Basic.Capacitor capacitor(C=1/(2*Modelica.Constants.pi))
        annotation (Placement(transformation(
            origin={30,20},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      QuasiStationary.SinglePhase.Sensors.VoltageSensor voltageSensor
        annotation (Placement(transformation(
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
      connect(voltageSensor.y, complexToPolar.u) annotation (Line(
          points={{61,20},{68,20}}, color={85,170,255}));
      annotation (Documentation(info="<html>
<p>
The frequency of the current source is varied by a ramp.
Plot length and angle of the voltage phasor, i.e., complexToPolar.len and .phi, versus time resp. frequency.
</p>
</html>"), experiment(StopTime=1.0, Interval=0.001));
    end ParallelResonance;

    model Rectifier "Rectifier example"
      extends Modelica.Icons.Example;
      import Modelica.Constants.pi;
      parameter Modelica.SIunits.Voltage VAC=100 "AC rms voltage";
      parameter Real conversionFactor=1 "Ratio of DC voltage / AC rms voltage";
      output Modelica.SIunits.Current Itr=iAC.y_rms "Transient current";
      output Modelica.SIunits.Current Iqs=iQS.len "QS current";
      Sources.VoltageSource voltageQS(
        f=50,
        V=VAC,
        phi=0,
        i(re(start=0), im(start=0)),
        gamma(fixed=true, start=0)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-80,50})));
      Basic.Resistor resistorQS(R_ref=50E-3)
        annotation (Placement(transformation(extent={{-72,50},{-52,70}})));
      Sensors.CurrentSensor currentSensorQS
        annotation (Placement(transformation(extent={{-40,70},{-20,50}})));
      ComplexBlocks.ComplexMath.ComplexToPolar iQS
        annotation (Placement(transformation(extent={{-20,70},{0,90}})));
      Basic.Ground groundQS
        annotation (Placement(transformation(extent={{-20,10},{0,30}})));
      Utilities.IdealACDCConverter rectifierQS(conversionFactor=
            conversionFactor)
        annotation (Placement(transformation(extent={{-10,40},{10,60}})));
      Analog.Basic.Ground groundDC1
        annotation (Placement(transformation(extent={{0,10},{20,30}})));
      Analog.Sensors.CurrentSensor iDC1
        annotation (Placement(transformation(extent={{20,70},{40,50}})));
      Analog.Basic.VariableConductor load1 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={50,50})));
      Analog.Sources.SineVoltage voltageAC(
        V=sqrt(2)*VAC,
        freqHz=50,
        phase=pi/2) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-80,-50})));
      Analog.Basic.Resistor resistorAC(R=50E-3)
        annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
      Analog.Sensors.CurrentSensor currentSensorAC
        annotation (Placement(transformation(extent={{-40,-30},{-20,-50}})));
      Modelica.Blocks.Math.Harmonic iAC(f=50, k=1)
        annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
      Analog.Basic.Ground groundAC
        annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
      Utilities.GraetzRectifier rectifierAC
        annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
      Analog.Sensors.CurrentSensor currentSensorDC2
        annotation (Placement(transformation(extent={{20,-30},{40,-50}})));
      Modelica.Blocks.Math.RootMeanSquare iDC2(f=50)
        annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
      Analog.Basic.VariableConductor load2 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={50,-50})));
      Blocks.Sources.Ramp ramp(
        height=1,
        duration=0.8,
        startTime=0.1)
        annotation (Placement(transformation(extent={{100,-10},{80,10}})));
    equation
      connect(voltageQS.pin_p, resistorQS.pin_p) annotation (Line(
          points={{-80,60},{-72,60}}, color={85,170,255}));
      connect(voltageQS.pin_n, rectifierQS.pin_nQS) annotation (Line(
          points={{-80,40},{-10,40}}, color={85,170,255}));
      connect(rectifierQS.pin_nQS, groundQS.pin) annotation (Line(
          points={{-10,40},{-10,30}}, color={85,170,255}));
      connect(rectifierQS.pin_nDC, groundDC1.p) annotation (Line(
          points={{10,40},{10,30}}, color={0,0,255}));
      connect(load1.n, rectifierQS.pin_nDC) annotation (Line(
          points={{50,40},{10,40}}, color={0,0,255}));
      connect(voltageAC.p, resistorAC.p) annotation (Line(
          points={{-80,-40},{-70,-40}}, color={0,0,255}));
      connect(voltageAC.n, rectifierAC.pin_nAC) annotation (Line(
          points={{-80,-60},{-10,-60}}, color={0,0,255}));
      connect(rectifierAC.pin_nAC, groundAC.p) annotation (Line(
          points={{-10,-60},{-10,-70}}, color={0,0,255}));
      connect(rectifierAC.pin_nDC, load2.n) annotation (Line(
          points={{10,-60},{50,-60}}, color={0,0,255}));
      connect(ramp.y, load1.G) annotation (Line(
          points={{79,0},{70,0},{70,50},{61,50}}, color={0,0,127}));
      connect(ramp.y, load2.G) annotation (Line(
          points={{79,0},{70,0},{70,-50},{61,-50}}, color={0,0,127}));
      connect(resistorQS.pin_n, currentSensorQS.pin_p) annotation (Line(
          points={{-52,60},{-40,60}}, color={85,170,255}));
      connect(currentSensorQS.pin_n, rectifierQS.pin_pQS) annotation (Line(
          points={{-20,60},{-10,60}}, color={85,170,255}));
      connect(currentSensorQS.y, iQS.u) annotation (Line(
          points={{-30,71},{-30,80},{-22,80}}, color={85,170,255}));
      connect(rectifierQS.pin_pDC, iDC1.p) annotation (Line(
          points={{10,60},{20,60}}, color={0,0,255}));
      connect(iDC1.n, load1.p) annotation (Line(
          points={{40,60},{50,60}}, color={0,0,255}));
      connect(resistorAC.n, currentSensorAC.p) annotation (Line(
          points={{-50,-40},{-40,-40}}, color={0,0,255}));
      connect(currentSensorAC.n, rectifierAC.pin_pAC) annotation (Line(
          points={{-20,-40},{-10,-40}}, color={0,0,255}));
      connect(currentSensorAC.i, iAC.u) annotation (Line(
          points={{-30,-30},{-30,-20},{-22,-20}}, color={0,0,127}));
      connect(currentSensorDC2.i, iDC2.u) annotation (Line(
          points={{30,-30},{30,-20},{38,-20}}, color={0,0,127}));
      connect(currentSensorDC2.p, rectifierAC.pin_pDC) annotation (Line(
          points={{20,-40},{10,-40}}, color={0,0,255}));
      connect(currentSensorDC2.n, load2.p) annotation (Line(
          points={{40,-40},{50,-40}}, color={0,0,255}));
      annotation (Documentation(info="<html>
<p>
This example demonstrates coupling a quasi stationary circuit with a DC circuit.
The QS voltage is rectified (using an
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Utilities.IdealACDCConverter\">
ideal AC DC converter</a>), loaded by a variable load conductor.
The <em>conversionFactor = DC voltage / AC rms voltage</em> in this case is the root mean square of a rectified sine, i.e., 1.
You may compare the quasi stationary results with that of a fully transient model (using a
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Utilities.GraetzRectifier\">
Graetz rectifier</a>), plotting:
</p>
<ul>
<li>QS: AC rms           current = iQS.len</li>
<li>AC: AC instantaneous current = iAC.u</li>
<li>AC: AC rms           current = iAC.y_rms</li>
<li>QS: DC current               = iDC1.i</li>
<li>AC: DC instantaneous current = iDC2.u</li>
<li>AC: DC rms           current = iDC2.y</li>
</ul>
<p>
It can be seen that at the DC side the current is represented by its averaged value, at the AC side by its rms value.
</p>
<h4>Note</h4>
<p>
The quasi stationary model needs a grounding at the QS side as well as the DC side,
whereas the transient model may have only one ground since AC side and DC side are connected via the diodes.
</p>
</html>"), experiment(StopTime=1.0, Interval=0.0001));
    end Rectifier;

    model Transformer "Example of transformer with short circuit impedance, transmission resistances and load"
      extends Modelica.Icons.Example;
      Sources.VoltageSource voltageSource(
        f=50,
        V=1000,
        phi=0,
        gamma(fixed=true, start=0)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-90,-30})));
      Ideal.IdealTransformer idealTransformer(n=5) annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
      Sensors.PowerSensor sensor0 annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
      Basic.Impedance zk(Z_ref(re=0.72, im=0.96)) annotation (Placement(transformation(
            extent={{-10,-10}, {10,10}},
            origin={-20,-10})));
      Sources.VariableCurrentSource load(gamma(fixed=true, start=0)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={80,-30})));
      Sensors.PowerSensor sensorL annotation (Placement(transformation(extent={{50,-20},{70,0}})));
      Basic.Ground ground1 annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
      Basic.Ground ground2 annotation (Placement(transformation(extent={{30,-70},{50,-50}})));
      Sensors.VoltageSensor v2 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={40,-32})));
      ComplexBlocks.ComplexMath.PolarToComplex polarToComplex annotation (Placement(transformation(extent={{60,52},{80,72}})));
      Blocks.Sources.Constant const(k=250) annotation (Placement(transformation(extent={{-34,70},{-14,90}})));
      Blocks.Sources.Ramp ramp(
        duration=1,
        offset=0,
        startTime=0,
        height=2*Modelica.Constants.pi) annotation (Placement(transformation(extent={{-14,40},{6,60}})));
      Blocks.Sources.Constant constFrequency(k=50) annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
      Sensors.CurrentSensor i2 annotation (Placement(transformation(extent={{20,-20},{40,0}})));
      Sensors.CurrentSensor i1 annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
    equation
      connect(voltageSource.pin_p, sensor0.currentP) annotation (Line(points={{-90,-20},{-90,-20},{-90,-10},{-80,-10}}, color={85,170,255}));
      connect(zk.pin_n, idealTransformer.pin_p1) annotation (Line(points={{-10,-10},{-10,-20}}, color={85,170,255}));
      connect(sensorL.voltageP, sensorL.currentP) annotation (Line(points={{60,0},{50,0},{50,-10}}, color={85,170,255}));
      connect(voltageSource.pin_n, ground1.pin) annotation (Line(points={{-90,-40},{-90,-40},{-90,-50}}, color={85,170,255}));
      connect(ground1.pin, idealTransformer.pin_n1) annotation (Line(points={{-90,-50},{-10,-50},{-10,-40}}, color={85,170,255}));
      connect(sensor0.currentP, sensor0.voltageP) annotation (Line(points={{-80,-10},{-80,-10},{-80,0},{-70,0}}, color={85,170,255}));
      connect(sensor0.voltageN, ground1.pin) annotation (Line(points={{-70,-20},{-70,-50},{-90,-50}}, color={85,170,255}));
      connect(v2.pin_n, ground2.pin) annotation (Line(points={{40,-42},{40,-42},{40,-50}}, color={85,170,255}));
      connect(const.y, polarToComplex.len) annotation (Line(points={{-13,80},{-4,80},{20,80},{20,68},{58,68}}, color={0,0,127}));
      connect(ramp.y, polarToComplex.phi) annotation (Line(points={{7,50},{20,50},{20,50},{20,56},{58,56}}, color={0,0,127}));
      connect(load.pin_p, sensorL.currentN) annotation (Line(points={{80,-20},{80,-20},{80,-12},{80,-10},{70,-10}}, color={85,170,255}));
      connect(sensorL.voltageN, ground2.pin) annotation (Line(points={{60,-20},{60,-20},{60,-44},{60,-50},{40,-50}}, color={85,170,255}));
      connect(load.pin_n, ground2.pin) annotation (Line(points={{80,-40},{80,-40},{80,-50},{40,-50}}, color={85,170,255}));
      connect(ground2.pin, idealTransformer.pin_n2) annotation (Line(points={{40,-50},{10,-50},{10,-39.8}},
                                                                                                          color={85,170,255}));
      connect(load.I, polarToComplex.y) annotation (Line(points={{92,-24},{100,-24},{100,62},{81,62}}, color={85,170,255}));
      connect(load.f, constFrequency.y) annotation (Line(points={{92,-36},{100,-36},{100,-80},{81,-80}}, color={0,0,127}));
      connect(sensorL.currentP, v2.pin_p) annotation (Line(points={{50,-10},{40,-10},{40,-22}}, color={85,170,255}));
      connect(i2.pin_n, sensorL.currentP) annotation (Line(points={{40,-10},{40,-10},{50,-10}}, color={85,170,255}));
      connect(sensor0.currentN, i1.pin_p) annotation (Line(points={{-60,-10},{-60,-10}}, color={85,170,255}));
      connect(i1.pin_n, zk.pin_p) annotation (Line(points={{-40,-10},{-35,-10},{-30,-10}}, color={85,170,255}));
      connect(idealTransformer.pin_p2, i2.pin_p) annotation (Line(points={{10,-20},{12,-20},{12,-10},{20,-10}}, color={85,170,255}));
      annotation (experiment(StopTime=1),Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Rectangle(
              extent={{50,10},{96,-60}},
              pattern=LinePattern.Dash,
              fillColor={255,255,170},
              fillPattern=FillPattern.Solid), Rectangle(
              extent={{-40,10},{20,-60}},
              pattern=LinePattern.Dash,
              fillColor={255,255,170},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-60,30},{40,10}},
              lineColor={28,108,200},
              textString="transformer with short
circuit impedance"),
            Text(
              extent={{50,30},{96,10}},
              lineColor={28,108,200},
              textString="load current")}),
        Documentation(info="<html>
<p>This examples shows the operational behavior of transformer with short circuit impedance. The transformer is loaded with constant current magnitude of 250A but variable phase angle. The angle varies from 0 to 360 degrees within one second of simulation time.
</p>

<p>Transformer data</p>
<ul>
<li>Nominal primary voltage <code>V1N = 1000 V</code></li>
<li>Nominal secondary voltage <code>V2N = 200 V</code></li>
<li>Nominal apparent power  <code>SN = 50 kVA</code></li>
<li>Short circuit impedance <code><u>Z</u><sub>k</sub> = 0.72 Ohm + j*0.96 Ohm</code></li>
<li>Magnetizing current and core loss are not taken into account</li>
</ul>

<p>Plot the real part of the secondary voltage <code>idealTransformer.v2.re</code> on the x axis and <code>idealTransformer.v2.im</code> on the y axis. The locus of this complex voltage <code><u>v</u><sub>2</sub></code> is a circle. The center of the circle is the primary supply voltage divided by the transformation ratio of <code>n=5</code>. Since in this experiment the load current magnitude is constant, the voltage drop across the short circuit impedance of the transformer is constant, as well. The radius of the circle is equal to the constant magnitude of the voltage drop across the short circuit impedance.</p>
</html>"));
    end Transformer;
    annotation (Documentation(info="<html>
Examples to demonstrate the usage of quasistationary electric components.
</html>"));
  end Examples;

  package Basic "Basic components for AC singlephase models"
    extends Modelica.Icons.Package;

    model Ground "Electrical ground"

      Interfaces.PositivePin pin annotation (Placement(transformation(extent={{
                -10,90},{10,110}})));
    equation
      Connections.potentialRoot(pin.reference, 256);
      if Connections.isRoot(pin.reference) then
        pin.reference.gamma = 0;
      end if;
      pin.v = Complex(0);
      annotation (Icon(graphics={
            Line(points={{-60,50},{60,50}}, color={85,170,255}),
            Line(points={{-40,30},{40,30}}, color={85,170,255}),
            Line(points={{-20,10},{20,10}}, color={85,170,255}),
            Line(points={{0,90},{0,50}}, color={85,170,255}),
            Text(
              extent={{150,-50},{-150,-10}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
<p>
Ground of a single phase circuit. The potential at the ground node is zero.
Every electrical circuit, e.g., a series resonance
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Examples.SeriesResonance\">
          example</a>, has to contain at least one ground object.
</p>

</html>"));
    end Ground;

    model Resistor "Single phase linear resistor"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.conj;
      parameter Modelica.SIunits.Resistance R_ref(start=1) "Reference resistance at T_ref";
      parameter Modelica.SIunits.Temperature T_ref=293.15 "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref=0 "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
      Modelica.SIunits.Resistance R_actual "Resistance = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
    equation
      assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps,
        "Temperature outside scope of model!");
      R_actual = R_ref*(1 + alpha_ref*(T_heatPort - T_ref));
      v = R_actual*i;
      LossPower = real(v*conj(i));
      annotation (Icon(graphics={
            Line(points={{60,0},{90,0}}, color={85,170,255}),
            Line(points={{-90,0},{-60,0}}, color={85,170,255}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{150,-40},{-150,-80}}, textString="R=%R_ref"),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}),
          Documentation(info="<html>
<p>
The linear resistor connects the complex voltage <code><u>v</u></code> with the complex
current <code><u>i</u></code> by <code><u>i</u>*R = <u>v</u></code>.
The resistance <code>R</code> is allowed to be positive, zero, or negative.
</p>

<p>
The resistor model also has an optional
<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">conditional heat port</a>.
A linear temperature dependency of the resistance is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end Resistor;

    model Conductor "Single phase linear conductor"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.conj;
      parameter Modelica.SIunits.Conductance G_ref(start=1) "Reference conductance at T_ref";
      parameter Modelica.SIunits.Temperature T_ref=293.15 "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref=0 "Temperature coefficient of conductance (G_actual = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
      Modelica.SIunits.Conductance G_actual "Conductance = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
    equation
      assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps,
        "Temperature outside scope of model!");
      G_actual = G_ref/(1 + alpha_ref*(T_heatPort - T_ref));
      i = G_actual*v;
      LossPower = real(v*conj(i));
      annotation (Icon(graphics={
            Line(points={{60,0},{90,0}}, color={85,170,255}),
            Line(points={{-90,0},{-60,0}}, color={85,170,255}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{150,-40},{-148,-80}}, textString="G=%G_ref"),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}),
          Documentation(info="<html>

<p>
The linear conductor connects the voltage <code><u>v</u></code> with the
current <code><u>i</u></code> by <code><u>i</u> = <u>v</u>*G</code>.
The conductance <code>G</code> is allowed to be positive, zero, or negative.
</p>

<p>
The conductor model also has an optional
<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">conditional heat port</a>.
A linear temperature dependency of the conductance is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end Conductor;

    model Capacitor "Single phase linear capacitor"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.j;
      parameter Modelica.SIunits.Capacitance C(start=1) "Capacitance";
    equation
      i = j*omega*C*v;
      annotation (Icon(graphics={
            Text(extent={{150,-40},{-150,-80}}, textString="C=%C"),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
            Line(
              points={{-6,28},{-6,-28}},
              color={85,170,255}),
            Line(
              points={{6,28},{6,-28}},
              color={85,170,255}),
                                 Line(points={{-90,0},{-6,0}}, color={85,170,255}),
                    Line(points={{6,0},{90,0}}, color={85,170,255})}),
          Documentation(info="<html>

<p>
The linear capacitor connects the voltage <code><u>v</u></code> with the
current <code><u>i</u></code> by <code><u>i</u> = j*&omega;*C*<u>v</u></code>.
The capacitance <code>C</code> is allowed to be positive, zero, or negative.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end Capacitor;

    model Inductor "Single phase linear inductor"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.j;
      parameter Modelica.SIunits.Inductance L(start=1) "Inductance";
    equation
      v = j*omega*L*i;
      annotation (Icon(graphics={
            Line(points={{60,0},{90,0}}, color={85,170,255}),
            Line(points={{-90,0},{-60,0}}, color={85,170,255}),
            Text(extent={{150,-50},{-150,-80}}, textString="L=%L"),
            Line(
              points={{-60,0},{-59,6},{-52,14},{-38,14},{-31,6},{-30,0}},
              color={0,128,255},
              smooth=Smooth.Bezier),
            Line(
              points={{-30,0},{-29,6},{-22,14},{-8,14},{-1,6},{0,0}},
              color={0,128,255},
              smooth=Smooth.Bezier),
            Line(
              points={{0,0},{1,6},{8,14},{22,14},{29,6},{30,0}},
              color={0,128,255},
              smooth=Smooth.Bezier),
            Line(
              points={{30,0},{31,6},{38,14},{52,14},{59,6},{60,0}},
              color={0,128,255},
              smooth=Smooth.Bezier),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}),
          Documentation(info="<html>

<p>
The linear inductor connects the voltage <code><u>v</u></code> with the
current <code><u>i</u></code> by  <code><u>v</u> = j*&omega;*L*<u>i</u></code>.
The Inductance <code>L</code> is allowed to be positive, zero, or negative.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end Inductor;

    model Impedance "Single phase linear impedance"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.j;
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.imag;
      import Modelica.ComplexMath.conj;
      parameter Modelica.SIunits.ComplexImpedance Z_ref(re(start=1),im(start=0)) "Complex impedance R_ref + j*X_ref";
      parameter Modelica.SIunits.Temperature T_ref=293.15 "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref=0 "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
      parameter Boolean frequencyDependent = false "Consider frequency dependency, if true"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Modelica.SIunits.Frequency f_ref = 1 "Reference frequency, if frequency dependency is considered"
        annotation(Dialog(enable=frequencyDependent));
      Modelica.SIunits.Resistance R_actual "Resistance = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      Modelica.SIunits.Reactance X_actual "Reactance considering possible frequency dependency";
      final parameter Modelica.SIunits.Resistance R_ref=real(Z_ref) "Resistive component of impedance, resistance";
      final parameter Modelica.SIunits.Reactance X_ref=imag(Z_ref) "Reactive component of impedance, reactance";
    equation
      assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps,
        "Temperature outside scope of model!");
      R_actual = R_ref*(1 + alpha_ref*(T_heatPort - T_ref));
      X_actual = X_ref * (if not frequencyDependent then 1 else
        (if X_ref>=0 then omega/(2*Modelica.Constants.pi*f_ref) else 2*Modelica.Constants.pi*f_ref/omega));
      v = Complex(R_actual, X_actual) * i;
      LossPower = real(v*conj(i));

      annotation (Icon(graphics={
            Line(points={{60,0},{90,0}}, color={85,170,255}),
            Line(points={{-90,0},{-60,0}}, color={85,170,255}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-70,-30},{70,30},{70,-30},{-70,-30}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}),
          Documentation(info="<html>

<p>The impedance model represents a <strong>series</strong> connection of a resistor and either an inductor or capacitor.<br>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/SinglePhase/Basic/RX_impedance.png\"></p>

<p>
The linear impedance connects the voltage <code><u>v</u></code> with the
current <code><u>i</u></code> by  <code><u>v</u> = <u>Z</u>*<u>i</u></code>. The resistive
component is modeled temperature dependent, so the real part <code>R_actual = real(<u>Z</u>)</code> is determined from
the actual operating temperature and the reference input resistance <code>real(Z_ref)</code>.
A <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">conditional heat port</a> is considered.
The reactive component <code>X_actual = imag(<u>Z</u>)</code>
is equal to <code>imag(Z_ref)</code> if <code>frequencyDependent = false</code>.
Frequency dependency is considered by <code>frequencyDependent = true</code>, distinguishing two cases:
</p>

<dl>
<dt>(a) <code>imag(Z_ref) &gt; 0</code>: inductive case</dt>
<dd>The actual reactance <code>X_actual</code> is proportional to <code>f/f_ref</code></dd>
<dt>(b) <code>imag(Z_ref) &lt; 0</code>: capacitive case</dt>
<dd>The actual reactance <code>X_actual</code> is proportional to <code>f_ref/f</code></dd>
</dl>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end Impedance;

    model Admittance "Single phase linear admittance"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.j;
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.imag;
      import Modelica.ComplexMath.conj;
      parameter Modelica.SIunits.ComplexAdmittance Y_ref(re(start=1),im(start=0)) "Complex admittance G_ref + j*B_ref";
      parameter Modelica.SIunits.Temperature T_ref=293.15 "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref=0 "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
      parameter Boolean frequencyDependent = false "Consider frequency dependency, if true"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Modelica.SIunits.Frequency f_ref = 1 "Reference frequency, if frequency dependency is considered"
        annotation(Dialog(enable=frequencyDependent));
      Modelica.SIunits.Conductance G_actual "Resistance = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      Modelica.SIunits.Susceptance B_actual "Susceptance considering possible frequency dependency";
      final parameter Modelica.SIunits.Conductance G_ref=real(Y_ref) "Resistive component of conductance";
      final parameter Modelica.SIunits.Susceptance B_ref=imag(Y_ref) "Reactive component of susceptance";
    equation
      assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps,
        "Temperature outside scope of model!");
      G_actual = G_ref/(1 + alpha_ref*(T_heatPort - T_ref));
      B_actual = B_ref * (if not frequencyDependent then 1 else
        (if B_ref>=0 then omega/(2*Modelica.Constants.pi*f_ref) else 2*Modelica.Constants.pi*f_ref/omega));
      i = Complex(G_actual, B_actual) * v;
      LossPower = real(v*conj(i));
      annotation (Icon(graphics={
            Line(points={{60,0},{90,0}}, color={85,170,255}),
            Line(points={{-90,0},{-60,0}}, color={85,170,255}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-70,-30},{70,30},{70,-30},{-70,-30}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}),
          Documentation(info="<html>

<p>The admittance model represents a <strong>parallel</strong> connection of a conductor and either a capacitor or inductor.<br>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/SinglePhase/Basic/GB_admittance.png\"></p>

<p>
The linear admittance connects the voltage <code><u>v</u></code> with the
current <code><u>i</u></code> by  <code><u>i</u> = <u>Y</u>*<u>v</u></code>. The resistive
component is modeled temperature dependent, so the real part <code>G_actual = real(<u>Y</u>)</code> is determined from
the actual operating temperature and the reference input conductance <code>real(Y_ref)</code>.
A <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">conditional heat port</a> is considered.
The reactive component <code>B_actual = imag(<u>Y</u>)</code>
is equal to <code>imag(Y_ref)</code> if <code>frequencyDependent = false</code>.
Frequency dependency is considered by <code>frequencyDependent = true</code>, distinguishing two cases:
</p>

<dl>
<dt>(a) <code>imag(Y_ref) &gt; 0</code>: capacitive case</dt>
<dd>The actual susceptance <code>B_actual</code> is proportional to <code>f/f_ref</code></dd>
<dt>(b) <code>imag(Y_ref) &lt; 0</code>: inductive case</dt>
<dd>The actual susceptance <code>B_actual</code> is proportional to <code>f_ref/f</code></dd>
</dl>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end Admittance;

    model VariableResistor "Single phase variable resistor"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.conj;
      parameter Modelica.SIunits.Temperature T_ref=293.15 "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref=0 "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
      Modelica.SIunits.Resistance R_actual "Resistance = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      Modelica.Blocks.Interfaces.RealInput R_ref(unit="Ohm") "Variable resistance"
                              annotation (Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,120})));
    equation
      assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps,
        "Temperature outside scope of model!");
      R_actual = R_ref*(1 + alpha_ref*(T_heatPort - T_ref));
      v = R_actual*i;
      LossPower = real(v*conj(i));
      annotation (defaultComponentName="resistor",
        Icon(graphics={
            Line(points={{60,0},{90,0}}, color={85,170,255}),
            Line(points={{-90,0},{-60,0}}, color={85,170,255}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>

<p>
The linear resistor connects the voltage <code><u>v</u></code> with the
current <code><u>i</u></code> by <code><u>i</u>*R = <u>v</u></code>.
The resistance <code>R</code> is given as input signal.
</p>

<p>
The variable resistor model also has an optional
<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">conditional heat port</a>.
A linear temperature dependency of the resistance is also taken into account.
</p>

<h4>Note</h4>
<p>
A zero crossing of the R signal could cause singularities due to the actual structure of the connected network.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end VariableResistor;

    model VariableConductor "Single phase variable conductor"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.conj;
      parameter Modelica.SIunits.Temperature T_ref=293.15 "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref=0 "Temperature coefficient of conductance (G_actual = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
      Modelica.SIunits.Conductance G_actual "Conductance = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
      Modelica.Blocks.Interfaces.RealInput G_ref(unit="S") "Variable conductance"
                               annotation (Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,120})));
    equation
      assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps,
        "Temperature outside scope of model!");
      G_actual = G_ref/(1 + alpha_ref*(T_heatPort - T_ref));
      i = G_actual*v;
      LossPower = real(v*conj(i));
      annotation (defaultComponentName="conductor",
        Icon(graphics={
            Line(points={{60,0},{90,0}}, color={85,170,255}),
            Line(points={{-90,0},{-60,0}}, color={85,170,255}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>

<p>
The linear conductor connects the voltage <code><u>v</u></code> with the
current <code><u>i</u></code> by <code><u>i</u> = G*<u>v</u></code>.
The conductance <code>G</code> is given as input signal.
</p>

<p>
The variable conductor model also has an optional
<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">conditional heat port</a>.
A linear temperature dependency of the conductance is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end VariableConductor;

    model VariableCapacitor "Single phase variable capacitor"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.j;
      Modelica.Blocks.Interfaces.RealInput C(unit="F") "Variable capacitances"
        annotation (Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,120})));
    equation
      i = j*omega*C*v;
      annotation (defaultComponentName="capacitor",
        Icon(graphics={
            Line(points={{-90,0},{-6,0}}, color={85,170,255}),
            Line(points={{6,0},{90,0}}, color={85,170,255}),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
            Line(
              points={{-6,28},{-6,-28}},
              color={0,128,255}),
            Line(
              points={{6,28},{6,-28}},
              color={0,128,255})}),
        Documentation(info="<html>

<p>
The linear capacitor connects the voltage <code><u>v</u></code> with the
current <code><u>i</u></code> by <code><u>i</u> = j*&omega;*C*<u>v</u></code>.
The capacitance <code>C</code> is given as input signal.
</p>

<h4>Note</h4>
<p>
The abstraction of a variable capacitor at quasi stationary operation assumes:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/SinglePhase/Basic/dc_dt.png\"
     alt=\"dc_dt.png\">.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end VariableCapacitor;

    model VariableInductor "Single phase variable inductor"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.j;
      Modelica.Blocks.Interfaces.RealInput L(unit="H") "Variable inductances"
        annotation (Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,120})));
    equation
      v = j*omega*L*i;
      annotation (defaultComponentName="inductor",
        Icon(graphics={
            Line(points={{60,0},{90,0}}, color={85,170,255}),
            Line(points={{-90,0},{-60,0}}, color={85,170,255}),
            Line(
              points={{-60,0},{-59,6},{-52,14},{-38,14},{-31,6},{-30,0}},
              color={0,128,255},
              smooth=Smooth.Bezier),
            Line(
              points={{-30,0},{-29,6},{-22,14},{-8,14},{-1,6},{0,0}},
              color={0,128,255},
              smooth=Smooth.Bezier),
            Line(
              points={{0,0},{1,6},{8,14},{22,14},{29,6},{30,0}},
              color={0,128,255},
              smooth=Smooth.Bezier),
            Line(
              points={{30,0},{31,6},{38,14},{52,14},{59,6},{60,0}},
              color={0,128,255},
              smooth=Smooth.Bezier),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>

<p>
The linear inductor connects the branch voltage <code><u>v</u></code> with the
branch current <code><u>i</u></code> by <code><u>v</u> = j*&omega;*L*<u>i</u></code>. The inductance <code>L</code> is given as input signal.
</p>

<h4>Note</h4>
<p>
The abstraction of a variable inductor at quasi stationary operation assumes:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/SinglePhase/Basic/dl_dt.png\"
     alt=\"dl_dt.png\">
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableAdmittance\">Variable admittance</a>,
</p>
</html>"));
    end VariableInductor;

    model VariableImpedance "Single phase variable impedance"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.imag;
      import Modelica.ComplexMath.conj;
      parameter Modelica.SIunits.Temperature T_ref=293.15 "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref=0 "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
      Modelica.ComplexBlocks.Interfaces.ComplexInput Z_ref "Variable complex impedance"
        annotation (Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,120})));
      parameter Boolean frequencyDependent = false "Consider frequency dependency, if true"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Modelica.SIunits.Frequency f_ref = 1 "Reference frequency, if frequency dependency is considered"
        annotation(Dialog(enable=frequencyDependent));
      Modelica.SIunits.Resistance R_actual "Resistance = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      Modelica.SIunits.Reactance X_actual "Reactance considering possible frequency dependency";
      Modelica.SIunits.Resistance R_ref=real(Z_ref) "Resistive component of impedance, resistance";
      Modelica.SIunits.Reactance X_ref=imag(Z_ref) "Reactive component of impedance, reactance";
    equation
      assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps,
        "Temperature outside scope of model!");
      R_actual = R_ref*(1 + alpha_ref*(T_heatPort - T_ref));
      X_actual = X_ref * (if not frequencyDependent then 1 else
        (if X_ref>=0 then omega/(2*Modelica.Constants.pi*f_ref) else 2*Modelica.Constants.pi*f_ref/omega));
      v = Complex(R_actual, X_actual) * i;
      LossPower = real(v*conj(i));
      annotation (defaultComponentName="impedance",
        Icon(graphics={
            Line(points={{60,0},{90,0}}, color={85,170,255}),
            Line(points={{-90,0},{-60,0}}, color={85,170,255}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-70,-30},{70,30},{70,-30},{-70,-30}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>

<p>The impedance model represents a <strong>series</strong> connection of a resistor and either an inductor or capacitor.<br>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/SinglePhase/Basic/RX_impedance.png\"></p>

<p>
The linear impedance connects the complex voltage <code><u>v</u></code> with the
complex current <code><u>i</u></code> by <code><u>i</u>*<u>Z</u> = <u>v</u></code>.
The impedance <code>Z_ref = R_ref + j*X_ref</code> is given as complex input signal, representing the
resistive and reactive component of the input impedance. The resistive
component is modeled temperature dependent, so the real part <code>R_actual = real(<u>Z</u>)</code> is determined from
the actual operating temperature and the reference input resistance <code>real(Z_ref)</code>.
The reactive component <code>X_actual = imag(<u>Z</u>)</code>
is equal to <code>imag(Z_ref)</code> if <code>frequencyDependent = false</code>.
Frequency dependency is considered by <code>frequencyDependent = true</code>, distinguishing two cases:
</p>

<dl>
<dt>(a) <code>imag(Z_ref) &gt; 0</code>: inductive case</dt>
<dd>The actual reactance <code>X_actual</code> is proportional to <code>f/f_ref</code></dd>
<dt>(b) <code>imag(Z_ref) &lt; 0</code>: capacitive case</dt>
<dd>The actual reactance <code>X_actual</code> is proportional to <code>f_ref/f</code></dd>
</dl>

<h4>Note</h4>
<p>
A zero crossing of the real or imaginary part of the impedance signal <code>Z_ref</code> could cause
singularities due to the actual structure of the connected network.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end VariableImpedance;

    model VariableAdmittance "Single phase variable admittance"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.imag;
      import Modelica.ComplexMath.conj;
      parameter Modelica.SIunits.Temperature T_ref=293.15 "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref=0 "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T=T_ref);
      Modelica.ComplexBlocks.Interfaces.ComplexInput Y_ref "Variable complex admittance"
        annotation (Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,120})));
      parameter Boolean frequencyDependent = false "Consider frequency dependency, if true"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Modelica.SIunits.Frequency f_ref = 1 "Reference frequency, if frequency dependency is considered"
        annotation(Dialog(enable=frequencyDependent));
      Modelica.SIunits.Conductance G_actual "Resistance = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      Modelica.SIunits.Susceptance B_actual "Susceptance considering possible frequency dependency";
      Modelica.SIunits.Conductance G_ref=real(Y_ref) "Resistive component of conductance";
      Modelica.SIunits.Susceptance B_ref=imag(Y_ref) "Reactive component of susceptance";
    equation
      assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps,
        "Temperature outside scope of model!");
      G_actual = G_ref/(1 + alpha_ref*(T_heatPort - T_ref));
      B_actual = B_ref * (if not frequencyDependent then 1 else
        (if B_ref>=0 then omega/(2*Modelica.Constants.pi*f_ref) else 2*Modelica.Constants.pi*f_ref/omega));
      i = Complex(G_actual, B_actual) * v;
      LossPower = real(v*conj(i));
      annotation (defaultComponentName="admittance",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{60,0},{90,0}}, color={85,170,255}),
            Line(points={{-90,0},{-60,0}}, color={85,170,255}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-70,-30},{70,30},{70,-30},{-70,-30}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>

<p>The admittance model represents a <strong>parallel</strong> connection of a conductor and either a capacitor or inductor.<br>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/SinglePhase/Basic/GB_admittance.png\"></p>

<p>
The linear admittance connects the complex voltage <code><u>v</u></code> with the
complex current <code><u>i</u></code> by <code><u>v</u>*<u>Y</u> = <u>i</u></code>.
The admittance <code>Y_ref = G_ref + j*B_ref</code> is given as complex input signal, representing the
resistive and reactive component of the input admittance. The resistive
component is modeled temperature dependent, so the real part <code>G_actual = real(<u>Y</u>)</code> is determined from
the actual operating temperature and the reference input conductance <code>real(Y_ref)</code>.
The reactive component <code>B_actual = imag(<u>Y</u>)</code>
is equal to <code>imag(Y_ref)</code> if <code>frequencyDependent = false</code>.
Frequency dependency is considered by <code>frequencyDependent = true</code>, distinguishing two cases:
</p>

<dl>
<dt>(a) <code>imag(Y_ref) &gt; 0</code>: capacitive case</dt>
<dd>The actual susceptance <code>B_actual</code> is proportional to <code>f/f_ref</code></dd>
<dt>(b) <code>imag(Y_ref) &lt; 0</code>: inductive case</dt>
<dd>The actual susceptance <code>B_actual</code> is proportional to <code>f_ref/f</code></dd>
</dl>

<h4>Note</h4>
<p>
A zero crossing of the real or imaginary part of the admittance signal <code>Y_ref</code> could cause
singularities due to the actual structure of the connected network.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableImpedance\">Variable impedance</a>
</p>
</html>"));
    end VariableAdmittance;
    annotation (Icon(graphics={
          Line(origin={10,40}, points={{-100,-40},{-80,-40}}),
          Line(origin={10,40}, points={{60,-40},{80,-40}}),
          Rectangle(
            lineColor={85,170,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            extent={{-70,-30},{70,30}})}, coordinateSystem(extent={{-100,-100},
              {100,100}}, preserveAspectRatio=true)), Documentation(info="<html>
<p>This package hosts basic models for quasi stationary single phase circuits.
Quasi stationary theory for single phase circuits can be found in the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic\">MultiPhase.Basic</a>

</html>"));
  end Basic;

  package Ideal "Ideal components for AC singlephase models"
    extends Modelica.Icons.Package;

    model Idle "Idle branch"
      extends Interfaces.OnePort;
    equation
      i = Complex(0);
      annotation (Icon(graphics={
            Rectangle(
              extent={{-60,60},{60,-60}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-41,0}}, color={85,170,255}),
            Line(points={{91,0},{40,0}}, color={85,170,255}),
            Text(
              extent={{-150,110},{150,70}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
<p>
This model is a simple idle branch considering the complex current <em><u>i</u></em> = 0.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.Short\">Short</a>
</p>
</html>"));
    end Idle;

    model Short "Short cut branch"
      extends Interfaces.OnePort;
    equation
      v = Complex(0);
      annotation (Icon(graphics={
            Rectangle(
              extent={{-60,60},{60,-60}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{91,0},{-90,0}}, color={85,170,255}),
            Text(
              extent={{-150,110},{150,70}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
<p>
This model is a simple short cut branch considering the complex voltage <em><u>v</u></em> = 0.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.Idle\">Idle</a>
</p>
</html>"));
    end Short;

    model IdealCommutingSwitch "Ideal commuting switch"
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.conj;
      parameter Modelica.SIunits.Resistance Ron(final min=0) = 1e-5 "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff(final min=0) = 1e-5 "Opened switch conductance";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
           293.15);
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin p
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin n2
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin n1
        annotation (Placement(transformation(extent={{90,30},{110,50}}), iconTransformation(extent={{90,30},{110,50}})));
      Modelica.Blocks.Interfaces.BooleanInput control "true => p--n2 connected, false => p--n1 connected"
                                                            annotation (
          Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    protected
      Complex s1(re(final unit="1"), im(final unit="1"));
      Complex s2(re(final unit="1"), im(final unit="1")) "Auxiliary variables";
      constant Modelica.SIunits.ComplexVoltage unitVoltage=Complex(1, 0)
        annotation (HideResult=true);
      constant Modelica.SIunits.ComplexCurrent unitCurrent=Complex(1, 0)
        annotation (HideResult=true);
    equation
      Connections.branch(p.reference, n1.reference);
      p.reference.gamma = n1.reference.gamma;
      Connections.branch(p.reference, n2.reference);
      p.reference.gamma = n2.reference.gamma;
      p.i + n2.i + n1.i = Complex(0, 0);
      p.v - n1.v = (s1*unitCurrent)*(if (control) then 1 else Ron);
      n1.i = -(s1*unitVoltage)*(if (control) then Goff else 1);
      p.v - n2.v = (s2*unitCurrent)*(if (control) then Ron else 1);
      n2.i = -(s2*unitVoltage)*(if (control) then 1 else Goff);
      LossPower = real(p.v*conj(p.i)) + real(n1.v*conj(n1.i)) + real(n2.v*conj(
        n2.i));
      annotation (defaultComponentName="switch",
        Documentation(info="<html>
<p>
The commuting switch has a positive pin p and two negative pins n1 and n2.
The switching behaviour is controlled
by the input signal control. If control is true, the pin p is connected
with the negative pin n2. Otherwise, the pin p is connected to the negative pin n1.
</p>
<p>
In order to prevent singularities during switching, the opened
switch has a (very low) conductance Goff
and the closed switch has a (very low) resistance Ron.
The limiting case is also allowed, i.e., the resistance Ron of the
closed switch could be exactly zero and the conductance Goff of the
open switch could be also exactly zero. Note, there are circuits,
where a description with zero Ron or zero Goff is not possible.
<br><br>
<strong>Please note:</strong>
In case of useHeatPort=true the temperature dependence of the electrical
behavior is <strong>not</strong> modelled. The parameters are not temperature dependent.
</p>
<p>
<strong>Use with care:</strong>
This switch is only intended to be used for structural changes, not for fast switching sequences, due to the quasistationary formulation.
</p>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Ellipse(extent={{-44,4},{-36,-4}}, lineColor={85,170,255}),
            Line(points={{-100,0},{-44,0}}, color={85,170,255}),
            Line(points={{-37,2},{40,40}}, color={85,170,255}),
            Line(points={{40,40},{100,40}}, color={85,170,255}),
            Line(points={{40,0},{100,0}}, color={85,170,255}),
            Line(
              visible=useHeatPort,
              points={{0,-100},{0,25}},
              color={127,0,0},
              pattern=LinePattern.Dot),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}));
    end IdealCommutingSwitch;

    model IdealIntermediateSwitch "Ideal intermediate switch"
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.conj;
      parameter Modelica.SIunits.Resistance Ron(final min=0) = 1e-5 "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff(final min=0) = 1e-5 "Opened switch conductance";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=
           293.15);
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin p1
        annotation (Placement(transformation(extent={{-110,30},{-90,50}}), iconTransformation(extent={{-110,30},{-90,50}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin p2
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin n1
        annotation (Placement(transformation(extent={{90,30},{110,50}}), iconTransformation(extent={{90,30},{110,50}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin n2
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.Blocks.Interfaces.BooleanInput control "true => p1--n2, p2--n1 connected, otherwise p1--n1, p2--n2  connected"
        annotation (Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    protected
      Complex s1(re(final unit="1"), im(final unit="1"));
      Complex s2(re(final unit="1"), im(final unit="1"));
      Complex s3(re(final unit="1"), im(final unit="1"));
      Complex s4(re(final unit="1"), im(final unit="1")) "Auxiliary variables";
      constant Modelica.SIunits.ComplexVoltage unitVoltage=Complex(1, 0)
        annotation (HideResult=true);
      constant Modelica.SIunits.ComplexCurrent unitCurrent=Complex(1, 0)
        annotation (HideResult=true);
    equation
      Connections.branch(p1.reference, n1.reference);
      p1.reference.gamma = n1.reference.gamma;
      Connections.branch(p2.reference, n2.reference);
      p2.reference.gamma = n2.reference.gamma;
      Connections.branch(n1.reference, n2.reference);
      n1.reference.gamma = n2.reference.gamma;

      p1.v - n1.v = (s1*unitCurrent)*(if (control) then 1 else Ron);
      p2.v - n2.v = (s2*unitCurrent)*(if (control) then 1 else Ron);
      p1.v - n2.v = (s3*unitCurrent)*(if (control) then Ron else 1);
      p2.v - n1.v = (s4*unitCurrent)*(if (control) then Ron else 1);

      p1.i = if control then s1*unitVoltage*Goff + s3*unitCurrent else s1*
        unitCurrent + s3*unitVoltage*Goff;
      p2.i = if control then s2*unitVoltage*Goff + s4*unitCurrent else s2*
        unitCurrent + s4*unitVoltage*Goff;
      n1.i = if control then -s1*unitVoltage*Goff - s4*unitCurrent else -s1*
        unitCurrent - s4*unitVoltage*Goff;
      n2.i = if control then -s2*unitVoltage*Goff - s3*unitCurrent else -s2*
        unitCurrent - s3*unitVoltage*Goff;

      LossPower = real(p1.v*conj(p1.i)) + real(p2.v*conj(p2.i)) + real(n1.v*
        conj(n1.i)) + real(n2.v*conj(n2.i));
      annotation (defaultComponentName="switch",
        Documentation(info="<html>
<p>
The intermediate switch has four switching contact pins p1, p2, n1, and n2.
The switching behaviour is controlled by the input signal control. If control
is true, the pin p1 is connected to pin n2, and the pin p2 is
connected to the pin n2. Otherwise, the pin p1 is connected to n1, and
p2 is connected to n2.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/SinglePhase/Ideal/IdealIntermediateSwitch1.png\" alt=\"IdealIntermediateSwitch1\">
</p>

<p>
In order to prevent singularities during switching, the opened
switch has a (very low) conductance Goff
and the closed switch has a (very low) resistance Ron.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/SinglePhase/Ideal/IdealIntermediateSwitch2.png\" alt=\"IdealIntermediateSwitch2\">
</p>

<p>
The limiting case is also allowed, i.e., the resistance Ron of the
closed switch could be exactly zero and the conductance Goff of the
open switch could be also exactly zero. Note, there are circuits,
where a description with zero Ron or zero Goff is not possible.
<br><br>
<strong>Please note:</strong>
In case of useHeatPort=true the temperature dependence of the electrical
behavior is <strong>not</strong> modelled. The parameters are not temperature dependent.
</p>
<p>
<strong>Use with care:</strong>
This switch is only intended to be used for structural changes, not for fast switching sequences, due to the quasistationary formulation.
</p>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Ellipse(extent={{-4,24},{4,16}}, lineColor={85,170,255}),
            Line(points={{-90,0},{-40,0}}, color={85,170,255}),
            Line(points={{-90,40},{-40,40}}, color={85,170,255}),
            Line(points={{-40,0},{40,40}}, color={85,170,255}),
            Line(points={{-40,40},{40,2}}, color={85,170,255}),
            Line(points={{40,40},{90,40}}, color={85,170,255}),
            Line(points={{40,0},{90,0}}, color={85,170,255}),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}));
    end IdealIntermediateSwitch;

    model IdealOpeningSwitch "Ideal electrical opener"
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.conj;
      extends Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.OnePort;
      parameter Modelica.SIunits.Resistance Ron(final min=0) = 1e-5 "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff(final min=0) = 1e-5 "Opened switch conductance";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=293.15);
      Modelica.Blocks.Interfaces.BooleanInput control "true => switch open, false => p--n connected"
                                                       annotation (Placement(
            transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    protected
      Complex s(re(final unit="1"),im(final unit="1")) "Auxiliary variable";
      constant Modelica.SIunits.ComplexVoltage unitVoltage=Complex(1, 0)
        annotation (HideResult=true);
      constant Modelica.SIunits.ComplexCurrent unitCurrent=Complex(1, 0)
        annotation (HideResult=true);
    equation
      v = (s*unitCurrent)*(if control then 1 else Ron);
      i = (s*unitVoltage)*(if control then Goff else 1);

      LossPower = real(v*conj(i));
      annotation (defaultComponentName="switch",
        Documentation(info="<html>
<p>
The ideal opening switch has a positive pin p and a negative pin n.
The switching behaviour is controlled by the input signal control.
If control is true, pin p is not connected
with negative pin n. Otherwise, pin p is connected
with negative pin n.
</p>
<p>
In order to prevent singularities during switching, the opened
switch has a (very low) conductance Goff
and the closed switch has a (very low) resistance Ron.
The limiting case is also allowed, i.e., the resistance Ron of the
closed switch could be exactly zero and the conductance Goff of the
open switch could be also exactly zero. Note, there are circuits,
where a description with zero Ron or zero Goff is not possible.
<br><br>
<strong>Please note:</strong>
In case of useHeatPort=true the temperature dependence of the electrical
behavior is <strong>not</strong> modelled. The parameters are not temperature dependent.
</p>
<p>
<strong>Use with care:</strong>
This switch is only intended to be used for structural changes, not for fast switching sequences, due to the quasistationary formulation.
</p>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Ellipse(extent={{-44,4},{-36,-4}}, lineColor={85,170,255}),
            Line(points={{-100,0},{-44,0}}, color={85,170,255}),
            Line(points={{-37,2},{40,40}}, color={85,170,255}),
            Line(points={{40,0},{100,0}}, color={85,170,255}),
            Line(points={{40,20},{40,0}}, color={85,170,255}),
            Line(
              visible=useHeatPort,
              points={{0,-100},{0,25}},
              color={127,0,0},
              pattern=LinePattern.Dot),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Text(
              extent={{-100,-40},{100,-79}},
              textString="%name",
              lineColor={0,0,255})}));
    end IdealOpeningSwitch;

    model IdealClosingSwitch "Ideal electrical closer"
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.conj;
      extends Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.OnePort;
      parameter Modelica.SIunits.Resistance Ron(final min=0) = 1e-5 "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff(final min=0) = 1e-5 "Opened switch conductance";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=293.15);
      Modelica.Blocks.Interfaces.BooleanInput control "true => p--n connected, false => switch open"
                                                       annotation (Placement(
            transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    protected
      Complex s(re(final unit="1"), im(final unit="1")) "Auxiliary variable";
      constant Modelica.SIunits.ComplexVoltage unitVoltage=Complex(1, 0)
        annotation (HideResult=true);
      constant Modelica.SIunits.ComplexCurrent unitCurrent=Complex(1, 0)
        annotation (HideResult=true);
    equation
      v = (s*unitCurrent)*(if control then Ron else 1);
      i = (s*unitVoltage)*(if control then 1 else Goff);

      LossPower = real(v*conj(i));
      annotation (defaultComponentName="switch",
        Documentation(info="<html>
<p>
The ideal closing switch has a positive pin p and a negative pin n.
The switching behaviour is controlled by input signal control.
If control is true, pin p is connected
with negative pin n. Otherwise, pin p is not connected
with negative pin n.
</p>
<p>
In order to prevent singularities during switching, the opened
switch has a (very low) conductance Goff
and the closed switch has a (very low) resistance Ron.
The limiting case is also allowed, i.e., the resistance Ron of the
closed switch could be exactly zero and the conductance Goff of the
open switch could be also exactly zero. Note, there are circuits,
where a description with zero Ron or zero Goff is not possible.
<br><br>
<strong>Please note:</strong>
In case of useHeatPort=true the temperature dependence of the electrical
behavior is <strong>not</strong> modelled. The parameters are not temperature dependent.
</p>
<p>
<strong>Use with care:</strong>
This switch is only intended to be used for structural changes, not for fast switching sequences, due to the quasistationary formulation.
</p>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Ellipse(extent={{-44,4},{-36,-4}}, lineColor={85,170,255}),
            Line(points={{-90,0},{-44,0}}, color={85,170,255}),
            Line(points={{-37,2},{40,40}}, color={85,170,255}),
            Line(points={{40,0},{90,0}}, color={85,170,255}),
            Line(
              visible=useHeatPort,
              points={{0,-100},{0,25}},
              color={127,0,0},
              pattern=LinePattern.Dot),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Text(
              extent={{-100,-40},{100,-79}},
              textString="%name",
              lineColor={0,0,255})}));
    end IdealClosingSwitch;

    model IdealTransformer "Ideal transformer"
      parameter Real n=1 "Ratio of primary to secondary voltage";
      Modelica.SIunits.ComplexVoltage v1=pin_p1.v - pin_n1.v "Voltage drop of side 1";
      Modelica.SIunits.ComplexCurrent i1=pin_p1.i "Current into side 1";
      Modelica.SIunits.ComplexVoltage v2=pin_p2.v - pin_n2.v "Voltage drop of side 2";
      Modelica.SIunits.ComplexCurrent i2=pin_p2.i "Current into side 2";

      Modelica.SIunits.Voltage abs_v1=Modelica.ComplexMath.'abs'(v1) "Magnitude of complex voltage v1";
      Modelica.SIunits.Angle arg_v1=Modelica.ComplexMath.arg(v1) "Argument of complex voltage v1";
      Modelica.SIunits.Current abs_i1=Modelica.ComplexMath.'abs'(i1) "Magnitude of complex current i1";
      Modelica.SIunits.Angle arg_i1=Modelica.ComplexMath.arg(i1) "Argument of complex current i1";
      Modelica.SIunits.ActivePower P1=Modelica.ComplexMath.real(v1*
          Modelica.ComplexMath.conj(i1)) "Active power, side 1";
      Modelica.SIunits.ReactivePower Q1=Modelica.ComplexMath.imag(v1*
          Modelica.ComplexMath.conj(i1)) "Reactive power, side 1";
      Modelica.SIunits.ApparentPower S1=Modelica.ComplexMath.'abs'(v1*
          Modelica.ComplexMath.conj(i1)) "Magnitude of complex apparent power, side 1";
      Real pf1=cos(Modelica.ComplexMath.arg(Complex(P1, Q1))) "Power factor, side 1";

      Modelica.SIunits.Voltage abs_v2=Modelica.ComplexMath.'abs'(v2) "Magnitude of complex voltage v2";
      Modelica.SIunits.Angle arg_v2=Modelica.ComplexMath.arg(v2) "Argument of complex voltage v2";
      Modelica.SIunits.Current abs_i2=Modelica.ComplexMath.'abs'(i2) "Magnitude of complex current i2";
      Modelica.SIunits.Angle arg_i2=Modelica.ComplexMath.arg(i2) "Argument of complex current i2";
      Modelica.SIunits.ActivePower P2=Modelica.ComplexMath.real(v2*
          Modelica.ComplexMath.conj(i2)) "Active power, side 2";
      Modelica.SIunits.ReactivePower Q2=Modelica.ComplexMath.imag(v2*
          Modelica.ComplexMath.conj(i2)) "Reactive power, side 2";
      Modelica.SIunits.ApparentPower S2=Modelica.ComplexMath.'abs'(v2*
          Modelica.ComplexMath.conj(i2)) "Magnitude of complex apparent power, side 2";
      Real pf2=cos(Modelica.ComplexMath.arg(Complex(P2, Q2))) "Power factor, side 2";

      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin
        pin_p1 "Primary positive pin" annotation (Placement(transformation(
              extent={{-110,90},{-90,110}}),iconTransformation(extent={{-110,90},{-90,110}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin
        pin_p2 "Secondary positive pin" annotation (Placement(transformation(
              extent={{90,90},{110,110}}),iconTransformation(extent={{90,90},{110,110}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin
        pin_n1 "Primary negative pin" annotation (Placement(transformation(
              extent={{-110,-110},{-90,-90}}),iconTransformation(extent={{-110,-110},{-90,-90}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin
        pin_n2 "Secondary negative pin" annotation (Placement(transformation(
              extent={{90,-108},{110,-88}}),iconTransformation(extent={{90,-108},{110,-88}})));
    equation
      // Current balance
      pin_p1.i + pin_n1.i = Complex(0, 0);
      pin_p2.i + pin_n2.i = Complex(0, 0);
      // Transformation ratios
      v1 = Complex(+n, 0)*v2;
      i2 = Complex(-n, 0)*i1;
      Connections.branch(pin_p1.reference, pin_n1.reference);
      pin_p1.reference.gamma = pin_n1.reference.gamma;
      Connections.branch(pin_n1.reference, pin_n2.reference);
      pin_p2.reference.gamma = pin_n2.reference.gamma;
      Connections.branch(pin_p1.reference, pin_p2.reference);
      pin_p1.reference.gamma = pin_p2.reference.gamma;
      annotation (defaultComponentName="transformer",
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={
            Text(
              extent={{-100,10},{0,-10}},
              lineColor={0,0,255},
              textString="1=primary"),
            Text(
              extent={{0,10},{100,-10}},
              lineColor={0,0,255},
              textString="2=secondary"),
            Polygon(
              points={{-120,53},{-110,50},{-120,47},{-120,53}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Line(points={{-136,50},{-111,50}}, color={160,160,164}),
            Text(
              extent={{-136,53},{-119,68}},
              lineColor={160,160,164},
              textString="i1"),
            Line(points={{-136,-49},{-111,-49}}, color={160,160,164}),
            Polygon(
              points={{-126,-46},{-136,-49},{-126,-52},{-126,-46}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-127,-46},{-110,-31}},
              lineColor={160,160,164},
              textString="i1"),
            Polygon(
              points={{127,-47},{137,-50},{127,-53},{127,-47}},
              lineColor={160,160,164},
              fillColor={160,160,164},
              fillPattern=FillPattern.Solid),
            Line(points={{111,-50},{136,-50}}, color={160,160,164}),
            Text(
              extent={{112,-44},{128,-29}},
              lineColor={160,160,164},
              textString="i2"),
            Text(
              extent={{118,52},{135,67}},
              textString="i2"),
            Polygon(
              points={{120,53},{110,50},{120,47},{120,53}},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={160,160,164}),
            Line(points={{111,50},{136,50}})}),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-100,20},{-60,-20}},
              lineColor={85,170,255},
              textString="1"),
            Text(
              extent={{60,20},{100,-20}},
              lineColor={85,170,255},
              textString="2"),
            Line(points={{-40,60},{-40,100},{-90,100}}, color={85,170,255}),
            Line(points={{40,60},{40,100},{90,100}}, color={85,170,255}),
            Line(points={{-40,-60},{-40,-100},{-90,-100}}, color={85,170,255}),
            Line(points={{40,-60},{40,-100},{90,-100}}, color={85,170,255}),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={85,170,255},
              smooth=Smooth.Bezier,
              origin={-33,45},
              rotation=270),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={85,170,255},
              smooth=Smooth.Bezier,
              origin={-33,15},
              rotation=270),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={85,170,255},
              smooth=Smooth.Bezier,
              origin={-33,-15},
              rotation=270),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={85,170,255},
              smooth=Smooth.Bezier,
              origin={-33,-45},
              rotation=270),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={85,170,255},
              smooth=Smooth.Bezier,
              origin={33,45},
              rotation=90),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={85,170,255},
              smooth=Smooth.Bezier,
              origin={33,15},
              rotation=90),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={85,170,255},
              smooth=Smooth.Bezier,
              origin={33,-15},
              rotation=90),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={85,170,255},
              smooth=Smooth.Bezier,
              origin={33,-45},
              rotation=90),
            Text(
              extent={{-150,149},{150,109}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>
<p>
The ideal transformer is a two-port circuit element without magnetization. Voltages and currents are ideally transformed:
</p>
<pre>
 v1 =  v2*n;
 i2 = -i1*n;
</pre>
<p>
where <code>n</code> is a real number called the turns ratio.</p>
</html>", revisions="<html>
<h5>2014-01-02, Christian Kral</h5>
<ul>
<li>Initial implementation of ideal transformer model</li>
</ul>

</html>"));
    end IdealTransformer;
    annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}},
            preserveAspectRatio=true), graphics={
          Line(origin={10,34}, points={{-100,-60},{-54,-60}}),
          Ellipse(origin={10,34}, extent={{-54,-64},{-46,-56}}),
          Line(origin={10,34}, points={{-47,-58},{30,-10}}),
          Line(origin={10,34}, points={{30,-40},{30,-60}}),
          Line(origin={10,34}, points={{30,-60},{80,-60}})}), Documentation(
          info="<html>
<p>This package hosts ideal models for quasi stationary single phase circuits.
Quasi stationary theory for single phase circuits can be found in the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Ideal\">MultiPhase.Ideal</a>

</html>"));
  end Ideal;

  package Sensors "AC singlephase sensors"
    extends Modelica.Icons.SensorsPackage;

    model ReferenceSensor "Sensor of reference angle gamma"
      extends Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.AbsoluteSensor;
      Modelica.Blocks.Interfaces.RealOutput y(unit="rad") "Reference angle" annotation (
          Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      y = pin.reference.gamma;
      annotation (
        Icon(graphics={Text(
              extent={{60,-60},{-60,-30}},
              textString="ref")}), Documentation(info="<html>

<p>
This sensor can be used to measure the reference angle.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"));
    end ReferenceSensor;

    model FrequencySensor "Frequency sensor"
      extends Interfaces.AbsoluteSensor;
      import Modelica.Constants.pi;
      Blocks.Interfaces.RealOutput y(unit="Hz") annotation (Placement(transformation(
              extent={{100,-10},{120,10}})));
    equation
      2*pi*y = omega;
      annotation (
        Icon(graphics={Text(
              extent={{-29,-11},{30,-70}},
              textString="f")}), Documentation(info="<html>

<p>
This sensor can be used to measure the frequency of the reference system.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"));
    end FrequencySensor;

    model PotentialSensor "Potential sensor"
      extends Interfaces.AbsoluteSensor;
      ComplexBlocks.Interfaces.ComplexOutput y annotation (Placement(
            transformation(extent={{100,-10},{120,10}})));
      Modelica.SIunits.Voltage abs_y=Modelica.ComplexMath.'abs'(y) "Magnitude of complex potential";
      Modelica.SIunits.Angle arg_y=Modelica.ComplexMath.arg(y) "Argument of complex potential";
    equation
      y = pin.v;
      annotation (
        Icon(graphics={Text(
              extent={{-29,-11},{30,-70}},
              textString="V")}), Documentation(info="<html>

<p>
This sensor can be used to measure the complex potential.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.MultiSensor\">MultiSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"));
    end PotentialSensor;

    model VoltageSensor "Voltage sensor"
      extends Interfaces.RelativeSensor;
      Modelica.SIunits.Voltage abs_y=Modelica.ComplexMath.'abs'(y) "Magnitude of complex voltage";
      Modelica.SIunits.Angle arg_y=Modelica.ComplexMath.arg(y) "Argument of complex voltage";
    equation
      i = Complex(0);
      y = v;
      annotation (
        Icon(graphics={Text(
              extent={{-29,-11},{30,-70}},
              textString="V")}), Documentation(info="<html>
<p>
This sensor can be used to measure the complex voltage.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"));
    end VoltageSensor;

    model CurrentSensor "Current sensor"
      extends Interfaces.RelativeSensor;
      Modelica.SIunits.Current abs_y=Modelica.ComplexMath.'abs'(y) "Magnitude of complex current";
      Modelica.SIunits.Angle arg_y=Modelica.ComplexMath.arg(y) "Argument of complex current";
    equation
      v = Complex(0);
      y = i;
      annotation (
        Icon(graphics={Text(
              extent={{-29,-11},{30,-70}},
              textString="I")}), Documentation(info="<html>
<p>
This sensor can be used to measure the complex current.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"));
    end CurrentSensor;

    model PowerSensor "Power sensor"
      import Modelica.ComplexMath.conj;
      extends Modelica.Icons.RotationalSensor;
      Interfaces.PositivePin currentP annotation (Placement(transformation(
              extent={{-110,-10},{-90,10}})));
      Interfaces.NegativePin currentN annotation (Placement(transformation(
              extent={{90,-10},{110,10}})));
      Interfaces.PositivePin voltageP annotation (Placement(transformation(
              extent={{-10,90},{10,110}})));
      Interfaces.NegativePin voltageN annotation (Placement(transformation(
              extent={{-10,-110},{10,-90}})));
      output Modelica.SIunits.ComplexCurrent i;
      output Modelica.SIunits.ComplexVoltage v;
      Modelica.ComplexBlocks.Interfaces.ComplexOutput y annotation (Placement(
            transformation(
            origin={-100,-110},
            extent={{-10,-10},{10,10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-100,-110})));
      Modelica.SIunits.ApparentPower abs_y=Modelica.ComplexMath.'abs'(y) "Magnitude of complex apparent power";
      Modelica.SIunits.Angle arg_y=Modelica.ComplexMath.arg(y) "Argument of complex apparent power";

    equation
      Connections.branch(currentP.reference, currentN.reference);
      currentP.reference.gamma = currentN.reference.gamma;
      Connections.branch(voltageP.reference, voltageN.reference);
      voltageP.reference.gamma = voltageN.reference.gamma;
      Connections.branch(currentP.reference, voltageP.reference);
      currentP.reference.gamma = voltageP.reference.gamma;
      currentP.i + currentN.i = Complex(0);
      currentP.v - currentN.v = Complex(0);
      i = currentP.i;
      voltageP.i + voltageN.i = Complex(0);
      voltageP.i = Complex(0);
      v = voltageP.v - voltageN.v;
      //P + j*Q = v * conj(i);
      y = v*conj(i);
      annotation (
        Icon(graphics={
            Line(points={{0,100},{0,70}}, color={85,170,255}),
            Line(points={{0,-70},{0,-100}}, color={85,170,255}),
            Text(extent={{-29,-70},{30,-11}}, textString="P"),
            Line(points={{-100,0},{100,0}}, color={85,170,255}),
            Text(
              extent={{-150,110},{150,150}},
              textString="%name",
              lineColor={0,0,255}),
          Line(points={{-100,-100},{-100,-80},{-58,-38}}, color = {0,0,127})}),
                                                                Documentation(
            info="<html>

<p>
This sensor can be used to measure the complex apparent power.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"));
    end PowerSensor;

  model MultiSensor "Sensor to measure current, voltage and power"
    extends Modelica.Icons.RotationalSensor;
    import Modelica.ComplexMath.conj;
    import Modelica.ComplexMath.'abs';
    import Modelica.ComplexMath.arg;
    Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin pc
        "Positive pin, current path"
      annotation (Placement(transformation(extent={{-90,-10},{-110,10}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin nc
        "Negative pin, current path"
      annotation (Placement(transformation(extent={{110,-10},{90,10}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin pv
        "Positive pin, voltage path"
      annotation (Placement(transformation(extent={{-10,110},{10,90}})));
    Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin nv
        "Negative pin, voltage path"
      annotation (Placement(transformation(extent={{10,-110},{-10,-90}})));
    Modelica.ComplexBlocks.Interfaces.ComplexOutput i(
      redeclare final Modelica.SIunits.Current re, redeclare final Modelica.SIunits.Current im)
      "Current as complex output signal" annotation (Placement(transformation(
          origin={-60,-110},
          extent={{10,10},{-10,-10}},
          rotation=90), iconTransformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={-60,-110})));
    Modelica.ComplexBlocks.Interfaces.ComplexOutput v(
      redeclare final Modelica.SIunits.Voltage re, redeclare final Modelica.SIunits.Voltage im)
      "Voltage as complex output signal" annotation (Placement(transformation(
          origin={60,-110},
          extent={{10,10},{-10,-10}},
          rotation=90), iconTransformation(
          extent={{10,10},{-10,-10}},
          rotation=90,
          origin={60,-110})));
    Modelica.ComplexBlocks.Interfaces.ComplexOutput apparentPower(
      redeclare final Modelica.SIunits.ActivePower re, redeclare final Modelica.SIunits.ReactivePower im)
      "Instantaneous apparent power as complex output signal" annotation (Placement(transformation(
          origin={-110,-60},
          extent={{-10,10},{10,-10}},
          rotation=180), iconTransformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-110,-60})));
    output Modelica.SIunits.Current abs_i='abs'(i) "Absolute of complex current";
    output Modelica.SIunits.Angle arg_i=arg(i) "Argument of complex current";
    output Modelica.SIunits.Voltage abs_v='abs'(v) "Absolute of complex voltage";
    output Modelica.SIunits.Angle arg_v=arg(v) "Argument of complex voltage";
    output Modelica.SIunits.ApparentPower abs_apparentPower='abs'(apparentPower) "Absolute of complex apparent power";
    output Modelica.SIunits.Angle arg_apparentPower=arg(apparentPower) "Argument of complex apparent power";
  equation
    Connections.branch(pc.reference, nc.reference);
    pc.reference.gamma = nc.reference.gamma;
    Connections.branch(pv.reference, nv.reference);
    pv.reference.gamma = nv.reference.gamma;
    Connections.branch(pc.reference, pv.reference);
    pc.reference.gamma = pv.reference.gamma;
    pc.i + nc.i = Complex(0);
    pc.v - nc.v = Complex(0);
    pv.i = Complex(0);
    nv.i = Complex(0);
    i = pc.i;
    v = pv.v - nv.v;
    apparentPower = v*conj(i);
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Line(points = {{0,100},{0,70}}, color={85,170,255}),
        Line(points = {{0,-70},{0,-100}}, color={85,170,255}),
        Line(points = {{-100,0},{100,0}}, color={85,170,255}),
        Line(points = {{0,70},{0,40}}),
          Text(
            extent={{-150,110},{150,150}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-100,-60},{-80,-60},{-56,-42}},
                                                     color={85,170,255}),
          Line(points={{-60,-100},{-60,-80},{-42,-56}},
                                                     color={85,170,255}),
          Line(points={{60,-100},{60,-80},{42,-56}},
                                                  color={85,170,255}),
          Text(
            extent={{-100,-40},{-60,-80}},
            textString="s"),
          Text(
            extent={{-80,-60},{-40,-100}},
            textString="i"),
          Text(
            extent={{40,-60},{80,-100}},
            textString="v")}),
      Documentation(info="<html>
<p>This multi sensor measures current, voltage and instantaneous electrical power of a singlephase system and has a separated voltage and current path.
The pins of the voltage path are pv and nv, the pins of the current path are pc and nc.
The internal resistance of the current path is zero, the internal resistance of the voltage path is infinite.</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
</p>
</html>",   revisions="<html>
<ul>
<li><em>20170306</em> first implementation by Anton Haumer</li>
</ul>
</html>"));
  end MultiSensor;
    annotation (Documentation(info="<html>
<p>This package hosts sensors for quasi stationary single phase circuits.
Quasi stationary theory for single phase circuits can be found in the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors\">MultiPhase.Sensors</a>

</html>"));
  end Sensors;

  package Sources "AC singlephase sources"
    extends Modelica.Icons.SourcesPackage;

    model VoltageSource "Constant AC voltage"
      extends Interfaces.Source;
      parameter Modelica.SIunits.Frequency f(start=1) "Frequency of the source";
      parameter Modelica.SIunits.Voltage V(start=1) "RMS voltage of the source";
      parameter Modelica.SIunits.Angle phi(start=0) "Phase shift of the source";
    equation
      omega = 2*Modelica.Constants.pi*f;
      v = Complex(V*cos(phi), V*sin(phi));
      annotation (Icon(graphics={
            Line(points={{-50,0},{50,0}}, color={85,170,255}),
            Line(points={{-70,30},{-70,10}}, color={85,170,255}),
            Line(points={{-80,20},{-60,20}}, color={85,170,255}),
            Line(points={{60,20},{80,20}}, color={85,170,255})}),
                                             Documentation(info="<html>

<p>
This is a constant voltage source, specifying the complex voltage by the RMS voltage and the phase shift.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
    end VoltageSource;

    model VariableVoltageSource "Variable AC voltage"
      extends Interfaces.Source;
      Modelica.Blocks.Interfaces.RealInput f(unit="Hz") annotation (Placement(
            transformation(
            origin={60,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.ComplexBlocks.Interfaces.ComplexInput V annotation (Placement(
            transformation(
            origin={-60,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      omega = 2*Modelica.Constants.pi*f;
      v = V;
      annotation (defaultComponentName="voltageSource",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-50,0},{50,0}}, color={85,170,255}),
            Line(points={{-70,30},{-70,10}}, color={85,170,255}),
            Line(points={{-80,20},{-60,20}}, color={85,170,255}),
            Line(points={{60,20},{80,20}}, color={85,170,255})}),
                                             Documentation(info="<html>

<p>
This is a voltage source with a complex signal input, specifying the complex voltage by the complex RMS voltage components.
Additionally, the frequency of the voltage source is defined by a real signal input.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
    end VariableVoltageSource;

    model FrequencySweepVoltageSource "Voltage source with integrated frequency sweep"
      extends Interfaces.TwoPin;
      import Modelica.Constants.eps;
      Modelica.SIunits.Angle gamma(start=0) = pin_p.reference.gamma;
      parameter Modelica.SIunits.Frequency fStart(final min=eps, start=1) "Start sweep frequency";
      parameter Modelica.SIunits.Frequency fStop(final min=eps, start=1) "Stop sweep frequency";
      parameter Modelica.SIunits.Time startTime=0 "Start time of frequency sweep";
      parameter Modelica.SIunits.Time duration(start=1) "Duration of frequency sweep";
      parameter Modelica.SIunits.Voltage V(start=1) "RMS voltage of the source";
      parameter Modelica.SIunits.Angle phi=0 "phase shift of the source";
      Modelica.SIunits.Frequency f = voltageSource.f "Actual frequency";
      ComplexBlocks.Sources.LogFrequencySweep logFrequencySweep(
        final wMin=fStart,
        final wMax=fStop,
        final startTime=startTime,
        final duration=duration) annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
      VariableVoltageSource voltageSource annotation (Placement(transformation(extent={{-20,10},{0,-10}})));
      ComplexBlocks.Sources.ComplexConstant const(final k=Modelica.ComplexMath.fromPolar(len=V, phi=phi))
        annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
    equation

      connect(logFrequencySweep.y, voltageSource.f) annotation (Line(points={{19,-50},{-4,-50},{-4,-12}}, color={0,0,127}));
      connect(const.y, voltageSource.V) annotation (Line(points={{-39,-50},{-16,-50},{-16,-12}}, color={85,170,255}));
      connect(pin_p, voltageSource.pin_p) annotation (Line(points={{-100,0},{-20,0}}, color={85,170,255}));
      connect(voltageSource.pin_n, pin_n) annotation (Line(points={{0,0},{100,0}},         color={85,170,255}));
      annotation (defaultComponentName="voltageSource",Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-50,0}}, color={85,170,255}),
            Line(points={{50,0},{90,0}}, color={85,170,255}),
            Line(points={{-50,0},{50,0}}, color={85,170,255}),
            Line(points={{-70,30},{-70,10}}, color={85,170,255}),
            Line(points={{-80,20},{-60,20}}, color={85,170,255}),
            Line(points={{60,20},{80,20}}, color={85,170,255}),
            Text(
              extent={{150,60},{-150,100}},
              textString="%name",
              lineColor={0,0,255}),
            Line(
              points={{-44,0},{-32,14},{-20,32},{-12,42},{-6,30},{0,0},{4,-28},{8,-40},{12,-20},{14,2},{16,30},{18,42},{20,28},{24,-32},{26,-40},{28,0}},
              color={192,192,192},
              smooth=Smooth.Bezier)}),                               Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>This source provides a constant RMS phase voltage <code>V</code> and phase angle <code>phi</code>,
whereas the frequency sweeps from
<code>fStart</code> to <code>fStop</code> with <code>duration</code>. The frequency sweeps such
way that on a logarithmic frequency scale, the frequency curve appears linear.</p>

<p><img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/SinglePhase/Sources/FrequencySweepSource.png\"
     alt=\"FrequencySweepSource.png\"></p>

</html>"));
    end FrequencySweepVoltageSource;

    model CurrentSource "Constant AC current"
      extends Interfaces.Source;
      parameter Modelica.SIunits.Frequency f(start=1) "Frequency of the source";
      parameter Modelica.SIunits.Current I(start=1) "RMS current of the source";
      parameter Modelica.SIunits.Angle phi(start=0) "Phase shift of the source";
    equation
      omega = 2*Modelica.Constants.pi*f;
      i = Complex(I*cos(phi), I*sin(phi));
      annotation (
        Icon(graphics={
            Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid), Line(points={{0,50},{0,-50}}, color={85,170,255})}),
                                                Documentation(info="<html>

<p>
This is a constant current source, specifying the complex current by the RMS current and the phase shift.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
    end CurrentSource;

    model VariableCurrentSource "Variable AC current"
      extends Interfaces.Source;
      Modelica.Blocks.Interfaces.RealInput f(unit="Hz") annotation (Placement(
            transformation(
            origin={60,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.ComplexBlocks.Interfaces.ComplexInput I annotation (Placement(
            transformation(
            origin={-60,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      omega = 2*Modelica.Constants.pi*f;
      i = I;
      annotation (defaultComponentName="currentSource",
        Icon(graphics={Line(points={{0,50},{0,-50}}, color={85,170,255}),
            Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>

<p>
This is a current source with a complex signal input, specifying the complex current by the complex RMS current components.
Additionally, the frequency of the voltage source is defined by a real signal input.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.CurrentSource\">CurrentSource</a>,
</p>
</html>"));
    end VariableCurrentSource;

    model FrequencySweepCurrentSource "Current source with integrated frequency sweep"
      extends Interfaces.TwoPin;
      import Modelica.Constants.eps;
      Modelica.SIunits.Angle gamma(start=0) = pin_p.reference.gamma;
      parameter Modelica.SIunits.Frequency fStart(final min=eps, start=1) "Start sweep frequency";
      parameter Modelica.SIunits.Frequency fStop(final min=eps, start=1) "Stop sweep frequency";
      parameter Modelica.SIunits.Time startTime=0 "Start time of frequency sweep";
      parameter Modelica.SIunits.Time duration(start=1) "Duration of frequency sweep";
      parameter Modelica.SIunits.Current I(start=1) "RMS current of the source";
      parameter Modelica.SIunits.Angle phi=0 "Phase shift of the source";
      Modelica.SIunits.Frequency f = currentSource.f "Actual frequency";
      ComplexBlocks.Sources.LogFrequencySweep logFrequencySweep(
        final wMin=fStart,
        final wMax=fStop,
        final startTime=startTime,
        final duration=duration) annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
      VariableCurrentSource currentSource annotation (Placement(transformation(extent={{-20,10},{0,-10}})));
      ComplexBlocks.Sources.ComplexConstant const(final k=Modelica.ComplexMath.fromPolar(len=I, phi=phi))
        annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
    equation

      connect(logFrequencySweep.y,currentSource. f) annotation (Line(points={{19,-50},{-4,-50},{-4,-12}}, color={0,0,127}));
      connect(pin_p,currentSource. pin_p) annotation (Line(points={{-100,0},{-20,0}}, color={85,170,255}));
      connect(currentSource.pin_n, pin_n) annotation (Line(points={{0,0},{100,0}},         color={85,170,255}));
      connect(const.y, currentSource.I) annotation (Line(points={{-39,-50},{-16,-50},{-16,-12}}, color={85,170,255}));
      annotation (defaultComponentName="currentSource",Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-50,0}}, color={85,170,255}),
            Line(points={{50,0},{90,0}}, color={85,170,255}),
            Text(
              extent={{150,60},{-150,100}},
              textString="%name",
              lineColor={0,0,255}),
            Line(
              points={{-44,0},{-32,14},{-20,32},{-12,42},{-6,30},{0,0},{4,-28},{8,-40},{12,-20},{14,2},{16,30},{18,42},{20,28},{24,-32},{26,-40},{28,0}},
              color={192,192,192},
              smooth=Smooth.Bezier),
            Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
                       Line(points={{0,50},{0,-50}}, color={85,170,255})}),
                                                                     Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>This source provides a constant RMS phase current <code>I</code> and phase angle <code>phi</code>,
whereas the frequency sweeps from
<code>fStart</code> to <code>fStop</code> with <code>duration</code>. The frequency sweeps such
way that on a logarithmic frequency scale, the frequency curve appears linear.</p>

<p><img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/SinglePhase/Sources/FrequencySweepSource.png\"
     alt=\"FrequencySweepSource.png\"></p>

</html>"));
    end FrequencySweepCurrentSource;
    annotation (Documentation(info="<html>
<p>This package hosts sources for quasi stationary single phase circuits.
Quasi stationary theory for single phase circuits can be found in the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources\">MultiPhase.Sources</a>

</html>"));
  end Sources;

  package Interfaces "Interfaces for AC singlephase models"
    extends Modelica.Icons.InterfacesPackage;

    connector Pin "Quasi-static single-phase pin"
      Modelica.SIunits.ComplexElectricPotential v "Complex potential at the quasi-static single-phase pin";
      flow Modelica.SIunits.ComplexCurrent i "Complex current flowing into the quasi-static single-phase pin";
      annotation (Documentation(info="<html>
<p>
The potential of this connector is the complex voltage and the flow variable is the complex current.
The <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">positive</a> and
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">negative pin</a> are
derived from this base connector.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.Plug\">Plug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">NegativePlug</a>
</p>

</html>"));
    end Pin;

    connector PositivePin "Positive quasi-static single-phase pin"
      extends Pin;
      QuasiStationary.Types.Reference reference "Reference";
      annotation (
        Diagram(graphics={Text(
              extent={{-100,100},{100,60}},
              lineColor={0,0,255},
              textString="%name"), Rectangle(
              extent={{-40,40},{40,-40}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid)}),
        Icon(graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>

<p>
The positive pin is based on <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">Pin</a>.
Additionally the reference angle is specified in the connector. The time derivative of the reference angle is the actual angular velocity of the quasi stationary voltage and current. The symbol is also designed such way to look different than the <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">negative pin</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">Pin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.Plug\">Plug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">NegativePlug</a>
</p>
</html>"));
    end PositivePin;

    connector NegativePin "Negative quasi-static single-phase pin"
      extends Pin;
      QuasiStationary.Types.Reference reference "Reference";
      annotation (
        Diagram(graphics={Text(
              extent={{-100,100},{100,60}},
              lineColor={0,0,255},
              textString="%name"), Rectangle(
              extent={{-40,40},{40,-40}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Icon(graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>

<p>
The negative pin is based on <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">Pin</a>.
Additionally the reference angle is specified in the connector. The time derivative of the reference angle is the actual angular velocity of the quasi stationary voltage and current. The symbol is also designed such way to look different than the <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">positive pin</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">Pin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.Plug\">Plug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">NegativePlug</a>
</p>
</html>"));
    end NegativePin;

    partial model TwoPin "Two pins"
      import Modelica.Constants.eps;
      Modelica.SIunits.ComplexVoltage v "Complex voltage";
      Modelica.SIunits.Voltage abs_v=Modelica.ComplexMath.'abs'(v) "Magnitude of complex voltage";
      Modelica.SIunits.Angle arg_v=Modelica.ComplexMath.arg(v) "Argument of complex voltage";
      Modelica.SIunits.ComplexCurrent i "Complex current";
      Modelica.SIunits.Current abs_i=Modelica.ComplexMath.'abs'(i) "Magnitude of complex current";
      Modelica.SIunits.Angle arg_i=Modelica.ComplexMath.arg(i) "Argument of complex current";
      Modelica.SIunits.ActivePower P=Modelica.ComplexMath.real(v*
          Modelica.ComplexMath.conj(i)) "Active power";
      Modelica.SIunits.ReactivePower Q=Modelica.ComplexMath.imag(v*
          Modelica.ComplexMath.conj(i)) "Reactive power";
      Modelica.SIunits.ApparentPower S=Modelica.ComplexMath.'abs'(v*
          Modelica.ComplexMath.conj(i)) "Magnitude of complex apparent power";
      Real pf=cos(Modelica.ComplexMath.arg(Complex(P, Q))) "Power factor";
      Modelica.SIunits.AngularVelocity omega "Angular velocity of reference frame";

      PositivePin pin_p "Positive quasi-static single-phase pin" annotation (Placement(transformation(
              extent={{-110,-10},{-90,10}})));
      NegativePin pin_n "Negative quasi-static single-phase pin" annotation (Placement(transformation(
              extent={{90,-10},{110,10}})));
    equation
      Connections.branch(pin_p.reference, pin_n.reference);
      pin_p.reference.gamma = pin_n.reference.gamma;
      omega = der(pin_p.reference.gamma);
      v = pin_p.v - pin_n.v;
      i = pin_p.i;
      annotation (Documentation(info="<html>
<p>
This partial model uses a <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">positive</a>
and <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">negative pin</a> and defines the complex voltage difference as well as the complex current (into the positive pin). Additionally, the angular velocity of the quasi stationary system is explicitly defined as variable. This model is mainly intended to be used with graphical representation of user models.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.OnePort\">OnePort</a>
</p>
</html>"));
    end TwoPin;

    partial model OnePort "Two pins, current through"
      extends TwoPin;
    equation
      pin_p.i + pin_n.i = Complex(0);
      annotation (Documentation(info="<html>
<p>
This partial model is based on <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.TwoPin\">TwoPin</a> and
additionally considers the complex current balance of the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">positive</a> and the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">negative pin</a>.
This model is intended to be used with textual representation of user models.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.TwoPin\">TwoPin</a>
</p>
</html>"));
    end OnePort;

    partial model AbsoluteSensor "Partial potential sensor"
      extends Modelica.Icons.RotationalSensor;
      Modelica.SIunits.AngularVelocity omega;
      PositivePin pin "Positive quasi-static single-phase pin" annotation (Placement(transformation(extent={{-110,
                -10},{-90,10}})));
    equation
      omega = der(pin.reference.gamma);
      pin.i = Complex(0);
      annotation (Icon(graphics={
            Line(points={{-70,0},{-94,0}}, color={85,170,255}),
            Text(
              extent={{-160,120},{160,80}},
              lineColor={0,0,255},
              textString="%name"),
            Line(points={{100,0},{70,0}})}), Documentation(info="<html>
<p>
The absolute sensor partial model provides a single
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">positive pin</a> to measure the complex voltage. Additionally this model contains a proper icon and a definition of the angular velocity.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.RelativeSensor\">RelativeSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.AbsoluteSensor\">MultiPhase.Interfaces.AbsoluteSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.RelativeSensor\">MultiPhase.Interfaces.RelativeSensor</a>
</p>

</html>"));
    end AbsoluteSensor;

    partial model RelativeSensor "Partial voltage / current sensor"
      extends Modelica.Icons.RotationalSensor;
      extends OnePort;
      Modelica.ComplexBlocks.Interfaces.ComplexOutput y annotation (Placement(
            transformation(
            origin={0,-110},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      annotation (Icon(graphics={
            Line(points={{-70,0},{-94,0}}, color={85,170,255}),
            Line(points={{70,0},{94,0}}, color={85,170,255}),
            Text(
              extent={{-160,120},{160,80}},
              lineColor={0,0,255},
              textString="%name"),
            Line(points={{0,-70},{0,-80},{0,-90},{0,-100}})}),
          Documentation(info="<html>
<p>
The relative sensor partial model relies on the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.OnePort\">OnePort</a> to measure the complex voltage, current or power. Additionally this model contains a proper icon and a definition of the angular velocity.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.AbsoluteSensor\">AbsoluteSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.AbsoluteSensor\">MultiPhase.Interfaces.AbsoluteSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.RelativeSensor\">MultiPhase.Interfaces.RelativeSensor</a>
</p>

</html>"));
    end RelativeSensor;

    partial model Source "Partial voltage / current source"
      extends OnePort;
      Modelica.SIunits.Angle gamma(start=0) = pin_p.reference.gamma;
    equation
      Connections.root(pin_p.reference);
      annotation (Icon(graphics={
            Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{150,60},{-150,100}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{-90,0},{-50,0}}, color={85,170,255}),
            Line(points={{50,0},{90,0}}, color={85,170,255})}),
                                            Documentation(info="<html>
<p>
The source partial model relies on the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.OnePort\">OnePort</a> and contains a proper icon.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.Source\">MultiPhase.Interfaces.Source</a>.
</p>
</html>"));
    end Source;
    annotation (Documentation(info="<html>
<p>This package contains connector specifications and partial models for more complex components.</p>
</html>"));
  end Interfaces;

  package Utilities "Library with auxiliary models for testing"
    extends Modelica.Icons.UtilitiesPackage;
    model IdealACDCConverter "Ideal AC DC converter"
      parameter Real conversionFactor "Ratio of DC voltage / QS rms voltage";
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.imag;
      import Modelica.ComplexMath.conj;
      import Modelica.ComplexMath.'abs';
      import Modelica.ComplexMath.arg;
      Modelica.SIunits.ComplexVoltage vQS=pin_pQS.v - pin_nQS.v "AC QS voltage";
      Modelica.SIunits.ComplexCurrent iQS=pin_pQS.i "AC QS current";
      output Modelica.SIunits.Voltage vQSabs='abs'(vQS) "Abs(AC QS voltage)";
      output Modelica.SIunits.Current iQSabs='abs'(iQS) "Abs(AC QS current)";
      Modelica.SIunits.ComplexPower sQS=vQS*conj(iQS) "AC QS apparent power";
      Modelica.SIunits.ActivePower pQS=real(sQS) "AC QS active power";
      Modelica.SIunits.ReactivePower qQS=imag(sQS) "AC QS reactive power";
      Modelica.SIunits.Voltage vDC=pin_pDC.v - pin_nDC.v "DC voltage";
      Modelica.SIunits.Current iDC=pin_pDC.i "DC current";
      Modelica.SIunits.Power pDC=vDC*iDC "DC power";
      Interfaces.PositivePin pin_pQS annotation (Placement(transformation(
              extent={{-110,110},{-90,90}}), iconTransformation(extent={{-110,
                110},{-90,90}})));
      Interfaces.NegativePin pin_nQS annotation (Placement(transformation(
              extent={{-110,-110},{-90,-90}}), iconTransformation(extent={{-110,
                -110},{-90,-90}})));
      Analog.Interfaces.PositivePin pin_pDC annotation (Placement(
            transformation(extent={{90,110},{110,90}}), iconTransformation(
              extent={{90,110},{110,90}})));
      Analog.Interfaces.NegativePin pin_nDC annotation (Placement(
            transformation(extent={{90,-110},{110,-90}}), iconTransformation(
              extent={{90,-110},{110,-90}})));
    equation
      //QS balances
      Connections.branch(pin_pQS.reference, pin_nQS.reference);
      pin_pQS.reference.gamma = pin_nQS.reference.gamma;
      pin_pQS.i + pin_nQS.i = Complex(0);
      //DC current balance
      pin_pDC.i + pin_nDC.i = 0;
      //voltage relation
      vDC = 'abs'(vQS)*conversionFactor;
      //power balance
      pQS + pDC = 0;
      //define reactive power
      qQS = 0;
      annotation (defaultComponentName="rectifier", Icon(graphics={
            Line(
              points={{2,40},{70,40},{2,40},{70,-50},{2,-50},{2,40},{2,-50}},
              color={0,0,255}),
            Text(
              extent={{50,30},{100,0}},
              lineColor={0,0,255},
              textString="DC"),
            Line(
              points={{-2,40},{-2,40},{-70,40},{-2,40},{-70,-50},{-2,-50},{-2,40},{-2,-50}},
              color={85,170,255}),
            Text(
              extent={{-90,30},{-40,0}},
              lineColor={85,170,255},
              textString="QS"),
            Text(
              extent={{-150,90},{150,50}},
              lineColor={0,0,255},
              textString="%name"),
            Text(
              extent={{-150,-50},{150,-90}},
              textString="%conversionFactor")}), Documentation(info="<html>
<p>
This is an ideal AC DC converter, based on a power balance between QS circuit and DC side.
The parameter <em>conversionFactor</em> defines the ratio between averaged DC voltage and QS rms voltage.
Furthermore, reactive power at the QS side is set to 0.
</p>
<h4>Note:</h4>
<p>
Of course no voltage or current ripple is present, neither at the QS side nor at the DC side.
At the QS side, only base harmonics of voltage and current are taken into account.
At the DC side, only the mean of voltage and current are taken into account.
</p>
</html>"));
    end IdealACDCConverter;

    model GraetzRectifier "Graetz rectifier bridge"
      Modelica.SIunits.Voltage vAC=pin_pAC.v - pin_nAC.v "AC voltage";
      Modelica.SIunits.Current iAC=pin_pAC.i "AC current";
      Modelica.SIunits.ActivePower pAC=vAC*iAC "AC power";
      Modelica.SIunits.Voltage vDC=pin_pDC.v - pin_nDC.v "DC voltage";
      Modelica.SIunits.Current iDC=pin_pDC.i "DC current";
      Modelica.SIunits.Power pDC=vDC*iDC "DC power";
      Analog.Interfaces.PositivePin pin_pAC annotation (Placement(
            transformation(extent={{-110,110},{-90,90}}), iconTransformation(
              extent={{-110,110},{-90,90}})));
      Analog.Interfaces.NegativePin pin_nAC annotation (Placement(
            transformation(extent={{-110,-110},{-90,-90}}), iconTransformation(
              extent={{-110,-110},{-90,-90}})));
      Analog.Interfaces.PositivePin pin_pDC annotation (Placement(
            transformation(extent={{90,110},{110,90}}), iconTransformation(
              extent={{90,110},{110,90}})));
      Analog.Interfaces.NegativePin pin_nDC annotation (Placement(
            transformation(extent={{90,-110},{110,-90}}), iconTransformation(
              extent={{90,-110},{110,-90}})));
      Analog.Ideal.IdealDiode idealDiode1(Vknee=0) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-40,30})));
      Analog.Ideal.IdealDiode idealDiode2(Vknee=0) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={40,30})));
      Analog.Ideal.IdealDiode idealDiode3(Vknee=0) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-40,-30})));
      Analog.Ideal.IdealDiode idealDiode4(Vknee=0) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={40,-30})));
    equation
      connect(idealDiode1.p, idealDiode3.n) annotation (Line(
          points={{-40,20},{-40,-20}}, color={0,0,255}));
      connect(idealDiode2.p, idealDiode4.n) annotation (Line(
          points={{40,20},{40,-20}}, color={0,0,255}));
      connect(idealDiode3.p, idealDiode4.p) annotation (Line(
          points={{-40,-40},{40,-40}}, color={0,0,255}));
      connect(idealDiode1.n, idealDiode2.n) annotation (Line(
          points={{-40,40},{40,40}}, color={0,0,255}));
      connect(pin_pAC, idealDiode1.p) annotation (Line(
          points={{-100,100},{-100,10},{-40,10},{-40,20}}, color={0,0,255}));
      connect(pin_nAC, idealDiode4.n) annotation (Line(
          points={{-100,-100},{-100,-10},{40,-10},{40,-20}}, color={0,0,255}));
      connect(idealDiode2.n, pin_pDC) annotation (Line(
          points={{40,40},{40,100},{100,100}}, color={0,0,255}));
      connect(idealDiode4.p, pin_nDC) annotation (Line(
          points={{40,-40},{40,-100},{100,-100}}, color={0,0,255}));
      annotation (defaultComponentName="rectifier", Icon(graphics={
            Text(
              extent={{50,30},{100,0}},
              lineColor={0,0,255},
              textString="DC"),
            Text(
              extent={{-100,30},{-50,0}},
              lineColor={0,0,255},
              textString="AC"),
            Text(
              extent={{-150,90},{150,50}},
              lineColor={0,0,255},
              textString="%name"),
            Line(
              points={{-2,40},{-2,40},{-70,40},{-2,40},{-70,-50},{-2,-50},{-2,40},{-2,-50}},
              color={0,0,255}),
            Line(
              points={{2,40},{70,40},{2,40},{70,-50},{2,-50},{2,40},{2,-50}},
              color={0,0,255})}), Documentation(info="<html>
<p>
This is a so called Graetz-bridge, a single phase rectifier built from 4 diodes.
</p>
</html>"));
    end GraetzRectifier;

    annotation (Documentation(info="<html>
<p>This package hosts utilities for test examples of quasi stationary single phase circuits.
Quasi stationary theory for single phase circuits can be found in the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Examples\">Examples</a>

</html>"));
  end Utilities;
  annotation (Icon(graphics={Rectangle(lineColor={0,0,255}, extent={{-50,-50},{
              50,50}}), Rectangle(
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          extent={{-20,-20},{20,20}})}, coordinateSystem(extent={{-100,-100},{
            100,100}}, preserveAspectRatio=true)), Documentation(info="<html>
<p>This package hosts models for quasi stationary single phase circuits.
Quasi stationary theory for single phase circuits can be found in the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase\">MultiPhase</a>

</html>"));
end SinglePhase;
