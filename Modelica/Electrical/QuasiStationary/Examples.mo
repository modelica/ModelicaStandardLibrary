within Modelica.Electrical.QuasiStationary;
package Examples "Test examples"
  extends Modelica.Icons.Library2;

  model SeriesResonance "Series resonance circuit"
    extends Modelica.Icons.Example;
    Modelica.Blocks.Sources.Constant V 
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
    Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource
      voltageSource 
      annotation (Placement(transformation(
          origin={-30,-20},
          extent={{-10,10},{10,-10}},
          rotation=270)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground 
      annotation (Placement(transformation(extent={{-40,-60},{-20,-40}}, rotation=
             0)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor resistor(
                                        R_ref=0.1) 
      annotation (Placement(transformation(extent={{10,-10},{30,10}}, rotation=0)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor inductor(
                                        L=1/(2*Modelica.Constants.pi)) 
      annotation (Placement(transformation(extent={{40,-10},{60,10}}, rotation=0)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor capacitor(
                                          C=1/(2*Modelica.Constants.pi)) 
      annotation (Placement(transformation(extent={{70,-10},{90,10}}, rotation=0)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor
      currentSensor                     annotation (Placement(transformation(
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
    annotation (Diagram(graphics), Documentation(info="<html>
<p>
The frequency of the voltage source is varied by a ramp. 
Plot length and angle of the current phasor, i.e. complexToPolar.len and .phi, versis time resp. frequency.
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
    Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource
      currentSource 
      annotation (Placement(transformation(
          origin={-30,20},
          extent={{10,10},{-10,-10}},
          rotation=270)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground 
      annotation (Placement(transformation(extent={{-40,-20},{-20,0}}, rotation=0)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor resistor(
                                        R_ref=10) 
      annotation (Placement(transformation(
          origin={-10,20},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor inductor(
                                        L=1/(2*Modelica.Constants.pi)) 
      annotation (Placement(transformation(
          origin={10,20},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor capacitor(
                                          C=1/(2*Modelica.Constants.pi)) 
      annotation (Placement(transformation(
          origin={30,20},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor
      voltageSensor                     annotation (Placement(transformation(
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
    connect(resistor.pin_n, ground.pin) annotation (Line(points={{-10,10},{-10,
            0},{-30,0}},
                      color={85,170,255}));
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
    annotation (Diagram(graphics), Documentation(info="<html>
<p>
The frequency of the current source is varied by a ramp. 
Plot length and angle of the voltage phasor, i.e. complexToPolar.len and .phi, versis time resp. frequency.
</p>
</html>"));
  end ParallelResonance;

  model BalancingStar "Balancing an unsymmetrical star-connected load"
    extends Modelica.Icons.Example;
    parameter Integer m=3 "Number of phases";
    parameter Modelica.SIunits.Voltage V = 100 "Source Voltage";
    parameter Modelica.SIunits.Frequency f = 50 "Source frequency";
    parameter Modelica.SIunits.Resistance R = 10 "Load resistance";
    parameter Modelica.SIunits.Inductance L = (R*sqrt(3))/(2*Modelica.Constants.pi*f)
      "Load inductance";
    parameter Modelica.SIunits.Capacitance C = 1/(R*sqrt(3))/(2*Modelica.Constants.pi*f)
      "Load capacitance";
    Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource
      voltageSource(
      m=m,
      f=f,
      V=fill(V, m),
      phi={-(j - 1)*2*Modelica.Constants.pi/m for j in 1:m}) 
      annotation (Placement(transformation(
          origin={-80,-20},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star(
                               m=m) 
      annotation (Placement(transformation(
          origin={-80,-50},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground 
      annotation (Placement(transformation(extent={{-90,-90},{-70,-70}}, rotation=
             0)));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_p
      plugToPin_p1(                           m=m, k=1) 
      annotation (Placement(transformation(extent={{-10,40},{10,60}}, rotation=0)));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_p
      plugToPin_p2(                           k=2, m=m) 
      annotation (Placement(transformation(extent={{-10,0},{10,20}}, rotation=0)));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_p
      plugToPin_p3(                           k=3, m=m) 
      annotation (Placement(transformation(extent={{-10,-40},{10,-20}}, rotation=
              0)));
    Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor
      powerSensor(                             m=m) 
      annotation (Placement(transformation(extent={{-70,0},{-50,20}}, rotation=0)));
    Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor
      currentSensor(                               m=m) 
      annotation (Placement(transformation(extent={{-40,0},{-20,20}}, rotation=0)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor resistor(
                                        R_ref=R) 
      annotation (Placement(transformation(extent={{20,-40},{40,-20}}, rotation=0)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor capacitor(
                                          C=C) 
      annotation (Placement(transformation(extent={{20,0},{40,20}}, rotation=0)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor inductor(
                                        L=L) 
      annotation (Placement(transformation(extent={{20,40},{40,60}}, rotation=0)));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star2(
                                m=m) 
      annotation (Placement(transformation(
          origin={80,-50},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_n
      plugToPin_n1(                           m=m, k=1) 
      annotation (Placement(transformation(
          origin={60,50},
          extent={{-10,-10},{10,10}},
          rotation=180)));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_n
      plugToPin_n2(                           k=2, m=m) 
      annotation (Placement(transformation(
          origin={60,10},
          extent={{-10,-10},{10,10}},
          rotation=180)));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_n
      plugToPin_n3(                           k=3, m=m) 
      annotation (Placement(transformation(
          origin={60,-30},
          extent={{-10,-10},{10,10}},
          rotation=180)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor
      currentSensor0 
      annotation (Placement(transformation(
          origin={-30,-60},
          extent={{-10,-10},{10,10}},
          rotation=180)));
  equation
    connect(ground.pin, star.pin_n) annotation (Line(points={{-80,-70},{-80,-60}},
          color={85,170,255}));
    connect(star.plug_p, voltageSource.plug_n) annotation (Line(points={{-80,-40},
            {-80,-30}}, color={85,170,255}));
    connect(voltageSource.plug_p, powerSensor.currentP) annotation (Line(points={
            {-80,-10},{-80,10},{-70,10}}, color={85,170,255}));
    connect(powerSensor.currentN, currentSensor.plug_p) 
      annotation (Line(points={{-50,10},{-40,10}}, color={85,170,255}));
    connect(powerSensor.voltageP, powerSensor.currentP) annotation (Line(points={
            {-60,20},{-70,20},{-70,10}}, color={85,170,255}));
    connect(powerSensor.voltageN, star.plug_p) annotation (Line(points={{-60,0},{
            -60,-40},{-80,-40}},                 color={85,170,255}));
    connect(currentSensor.plug_n, plugToPin_p2.plug_p) 
      annotation (Line(points={{-20,10},{-2,10}}, color={85,170,255}));
    connect(currentSensor.plug_n, plugToPin_p3.plug_p) annotation (Line(points={{
            -20,10},{-20,-30},{-2,-30}}, color={85,170,255}));
    connect(currentSensor.plug_n, plugToPin_p1.plug_p) annotation (Line(points={{
            -20,10},{-20,50},{-2,50}}, color={85,170,255}));
    connect(plugToPin_p1.pin_p, inductor.pin_p) 
      annotation (Line(points={{2,50},{20,50}}, color={85,170,255}));
    connect(plugToPin_p2.pin_p, capacitor.pin_p) 
      annotation (Line(points={{2,10},{20,10}}, color={85,170,255}));
    connect(plugToPin_p3.pin_p, resistor.pin_p) 
      annotation (Line(points={{2,-30},{20,-30}}, color={85,170,255}));
    connect(inductor.pin_n, plugToPin_n1.pin_n) 
      annotation (Line(points={{40,50},{58,50}}, color={85,170,255}));
    connect(capacitor.pin_n, plugToPin_n2.pin_n) 
      annotation (Line(points={{40,10},{58,10}}, color={85,170,255}));
    connect(resistor.pin_n, plugToPin_n3.pin_n) 
      annotation (Line(points={{40,-30},{58,-30}}, color={85,170,255}));
    connect(plugToPin_n1.plug_n, star2.plug_p) annotation (Line(points={{62,50},{
            80,50},{80,-40}}, color={85,170,255}));
    connect(plugToPin_n2.plug_n, star2.plug_p) annotation (Line(points={{62,10},{
            80,10},{80,-40}}, color={85,170,255}));
    connect(plugToPin_n3.plug_n, star2.plug_p) annotation (Line(points={{62,-30},
            {80,-30},{80,-40}}, color={85,170,255}));
    connect(star2.pin_n, currentSensor0.pin_p) 
      annotation (Line(points={{80,-60},{-20,-60}}, color={85,170,255}));
    connect(currentSensor0.pin_n, star.pin_n) annotation (Line(points={{-40,-60},
            {-80,-60}}, color={85,170,255}));
    annotation (Diagram(graphics), Documentation(info="<html>
<p>
For the unsymmetrical load (resistor, capacitor and inductor) the parameters inductance L and capacitance C 
are choosen such way that the neutral current (see currentSensor0) is zero.
</p>
<p>
P.Vaske, Berechnung von Drehstromschaltungen (German, Calculation of polyphase circuits), Teubner 1973, page 42, example 18
</p>
</html>"));
  end BalancingStar;

  model BalancingDelta "Balancing an unsymmetrical delta-connected load"
    extends Modelica.Icons.Example;
    parameter Integer m=3 "Number of phases";
    parameter Modelica.SIunits.Voltage V_LL = 100 "Source voltage line-to-line";
    parameter Modelica.SIunits.Frequency f = 50 "Source frequency";
    parameter Modelica.SIunits.Resistance R = 10 "Load resistance";
    parameter Modelica.SIunits.Inductance L = (R*sqrt(3))/(2*Modelica.Constants.pi*f)
      "Load inductance";
    parameter Modelica.SIunits.Capacitance C = 1/(R*sqrt(3))/(2*Modelica.Constants.pi*f)
      "Load capacitance";
    Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource
      voltageSource(
      m=m,
      f=f,
      V=fill(V_LL, m),
      phi={-(j - 1)*2*Modelica.Constants.pi/m for j in 1:m}) 
      annotation (Placement(transformation(
          origin={-70,-20},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star(
                               m=m) 
      annotation (Placement(transformation(
          origin={-70,-50},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground 
      annotation (Placement(transformation(extent={{-80,-90},{-60,-70}}, rotation=
             0)));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_p
      plugToPin_p1(                           m=m, k=1) 
      annotation (Placement(transformation(extent={{12,70},{32,90}}, rotation=0)));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_p
      plugToPin_p2(                           k=2, m=m) 
      annotation (Placement(transformation(extent={{10,0},{30,20}}, rotation=0)));
    Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_p
      plugToPin_p3(                           k=3, m=m) 
      annotation (Placement(transformation(extent={{10,-70},{30,-50}}, rotation=0)));
    Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor
      powerSensor(                             m=m) 
      annotation (Placement(transformation(extent={{-60,0},{-40,20}}, rotation=0)));
    Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor
      currentSensor(                               m=m) 
      annotation (Placement(transformation(extent={{-30,0},{-10,20}}, rotation=0)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor resistor(
                                        R_ref=R) 
      annotation (Placement(transformation(
          origin={70,30},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor capacitor(
                                          C=C) 
      annotation (Placement(transformation(
          origin={40,32},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor inductor(
                                        L=L) 
      annotation (Placement(transformation(
          origin={40,-38},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor
      currentSensor12 
      annotation (Placement(transformation(
          origin={40,62},
          extent={{-10,10},{10,-10}},
          rotation=270)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor
      currentSensor23 
      annotation (Placement(transformation(
          origin={40,-8},
          extent={{-10,10},{10,-10}},
          rotation=270)));
    Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor
      currentSensor31 
      annotation (Placement(transformation(
          origin={70,-10},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.ComplexBlocks.ComplexMath.ComplexToPolar complexToPolar[m] 
      annotation (Placement(transformation(
          origin={-20,-20},
          extent={{-10,-10},{10,10}},
          rotation=270)));
  equation
    connect(ground.pin, star.pin_n) annotation (Line(points={{-70,-70},{-70,-60}},
          color={85,170,255}));
    connect(star.plug_p, voltageSource.plug_n) annotation (Line(points={{-70,-40},
            {-70,-30}}, color={85,170,255}));
    connect(voltageSource.plug_p, powerSensor.currentP) annotation (Line(points={
            {-70,-10},{-70,10},{-60,10}}, color={85,170,255}));
    connect(powerSensor.currentP, powerSensor.voltageP) annotation (Line(points={
            {-60,10},{-60,20},{-50,20}}, color={85,170,255}));
    connect(powerSensor.currentN, currentSensor.plug_p) 
      annotation (Line(points={{-40,10},{-30,10}}, color={85,170,255}));
    connect(powerSensor.voltageN, star.plug_p) annotation (Line(points={{-50,0},{-50,
            -40},{-70,-40}},                     color={85,170,255}));
    connect(currentSensor.plug_n, plugToPin_p2.plug_p) 
      annotation (Line(points={{-10,10},{18,10}}, color={85,170,255}));
    connect(currentSensor.plug_n, plugToPin_p1.plug_p) annotation (Line(points={{
            -10,10},{0,10},{0,80},{20,80}}, color={85,170,255}));
    connect(currentSensor.plug_n, plugToPin_p3.plug_p) annotation (Line(points={{
            -10,10},{0,10},{0,-60},{18,-60}}, color={85,170,255}));
    connect(currentSensor12.pin_p, plugToPin_p1.pin_p) annotation (Line(points={{
            40,72},{40,80},{24,80}}, color={85,170,255}));
    connect(currentSensor12.pin_n, capacitor.pin_p) annotation (Line(points={{40,
            52},{40,42}}, color={85,170,255}));
    connect(capacitor.pin_n, plugToPin_p2.pin_p) annotation (Line(points={{40,22},
            {40,10},{22,10}}, color={85,170,255}));
    connect(plugToPin_p2.pin_p, currentSensor23.pin_p) annotation (Line(points={{22,10},
            {40,10},{40,2}},        color={85,170,255}));
    connect(currentSensor23.pin_n, inductor.pin_p) annotation (Line(points={{40,
            -18},{40,-28}}, color={85,170,255}));
    connect(inductor.pin_n, plugToPin_p3.pin_p) annotation (Line(points={{40,-48},
            {40,-60},{22,-60}}, color={85,170,255}));
    connect(plugToPin_p1.pin_p, resistor.pin_n) annotation (Line(points={{24,80},
            {70,80},{70,40}}, color={85,170,255}));
    connect(resistor.pin_p, currentSensor31.pin_n) 
      annotation (Line(points={{70,20},{70,0}},            color={85,170,255}));
    connect(currentSensor31.pin_p, plugToPin_p3.pin_p) annotation (Line(points={{
            70,-20},{70,-60},{22,-60}}, color={85,170,255}));
    connect(currentSensor.y, complexToPolar.u) annotation (Line(
        points={{-20,-1},{-20,-4.5},{-20,-8},{-20,-8}},
        color={85,170,255},
        smooth=Smooth.None));
    annotation (Diagram(graphics), Documentation(info="<html>
<p>
For the unsymmetrical load (resistor, capacitor and inductor) the parameters inductance L and capacitance C 
are choosen such way that the magnitudes of the three phase currents (see currentSensor12, currentSensor23, currentSensor31) are equal.
</p>
<p>
P.Vaske, Berechnung von Drehstromschaltungen (German, Calculation of polyphase circuits), Teubner 1973, page 43, example 23
</p>
</html>"));
  end BalancingDelta;
  annotation (Documentation(info="<html>
Examples to demonstrate the usage of quasistationary electric components.
</html>"), Icon(graphics={Ellipse(extent={{-80,44},{60,-96}}, lineColor={95,
            95,95}), Polygon(
        points={{-40,36},{-40,-88},{60,-26},{-40,36}},
        lineColor={95,95,95},
        fillColor={95,95,95},
        fillPattern=FillPattern.Solid)}));
end Examples;
