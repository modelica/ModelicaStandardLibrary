within Modelica.Electrical.QuasiStationary;
package SinglePhase "Single phase AC components"
  extends Modelica.Icons.Package;

  package Examples "Test examples"
    extends Modelica.Icons.ExamplesPackage;

    model SeriesResonance "Series resonance circuit"
      extends Modelica.Icons.Example;
      Modelica.Blocks.Sources.Constant V(k=1)
        annotation (Placement(transformation(
            origin={-40,50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Sources.Constant phi(k=0)
        annotation (Placement(transformation(
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
      QuasiStationary.SinglePhase.Sources.VariableVoltageSource voltageSource
        annotation (Placement(transformation(
            origin={-30,-20},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      QuasiStationary.SinglePhase.Basic.Ground ground
        annotation (Placement(transformation(extent={{-40,-60},{-20,-40}}, rotation=
               0)));
      QuasiStationary.SinglePhase.Basic.Resistor resistor(R_ref=0.1)
        annotation (Placement(transformation(extent={{10,-10},{30,10}}, rotation=0)));
      QuasiStationary.SinglePhase.Basic.Inductor inductor(L=1/(2*Modelica.Constants.pi))
        annotation (Placement(transformation(extent={{40,-10},{60,10}}, rotation=0)));
      QuasiStationary.SinglePhase.Basic.Capacitor capacitor(C=1/(2*Modelica.Constants.pi))
        annotation (Placement(transformation(extent={{70,-10},{90,10}}, rotation=0)));
      QuasiStationary.SinglePhase.Sensors.CurrentSensor currentSensor
                                          annotation (Placement(transformation(
              extent={{-20,10},{0,-10}}, rotation=0)));
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
      connect(f.y, voltageSource.f) annotation (Line(points={{-60,-39},{-60,-24},{-40,
              -24}}, color={0,0,127}));
      connect(polarToComplex.y, voltageSource.V) annotation (Line(points={{-60,-1},
              {-60,-16},{-40,-16}},color={85,170,255}));
      connect(ground.pin, voltageSource.pin_n) annotation (Line(points={{-30,-40},
              {-30,-35},{-30,-30},{-30,-30}},
                                         color={85,170,255}));
      connect(voltageSource.pin_p, currentSensor.pin_p) annotation (Line(points={{-30,-10},
              {-30,0},{-20,0}},      color={85,170,255}));
      connect(currentSensor.pin_n, resistor.pin_p)
        annotation (Line(points={{0,0},{2.5,0},{2.5,-3.36456e-022},{5,-3.36456e-022},
              {5,0},{10,0}}, color={85,170,255}));
      connect(resistor.pin_n, inductor.pin_p)
        annotation (Line(points={{30,0},{32.5,0},{32.5,1.22125e-015},{35,1.22125e-015},
              {35,0},{40,0}}, color={85,170,255}));
      connect(inductor.pin_n, capacitor.pin_p)
        annotation (Line(points={{60,0},{62.5,0},{62.5,1.22125e-015},{65,1.22125e-015},
              {65,0},{70,0}}, color={85,170,255}));
      connect(capacitor.pin_n, ground.pin) annotation (Line(points={{90,0},{90,-40},
              {-30,-40}}, color={85,170,255}));
      connect(phi.y, polarToComplex.phi) annotation (Line(points={{-80,39},{-80,30},
              {-66,30},{-66,22}},     color={0,0,127}));
      connect(V.y, polarToComplex.len) annotation (Line(
          points={{-40,39},{-40,30},{-54,30},{-54,22}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(currentSensor.y, complexToPolar.u) annotation (Line(
          points={{-10,11},{-10,18}},
          color={85,170,255},
          smooth=Smooth.None));
      annotation ( Documentation(info="<html>
<p>
The frequency of the voltage source is varied by a ramp.
Plot length and angle of the current phasor, i.e., complexToPolar.len and .phi, versis time resp. frequency.
</p>
</html>"));
    end SeriesResonance;

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
      QuasiStationary.SinglePhase.Sources.VariableCurrentSource currentSource
        annotation (Placement(transformation(
            origin={-30,20},
            extent={{10,10},{-10,-10}},
            rotation=270)));
      QuasiStationary.SinglePhase.Basic.Ground ground
        annotation (Placement(transformation(extent={{-40,-20},{-20,0}}, rotation=0)));
      QuasiStationary.SinglePhase.Basic.Resistor resistor(R_ref=10)
        annotation (Placement(transformation(
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
      connect(currentSource.pin_p, ground.pin) annotation (Line(points={{-30,10},
              {-30,5},{-30,0}},               color={85,170,255}));
      connect(resistor.pin_n, ground.pin) annotation (Line(points={{-10,10},{
              -10,0},{-30,0}},
                        color={85,170,255}));
      connect(inductor.pin_n, ground.pin) annotation (Line(points={{10,10},{10,0},{-30,
              0}}, color={85,170,255}));
      connect(capacitor.pin_n, ground.pin) annotation (Line(points={{30,10},{30,
              0},{-30,0}},
                       color={85,170,255}));
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
      annotation ( Documentation(info="<html>
<p>
The frequency of the current source is varied by a ramp.
Plot length and angle of the voltage phasor, i.e., complexToPolar.len and .phi, versis time resp. frequency.
</p>
</html>"));
    end ParallelResonance;

    model Rectifier "Rectifier example"
      extends Modelica.Icons.Example;
      import Modelica.Constants.pi;
      parameter Modelica.SIunits.Voltage VAC = 100 "AC rms voltage";
      parameter Real conversionFactor = 1
        "Ratio of DC voltage / AC rms voltage";
      Sources.VoltageSource voltageQS(f=50, V=VAC) annotation (Placement(
            transformation(
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
      Utilities.IdealACDCConverter rectifierQS(conversionFactor=conversionFactor)
        annotation (Placement(transformation(extent={{-10,40},{10,60}})));
      Analog.Basic.Ground groundDC1
        annotation (Placement(transformation(extent={{0,10},{20,30}})));
      Analog.Sensors.CurrentSensor iDC1
        annotation (Placement(transformation(extent={{20,70},{40,50}})));
      Analog.Basic.VariableConductor load1 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={50,50})));
      Analog.Sources.SineVoltage voltageAC(V=sqrt(2)*VAC, freqHz=50,phase=pi/2)
        annotation (
          Placement(transformation(
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
      Blocks.Sources.Ramp ramp(height=1,
        duration=0.8,
        startTime=0.1)
        annotation (Placement(transformation(extent={{100,-10},{80,10}})));
    equation
      connect(voltageQS.pin_p, resistorQS.pin_p) annotation (Line(
          points={{-80,60},{-72,60}},
          color={85,170,255},
          smooth=Smooth.None));
      connect(voltageQS.pin_n, rectifierQS.pin_nQS) annotation (Line(
          points={{-80,40},{-10,40}},
          color={85,170,255},
          smooth=Smooth.None));
      connect(rectifierQS.pin_nQS, groundQS.pin) annotation (Line(
          points={{-10,40},{-10,30}},
          color={85,170,255},
          smooth=Smooth.None));
      connect(rectifierQS.pin_nDC, groundDC1.p) annotation (Line(
          points={{10,40},{10,30}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(load1.n, rectifierQS.pin_nDC) annotation (Line(
          points={{50,40},{10,40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(voltageAC.p, resistorAC.p) annotation (Line(
          points={{-80,-40},{-70,-40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(voltageAC.n, rectifierAC.pin_nAC) annotation (Line(
          points={{-80,-60},{-10,-60}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(rectifierAC.pin_nAC, groundAC.p) annotation (Line(
          points={{-10,-60},{-10,-70}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(rectifierAC.pin_nDC, load2.n) annotation (Line(
          points={{10,-60},{50,-60}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(ramp.y, load1.G) annotation (Line(
          points={{79,0},{70,0},{70,50},{61,50}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(ramp.y, load2.G) annotation (Line(
          points={{79,0},{70,0},{70,-50},{61,-50}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(resistorQS.pin_n, currentSensorQS.pin_p) annotation (Line(
          points={{-52,60},{-40,60}},
          color={85,170,255},
          smooth=Smooth.None));
      connect(currentSensorQS.pin_n, rectifierQS.pin_pQS) annotation (Line(
          points={{-20,60},{-10,60}},
          color={85,170,255},
          smooth=Smooth.None));
      connect(currentSensorQS.y, iQS.u)            annotation (Line(
          points={{-30,71},{-30,80},{-22,80}},
          color={85,170,255},
          smooth=Smooth.None));
      connect(rectifierQS.pin_pDC, iDC1.p)             annotation (Line(
          points={{10,60},{20,60}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(iDC1.n, load1.p)             annotation (Line(
          points={{40,60},{50,60}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(resistorAC.n, currentSensorAC.p) annotation (Line(
          points={{-50,-40},{-40,-40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(currentSensorAC.n, rectifierAC.pin_pAC) annotation (Line(
          points={{-20,-40},{-10,-40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(currentSensorAC.i, iAC.u)            annotation (Line(
          points={{-30,-30},{-30,-20},{-22,-20}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(currentSensorDC2.i, iDC2.u) annotation (Line(
          points={{30,-30},{30,-20},{38,-20}},
          color={0,0,127},
          smooth=Smooth.None));
     connect(currentSensorDC2.p, rectifierAC.pin_pDC) annotation (Line(
          points={{20,-40},{10,-40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(currentSensorDC2.n, load2.p) annotation (Line(
          points={{40,-40},{50,-40}},
          color={0,0,255},
          smooth=Smooth.None));
      annotation (Diagram(graphics),
        experiment(Interval=0.0001),
        experimentSetupOutput,
        Documentation(info="<html>
<p>
This example demonstrates coupling a quasi stationary circuit with a DC circuit.
The QS voltage is rectified (using an
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Utilities.IdealACDCConverter\">
ideal AC DC converter</a>), loaded by a variable load conductor.
The <i>conversionFactor = DC voltage / AC rms voltage</i> in this case is the root mean square of a rectified sine, i.e., 1.
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
It can be ssen that at the DC side the current is represented by its averaged value, at the AC side by its rms value.
</p>
<h4>Note</h4>
<p>
The quasi stationary model needs a grounding at the QS side as well as the DC side,
wheras the transient model may have only one ground since AC side and DC side are connected via the diodes.
</p>
</html>"));
    end Rectifier;

    annotation (Documentation(info="<html>
Examples to demonstrate the usage of quasistationary electric components.
</html>"),   Icon(graphics));
  end Examples;

  package Basic "Basic components for AC singlephase models"
    extends Modelica.Icons.Package;

    model Ground "Electrical ground"

      Interfaces.PositivePin pin
        annotation (Placement(transformation(extent={{-10,90},{10,110}}, rotation=0)));
    equation
      Connections.potentialRoot(pin.reference, 256);
      if Connections.isRoot(pin.reference) then
        pin.reference.gamma = 0;
      end if;
      pin.v = Complex(0);
      annotation (Icon(graphics={
            Line(points={{-60,50},{60,50}}),
            Line(points={{-40,30},{40,30}}),
            Line(points={{-20,10},{20,10}}),
            Line(points={{0,90},{0,50}}),
            Text(extent={{100,-60},{-100,-20}},
                                              textString=
                                                "%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>
<p>
Ground of a single phase circuit. The potential at the ground node is zero.
Every electrical circuit, e.g., a series resonance
<a href=\"modelica://Modelica.Electrical.QuasiStationary.Examples.SeriesResonance\">
          example</a>, has to contain at least one ground object.
</p>

</html>"));
    end Ground;

    model Resistor "Singlephase linear resistor"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.conj;
      parameter Modelica.SIunits.Resistance R_ref(start=1)
        "Reference resistance at T_ref";
      parameter Modelica.SIunits.Temperature T_ref=293.15
        "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref=0
        "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref);
      Modelica.SIunits.Resistance R_actual
        "Resistance = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
    equation
      assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps, "Temperature outside scope of model!");
      R_actual = R_ref*(1 + alpha_ref*(T_heatPort - T_ref));
      v = R_actual*i;
      LossPower = real(v*conj(i));
      annotation (Icon(graphics={
            Text(extent={{100,60},{-100,100}}, textString=
                                                   "%name",
              lineColor={0,0,255}),
            Line(points={{60,0},{90,0}}),
            Line(points={{-90,0},{-60,0}}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{100,-80},{-100,-40}}, textString=
                                                  "R=%R_ref")}),
        Documentation(info="<html>
<p>
The linear resistor connects the complex voltage <i><u>v</u></i> with the complex
current <i><u>i</u></i> by <i><u>i</u>*R = <u>v</u></i>.
The resistance <i>R</i> is allowed to be positive, zero, or negative.
</p>

<p>
The resistor model also has an optional
<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">conditional heat port</a>.
A linear temperature dependency of the resistance for an enabled heat port is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor>Capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>Variable resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor>Variable conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>Variable capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
    end Resistor;

    model Conductor "Singlephase linear conductor"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.conj;
      parameter Modelica.SIunits.Conductance G_ref(start=1)
        "Reference conductance at T_ref";
      parameter Modelica.SIunits.Temperature T_ref=293.15
        "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref=0
        "Temperature coefficient of conductance (G_actual = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref);
      Modelica.SIunits.Conductance G_actual
        "Conductance = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
    equation
      assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps, "Temperature outside scope of model!");
      G_actual = G_ref/(1 + alpha_ref*(T_heatPort - T_ref));
      i = G_actual*v;
      LossPower = real(v*conj(i));
      annotation (Icon(graphics={
            Text(extent={{100,60},{-100,100}}, textString=
                                                   "%name",
              lineColor={0,0,255}),
            Line(points={{60,0},{90,0}}),
            Line(points={{-90,0},{-60,0}}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{100,-80},{-100,-40}}, textString=
                                                  "G=%G_ref")}),
        Documentation(info="<html>

<p>
The linear conductor connects the voltage <i><u>v</u></i> with the
current <i><u>i</u></i> by <i><u>i</u> = <u>v</u>*G</i>.
The conductance <i>G</i> is allowed to be positive, zero, or negative.
</p>

<p>
The conductor model also has an optional
<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">conditional heat port</a>.
A linear temperature dependency of the resistance for an enabled heat port is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor>Resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor>Capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>Variable resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor>Variable conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>Variable capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
    end Conductor;

    model Capacitor "Singlephase linear capacitor"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.j;
      parameter Modelica.SIunits.Capacitance C(start=1) "Capacitance";
    equation
      i = j*omega*C*v;
      annotation (Icon(graphics={
            Text(extent={{100,60},{-100,100}}, textString=
                                                   "%name",
              lineColor={0,0,255}),
            Line(
              points={{-14,28},{-14,-28}},
              color={0,0,255},
              thickness=0.5),
            Line(
              points={{14,28},{14,-28}},
              color={0,0,255},
              thickness=0.5),
            Line(points={{-90,0},{-14,0}}),
            Line(points={{14,0},{90,0}}),
            Text(extent={{100,-80},{-100,-40}}, textString=
                                                  "C=%C")}),
        Documentation(info="<html>

<p>
The linear capacitor connects the voltage <i><u>v</u></i> with the
current <i><u>i</u></i> by <i><u>i</u> = j*&omega;*C*<u>v</u></i>.
The capacitance <i>C</i> is allowed to be positive, zero, or negative.
</p>

<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor>Resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>Variable resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor>Variable conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>Variable capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
    end Capacitor;

    model Inductor "Singlephase linear inductor"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.j;
      parameter Modelica.SIunits.Inductance L(start=1) "Inductance";
    equation
      v = j*omega*L*i;
      annotation (Icon(graphics={
            Text(extent={{100,60},{-100,100}}, textString=
                                                   "%name",
              lineColor={0,0,255}),
            Ellipse(extent={{-60,-15},{-30,15}}),
            Ellipse(extent={{-30,-15},{0,15}}),
            Ellipse(extent={{0,-15},{30,15}}),
            Ellipse(extent={{30,-15},{60,15}}),
            Rectangle(
              extent={{-60,-30},{60,0}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{60,0},{90,0}}),
            Line(points={{-90,0},{-60,0}}),
            Text(extent={{100,-80},{-100,-40}}, textString=
                                                  "L=%L")}),
        Documentation(info="<html>

<p>
The linear inductor connects the voltage <i><u>v</u></i> with the
current <i><u>i</u></i> by  <i><u>v</u> = j*&omega;*L*<u>i</u></i>.
The Inductance <i>L</i> is allowed to be positive, zero, or negative.
</p>

<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor>Resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor>Capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>Variable resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor>Variable conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>Variable capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
    end Inductor;

    model VariableResistor "Singlephase variable resistor"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.conj;
      parameter Modelica.SIunits.Temperature T_ref=293.15
        "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref=0
        "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref);
      Modelica.SIunits.Resistance R_actual
        "Resistance = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      Modelica.Blocks.Interfaces.RealInput R_ref
        annotation (Placement(transformation(
            origin={0,110},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps, "Temperature outside scope of model!");
      R_actual = R_ref*(1 + alpha_ref*(T_heatPort - T_ref));
      v = R_actual*i;
      LossPower = real(v*conj(i));
      annotation (Icon(graphics={
            Text(extent={{100,-80},{-100,-40}}, textString=
                                                   "%name",
              lineColor={0,0,255}),
            Line(points={{60,0},{90,0}}),
            Line(points={{-90,0},{-60,0}}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,90},{0,30}},
              color={0,0,255},
              smooth=Smooth.None)}),
        Documentation(info="<html>

<p>
The linear resistor connects the voltage <i><u>v</u></i> with the
current <i><u>i</u></i> by <i><u>i</u>*R = <u>v</u></i>.
The resistance <i>R</i> is given as input signal.
<p>

<p>
The variable resistor model also has an optional
<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">conditional heat port</a>.
A linear temperature dependency of the resistance for an enabled heat port is also taken into account.
</p>

<h4>Note</h4>
<p>
A zero crossing of the R signal could cause singularities due to the actual structure of the connected network.
</p>

<p>
The variable resistor model also has an optional
<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">conditional heat port</a>.
A linear temperature dependency of the resistance for an enabled heat port is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor>Resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor>Capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor>Variable conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>Variable capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
    end VariableResistor;

    model VariableConductor "Singlephase variable conductor"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.conj;
      parameter Modelica.SIunits.Temperature T_ref=293.15
        "Reference temperature";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref=0
        "Temperature coefficient of conductance (G_actual = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(T = T_ref);
      Modelica.SIunits.Conductance G_actual
        "Conductance = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
      Modelica.Blocks.Interfaces.RealInput G_ref
        annotation (Placement(transformation(
            origin={0,110},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      assert((1 + alpha_ref*(T_heatPort - T_ref)) >= Modelica.Constants.eps, "Temperature outside scope of model!");
      G_actual = G_ref/(1 + alpha_ref*(T_heatPort - T_ref));
      i = G_actual*v;
      LossPower = real(v*conj(i));
      annotation (Icon(graphics={
            Text(extent={{100,-80},{-100,-40}}, textString=
                                                   "%name",
              lineColor={0,0,255}),
            Line(points={{60,0},{90,0}}),
            Line(points={{-90,0},{-60,0}}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,90},{0,30}},
              color={0,0,255},
              smooth=Smooth.None)}),
        Documentation(info="<html>

<p>
The linear conductor connects the voltage <i><u>v</u></i> with the
current <i><u>i</u></i> by <i><u>i</u> = G*<u>v</u></i>.
The conductance <i>G</i> is given as input signal.
</p>

<p>
The variable conductor model also has an optional
<a href=\"modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">conditional heat port</a>.
A linear temperature dependency of the resistance for an enabled heat port is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor>Resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor>Capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>Variable resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>Variable capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
    end VariableConductor;

    model VariableCapacitor "Singlephase variable capacitor"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.j;
      Modelica.Blocks.Interfaces.RealInput C
        annotation (Placement(transformation(
            origin={0,110},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      i = j*omega*C*v;
      annotation (Icon(graphics={
            Text(extent={{100,-80},{-100,-40}}, textString=
                                                   "%name",
              lineColor={0,0,255}),
            Line(
              points={{-14,28},{-14,-28}},
              color={0,0,255},
              thickness=0.5),
            Line(
              points={{14,28},{14,-28}},
              color={0,0,255},
              thickness=0.5),
            Line(points={{-90,0},{-14,0}}),
            Line(points={{14,0},{90,0}}),
            Line(points={{0,90},{0,30}}, color={0,0,255})}),
        Documentation(info="<html>

<p>
The linear capacitor connects the voltage <i><u>v</u></i> with the
current <i><u>i</u></i> by <i><u>i</u> = j*&omega;*C*<u>v</u></i>.
The capacitance <i>C</i> is given as input signal.
</p>

<h4>Note</h4>
<p>
The abstraction of a variable capacitor at quasi stationary operation assumes:<br>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/SinglePhase/Basic/dc_dt.png\">.
</p>

<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor>Resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor>Capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>Variable resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor>Variable conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor>Variable inductor</a>
</p>
</html>"));
    end VariableCapacitor;

    model VariableInductor "Singlephase variable inductor"
      extends Interfaces.OnePort;
      import Modelica.ComplexMath.j;
      Modelica.Blocks.Interfaces.RealInput L
        annotation (Placement(transformation(
            origin={0,108},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      v = j*omega*L*i;
      annotation (Icon(graphics={
            Text(extent={{100,-80},{-100,-40}}, textString=
                                                   "%name",
              lineColor={0,0,255}),
            Ellipse(extent={{-60,-15},{-30,15}}),
            Ellipse(extent={{-30,-15},{0,15}}),
            Ellipse(extent={{0,-15},{30,15}}),
            Ellipse(extent={{30,-15},{60,15}}),
            Rectangle(
              extent={{-60,-30},{60,0}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{60,0},{90,0}}),
            Line(points={{-90,0},{-60,0}}),
            Line(points={{0,90},{0,8}}, color={0,0,255})}),
        Documentation(info="<html>

<p>
The linear inductor connects the branch voltage <i><u>v</u></i> with the
branch current <i><u>i</u></i> by <i><u>v</u> = j*&omega;*L*<u>i</u></i>. The inductance <i>L</i> is given as input signal.
</p>

<h4>Note</h4>
<p>
The abstraction of a variable inductor at quasi stationary operation assumes:<br>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/SinglePhase/Basic/dl_dt.png\">
</p>

<h4>See also</h4>
<p>
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor>Resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor>Conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor>Capacitor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor>Inductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor>Variable resistor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor>Variable conductor</a>,
<a href=modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor>Variable capacitor</a>
</p>
</html>"));
    end VariableInductor;
    annotation (Icon(graphics={
        Line(points={{-100,-40},{-80,-40}}),
        Line(points={{60,-40},{80,-40}}),
        Rectangle(
          extent={{-80,-10},{60,-70}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>
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
      annotation (
        Icon(graphics={
            Rectangle(
              extent={{-60,60},{60,-60}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-41,0}}),
            Line(points={{91,0},{40,0}}),
            Text(extent={{-100,100},{100,70}}, textString=
                                                   "%name",
              lineColor={0,0,255})}),
        Window(
          x=0.36,
          y=0.16,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p>
This model is a simple idle branch considering the complex current <i><u>i</u></i> = 0.
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
      annotation (
        Icon(graphics={
            Rectangle(
              extent={{-60,60},{60,-60}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{91,0},{-90,0}}),
            Text(extent={{-100,100},{100,70}}, textString=
                                                   "%name",
              lineColor={0,0,255})}),
        Window(
          x=0.31,
          y=0.14,
          width=0.6,
          height=0.6),
        Documentation(info="<html>
<p>
This model is a simple short cut branch considering the complex voltage <i><u>v</u></i> = 0.
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
      parameter Modelica.SIunits.Resistance Ron(final min=0)=1.E-5
        "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff(final min=0)=1.E-5
        "Opened switch conductance";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=293.15);
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin p
       annotation (Placement(transformation(extent={{-110,
                -10},{-90,10}}, rotation=0)));
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin n2
       annotation (Placement(transformation(extent={{90,
                -10},{110,10}}, rotation=0)));
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin n1
       annotation (Placement(transformation(extent={{90,
                40},{110,60}}, rotation=0)));
      Modelica.Blocks.Interfaces.BooleanInput control
        "true => p--n2 connected, false => p--n1 connected" annotation (Placement(
            transformation(
            origin={0,80},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    protected
      Complex s1(re(final unit="1"), im(final unit="1"));
      Complex s2(re(final unit="1"), im(final unit="1")) "Auxiliary variables";
      constant Modelica.SIunits.ComplexVoltage  unitVoltage=
                                                           Complex(1,0)  annotation(HideResult=true);
      constant Modelica.SIunits.ComplexCurrent  unitCurrent=
                                                           Complex(1,0)  annotation(HideResult=true);
    equation
      Connections.branch(p.reference, n1.reference);
      p.reference.gamma = n1.reference.gamma;
      Connections.branch(p.reference, n2.reference);
      p.reference.gamma = n2.reference.gamma;
      p.i + n2.i + n1.i = Complex(0,0);
      p.v - n1.v = (s1*unitCurrent)*(if (control) then 1 else Ron);
      n1.i = -(s1*unitVoltage)*(if (control) then Goff else 1);
      p.v - n2.v = (s2*unitCurrent)*(if (control) then Ron else 1);
      n2.i = -(s2*unitVoltage)*(if (control) then 1 else Goff);
      LossPower = real(p.v*conj(p.i)) + real(n1.v*conj(n1.i)) + real(n2.v*conj(n2.i));
      annotation (
        Documentation(info="<HTML>
<P>
The commuting switch has a positive pin p and two negative pins n1 and n2.
The switching behaviour is controlled
by the inpug signal control. If control is true, the pin p is connected
with the negative pin n2. Otherwise, the pin p is connected to the negative pin n1.
</P>
<P>
In order to prevent singularities during switching, the opened
switch has a (very low) conductance Goff
and the closed switch has a (very low) resistance Ron.
The limiting case is also allowed, i.e., the resistance Ron of the
closed switch could be exactly zero and the conductance Goff of the
open switch could be also exactly zero. Note, there are circuits,
where a description with zero Ron or zero Goff is not possible.
<br> <br>
<b>Please note:</b>
In case of useHeatPort=true the temperature dependence of the electrical
behavior is <b> not </b> modelled. The parameters are not temperature dependent.
</P>
<p>
<b>Use with care:</b>
This switch is only intended to be used for structural changes, not for fast switching sequences, due to the quasistationary formulation.
</p>
</HTML>"),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Ellipse(extent={{-44,4},{-36,-4}}, lineColor={0,0,255}),
            Text(
              extent={{-80,0},{-60,22}},
              textString="p",
              lineColor={0,0,255}),
            Text(
              extent={{60,50},{80,72}},
              textString="n1",
              lineColor={0,0,255}),
            Text(
              extent={{60,0},{80,22}},
              textString="n2",
              lineColor={0,0,255}),
            Line(points={{-90,0},{-44,0}}, color={0,0,255}),
            Line(points={{-37,2},{40,50}}, color={0,0,255}),
            Line(points={{40,50},{90,50}}, color={0,0,255}),
            Line(points={{0,90},{0,25}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255}),
            Line(
              visible=useHeatPort,
              points={{0,-100},{0,25}},
              color={127,0,0},
              smooth=Smooth.None,
              pattern=LinePattern.Dot),
            Text(
              extent={{-148,-22},{152,-62}},
              textString="%name",
              lineColor={0,0,255})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Ellipse(extent={{-44,4},{-36,-4}}, lineColor={0,0,255}),
            Line(points={{-96,0},{-44,0}}, color={0,0,255}),
            Line(points={{-37,2},{40,50}}, color={0,0,255}),
            Line(points={{40,50},{96,50}}, color={0,0,255}),
            Line(points={{0,60},{0,25}}, color={0,0,255}),
            Line(points={{40,0},{96,0}}, color={0,0,255})}));
    end IdealCommutingSwitch;

    model IdealIntermediateSwitch "Ideal intermediate switch"
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.conj;
      parameter Modelica.SIunits.Resistance Ron(final min=0)=1.E-5
        "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff(final min=0)=1.E-5
        "Opened switch conductance";
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=293.15);
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin p1
        annotation (Placement(transformation(extent={{
                -110,40},{-90,60}}, rotation=0)));
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin p2
        annotation (Placement(transformation(extent={{
                -110,-10},{-90,10}}, rotation=0)));
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin n1
        annotation (Placement(transformation(extent={{90,
                40},{110,60}}, rotation=0)));
      Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin n2
        annotation (Placement(transformation(extent={{90,
                -10},{110,10}}, rotation=0)));
      Modelica.Blocks.Interfaces.BooleanInput control
        "true => p1--n2, p2--n1 connected, otherwise p1--n1, p2--n2  connected"
        annotation (Placement(transformation(
            origin={0,80},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    protected
      Complex s1(re(final unit="1"), im(final unit="1"));
      Complex s2(re(final unit="1"), im(final unit="1"));
      Complex s3(re(final unit="1"), im(final unit="1"));
      Complex s4(re(final unit="1"), im(final unit="1")) "Auxiliary variables";
      constant Modelica.SIunits.ComplexVoltage  unitVoltage=
                                                           Complex(1,0)  annotation(HideResult=true);
      constant Modelica.SIunits.ComplexCurrent  unitCurrent=
                                                           Complex(1,0)  annotation(HideResult=true);
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

      p1.i = if control then s1*unitVoltage*Goff + s3*unitCurrent else s1*unitCurrent + s3*unitVoltage*Goff;
      p2.i = if control then s2*unitVoltage*Goff + s4*unitCurrent else s2*unitCurrent + s4*unitVoltage*Goff;
      n1.i = if control then -s1*unitVoltage*Goff - s4*unitCurrent else -s1*unitCurrent - s4*unitVoltage*Goff;
      n2.i = if control then -s2*unitVoltage*Goff - s3*unitCurrent else -s2*unitCurrent - s3*unitVoltage*Goff;

      LossPower = real(p1.v*conj(p1.i)) + real(p2.v*conj(p2.i)) + real(n1.v*conj(n1.i)) + real(n2.v*conj(n2.i));
      annotation (
        Documentation(info="<HTML>
<P>
The intermediate switch has four switching contact pins p1, p2, n1, and n2.
The switching behaviour is controlled by the input signal control. If control
is true, the pin p1 is connected to pin n2, and the pin p2 is
connected to the pin n2. Otherwise, the pin p1 is connected to n1, and
p2 is connected to n2.
</P>
<IMG src=\"modelica://Modelica/Resources/Images/IdealIntermediateSwitch1.png\" ALT=\"IdealIntermediateSwitch1\">
<P>
In order to prevent singularities during switching, the opened
switch has a (very low) conductance Goff
and the closed switch has a (very low) resistance Ron.
</P>
<IMG src=\"modelica://Modelica/Resources/Images/IdealIntermediateSwitch2.png\" ALT=\"IdealIntermediateSwitch2\">
<P>
The limiting case is also allowed, i.e., the resistance Ron of the
closed switch could be exactly zero and the conductance Goff of the
open switch could be also exactly zero. Note, there are circuits,
where a description with zero Ron or zero Goff is not possible.
<br> <br>
<b>Please note:</b>
In case of useHeatPort=true the temperature dependence of the electrical
behavior is <b> not </b> modelled. The parameters are not temperature dependent.
</P>
<p>
<b>Use with care:</b>
This switch is only intended to be used for structural changes, not for fast switching sequences, due to the quasistationary formulation.
</p>
</HTML>"),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Ellipse(extent={{-4,30},{4,22}}, lineColor={0,0,255}),
            Text(
              extent={{-80,50},{-60,72}},
              textString="p1",
              lineColor={0,0,255}),
            Text(
              extent={{-80,0},{-60,22}},
              textString="p2",
              lineColor={0,0,255}),
            Text(
              extent={{60,50},{80,72}},
              textString="n1",
              lineColor={0,0,255}),
            Text(
              extent={{60,0},{80,22}},
              textString="n2",
              lineColor={0,0,255}),
            Line(points={{-90,0},{-44,0}}, color={0,0,255}),
            Line(points={{-90,50},{-44,50}}, color={0,0,255}),
            Line(points={{-44,0},{40,50}}, color={0,0,255}),
            Line(points={{-44,50},{40,0}}, color={0,0,255}),
            Line(points={{40,50},{90,50}}, color={0,0,255}),
            Line(points={{0,90},{0,25}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-151,-24},{149,-64}},
              textString="%name",
              lineColor={0,0,255})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Ellipse(extent={{-4,29},{4,21}}, lineColor={0,0,255}),
            Line(points={{-96,0},{-40,0}}, color={0,0,255}),
            Line(points={{-96,50},{-40,50}}, color={0,0,255}),
            Line(points={{-40,0},{40,50}}, color={0,0,255}),
            Line(points={{-40,50},{40,0}}, color={0,0,255}),
            Line(points={{40,50},{96,50}}, color={0,0,255}),
            Line(points={{0,60},{0,25}}, color={0,0,255}),
            Line(points={{40,0},{96,0}}, color={0,0,255})}));
    end IdealIntermediateSwitch;

    model IdealOpeningSwitch "Ideal electrical opener"
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.conj;
     extends Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.OnePort;
     parameter Modelica.SIunits.Resistance Ron(final min=0)=1.E-5
        "Closed switch resistance"
         annotation (Placement(transformation(extent={{-56.6667,10},{-10,56.6667}},
              rotation=0)));
     parameter Modelica.SIunits.Conductance Goff(final min=0)=1.E-5
        "Opened switch conductance" annotation (Placement(transformation(extent={
                {10,10},{56.6667,56.6667}}, rotation=0)));
     extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=293.15);
     Modelica.Blocks.Interfaces.BooleanInput control
        "true => switch open, false => p--n connected" annotation (Placement(
            transformation(
            origin={0,70},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    protected
     Complex s(re(final unit="1"), im(final unit="1")) "Auxiliary variable";
     constant Modelica.SIunits.ComplexVoltage  unitVoltage=
                                                          Complex(1,0)  annotation(HideResult=true);
     constant Modelica.SIunits.ComplexCurrent  unitCurrent=
                                                          Complex(1,0)  annotation(HideResult=true);
    equation
     v = (s*unitCurrent)*(if control then 1 else Ron);
     i = (s*unitVoltage)*(if control then Goff else 1);

     LossPower = real(v*conj(i));
      annotation (
        Documentation(info="<HTML>
<P>
The ideal opening switch has a positive pin p and a negative pin n.
The switching behaviour is controlled by the input signal control.
If control is true, pin p is not connected
with negative pin n. Otherwise, pin p is connected
with negative pin n.
</P>
<P>
In order to prevent singularities during switching, the opened
switch has a (very low) conductance Goff
and the closed switch has a (very low) resistance Ron.
The limiting case is also allowed, i.e., the resistance Ron of the
closed switch could be exactly zero and the conductance Goff of the
open switch could be also exactly zero. Note, there are circuits,
where a description with zero Ron or zero Goff is not possible.
<br> <br>
<b>Please note:</b>
In case of useHeatPort=true the temperature dependence of the electrical
behavior is <b> not </b> modelled. The parameters are not temperature dependent.
</P>
<p>
<b>Use with care:</b>
This switch is only intended to be used for structural changes, not for fast switching sequences, due to the quasistationary formulation.
</p>
</HTML>"),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Ellipse(extent={{-44,4},{-36,-4}}, lineColor={0,0,255}),
            Line(points={{-90,0},{-44,0}}, color={0,0,255}),
            Line(points={{-37,2},{40,50}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255}),
            Line(points={{0,51},{0,26}}, color={0,0,255}),
            Line(points={{40,20},{40,0}}, color={0,0,255}),
            Line(
              visible=useHeatPort,
              points={{0,-100},{0,25}},
              color={127,0,0},
              smooth=Smooth.None,
              pattern=LinePattern.Dot),
            Text(
              extent={{-151,-21},{149,-61}},
              textString="%name",
              lineColor={0,0,255})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Ellipse(extent={{-44,4},{-36,-4}}, lineColor={0,0,255}),
            Line(points={{-96,0},{-44,0}}, color={0,0,255}),
            Line(points={{-37,2},{40,50}}, color={0,0,255}),
            Line(points={{40,0},{96,0}}, color={0,0,255}),
            Text(
              extent={{-100,-40},{100,-79}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{0,51},{0,26}}, color={0,0,255}),
            Line(points={{40,20},{40,0}}, color={0,0,255})}));
    end IdealOpeningSwitch;

    model IdealClosingSwitch "Ideal electrical closer"
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.conj;
      extends
        Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.OnePort;
        parameter Modelica.SIunits.Resistance Ron(final min=0)=1.E-5
        "Closed switch resistance"
           annotation (Placement(transformation(extent={{-56.6667,10},{-10,
                56.6667}}, rotation=0)));
        parameter Modelica.SIunits.Conductance Goff(final min=0)=1.E-5
        "Opened switch conductance"   annotation (Placement(transformation(extent=
               {{10,10},{56.6667,56.6667}}, rotation=0)));
      extends Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort(final T=293.15);
        Modelica.Blocks.Interfaces.BooleanInput control
        "true => p--n connected, false => switch open"   annotation (Placement(
            transformation(
            origin={0,70},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    protected
        Complex s(re(final unit="1"), im(final unit="1")) "Auxiliary variable";
        constant Modelica.SIunits.ComplexVoltage  unitVoltage=
                                                             Complex(1,0)  annotation(HideResult=true);
        constant Modelica.SIunits.ComplexCurrent  unitCurrent=
                                                             Complex(1,0)  annotation(HideResult=true);
    equation
        v = (s*unitCurrent)*(if control then Ron else 1);
        i = (s*unitVoltage)*(if control then 1 else Goff);

        LossPower = real(v*conj(i));
        annotation (
          Documentation(info="<HTML>
<P>
The ideal closing switch has a positive pin p and a negative pin n.
The switching behaviour is controlled by input signal control.
If control is true, pin p is connected
with negative pin n. Otherwise, pin p is not connected
with negative pin n.
</P>
<P>
In order to prevent singularities during switching, the opened
switch has a (very low) conductance Goff
and the closed switch has a (very low) resistance Ron.
The limiting case is also allowed, i.e., the resistance Ron of the
closed switch could be exactly zero and the conductance Goff of the
open switch could be also exactly zero. Note, there are circuits,
where a description with zero Ron or zero Goff is not possible.
<br> <br>
<b>Please note:</b>
In case of useHeatPort=true the temperature dependence of the electrical
behavior is <b> not </b> modelled. The parameters are not temperature dependent.
</P>
<p>
<b>Use with care:</b>
This switch is only intended to be used for structural changes, not for fast switching sequences, due to the quasistationary formulation.
</p>
</HTML>"),Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Ellipse(extent={{-44,4},{-36,-4}}, lineColor={0,0,255}),
            Line(points={{-90,0},{-44,0}}, color={0,0,255}),
            Line(points={{-37,2},{40,50}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255}),
            Line(points={{0,51},{0,26}}, color={0,0,255}),
            Line(
              visible=useHeatPort,
              points={{0,-100},{0,25}},
              color={127,0,0},
              smooth=Smooth.None,
              pattern=LinePattern.Dot),
            Text(
              extent={{-152,-28},{148,-68}},
              textString="%name",
              lineColor={0,0,255})}),
          Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={1,1}), graphics={
            Ellipse(extent={{-44,4},{-36,-4}}, lineColor={0,0,255}),
            Line(points={{-96,0},{-44,0}}, color={0,0,255}),
            Line(points={{-37,2},{40,50}}, color={0,0,255}),
            Line(points={{40,0},{96,0}}, color={0,0,255}),
            Text(
              extent={{-100,-40},{100,-79}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{0,51},{0,26}}, color={0,0,255})}));
    end IdealClosingSwitch;
    annotation (Icon(graphics={
        Ellipse(extent={{-54,-56},{-46,-64}}),
        Line(points={{-100,-60},{-54,-60}}),
        Line(points={{-47,-58},{30,-10}}),
        Line(points={{30,-60},{80,-60}}),
        Line(points={{30,-40},{30,-60}})}), Documentation(info="<html>
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

    model FrequencySensor "Frequency sensor"
      extends Interfaces.AbsoluteSensor;
      import Modelica.Constants.pi;
      Blocks.Interfaces.RealOutput y                    annotation (Placement(transformation(extent={{100,-10},
                {120,10}},           rotation=0)));
    equation
      2*pi*y = omega;
      annotation (Icon(graphics={Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString="f"),
            Text(extent={{100,70},{-100,110}}, textString="%name",
              lineColor={0,0,255})}),
      Documentation(info="<html>

<p>
This sensor can be used to measure the frequency of the reference system.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>
</p>

</html>"));
    end FrequencySensor;

    model PotentialSensor "Potential sensor"
      extends Interfaces.AbsoluteSensor;
      ComplexBlocks.Interfaces.ComplexOutput y          annotation (Placement(transformation(extent={{100,-10},
                {120,10}},           rotation=0)));
    equation
      y = pin.v;
      annotation (Icon(graphics={Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString="V"),
            Text(extent={{100,70},{-100,110}}, textString="%name",
              lineColor={0,0,255})}),
      Documentation(info="<html>

<p>
This sensor can be used to measure the complex potential.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>
</p>

</html>"));
    end PotentialSensor;

    model VoltageSensor "Voltage sensor"
      extends Interfaces.RelativeSensor;
    equation
      i = Complex(0);
      y = v;
      annotation (Icon(graphics={Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString=
                   "V"),
            Text(extent={{100,70},{-100,110}},   textString=
                                                   "%name",
              lineColor={0,0,255})}),
      Documentation(info="<html>
<p>
This sensor can be used to measure the complex voltage.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>
</p>

</html>"));
    end VoltageSensor;

    model CurrentSensor "Current sensor"
      extends Interfaces.RelativeSensor;
    equation
      v = Complex(0);
      y = i;
      annotation (Icon(graphics={Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString=
                   "I"),
            Text(extent={{100,70},{-100,110}},   textString=
                                                   "%name",
              lineColor={0,0,255})}),
      Documentation(info="<html>
<p>
This sensor can be used to measure the complex current.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>
</p>

</html>"));
    end CurrentSensor;

    model PowerSensor "Power sensor"
      import Modelica.ComplexMath.conj;
      Interfaces.PositivePin currentP
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
               0)));
      Interfaces.NegativePin currentN
        annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
      Interfaces.PositivePin voltageP
        annotation (Placement(transformation(extent={{-10,90},{10,110}}, rotation=0)));
      Interfaces.NegativePin voltageN
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}}, rotation=
               0)));
      output Modelica.SIunits.ComplexCurrent  i;
      output Modelica.SIunits.ComplexVoltage  v;
      Modelica.ComplexBlocks.Interfaces.ComplexOutput y
        annotation (Placement(transformation(
            origin={-80,-110},
            extent={{-10,-10},{10,10}},
            rotation=270)));
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
      annotation (         Icon(graphics={
            Ellipse(
              extent={{-70,70},{70,-70}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{0,100},{0,70}}, color={0,0,255}),
            Line(points={{0,-70},{0,-100}}, color={0,0,255}),
            Line(points={{-100,0},{100,0}}, color={0,0,255}),
            Line(points={{0,70},{0,40}}, color={0,0,0}),
            Line(points={{22.9,32.8},{40.2,57.3}}, color={0,0,0}),
            Line(points={{-22.9,32.8},{-40.2,57.3}}, color={0,0,0}),
            Line(points={{37.6,13.7},{65.8,23.9}}, color={0,0,0}),
            Line(points={{-37.6,13.7},{-65.8,23.9}}, color={0,0,0}),
            Line(points={{0,0},{9.02,28.6}}, color={0,0,0}),
            Polygon(
              points={{-0.48,31.6},{18,26},{18,57.2},{-0.48,31.6}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-5,5},{5,-5}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString=
                   "P"),
            Line(points={{-80,-100},{-80,0}}, color={85,170,255}),
            Text(extent={{100,110},{-100,150}},  textString=
                                                   "%name",
              lineColor={0,0,255})}),
      Documentation(info="<html>

<p>
This sensor can be used to measure the complex apparent power.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
</p>

</html>"));
    end PowerSensor;
    annotation (Icon(graphics),                            Documentation(info="<html>
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
      parameter Modelica.SIunits.Frequency f(start=1) "frequency of the source";
      parameter Modelica.SIunits.Voltage V(start=1) "RMS voltage of the source";
      parameter Modelica.SIunits.Angle phi(start=0) "phase shift of the source";
    equation
      omega = 2*Modelica.Constants.pi*f;
      v = Complex(V*cos(phi), V*sin(phi));
      annotation (Icon(graphics={
            Text(
              extent={{-120,50},{-20,0}},
              lineColor={0,0,255},
              textString=
                      "+"),
            Text(
              extent={{20,50},{120,0}},
              lineColor={0,0,255},
              textString=
                      "-"),
            Line(points={{50,0},{-50,0}}, color={0,0,0})}),
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
      Modelica.Blocks.Interfaces.RealInput f
        annotation (Placement(transformation(
            origin={40,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.ComplexBlocks.Interfaces.ComplexInput V
        annotation (Placement(transformation(
            origin={-40,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      omega = 2*Modelica.Constants.pi*f;
      v = V;
      annotation (Icon(graphics={
            Text(
              extent={{-120,50},{-20,0}},
              lineColor={0,0,255},
              textString=
                      "+"),
            Text(
              extent={{20,50},{120,0}},
              lineColor={0,0,255},
              textString=
                      "-"),
            Line(points={{50,0},{-50,0}}, color={0,0,0})}),
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

    model CurrentSource "Constant AC current"
      extends Interfaces.Source;
      parameter Modelica.SIunits.Frequency f(start=1) "frequency of the source";
      parameter Modelica.SIunits.Current I(start=1) "RMS current of the source";
      parameter Modelica.SIunits.Angle phi(start=0) "phase shift of the source";
    equation
      omega = 2*Modelica.Constants.pi*f;
      i = Complex(I*cos(phi), I*sin(phi));
      annotation (Icon(graphics={
            Line(points={{0,-50},{0,50}}, color={0,0,0}),
            Line(points={{-60,60},{60,60}}, color={0,0,255}),
            Polygon(
              points={{60,60},{30,70},{30,50},{60,60}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
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
      Modelica.Blocks.Interfaces.RealInput f
        annotation (Placement(transformation(
            origin={40,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.ComplexBlocks.Interfaces.ComplexInput I
        annotation (Placement(transformation(
            origin={-40,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      omega = 2*Modelica.Constants.pi*f;
      i = I;
      annotation (Icon(graphics={
            Line(points={{0,-50},{0,50}}, color={0,0,0}),
            Line(points={{-60,60},{60,60}}, color={0,0,255}),
            Polygon(
              points={{60,60},{30,70},{30,50},{60,60}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>

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
    annotation (Icon(graphics),             Documentation(info="<html>
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

    connector Pin "Basic connector"
      Modelica.SIunits.ComplexVoltage  v "Complex potential at the node";
      flow Modelica.SIunits.ComplexCurrent  i
        "Complex current flowing into the pin";
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

    connector PositivePin "Positive connector"
      extends Pin;
      QuasiStationary.Types.Reference reference "Reference";
      annotation (Diagram(graphics={Text(
              extent={{-100,100},{100,60}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name"), Rectangle(
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
Additionally the reference angle is specified in the connector. The time derivative of the reference angle is the actual angluar velocity of the quasi stationary voltage and current. The symbol is also designed such way to look different than the <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">negative pin</a>.
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

    connector NegativePin "Negative Connector"
      extends Pin;
      QuasiStationary.Types.Reference reference "Reference";
      annotation (Diagram(graphics={Text(
              extent={{-100,100},{100,60}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name"), Rectangle(
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
Additionally the reference angle is specified in the connector. The time derivative of the reference angle is the actual angluar velocity of the quasi stationary voltage and current. The symbol is also designed such way to look different than the <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">positive pin</a>.
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
      Modelica.SIunits.ComplexVoltage  v;
      Modelica.SIunits.ComplexCurrent  i;
      Modelica.SIunits.AngularVelocity omega = der(pin_p.reference.gamma);
      PositivePin pin_p "Positive pin"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
               0)));
      NegativePin pin_n "Negative pin"
        annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
    equation
      Connections.branch(pin_p.reference, pin_n.reference);
      pin_p.reference.gamma = pin_n.reference.gamma;
      i = pin_p.i;
      v = pin_p.v - pin_n.v;
      annotation (         Documentation(info="<html>
<p>
This partial model uses a <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">positive</a>
and <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">negative pin</a> and defines the complex voltage difference as well as the complex current (into the positive pin). Additionally, the angular velocity of the quasi stationary system is explicitely defined as variable. This model is mainly intended to be used with graphical representation of user models.
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
      annotation (         Documentation(info="<html>
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
      Modelica.SIunits.AngularVelocity omega = der(pin.reference.gamma);
      PositivePin pin "Pin"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
               0)));
    equation
      pin.i = Complex(0);
      annotation (         Icon(graphics={
            Line(points={{-70,0},{-94,0}}, color={0,0,0}),
            Text(
              extent={{-100,100},{100,70}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={170,85,255},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name"),
            Line(points={{100,0},{70,0}},  color={0,0,0})}),
      Documentation(info="<html>
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

</html>"),
        Diagram(graphics));
    end AbsoluteSensor;

    partial model RelativeSensor "Partial voltage / current sensor"
      extends Modelica.Icons.RotationalSensor;
      extends OnePort;
      Modelica.ComplexBlocks.Interfaces.ComplexOutput y annotation (Placement(transformation(
            origin={0,-110},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      annotation (         Icon(graphics={
            Line(points={{-70,0},{-94,0}}, color={0,0,0}),
            Line(points={{70,0},{94,0}}, color={0,0,0}),
            Text(
              extent={{-100,100},{100,70}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={170,85,255},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name"),
            Line(points={{0,-70},{0,-80},{0,-90},{0,-100}}, color={85,170,255})}),
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
    equation
      Connections.root(pin_p.reference);
      annotation (Icon(graphics={
            Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(extent={{100,-100},{-100,-60}}, textString=
                                                   "%name",
              lineColor={0,0,255}),
            Line(points={{-90,0},{-50,0}}, color={0,0,0}),
            Line(points={{50,0},{90,0}}, color={0,0,0})}),
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
    annotation (Icon(graphics),                   Documentation(info="<html>
<p>This package contains connector specifications and partial models for more complex components.</p>
</html>"));
  end Interfaces;

  package Utilities "Library with auxiliary models for testing"
    extends Modelica.Icons.Package;
    model IdealACDCConverter "Ideal AC DC converter"
      parameter Real conversionFactor "Ratio of DC voltage / QS rms voltage";
      import Modelica.ComplexMath.real;
      import Modelica.ComplexMath.imag;
      import Modelica.ComplexMath.conj;
      import Modelica.ComplexMath.'abs';
      import Modelica.ComplexMath.arg;
      Modelica.SIunits.ComplexVoltage  vQS= pin_pQS.v - pin_nQS.v
        "AC QS voltage";
      Modelica.SIunits.ComplexCurrent  iQS= pin_pQS.i "AC QS current";
      output Modelica.SIunits.Voltage vQSabs='abs'(vQS) "Abs(AC QS voltage)";
      output Modelica.SIunits.Current iQSabs='abs'(iQS) "Abs(AC QS current)";
      Modelica.SIunits.ComplexPower  sQS= vQS*conj(iQS) "AC QS apparent power";
      Modelica.SIunits.ActivePower pQS = real(sQS) "AC QS active power";
      Modelica.SIunits.ReactivePower qQS = imag(sQS) "AC QS reactive power";
      Modelica.SIunits.Voltage vDC = pin_pDC.v - pin_nDC.v "DC voltage";
      Modelica.SIunits.Current iDC = pin_pDC.i "DC current";
      Modelica.SIunits.Power pDC = vDC*iDC "DC power";
      Interfaces.PositivePin pin_pQS
        annotation (Placement(transformation(extent={{-110,110},{-90,90}}),
            iconTransformation(extent={{-110,110},{-90,90}})));
      Interfaces.NegativePin pin_nQS
        annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}),
            iconTransformation(extent={{-110,-110},{-90,-90}})));
      Analog.Interfaces.PositivePin pin_pDC
        annotation (Placement(transformation(extent={{90,110},{110,90}}),
            iconTransformation(extent={{90,110},{110,90}})));
      Analog.Interfaces.NegativePin pin_nDC
        annotation (Placement(transformation(extent={{90,-110},{110,-90}}),
            iconTransformation(extent={{90,-110},{110,-90}})));
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
      annotation (Diagram(graphics), Icon(graphics={
            Line(
              points={{2,100},{2,60},{82,60},{2,60},{82,-60},{2,-60},{2,60},{2,-100}},
              color={0,0,255},
              smooth=Smooth.None),
            Text(
              extent={{40,40},{100,0}},
              lineColor={0,0,255},
              textString="DC"),
            Line(
              points={{-2,100},{-2,60},{-82,60},{-2,60},{-82,-60},{-2,-60},{-2,60},
                  {-2,-100}},
              color={85,170,255},
              smooth=Smooth.None),
            Text(
              extent={{-100,40},{-40,0}},
              lineColor={85,170,255},
              textString="QS"),
            Text(
              extent={{-100,92},{100,60}},
              lineColor={0,0,255},
              textString="%name"),
            Text(
              extent={{-100,-60},{100,-92}},
              lineColor={0,0,255},
              textString="%conversionFactor")}),
        Documentation(info="<html>
<p>
This is an ideal AC DC converter, based on a power balance between QS circuit and DC side.
The paramater <i>conversionFactor</i> defines the ratio between averaged DC voltage and QS rms voltage.
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
      Modelica.SIunits.Voltage vAC = pin_pAC.v - pin_nAC.v "AC voltage";
      Modelica.SIunits.Current iAC = pin_pAC.i "AC current";
      Modelica.SIunits.ActivePower pAC = vAC*iAC "AC power";
      Modelica.SIunits.Voltage vDC = pin_pDC.v - pin_nDC.v "DC voltage";
      Modelica.SIunits.Current iDC = pin_pDC.i "DC current";
      Modelica.SIunits.Power pDC = vDC*iDC "DC power";
      Analog.Interfaces.PositivePin pin_pAC
        annotation (Placement(transformation(extent={{-110,110},{-90,90}}),
            iconTransformation(extent={{-110,110},{-90,90}})));
      Analog.Interfaces.NegativePin pin_nAC
        annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}),
            iconTransformation(extent={{-110,-110},{-90,-90}})));
      Analog.Interfaces.PositivePin pin_pDC
        annotation (Placement(transformation(extent={{90,110},{110,90}}),
            iconTransformation(extent={{90,110},{110,90}})));
      Analog.Interfaces.NegativePin pin_nDC
        annotation (Placement(transformation(extent={{90,-110},{110,-90}}),
            iconTransformation(extent={{90,-110},{110,-90}})));
      Analog.Ideal.IdealDiode idealDiode1 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-40,30})));
      Analog.Ideal.IdealDiode idealDiode2 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={40,30})));
      Analog.Ideal.IdealDiode idealDiode3 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-40,-30})));
      Analog.Ideal.IdealDiode idealDiode4 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={40,-30})));
    equation
      connect(idealDiode1.p, idealDiode3.n) annotation (Line(
          points={{-40,20},{-40,-20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(idealDiode2.p, idealDiode4.n) annotation (Line(
          points={{40,20},{40,-20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(idealDiode3.p, idealDiode4.p) annotation (Line(
          points={{-40,-40},{40,-40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(idealDiode1.n, idealDiode2.n) annotation (Line(
          points={{-40,40},{40,40}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(pin_pAC, idealDiode1.p) annotation (Line(
          points={{-100,100},{-100,10},{-40,10},{-40,20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(pin_nAC, idealDiode4.n) annotation (Line(
          points={{-100,-100},{-100,-10},{40,-10},{40,-20}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(idealDiode2.n, pin_pDC) annotation (Line(
          points={{40,40},{40,100},{100,100}},
          color={0,0,255},
          smooth=Smooth.None));
      connect(idealDiode4.p, pin_nDC) annotation (Line(
          points={{40,-40},{40,-100},{100,-100}},
          color={0,0,255},
          smooth=Smooth.None));
      annotation (Diagram(graphics), Icon(graphics={
            Line(
              points={{2,100},{2,60},{82,60},{2,60},{82,-60},{2,-60},{2,60},{2,-100}},
              color={0,0,255},
              smooth=Smooth.None),
            Text(
              extent={{40,40},{100,0}},
              lineColor={0,0,255},
              textString="DC"),
            Line(
              points={{-2,100},{-2,60},{-82,60},{-2,60},{-82,-60},{-2,-60},{-2,60},
                  {-2,-100}},
              color={0,0,255},
              smooth=Smooth.None),
            Text(
              extent={{-100,40},{-40,0}},
              lineColor={0,0,255},
              textString="AC"),
            Text(
              extent={{-100,92},{100,60}},
              lineColor={0,0,255},
              textString="%name")}),
        Documentation(info="<html>
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
  annotation (Icon(graphics={Rectangle(extent={{-60,10},{40,-90}}, lineColor={0,
            0,255}), Rectangle(
        extent={{-30,-20},{10,-60}},
        lineColor={0,0,0},
        fillPattern=FillPattern.Solid,
        fillColor={170,213,255})}),  Documentation(info="<html>
<p>This package hosts models for quasi stationary single phase circuits.
Quasi stationary theory for single phase circuits can be found in the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase\">MultiPhase</a>

</html>"));
end SinglePhase;
