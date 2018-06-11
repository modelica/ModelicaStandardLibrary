within Modelica.Electrical.QuasiStationary;
package MultiPhase "Multiphase AC components"
  extends Modelica.Icons.Package;

  package Examples "Test examples"
    extends Modelica.Icons.ExamplesPackage;

    model BalancingStar "Balancing an unsymmetrical star-connected load"
      extends Modelica.Icons.Example;
      constant Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage V=100 "Source Voltage";
      parameter Modelica.SIunits.Frequency f=50 "Source frequency";
      parameter Modelica.SIunits.Resistance R=10 "Load resistance";
      parameter Modelica.SIunits.Inductance L=(R*sqrt(3))/(2*Modelica.Constants.pi*f)
        "Load inductance";
      parameter Modelica.SIunits.Capacitance C=1/(R*sqrt(3))/(2*Modelica.Constants.pi*f)
        "Load capacitance";
      output Modelica.SIunits.ComplexCurrent i[m]={resistor.i, inductor.i, capacitor.i}
        "Phase currents";
      QuasiStationary.MultiPhase.Sources.VoltageSource voltageSource(
        m=m,
        f=f,
        V=fill(V, m),
        phi=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m),
        gamma(fixed=true, start=0)) annotation (Placement(transformation(
            origin={-80,-20},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      QuasiStationary.MultiPhase.Basic.Star star(m=m) annotation (Placement(
            transformation(
            origin={-80,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      QuasiStationary.SinglePhase.Basic.Ground ground annotation (Placement(
            transformation(extent={{-90,-90},{-70,-70}})));
      QuasiStationary.MultiPhase.Basic.PlugToPin_p plugToPin_p1(m=m, k=1)
        annotation (Placement(transformation(extent={{0,40},{20,60}})));
      QuasiStationary.MultiPhase.Basic.PlugToPin_p plugToPin_p2(k=2, m=m)
        annotation (Placement(transformation(extent={{0,0},{20,20}})));
      QuasiStationary.MultiPhase.Basic.PlugToPin_p plugToPin_p3(k=3, m=m)
        annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
      QuasiStationary.MultiPhase.Sensors.PowerSensor powerSensor(m=m)
        annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
      QuasiStationary.MultiPhase.Sensors.CurrentSensor currentSensor(m=m)
        annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
      QuasiStationary.SinglePhase.Basic.Resistor resistor(R_ref=R) annotation (
          Placement(transformation(extent={{30,-40},{50,-20}})));
      QuasiStationary.SinglePhase.Basic.Capacitor capacitor(C=C) annotation (
          Placement(transformation(extent={{30,0},{50,20}})));
      QuasiStationary.SinglePhase.Basic.Inductor inductor(L=L) annotation (
          Placement(transformation(extent={{30,40},{50,60}})));
      QuasiStationary.MultiPhase.Basic.Star star2(m=m) annotation (Placement(
            transformation(
            origin={90,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      QuasiStationary.MultiPhase.Basic.PlugToPin_n plugToPin_n1(m=m, k=1)
        annotation (Placement(transformation(
            origin={70,50},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      QuasiStationary.MultiPhase.Basic.PlugToPin_n plugToPin_n2(k=2, m=m)
        annotation (Placement(transformation(
            origin={70,10},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      QuasiStationary.MultiPhase.Basic.PlugToPin_n plugToPin_n3(k=3, m=m)
        annotation (Placement(transformation(
            origin={70,-30},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      QuasiStationary.SinglePhase.Sensors.CurrentSensor currentSensor0
        annotation (Placement(transformation(
            origin={-30,-60},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      ComplexBlocks.ComplexMath.ComplexToPolar          complexToPolar[m]
        annotation (Placement(transformation(
            origin={-30,-20},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(ground.pin, star.pin_n)
        annotation (Line(points={{-80,-70},{-80,-60}}, color={85,170,255}));
      connect(star.plug_p, voltageSource.plug_n)
        annotation (Line(points={{-80,-40},{-80,-30}}, color={85,170,255}));
      connect(voltageSource.plug_p, powerSensor.currentP) annotation (Line(
            points={{-80,-10},{-80,10},{-70,10}}, color={85,170,255}));
      connect(powerSensor.currentN, currentSensor.plug_p)
        annotation (Line(points={{-50,10},{-40,10}}, color={85,170,255}));
      connect(powerSensor.voltageP, powerSensor.currentP) annotation (Line(
            points={{-60,20},{-70,20},{-70,10}}, color={85,170,255}));
      connect(powerSensor.voltageN, star.plug_p) annotation (Line(points={{-60,
              0},{-60,-40},{-80,-40}}, color={85,170,255}));
      connect(currentSensor.plug_n, plugToPin_p2.plug_p)
        annotation (Line(points={{-20,10},{8,10}}, color={85,170,255}));
      connect(currentSensor.plug_n, plugToPin_p3.plug_p) annotation (Line(
            points={{-20,10},{-20,10},{-10,10},{-10,-30},{8,-30}}, color={85,170,255}));
      connect(currentSensor.plug_n, plugToPin_p1.plug_p) annotation (Line(
            points={{-20,10},{-20,10},{-10,10},{-10,50},{8,50}}, color={85,170,255}));
      connect(plugToPin_p1.pin_p, inductor.pin_p)
        annotation (Line(points={{12,50},{30,50}}, color={85,170,255}));
      connect(plugToPin_p2.pin_p, capacitor.pin_p)
        annotation (Line(points={{12,10},{30,10}}, color={85,170,255}));
      connect(plugToPin_p3.pin_p, resistor.pin_p)
        annotation (Line(points={{12,-30},{30,-30}}, color={85,170,255}));
      connect(inductor.pin_n, plugToPin_n1.pin_n)
        annotation (Line(points={{50,50},{68,50}}, color={85,170,255}));
      connect(capacitor.pin_n, plugToPin_n2.pin_n)
        annotation (Line(points={{50,10},{68,10}}, color={85,170,255}));
      connect(resistor.pin_n, plugToPin_n3.pin_n)
        annotation (Line(points={{50,-30},{68,-30}}, color={85,170,255}));
      connect(plugToPin_n1.plug_n, star2.plug_p) annotation (Line(points={{72,50},{90,
              50},{90,-40}}, color={85,170,255}));
      connect(plugToPin_n2.plug_n, star2.plug_p) annotation (Line(points={{72,10},{90,
              10},{90,-40}}, color={85,170,255}));
      connect(plugToPin_n3.plug_n, star2.plug_p) annotation (Line(points={{72,-30},{
              90,-30},{90,-40}}, color={85,170,255}));
      connect(star2.pin_n, currentSensor0.pin_p)
        annotation (Line(points={{90,-60},{-20,-60}}, color={85,170,255}));
      connect(currentSensor0.pin_n, star.pin_n)
        annotation (Line(points={{-40,-60},{-80,-60}}, color={85,170,255}));
      connect(currentSensor.y, complexToPolar.u)
        annotation (Line(points={{-30,-1},{-30,-1},{-30,-8}}, color={85,170,255}));
      annotation (Documentation(info="<html>
<p>
For the unsymmetrical load (resistor, capacitor and inductor) the parameters inductance L and capacitance C
are chosen such way that the neutral current (see currentSensor0) is zero.
</p>
<p>
P.Vaske, Berechnung von Drehstromschaltungen (German, Calculation of polyphase circuits), Teubner 1973, page 42, example 18
</p>
</html>"), experiment(StopTime=1.0, Interval=0.001));
    end BalancingStar;

    model BalancingDelta "Balancing an unsymmetrical delta-connected load"
      extends Modelica.Icons.Example;
      parameter Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage V_LL=100 "Source voltage line-to-line";
      parameter Modelica.SIunits.Frequency f=50 "Source frequency";
      parameter Modelica.SIunits.Resistance R=10 "Load resistance";
      parameter Modelica.SIunits.Inductance L=(R*sqrt(3))/(2*Modelica.Constants.pi*f)
        "Load inductance";
      parameter Modelica.SIunits.Capacitance C=1/(R*sqrt(3))/(2*Modelica.Constants.pi*f)
        "Load capacitance";
      output Modelica.SIunits.ComplexCurrent i[m]={resistor.i, inductor.i, capacitor.i}
        "Phase currents";
      QuasiStationary.MultiPhase.Sources.VoltageSource voltageSource(
        m=m,
        f=f,
        V=fill(V_LL, m),
        phi=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m),
        gamma(fixed=true, start=0)) annotation (Placement(transformation(
            origin={-80,-20},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      QuasiStationary.MultiPhase.Basic.Star star(m=m) annotation (Placement(
            transformation(
            origin={-80,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      QuasiStationary.SinglePhase.Basic.Ground ground annotation (Placement(
            transformation(extent={{-90,-90},{-70,-70}})));
      QuasiStationary.MultiPhase.Basic.PlugToPin_p plugToPin_p1(m=m, k=1)
        annotation (Placement(transformation(extent={{2,70},{22,90}})));
      QuasiStationary.MultiPhase.Basic.PlugToPin_p plugToPin_p2(k=2, m=m)
        annotation (Placement(transformation(extent={{0,0},{20,20}})));
      QuasiStationary.MultiPhase.Basic.PlugToPin_p plugToPin_p3(k=3, m=m)
        annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
      QuasiStationary.MultiPhase.Sensors.PowerSensor powerSensor(m=m)
        annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
      QuasiStationary.MultiPhase.Sensors.CurrentSensor currentSensor(m=m)
        annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
      QuasiStationary.SinglePhase.Basic.Resistor resistor(R_ref=R) annotation (
          Placement(transformation(
            origin={60,30},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      QuasiStationary.SinglePhase.Basic.Capacitor capacitor(C=C) annotation (
          Placement(transformation(
            origin={30,32},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      QuasiStationary.SinglePhase.Basic.Inductor inductor(L=L) annotation (
          Placement(transformation(
            origin={30,-38},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      QuasiStationary.SinglePhase.Sensors.CurrentSensor currentSensor12
        annotation (Placement(transformation(
            origin={30,62},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      QuasiStationary.SinglePhase.Sensors.CurrentSensor currentSensor23
        annotation (Placement(transformation(
            origin={30,-8},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      QuasiStationary.SinglePhase.Sensors.CurrentSensor currentSensor31
        annotation (Placement(transformation(
            origin={60,-10},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Modelica.ComplexBlocks.ComplexMath.ComplexToPolar complexToPolar[m]
        annotation (Placement(transformation(
            origin={-30,-20},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    equation
      connect(ground.pin, star.pin_n)
        annotation (Line(points={{-80,-70},{-80,-60}}, color={85,170,255}));
      connect(star.plug_p, voltageSource.plug_n)
        annotation (Line(points={{-80,-40},{-80,-30}}, color={85,170,255}));
      connect(voltageSource.plug_p, powerSensor.currentP) annotation (Line(
            points={{-80,-10},{-80,10},{-70,10}}, color={85,170,255}));
      connect(powerSensor.currentP, powerSensor.voltageP) annotation (Line(
            points={{-70,10},{-70,20},{-60,20}}, color={85,170,255}));
      connect(powerSensor.currentN, currentSensor.plug_p)
        annotation (Line(points={{-50,10},{-40,10}}, color={85,170,255}));
      connect(powerSensor.voltageN, star.plug_p) annotation (Line(points={{-60,0},{-60,
              -40},{-80,-40}}, color={85,170,255}));
      connect(currentSensor.plug_n, plugToPin_p2.plug_p)
        annotation (Line(points={{-20,10},{8,10}}, color={85,170,255}));
      connect(currentSensor.plug_n, plugToPin_p1.plug_p) annotation (Line(
            points={{-20,10},{-10,10},{-10,80},{10,80}}, color={85,170,255}));
      connect(currentSensor.plug_n, plugToPin_p3.plug_p) annotation (Line(
            points={{-20,10},{-10,10},{-10,-60},{8,-60}}, color={85,170,255}));
      connect(currentSensor12.pin_p, plugToPin_p1.pin_p) annotation (Line(
            points={{30,72},{30,80},{14,80}}, color={85,170,255}));
      connect(currentSensor12.pin_n, capacitor.pin_p)
        annotation (Line(points={{30,52},{30,42}}, color={85,170,255}));
      connect(capacitor.pin_n, plugToPin_p2.pin_p) annotation (Line(points={{30,22},
              {30,10},{12,10}}, color={85,170,255}));
      connect(plugToPin_p2.pin_p, currentSensor23.pin_p)
        annotation (Line(points={{12,10},{30,10},{30,2}}, color={85,170,255}));
      connect(currentSensor23.pin_n, inductor.pin_p)
        annotation (Line(points={{30,-18},{30,-28}}, color={85,170,255}));
      connect(inductor.pin_n, plugToPin_p3.pin_p) annotation (Line(points={{30,-48},
              {30,-60},{12,-60}}, color={85,170,255}));
      connect(plugToPin_p1.pin_p, resistor.pin_n) annotation (Line(points={{14,80},{
              60,80},{60,40}}, color={85,170,255}));
      connect(resistor.pin_p, currentSensor31.pin_n)
        annotation (Line(points={{60,20},{60,0}}, color={85,170,255}));
      connect(currentSensor31.pin_p, plugToPin_p3.pin_p) annotation (Line(
            points={{60,-20},{60,-60},{12,-60}}, color={85,170,255}));
      connect(currentSensor.y, complexToPolar.u) annotation (Line(
          points={{-30,-1},{-30,-8}}, color={85,170,255}));
      annotation (Documentation(info="<html>
<p>
For the unsymmetrical load (resistor, capacitor and inductor) the parameters inductance L and capacitance C
are chosen such way that the magnitudes of the three phase currents (see currentSensor12, currentSensor23, currentSensor31) are equal.
</p>
<p>
P.Vaske, Berechnung von Drehstromschaltungen (German, Calculation of polyphase circuits), Teubner 1973, page 43, example 23
</p>
</html>"), experiment(StopTime=1.0, Interval=0.001));
    end BalancingDelta;

    model UnsymmetricalLoad "Unsymmetrical threephase load"
      extends Icons.Example;
      import Modelica.ComplexMath.'abs';
      output Modelica.SIunits.Current i1_d=symmetricalComponents_1.abs_y[1]
        "with neutral, direct component";
      output Modelica.SIunits.Current i1_i=symmetricalComponents_1.abs_y[2]
        "with neutral, inverse component";
      output Modelica.SIunits.Current i1_0=symmetricalComponents_1.abs_y[3]
        "with neutral, zero component";
      output Modelica.SIunits.Current i1_n='abs'(currentSensorN.y)
        "with neutral, neutral current";
      output Modelica.SIunits.Current i2_d=symmetricalComponents_2.abs_y[1]
        "w/o neutral, direct component";
      output Modelica.SIunits.Current i2_i=symmetricalComponents_2.abs_y[2]
        "w/o neutral, inverse component";
      output Modelica.SIunits.Current i2_0=symmetricalComponents_2.abs_y[3]
        "w/o neutral, zero component";
      output Modelica.SIunits.Voltage v2_n='abs'(voltageSensorN.y)
        "w/o neutral, neutral voltage";

      Sources.VoltageSource voltageSource1(
        m=3,
        f=50,
        V=fill(400/sqrt(3), 3),
        gamma(fixed=true, start=0))
                                annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-70,80})));
      Basic.Star star1_1(m=3) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-70,50})));
      SinglePhase.Basic.Ground ground1
        annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
      Sources.VoltageSource voltageSource2(
        m=3,
        f=50,
        V=fill(400/sqrt(3), 3),
        gamma(fixed=true, start=0))
                                annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-70,-20})));
      Basic.Star star2_1(m=3) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-70,-50})));
      SinglePhase.Basic.Ground ground2
        annotation (Placement(transformation(extent={{-80,-100},{-60,-80}})));
      Sensors.CurrentSensor currentSensor1(m=3)
        annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
      Blocks.SymmetricalComponents symmetricalComponents_1(m=3) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-50,50})));
      Sensors.CurrentSensor currentSensor2(m=3)
        annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
      Blocks.SymmetricalComponents symmetricalComponents_2(m=3) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-50,-50})));
      SinglePhase.Basic.Resistor resistor1_1(R_ref=110)
        annotation (Placement(transformation(extent={{-10,80},{10,100}})));
      SinglePhase.Basic.Resistor resistor1_2(R_ref=100)
        annotation (Placement(transformation(extent={{-10,60},{10,80}})));
      SinglePhase.Basic.Resistor resistor1_3(R_ref=60)
        annotation (Placement(transformation(extent={{-10,40},{10,60}})));
      SinglePhase.Basic.Inductor inductor1_2(L=0.25)
        annotation (Placement(transformation(extent={{20,60},{40,80}})));
      SinglePhase.Basic.Capacitor capacitor1_3(C=35e-6)
        annotation (Placement(transformation(extent={{-10,20},{10,40}})));
      SinglePhase.Basic.Resistor resistor2_1(R_ref=110)
        annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
      SinglePhase.Basic.Resistor resistor2_2(R_ref=100)
        annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
      SinglePhase.Basic.Resistor resistor2_3(R_ref=60)
        annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
      SinglePhase.Basic.Inductor inductor2_2(L=0.25)
        annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
      SinglePhase.Basic.Capacitor capacitor2_3(C=35e-6)
        annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
      Basic.PlugToPins_p plugToPins_p_1(m=3)
        annotation (Placement(transformation(extent={{-40,100},{-20,80}})));
      Basic.PlugToPins_p plugToPins_p_2(m=3)
        annotation (Placement(transformation(extent={{-40,0},{-20,-20}})));
      Basic.PlugToPins_n plugToPins_n_1(m=3)
        annotation (Placement(transformation(extent={{70,100},{50,80}})));
      Basic.PlugToPins_n plugToPins_n_2(m=3)
        annotation (Placement(transformation(extent={{72,0},{52,-20}})));
      Basic.Star star1_2(m=3) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={80,50})));
      Basic.Star star2_2(m=3) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={80,-50})));
      SinglePhase.Sensors.CurrentSensor currentSensorN
        annotation (Placement(transformation(extent={{70,30},{50,10}})));
      SinglePhase.Sensors.VoltageSensor voltageSensorN
        annotation (Placement(transformation(extent={{70,-70},{50,-90}})));
    equation
      connect(voltageSource1.plug_n, star1_1.plug_p)
        annotation (Line(points={{-70,70},{-70,65},{-70,60}}, color={85,170,255}));
      connect(star1_1.pin_n, ground1.pin)
        annotation (Line(points={{-70,40},{-70,20}}, color={85,170,255}));
      connect(voltageSource2.plug_n, star2_1.plug_p) annotation (Line(points={{-70,-30},
              {-70,-35},{-70,-40}}, color={85,170,255}));
      connect(star2_1.pin_n, ground2.pin)
        annotation (Line(points={{-70,-60},{-70,-80}}, color={85,170,255}));
      connect(voltageSource1.plug_p, currentSensor1.plug_p)
        annotation (Line(points={{-70,90},{-65,90},{-60,90}}, color={85,170,255}));
      connect(voltageSource2.plug_p, currentSensor2.plug_p) annotation (Line(points=
             {{-70,-10},{-65,-10},{-60,-10}}, color={85,170,255}));
      connect(resistor1_2.pin_n, inductor1_2.pin_p)
        annotation (Line(points={{10,70},{20,70}}, color={85,170,255}));
      connect(resistor1_3.pin_p, capacitor1_3.pin_p)
        annotation (Line(points={{-10,50},{-10,30}}, color={85,170,255}));
      connect(resistor1_3.pin_n, capacitor1_3.pin_n)
        annotation (Line(points={{10,50},{10,40},{10,30}}, color={85,170,255}));
      connect(resistor2_2.pin_n, inductor2_2.pin_p)
        annotation (Line(points={{10,-30},{20,-30}}, color={85,170,255}));
      connect(resistor2_3.pin_n, capacitor2_3.pin_n)
        annotation (Line(points={{10,-50},{10,-60},{10,-70}}, color={85,170,255}));
      connect(resistor2_3.pin_p, capacitor2_3.pin_p) annotation (Line(points={{-10,-50},
              {-10,-70},{-10,-70}}, color={85,170,255}));
      connect(currentSensor1.plug_n, plugToPins_p_1.plug_p)
        annotation (Line(points={{-40,90},{-36,90},{-32,90}}, color={85,170,255}));
      connect(currentSensor2.plug_n, plugToPins_p_2.plug_p) annotation (Line(points=
             {{-40,-10},{-32,-10},{-32,-10}}, color={85,170,255}));
      connect(plugToPins_p_1.pin_p[1], resistor1_1.pin_p) annotation (Line(points={{-28,
              90.6667},{-19,90},{-10,90}}, color={85,170,255}));
      connect(plugToPins_p_1.pin_p[2], resistor1_2.pin_p) annotation (Line(points={{
              -28,90},{-18,90},{-18,70},{-10,70}}, color={85,170,255}));
      connect(plugToPins_p_1.pin_p[3], resistor1_3.pin_p) annotation (Line(points={{-28,
              89.3333},{-22,89.3333},{-22,50},{-10,50}}, color={85,170,255}));
      connect(plugToPins_p_2.pin_p[1], resistor2_1.pin_p) annotation (Line(points={{-28,
              -9.33333},{-20,-9.33333},{-20,-10},{-10,-10}}, color={85,170,255}));
      connect(plugToPins_p_2.pin_p[2], resistor2_2.pin_p) annotation (Line(points={{
              -28,-10},{-18,-10},{-18,-30},{-10,-30}}, color={85,170,255}));
      connect(plugToPins_p_2.pin_p[3], resistor2_3.pin_p) annotation (Line(points={{-28,
              -10.6667},{-22,-10.6667},{-22,-50},{-10,-50}}, color={85,170,255}));
      connect(plugToPins_n_1.pin_n[1], resistor1_1.pin_n) annotation (Line(points={{58,
              90.6667},{34,90},{10,90}}, color={85,170,255}));
      connect(plugToPins_n_1.pin_n[2], inductor1_2.pin_n) annotation (Line(points={{
              58,90},{48,90},{48,70},{40,70}}, color={85,170,255}));
      connect(plugToPins_n_1.pin_n[3], resistor1_3.pin_n) annotation (Line(points={{58,
              89.3333},{52,89.3333},{52,50},{10,50}}, color={85,170,255}));
      connect(plugToPins_n_2.pin_n[1], resistor2_1.pin_n) annotation (Line(points={{60,
              -9.33333},{36,-10},{10,-10}}, color={85,170,255}));
      connect(plugToPins_n_2.pin_n[2], inductor2_2.pin_n) annotation (Line(points={{
              60,-10},{48,-10},{48,-30},{40,-30}}, color={85,170,255}));
      connect(plugToPins_n_2.pin_n[3], resistor2_3.pin_n) annotation (Line(points={{60,
              -10.6667},{52,-10.6667},{52,-50},{10,-50}}, color={85,170,255}));
      connect(plugToPins_n_1.plug_n, star1_2.plug_p)
        annotation (Line(points={{62,90},{80,90},{80,60}}, color={85,170,255}));
      connect(plugToPins_n_2.plug_n, star2_2.plug_p)
        annotation (Line(points={{64,-10},{80,-10},{80,-40}}, color={85,170,255}));
      connect(star1_2.pin_n, currentSensorN.pin_p)
        annotation (Line(points={{80,40},{80,20},{70,20}}, color={85,170,255}));
      connect(currentSensorN.pin_n, ground1.pin)
        annotation (Line(points={{50,20},{-10,20},{-70,20}}, color={85,170,255}));
      connect(star2_2.pin_n, voltageSensorN.pin_p)
        annotation (Line(points={{80,-60},{80,-80},{70,-80}}, color={85,170,255}));
      connect(voltageSensorN.pin_n, ground2.pin) annotation (Line(points={{50,-80},{
              -10,-80},{-70,-80}}, color={85,170,255}));
      connect(currentSensor1.y, symmetricalComponents_1.u)
        annotation (Line(points={{-50,79},{-50,62}}, color={85,170,255}));
      connect(currentSensor2.y, symmetricalComponents_2.u) annotation (Line(points={
              {-50,-21},{-50,-29.5},{-50,-38}}, color={85,170,255}));
      annotation (Documentation(info="<html>
<p>
This example shows an unsymmetrical load, in the upper with neutral connection (the singlephase current sensor measures the neutral current) and in the lower without neutral connection (the singlephase voltage sensor measures the neutral displacement).
</p>
</html>"),
      experiment(StopTime=1.0, Interval=0.001));
    end UnsymmetricalLoad;

    model TestSensors
      import Modelica;
      extends Modelica.Icons.Example;
      constant Integer m=3 "Number of phases";
      import Modelica.Constants.pi;
      parameter Modelica.SIunits.Voltage VRMS=100
        "Nominal RMS voltage per phase";
      parameter Modelica.SIunits.Frequency f=50 "Frequency";
      parameter Modelica.SIunits.Resistance R=1/sqrt(2) "Load resistance";
      parameter Modelica.SIunits.Inductance L=1/sqrt(2)/(2*pi*f) "Load inductance";
      final parameter Modelica.SIunits.Impedance Z=sqrt(R^2 + (2*pi*f*L)^2) "Load impedance";
      final parameter Modelica.SIunits.Current IRMS=VRMS/Z "Steady state RMS current";
      final parameter Modelica.SIunits.ActivePower P=3*R*IRMS^2 "Total active power";
      final parameter Modelica.SIunits.ReactivePower Q=3*(2*pi*f*L)*IRMS^2 "Total reactive power";
      final parameter Modelica.SIunits.ApparentPower S=3*Z*IRMS^2 "Total apparent power";
      Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource sineVoltage(
        final m=m,
        f=f,
        V=fill(VRMS, m),
        gamma(fixed=true, start=0))
                           annotation (Placement(transformation(
            origin={-20,-30},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star star(final m=m) annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-20,-70})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Ground ground annotation (Placement(
            transformation(
            origin={-20,-100},
            extent={{-10,-10},{10,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor resistor(m=m, R_ref=fill(R, m))
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={20,-20})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor inductor(m=m, L=fill(L, m))
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={20,-50})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star starLoad(m=m) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={20,-80})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor
        currentQuasiRMSSensor(m=m) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={-20,40})));
      Modelica.Blocks.Math.Feedback feedbackI
        annotation (Placement(transformation(extent={{-70,30},{-90,50}})));
      Modelica.Blocks.Sources.Constant constI(k=IRMS) annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-80,10})));

      Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor(m=m)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-50,-30})));
      Modelica.Blocks.Math.Feedback feedbackV
        annotation (Placement(transformation(extent={{-70,-40},{-90,-20}})));
      Modelica.Blocks.Sources.Constant constV(k=VRMS) annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-80,-60})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor powerSensor(m=m)
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={20,10})));
      Modelica.ComplexBlocks.ComplexMath.ComplexToReal complexToReal
        annotation (Placement(transformation(extent={{40,30},{60,10}})));
      Modelica.Blocks.Math.Feedback feedbackP
        annotation (Placement(transformation(extent={{80,-10},{100,10}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=
        Modelica.Electrical.QuasiStationary.MultiPhase.Functions.activePower(
            voltageQuasiRMSSensor.v, currentQuasiRMSSensor.i)) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={90,-30})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.AronSensor aronSensor annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={20,40})));
      Modelica.Blocks.Math.Feedback feedbackPAron
        annotation (Placement(transformation(extent={{80,30},{100,50}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.ReactivePowerSensor
        reactivePowerSensor annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={20,70})));
      Modelica.Blocks.Math.Feedback feedbackQ
        annotation (Placement(transformation(extent={{40,60},{60,80}})));
    equation

      connect(feedbackV.u1, voltageQuasiRMSSensor.V) annotation (Line(
          points={{-72,-30},{-61,-30}},
                                      color={0,0,127}));
      connect(constV.y, feedbackV.u2) annotation (Line(
          points={{-80,-49},{-80,-38}},
                                      color={0,0,127}));
      connect(realExpression.y, feedbackP.u2)
        annotation (Line(points={{90,-19},{90,-8}},
                                                  color={0,0,127}));
      connect(voltageQuasiRMSSensor.plug_p, sineVoltage.plug_p)
        annotation (Line(points={{-50,-20},{-20,-20}},
                                                     color={85,170,255}));
      connect(voltageQuasiRMSSensor.plug_n, sineVoltage.plug_n)
        annotation (Line(points={{-50,-40},{-20,-40}},
                                                     color={85,170,255}));
      connect(powerSensor.currentP, aronSensor.plug_n)
        annotation (Line(points={{20,20},{20,30}}, color={85,170,255}));
      connect(powerSensor.currentP, powerSensor.voltageP)
        annotation (Line(points={{20,20},{10,20},{10,10}},
                                                         color={85,170,255}));
      connect(powerSensor.currentN, resistor.plug_p)
        annotation (Line(points={{20,0},{20,-10}}, color={85,170,255}));
      connect(resistor.plug_n, inductor.plug_p)
        annotation (Line(points={{20,-30},{20,-40}}, color={85,170,255}));
      connect(inductor.plug_n, starLoad.plug_p)
        annotation (Line(points={{20,-60},{20,-70}}, color={85,170,255}));
      connect(starLoad.plug_p, powerSensor.voltageN)
        annotation (Line(points={{20,-70},{30,-70},{30,10}}, color={85,170,255}));
      connect(star.pin_n, ground.pin)
        annotation (Line(points={{-20,-80},{-20,-90}}, color={85,170,255}));
      connect(sineVoltage.plug_n, star.plug_p)
        annotation (Line(points={{-20,-40},{-20,-60}},color={85,170,255}));
      connect(powerSensor.y, complexToReal.u)
        annotation (Line(points={{31,20},{38,20}}, color={85,170,255}));
      connect(complexToReal.re, feedbackP.u1) annotation (Line(points={{62,14},{70,14},
              {70,0},{82,0}},   color={0,0,127}));
      connect(feedbackI.u2, constI.y)
        annotation (Line(points={{-80,32},{-80,21}}, color={0,0,127}));
      connect(feedbackI.u1, currentQuasiRMSSensor.I)
        annotation (Line(points={{-72,40},{-31,40}}, color={0,0,127}));
      connect(currentQuasiRMSSensor.plug_p, sineVoltage.plug_p)
        annotation (Line(points={{-20,30},{-20,-20}}, color={85,170,255}));
      connect(reactivePowerSensor.plug_n, aronSensor.plug_p)
        annotation (Line(points={{20,60},{20,50}}, color={85,170,255}));
      connect(currentQuasiRMSSensor.plug_n, reactivePowerSensor.plug_p)
        annotation (Line(points={{-20,50},{-20,80},{20,80}}, color={85,170,255}));
      connect(reactivePowerSensor.reactivePower, feedbackQ.u1)
        annotation (Line(points={{31,70},{42,70}}, color={0,0,127}));
      connect(aronSensor.power, feedbackPAron.u1)
        annotation (Line(points={{31,40},{82,40}}, color={0,0,127}));
      connect(complexToReal.re, feedbackPAron.u2)
        annotation (Line(points={{62,14},{90,14},{90,32}}, color={0,0,127}));
      connect(complexToReal.im, feedbackQ.u2) annotation (Line(points={{62,26},{70,26},
              {70,50},{50,50},{50,62}}, color={0,0,127}));
      annotation (experiment(StopTime=0.1, Interval=0.0001), Documentation(info="<html>
<p>
Test quasistationary multiphase sensors: A sinusoidal source feeds a load consisting of resistor and inductor.
</p>
</html>"));
    end TestSensors;
    annotation (Documentation(info="<html>
Examples to demonstrate the usage of quasistationary electric components.
</html>"));
  end Examples;

  package Basic "Basic components for AC multiphase models"
    extends Modelica.Icons.Package;

    model Star "Star connection"
      parameter Integer m(final min=1) = 3 "Number of phases";
      Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      QuasiStationary.SinglePhase.Interfaces.NegativePin pin_n annotation (
          Placement(transformation(extent={{90,-10},{110,10}})));
      PlugToPins_p plugToPins_p(final m=m) annotation (Placement(transformation(
              extent={{-80,-10},{-60,10}})));
    equation
      for j in 1:m loop
        connect(plugToPins_p.pin_p[j], pin_n);
      end for;
      connect(plug_p, plugToPins_p.plug_p) annotation (Line(points={{-100,0},{-93,
              0},{-86,0},{-72,0}}, color={85,170,255}));
      annotation (Icon(graphics={Line(
                  points={{80,0},{0,0}},
                  color={85,170,255},
                  thickness=0.5),Line(
                  points={{0,0},{-39,68}},
                  color={85,170,255},
                  thickness=0.5),Line(
                  points={{0,0},{-38,-69}},
                  color={85,170,255},
                  thickness=0.5), Line(points={{-90,0},{-40,0}}, color={85,170,255}),
              Line(points={{80,0},{90,0}}, color={85,170,255}),
            Text(
              extent={{-150,70},{150,110}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-110},{150,-70}},
              textString="m=%m")}),
          Documentation(info="<html>
<p>
Star (wye) connection of a multi phase circuit. The potentials at the star points are the same.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Delta\">Delta</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.MultiStar\">MultiStar</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.MultiDelta\">MultiDelta</a>
</p>
</html>"));
    end Star;

    model Delta "Delta (polygon) connection"
      parameter Integer m(final min=2) = 3 "Number of phases";
      Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));

      PlugToPins_p plugToPins_p(final m=m) annotation (Placement(transformation(
              extent={{-80,-10},{-60,10}})));
      PlugToPins_n plugToPins_n(final m=m) annotation (Placement(transformation(
              extent={{80,-10},{60,10}})));
    equation
      for j in 1:m loop
        if j < m then
          connect(plugToPins_n.pin_n[j], plugToPins_p.pin_p[j + 1]);
        else
          connect(plugToPins_n.pin_n[j], plugToPins_p.pin_p[1]);
        end if;
      end for;
      connect(plug_p, plugToPins_p.plug_p) annotation (Line(points={{-100,0},{-93,
              0},{-86,0},{-72,0}}, color={85,170,255}));
      connect(plugToPins_n.plug_n, plug_n) annotation (Line(points={{72,0},{79,
              0},{79,0},{86,0},{86,0},{100,0}}, color={85,170,255}));
      annotation (Icon(graphics={Line(
                  points={{-40,68},{-40,-70},{79,0},{-40,68},{-40,67}},
                  color={85,170,255},
                  thickness=0.5), Line(points={{-90,0},{-40,0}}, color={85,170,255}),
              Line(points={{80,0},{90,0}}, color={85,170,255}),
            Text(
              extent={{-150,70},{150,110}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-110},{150,-70}},
              textString="m=%m")}),
          Documentation(info="<html>
<p>
Delta (polygon) connection of a multi phase circuit.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star\">Star</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.MultiStar\">MultiStar</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.MultiDelta\">MultiDelta</a>
</p></html>"));
    end Delta;

    model MultiStar
      "Star connection of multi phase systems consisting of multiple base systems"
      parameter Integer m(final min=1) = 3 "Number of phases";
      final parameter Integer mSystems=
          Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(
          m) "Number of base systems";
      final parameter Integer mBasic=integer(m/mSystems)
        "Phase number of base systems";
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug
        plug_p(final m=m) annotation (Placement(transformation(extent={{-110,-10},
                {-90,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug
        starpoints(final m=mSystems) annotation (Placement(transformation(
              extent={{90,-10},{110,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_p
        plugToPins_p(final m=m) annotation (Placement(transformation(extent={{-80,
                -10},{-60,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_n
        plugToPins_n(final m=mSystems)
        annotation (Placement(transformation(extent={{80,-10},{60,10}})));
    equation
      for k in 1:mSystems loop
        for j in 1:mBasic loop
          connect(plugToPins_p.pin_p[(k - 1)*mBasic + j], plugToPins_n.pin_n[k]);
        end for;
      end for;
      connect(plug_p, plugToPins_p.plug_p)
        annotation (Line(points={{-100,0},{-72,0}}, color={85,170,255}));
      connect(plugToPins_n.plug_n, starpoints) annotation (Line(
          points={{72,0},{100,0}}, color={85,170,255}));
      annotation (
        Icon(graphics={Line(
                  points={{86,4},{6,4}},
                  color={85,170,255},
                  thickness=0.5),Line(
                  points={{6,4},{-33,72}},
                  color={85,170,255},
                  thickness=0.5),Line(
                  points={{6,4},{-32,-65}},
                  color={85,170,255},
                  thickness=0.5), Line(points={{-90,0},{-40,0}}, color={85,170,255}),
              Line(points={{80,0},{90,0}}, color={85,170,255}),
                                                            Line(
                  points={{-6,-4},{-45,64}},
                  color={85,170,255},
                  thickness=0.5),Line(
                  points={{74,-4},{-6,-4}},
                  color={85,170,255},
                  thickness=0.5),Line(
                  points={{-6,-4},{-44,-73}},
                  color={85,170,255},
                  thickness=0.5),
            Text(
              extent={{-150,70},{150,110}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-110},{150,-70}},
              textString="m=%m")}),
        Documentation(info="<html>
<p>
Star (wye) connection of a multi phase circuit consisting of multiple base systems (see
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.MultiPhase\">multi phase guidelines</a>). The potentials at the star points are all equal.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star\">Star</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Delta\">Delta</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.MultiDelta\">MultiDelta</a>
</p></html>"));
    end MultiStar;

    model MultiDelta
      "Delta (polygon) connection of multi phase systems consisting of multiple base systems"
      parameter Integer m(final min=2) = 3 "Number of phases";
      final parameter Integer mSystems=
          Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(
          m) "Number of base systems";
      final parameter Integer mBasic=integer(m/mSystems)
        "Phase number of base systems";
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug
        plug_p(final m=m) annotation (Placement(transformation(extent={{-110,-10},
                {-90,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug
        plug_n(final m=m) annotation (Placement(transformation(extent={{90,-10},
                {110,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_p
        plugToPins_p(final m=m) annotation (Placement(transformation(extent={{-80,
                -10},{-60,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_n
        plugToPins_n(final m=m) annotation (Placement(transformation(extent={{
                80,-10},{60,10}})));
    equation
      for k in 1:mSystems loop
        for j in 1:mBasic - 1 loop
          connect(plugToPins_n.pin_n[(k - 1)*mBasic + j], plugToPins_p.pin_p[(k
             - 1)*mBasic + j + 1]);
        end for;
        connect(plugToPins_n.pin_n[k*mBasic], plugToPins_p.pin_p[(k - 1)*mBasic
           + 1]);
      end for;
      connect(plug_p, plugToPins_p.plug_p) annotation (Line(points={{-100,0},{-93,
              0},{-86,0},{-72,0}}, color={85,170,255}));
      connect(plugToPins_n.plug_n, plug_n) annotation (Line(points={{72,0},{79,
              0},{79,0},{86,0},{86,0},{100,0}}, color={85,170,255}));
      annotation (Icon(graphics={Line(
                  points={{-44,62},{-44,-76},{75,-6},{-44,62},{-44,61}},
                  color={85,170,255},
                  thickness=0.5), Line(points={{-90,0},{-44,0}}, color={85,170,255}),
              Line(points={{80,0},{90,0}}, color={85,170,255}),Line(
                  points={{-36,74},{-36,-64},{83,6},{-36,74},{-36,73}},
                  color={85,170,255},
                  thickness=0.5),
            Text(
              extent={{-150,70},{150,110}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-110},{150,-70}},
              textString="m=%m")}), Documentation(info="<html>
<p>
Delta (polygon) connection of a multi phase circuit consisting of multiple base systems (see
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.MultiPhase\">multi phase guidelines</a>).
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Star\">Star</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Delta\">Delta</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.MultiStar\">MultiStar</a>
</p>
</html>"));
    end MultiDelta;

    model MultiStarResistance "Resistance connection of star points"
      parameter Integer m(final min=3) = 3 "Number of phases";
      final parameter Integer mBasic=
          Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(
          m) "Number of symmetric base systems";
      parameter Modelica.SIunits.Resistance R=1e6
        "Insulation resistance between base systems";
      Interfaces.PositivePlug plug(m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      MultiStar multiStar(m=m) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={-50,0})));
      Resistor resistor(m=mBasic, final R_ref=fill(R, mBasic)) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}})));
      Star star(m=mBasic) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={50,0})));
      SinglePhase.Interfaces.NegativePin pin annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={100,0})));
    equation
      connect(plug, multiStar.plug_p) annotation (Line(
          points={{-100,0},{-60,0}}, color={85,170,255}));
      connect(multiStar.starpoints, resistor.plug_p) annotation (Line(
          points={{-40,0},{-10,0}}, color={85,170,255}));
      connect(resistor.plug_n, star.plug_p) annotation (Line(
          points={{10,0},{40,0}}, color={85,170,255}));
      connect(star.pin_n, pin) annotation (Line(
          points={{60,0},{100,0}}, color={85,170,255}));
      annotation (defaultComponentName="multiStar",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Line(
                  points={{-40,40},{0,0},{40,40},{0,0},{0,-40}},
                  color={85,170,255},
                  origin={-60,0},
                  rotation=90),Rectangle(
                  extent={{-10,20},{10,-20}},
                  lineColor={85,170,255},
                  rotation=90),Line(
                  points={{-40,40},{0,0},{40,40},{0,0},{0,-40}},
                  color={85,170,255},
                  origin={60,0},
                  rotation=90),
            Text(
              extent={{-150,70},{150,110}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-110},{150,-70}},
              textString="R=%R")}),
        Documentation(info="<html>
<p>
Multi star points are connected by resistors. This model is required to operate multi phase systems with even phase numbers to avoid ideal connections of start points of base systems; see
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.MultiPhase\">multi phase guidelines</a>.
</p>
</html>"));
    end MultiStarResistance;

    model PlugToPin_p "Connect one (positive) pin"
      parameter Integer m(final min=1) = 3 "Number of phases";
      parameter Integer k(
        final min=1,
        final max=m) = 1 "Phase index";
      Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
            transformation(extent={{-30,-10},{-10,10}})));
      QuasiStationary.SinglePhase.Interfaces.PositivePin pin_p annotation (
          Placement(transformation(extent={{10,-10},{30,10}})));
    equation
      Connections.branch(plug_p.reference, pin_p.reference);
      //Connections.potentialRoot(plug_p.reference);
      //Connections.potentialRoot(pin_p.reference);
      plug_p.reference.gamma = pin_p.reference.gamma;
      pin_p.v = plug_p.pin[k].v;
      for j in 1:m loop
        plug_p.pin[j].i = if j == k then -pin_p.i else Complex(0);
      end for;
      annotation (defaultComponentName="plugToPin", Icon(graphics={Rectangle(
                  extent={{-20,20},{40,-20}},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid),Ellipse(
                  extent={{-40,20},{0,-20}},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,50},{150,90}},
                  textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-40},{150,-80}},
                  textString="k = %k")}), Documentation(info="<html>
<p>
Connects the single phase (positive) pin <code>k</code> of the multi phase (positive) plug to a single phase (positive) pin.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_n\">PlugToPin_n</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_p\">PlutToPins_p</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_n\">PlugToPins_n</a>
</p>
</html>"));
    end PlugToPin_p;

    model PlugToPin_n "Connect one (negative) pin"
      parameter Integer m(final min=1) = 3 "Number of phases";
      parameter Integer k(
        final min=1,
        final max=m) = 1 "Phase index";
      Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
            transformation(extent={{-30,-10},{-10,10}})));
      QuasiStationary.SinglePhase.Interfaces.NegativePin pin_n annotation (
          Placement(transformation(extent={{10,-10},{30,10}})));
    equation
      Connections.branch(plug_n.reference, pin_n.reference);
      //Connections.potentialRoot(plug_n.reference);
      //Connections.potentialRoot(pin_n.reference);
      plug_n.reference.gamma = pin_n.reference.gamma;
      pin_n.v = plug_n.pin[k].v;
      for j in 1:m loop
        plug_n.pin[j].i = if j == k then -pin_n.i else Complex(0);
      end for;
      annotation (defaultComponentName="plugToPin", Icon(graphics={Rectangle(
                  extent={{-20,20},{40,-20}},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid),Ellipse(
                  extent={{-40,20},{0,-20}},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,50},{150,90}},
                  textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-40},{150,-80}},
                  textString="k = %k")}), Documentation(info="<html>
<p>
Connects the single phase (negative) pin <code>k</code> of the multi phase (negative) plug to a single phase (negative) pin.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_p\">PlugToPin_p</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_p\">PlutToPins_p</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_n\">PlugToPins_n</a>
</p>
</html>"));
    end PlugToPin_n;

    model PlugToPins_p "Connect all (positive) pins"
      parameter Integer m(final min=1) = 3 "number of phases";
      Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
            transformation(extent={{-30,-10},{-10,10}})));
      QuasiStationary.SinglePhase.Interfaces.PositivePin pin_p[m] annotation (
          Placement(transformation(extent={{10,-10},{30,10}})));
      PlugToPin_p plugToPin_p[m](each final m=m, final k={j for j in 1:m})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      for j in 1:m loop
        /*
    Connections.branch(plug_p.reference, pin_p[j].reference);
    plug_p.reference.gamma = pin_p[j].reference.gamma;
    plug_p.pin[j].v = pin_p[j].v;
    plug_p.pin[j].i = -pin_p[j].i;
*/
        connect(plug_p, plugToPin_p[j].plug_p);
        connect(plugToPin_p[j].pin_p, pin_p[j]);
      end for;
      annotation (defaultComponentName="plugToPins", Icon(graphics={
            Rectangle(
              extent={{-20,20},{40,-20}},
              fillColor={170,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-40,20},{0,-20}},
              fillColor={170,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,50},{150,90}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
<p>
Connects all <code>m</code> single phase (positive) pins of the multi phase (positive) plug to an array of <code>m</code> single phase (positive) pins.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_p\">PlugToPin_p</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_n\">PlugToPin_n</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_n\">PlugToPins_n</a>
</p>
</html>"));
    end PlugToPins_p;

    model PlugToPins_n "Connect all (negative) pins"
      parameter Integer m(final min=1) = 3 "number of phases";
      Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
            transformation(extent={{-30,-10},{-10,10}})));
      QuasiStationary.SinglePhase.Interfaces.NegativePin pin_n[m] annotation (
          Placement(transformation(extent={{10,-10},{30,10}})));
      PlugToPin_n plugToPin_n[m](each final m=m, final k={j for j in 1:m})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      for j in 1:m loop
        /*
    Connections.branch(plug_n.reference, pin_n[j].reference);
    plug_n.reference.gamma = pin_n[j].reference.gamma;
    plug_n.pin[j].v = pin_n[j].v;
    plug_n.pin[j].i = -pin_n[j].i;
*/
        connect(plug_n, plugToPin_n[j].plug_n);
        connect(plugToPin_n[j].pin_n, pin_n[j]);
      end for;
      annotation (defaultComponentName="plugToPins", Icon(graphics={
            Rectangle(
              extent={{-20,20},{40,-20}},
              fillColor={170,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-40,20},{0,-20}},
              fillColor={170,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,50},{150,90}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
<p>
Connects all <code>m</code> single phase (negative) pins of the multi phase (negative) plug to an array of <code>m</code> single phase (negative) pins.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_p\">PlugToPin_p</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPin_n\">PlugToPin_n</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_p\">PlugToPins_p</a>
</p>
</html>"));
    end PlugToPins_n;

    model Resistor "Multiphase linear resistor"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance R_ref[m](start=fill(1, m))
        "Reference resistances at T_ref";
      parameter Modelica.SIunits.Temperature T_ref[m]=fill(293.15, m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref[m]=
          zeros(m)
        "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, T=T_ref);
      QuasiStationary.SinglePhase.Basic.Resistor resistor[m](
        final R_ref=R_ref,
        final T_ref=T_ref,
        final alpha_ref=alpha_ref,
        each final useHeatPort=useHeatPort,
        final T=T) annotation (Placement(transformation(extent={{-10,-10},{10,
                10}})));
    equation
      connect(plugToPins_p.pin_p, resistor.pin_p) annotation (Line(points={{-68,
              0},{-53.5,0},{-39,0},{-10,0}}, color={85,170,255}));
      connect(resistor.pin_n, plugToPins_n.pin_n)
        annotation (Line(points={{10,0},{39,0},{68,0}}, color={85,170,255}));
      connect(resistor.heatPort, heatPort) annotation (Line(points={{0,-10},{0,
              -32.5},{0,-55},{0,-100}}, color={191,0,0}));
      annotation (Icon(graphics={Line(points={{60,0},{90,0}}, color={85,170,255}),
              Line(points={{-90,0},{-60,0}}, color={85,170,255}),
              Rectangle(
                  extent={{-70,30},{70,-30}},
                  lineColor={85,170,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{150,-80},{-150,-40}},
              textString="m=%m")}), Documentation(info="<html>
<p>
The linear resistor connects the complex voltages <code><u>v</u></code> with the complex
currents <code><u>i</u></code> by <code><u>i</u>*R = <u>v</u></code>,
using <code>m</code> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor\">single phase Resistors</a>.
</p>

<p>
The resistor model also has <code>m</code> optional
<a href=\"modelica://Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort\">conditional heat ports</a>.
A linear temperature dependency of the resistances for enabled heat ports is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end Resistor;

    model Conductor "Multiphase linear conductor"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Conductance G_ref[m](start=fill(1, m))
        "Reference conductances at T_ref";
      parameter Modelica.SIunits.Temperature T_ref[m]=fill(293.15, m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref[m]=
          zeros(m)
        "Temperature coefficient of conductance (G_actual = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, T=T_ref);
      QuasiStationary.SinglePhase.Basic.Conductor conductor[m](
        final G_ref=G_ref,
        final T_ref=T_ref,
        final alpha_ref=alpha_ref,
        each final useHeatPort=useHeatPort,
        final T=T) annotation (Placement(transformation(extent={{-10,-10},{10,
                10}})));
    equation
      connect(plugToPins_p.pin_p, conductor.pin_p) annotation (Line(points={{-68,
              0},{-53.5,0},{-53.5,0},{-39,0},{-39,0},{-10,0}}, color={85,170,
              255}));
      connect(conductor.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,
              0},{39,0},{39,0},{68,0}}, color={85,170,255}));
      connect(conductor.heatPort, heatPort) annotation (Line(points={{0,-10},{0,
              -32.5},{0,-32.5},{0,-55},{0,-55},{0,-100}}, color={191,0,0}));
      annotation (Icon(graphics={Line(points={{60,0},{90,0}}, color={85,170,255}),
              Line(points={{-90,0},{-60,0}}, color={85,170,255}),
              Rectangle(
                  extent={{-70,30},{70,-30}},
                  lineColor={85,170,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{150,-80},{-150,-40}},
                  textString="m=%m"),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
<p>
The linear resistor connects the complex currents <code><u>i</u></code> with the complex
voltages <code><u>v</u></code> by <code><u>v</u>*G = <u>i</u></code>,
using <code>m</code> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor\">single phase Conductors</a>.
</p>

<p>
The conductor model also has <code>m</code> optional
<a href=\"modelica://Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort\">conditional heat ports</a>.
A linear temperature dependency of the conductances for enabled heat ports is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end Conductor;

    model Capacitor "Multiphase linear capacitor"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Capacitance C[m](start=fill(1, m))
        "Capacitances";
      QuasiStationary.SinglePhase.Basic.Capacitor capacitor[m](final C=C)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(plugToPins_p.pin_p, capacitor.pin_p) annotation (Line(points={{-68,
              0},{-53.5,0},{-53.5,0},{-39,0},{-39,0},{-10,0}}, color={85,170,
              255}));
      connect(capacitor.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,
              0},{39,0},{39,0},{68,0}}, color={85,170,255}));
      annotation (Icon(graphics={Text(
                  extent={{150,-80},{-150,-40}},
                  textString="m=%m"),
            Text(
              extent={{-150,90},{150,50}},
                  textString="%name",
              lineColor={0,0,255}),
            Line(
              points={{-6,28},{-6,-28}},
              color={0,128,255}),
            Line(
              points={{6,28},{6,-28}},
              color={0,128,255}),Line(points={{-90,0},{-6,0}}, color={85,170,255}),
              Line(points={{6,0},{90,0}}, color={85,170,255})}), Documentation(info="<html>
<p>
The linear capacitor connects the complex currents <code><u>i</u></code> with the complex
voltages <code><u>v</u></code> by <code><u>v</u>*j*&omega;*C = <u>i</u></code>,
using <code>m</code> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor\">single phase Capacitors</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end Capacitor;

    model Inductor "Multiphase linear inductor"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Inductance L[m](start=fill(1, m))
        "Inductances";
      QuasiStationary.SinglePhase.Basic.Inductor inductor[m](final L=L)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation

      connect(plugToPins_p.pin_p, inductor.pin_p) annotation (Line(points={{-68,
              0},{-53.5,0},{-53.5,0},{-39,0},{-39,0},{-10,0}}, color={85,170,
              255}));
      connect(inductor.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,
              0},{39,0},{39,0},{68,0}}, color={85,170,255}));
      annotation (Icon(graphics={Line(points={{60,0},{90,0}},
              color={85,170,255}),Line(points={{-90,0},{-60,0}}, color={85,170,255}),
              Text(
                  extent={{150,-80},{-150,-40}},
                  textString="m=%m"),
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
              lineColor={0,0,255})}), Documentation(info="<html>
<p>
The linear inductor connects the complex voltages <code><u>v</u></code> with the complex
currents <code><u>i</u></code> by <code><u>i</u>*j*&omega;*L = <u>v</u></code>,
using <code>m</code> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor\">single phase Inductors</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end Inductor;

    model MutualInductor "Linear mutual inductor"
      extends Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.OnePort;
      import Modelica.ComplexMath.j;
      parameter Real epsilon=1e-9 "Relative accuracy tolerance of matrix symmetry";
      parameter Modelica.SIunits.Inductance L[m, m] "Mutual inductance matrix";
    initial equation
      if abs(Modelica.Math.Matrices.det(L)) < epsilon then
        Modelica.Utilities.Streams.print("Warning: mutual inductance matrix singular!");
      end if;
    equation
      assert(sum(abs(L - transpose(L))) < epsilon*sum(abs(L)),"Mutual inductance matrix is not symmetric");
      for j in 1:m loop
        v[j] = sum(j*omega*L[j, k]*i[k] for k in 1:m);
      end for;
      annotation (defaultComponentName="inductor", Documentation(info="<html>
<p>
Model of a multi phase inductor providing a mutual inductance matrix model.
</p>
<h4>Implementation</h4>
<pre>
  v[1] = j*omega*L[1,1]*i[1] + j*omega*L[1,2]*i[2] + ... + j*omega*L[1,m]*i[m]
  v[2] = j*omega*L[2,1]*i[1] + j*omega*L[2,2]*i[2] + ... + j*omega*L[2,m]*i[m]
     :              :                     :                           :
  v[m] = j*omega*L[m,1]*i[1] + j*omega*L[m,2]*i[2] + ... + j*omega*L[m,m]*i[m]
</pre>

</html>"), Icon(graphics={
            Line(points={{-80,20},{-80,-20},{-60,-20}}, color={85,170,255}),
            Line(points={{-80,20},{-60,20}}, color={85,170,255}),
            Line(points={{60,20},{80,20}}, color={85,170,255}),
            Line(points={{80,20},{80,-20},{60,-20}}, color={85,170,255}),
            Line(points={{-90,0},{-80,0}}, color={85,170,255}),
            Line(points={{80,0},{90,0}}, color={85,170,255}),
            Text(
              extent={{-150,-80},{150,-40}},
              textString="m=%m"),
            Line(
              points={{-60,20},{-59,26},{-52,34},{-38,34},{-31,26},{-30,20}},
              color={0,128,255},
              smooth=Smooth.Bezier),
            Line(
              points={{-30,20},{-29,26},{-22,34},{-8,34},{-1,26},{0,20}},
              color={0,128,255},
              smooth=Smooth.Bezier),
            Line(
              points={{0,20},{1,26},{8,34},{22,34},{29,26},{30,20}},
              color={0,128,255},
              smooth=Smooth.Bezier),
            Line(
              points={{30,20},{31,26},{38,34},{52,34},{59,26},{60,20}},
              color={0,128,255},
              smooth=Smooth.Bezier),
            Line(
              points={{-60,-20},{-59,-26},{-52,-34},{-38,-34},{-31,-26},{-30,-20}},
              color={0,128,255},
              smooth=Smooth.Bezier),
            Line(
              points={{-30,-20},{-29,-26},{-22,-34},{-8,-34},{-1,-26},{0,-20}},
              color={0,128,255},
              smooth=Smooth.Bezier),
            Line(
              points={{0,-20},{1,-26},{8,-34},{22,-34},{29,-26},{30,-20}},
              color={0,128,255},
              smooth=Smooth.Bezier),
            Line(
              points={{30,-20},{31,-26},{38,-34},{52,-34},{59,-26},{60,-20}},
              color={0,128,255},
              smooth=Smooth.Bezier),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}));
    end MutualInductor;

    model Impedance "Multiphase linear impedance"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.ComplexImpedance Z_ref[m](re(start=fill(1,m)),im(start=fill(0,m)))
        "Complex impedances R_ref + j*X_ref";
      parameter Modelica.SIunits.Temperature T_ref[m]=fill(293.15, m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref[m]=zeros(m)
        "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, T=T_ref);
      parameter Boolean frequencyDependent = false "Consider frequency dependency, if true"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Modelica.SIunits.Frequency f_ref = 1 "Reference frequency, if frequency dependency is considered"
        annotation(Dialog(enable=frequencyDependent));
      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Impedance impedance[m](
        final Z_ref=Z_ref,
        final T_ref=T_ref,
        final alpha_ref=alpha_ref,
        final useHeatPort=fill(useHeatPort,m),
        final frequencyDependent=fill(frequencyDependent, m),
        final f_ref=fill(f_ref, m),
        final T=T_ref) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation

      connect(plugToPins_p.pin_p, impedance.pin_p) annotation (Line(points={{-68,0},{-53.5,0},{-39,0},{-10,0}}, color={85,170,255}));
      connect(impedance.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,0},{39,0},{68,0}}, color={85,170,255}));
      connect(impedance.heatPort, heatPort) annotation (Line(points={{0,-10},{0,-10},{0,-100}}, color={191,0,0}));
      annotation (Icon(graphics={
                    Text(
                  extent={{150,-80},{-150,-40}},
                  textString="m=%m"), Line(points={{60,0},{90,0}}, color={85,170,255}),
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
              lineColor={0,0,255})}), Documentation(info="<html>
<p>The impedance model represents a <strong>series</strong> connection of a resistor and either an inductor or capacitor
in each phase.<br>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/SinglePhase/Basic/RX_impedance.png\"></p>

<p>
The linear impedance connects the voltage <code><u>v</u></code> with the
current <code><u>i</u></code> by  <code><u>v</u> = <u>Z</u>*<u>i</u></code> in each phase, using <code>m</code>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Impedance\">singlephase impedances</a>.
The resistive
components are modeled temperature dependent, so the real parts <code>R_actual = real(<u>Z</u>)</code> are determined from
the actual operating temperatures and the reference input resistances <code>real(Z_ref)</code>.
<a href=\"modelica://Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort\">Conditional heat ports</a> are considered.
The reactive components <code>X_actual = imag(<u>Z</u>)</code>
are equal to <code>imag(Z_ref)</code> if <code>frequencyDependent = false</code>.
Frequency dependency is considered by <code>frequencyDependent = true</code>, distinguishing two cases:
</p>

<dl>
<dt>(a) <code>imag(Z_ref) &gt; 0</code>: inductive case</dt>
<dd>The actual reactances <code>X_actual</code> are proportional to <code>f/f_ref</code></dd>
<dt>(b) <code>imag(Z_ref) &lt; 0</code>: capacitive case</dt>
<dd>The actual reactances <code>X_actual</code> are proportional to <code>f_ref/f</code></dd>
</dl>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end Impedance;

    model Admittance "Multiphase linear admittance"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.ComplexAdmittance Y_ref[m](re(start=fill(1,m)),im(start=fill(0,m)))
        "Complex admittances G_ref + j*B_ref";
      parameter Modelica.SIunits.Temperature T_ref[m]=fill(293.15, m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref[m]=zeros(m)
        "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, T=T_ref);
      parameter Boolean frequencyDependent = false "Consider frequency dependency, if true"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Modelica.SIunits.Frequency f_ref = 1 "Reference frequency, if frequency dependency is considered"
        annotation(Dialog(enable=frequencyDependent));
      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Admittance admittance[m](
        final Y_ref=Y_ref,
        final T_ref=T_ref,
        final alpha_ref=alpha_ref,
        final useHeatPort=fill(useHeatPort,m),
        final T=T,
        final frequencyDependent=fill(frequencyDependent, m),
        final f_ref=fill(f_ref, m)) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

    equation
      connect(plugToPins_p.pin_p, admittance.pin_p) annotation (Line(points={{-68,0},{-53.5,0},{-39,0},{-10,0}}, color={85,170,255}));
      connect(admittance.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,0},{39,0},{68,0}}, color={85,170,255}));
      connect(admittance.heatPort, heatPort) annotation (Line(points={{0,-10},{0,-10},{0,-100}}, color={191,0,0}));
      annotation (Icon(graphics={
                    Text(
                  extent={{150,-80},{-150,-40}},
                  textString="m=%m"), Line(points={{60,0},{90,0}}, color={85,170,255}),
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
              lineColor={0,0,255})}), Documentation(info="<html>

<p>The admittance model represents a <strong>parallel</strong> connection of a resistor and either a capacitor or inductor
in each phase.<br>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/SinglePhase/Basic/GB_admittance.png\"></p>

<p>
The linear admittance connects the voltage <code><u>v</u></code> with the
current <code><u>i</u></code> by  <code><u>i</u> = <u>Y</u>*<u>v</u></code> in each phase, using <code>m</code>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Admittance\">singlephase admittances</a>.
The resistive
components are modeled temperature dependent, so the real parts <code>G_actual = real(<u>Y</u>)</code> are determined from
the actual operating temperatures and the reference input conductances <code>real(Y_ref)</code>.
<a href=\"modelica://Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort\">Conditional heat ports</a> are considered.
The reactive components
<code>B_actual = imag(<u>Y</u>)</code>
are equal to <code>imag(Y_ref)</code> if <code>frequencyDependent = false</code>.
Frequency dependency is considered by <code>frequencyDependent = true</code>, distinguishing two cases:
</p>

<dl>
<dt>(a) <code>imag(Y_ref) &gt; 0</code>: capacitive case</dt>
<dd>The actual susceptances <code>B_actual</code> are proportional to <code>f/f_ref</code></dd>
<dt>(b) <code>imag(Y_ref) &lt; 0</code>: inductive case</dt>
<dd>The actual susceptances <code>B_actual</code> are proportional to <code>f_ref/f</code></dd>
</dl>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end Admittance;

    model VariableResistor "Multiphase variable resistor"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Temperature T_ref[m]=fill(293.15, m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref[m]=
          zeros(m)
        "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, T=T_ref);
      Modelica.Blocks.Interfaces.RealInput R_ref[m](each unit="Ohm")
        "Variable resistance" annotation (Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,120})));
      QuasiStationary.SinglePhase.Basic.VariableResistor variableResistor[m](
        final T_ref=T_ref,
        final alpha_ref=alpha_ref,
        each final useHeatPort=useHeatPort,
        final T=T) annotation (Placement(transformation(extent={{-10,-10},{10,
                10}})));
    equation

      connect(variableResistor.pin_p, plugToPins_p.pin_p) annotation (Line(
            points={{-10,0},{-24.5,0},{-24.5,0},{-39,0},{-39,0},{-68,0}}, color={85,170,255}));
      connect(variableResistor.pin_n, plugToPins_n.pin_n) annotation (Line(
            points={{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
      connect(variableResistor.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-10},{0,-100}}, color={191,0,0}));
      connect(R_ref, variableResistor.R_ref) annotation (Line(
          points={{0,120},{0,12}}, color={0,0,127}));
      annotation (defaultComponentName="resistor",
        Icon(graphics={Line(points={{60,0},{90,0}}, color={85,170,255}),
              Line(points={{-90,0},{-60,0}}, color={85,170,255}),
              Rectangle(
                  extent={{-70,30},{70,-30}},
                  lineColor={85,170,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
                    Text(
                  extent={{150,-80},{-150,-40}},
                  textString="m=%m")}),
        Documentation(info="<html>
<p>
The linear resistors connect the complex voltages <code><u>v</u></code> with the complex
currents <code><u>i</u></code> by <code><u>i</u>*R = <u>v</u></code>,
using <code>m</code> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor\">single phase variable Resistors</a>.
The resistances <code>R</code> are given as <code>m</code> input signals.
</p>

<p>
The resistor model also has <code>m</code> optional
<a href=\"modelica://Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort\">conditional heat ports</a>.
A linear temperature dependency of the resistances is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor\">VariableResistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor\">Variable inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end VariableResistor;

    model VariableConductor "Multiphase variable conductor"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Temperature T_ref[m]=fill(293.15, m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref[m]=
          zeros(m)
        "Temperature coefficient of resistance (G_actual = G_ref/(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, T=T_ref);
      Modelica.Blocks.Interfaces.RealInput G_ref[m](each unit="S")
        "Variable conductance" annotation (Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,120})));
      QuasiStationary.SinglePhase.Basic.VariableConductor variableResistor[m](
        final T_ref=T_ref,
        final alpha_ref=alpha_ref,
        each final useHeatPort=useHeatPort,
        final T=T) annotation (Placement(transformation(extent={{-10,-10},{10,
                10}})));
    equation
      connect(variableResistor.pin_p, plugToPins_p.pin_p) annotation (Line(
            points={{-10,0},{-24.5,0},{-24.5,0},{-39,0},{-39,0},{-68,0}}, color={85,170,255}));
      connect(variableResistor.pin_n, plugToPins_n.pin_n) annotation (Line(
            points={{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
      connect(variableResistor.heatPort, heatPort) annotation (Line(points={{0,
              -10},{0,-32.5},{0,-32.5},{0,-55},{0,-55},{0,-100}}, color={191,0,0}));
      connect(G_ref, variableResistor.G_ref) annotation (Line(points={{0,120},{0,120},{0,12},{0,12}}, color={0,0,127}));
      annotation (defaultComponentName="conductor",
        Icon(graphics={Line(points={{60,0},{90,0}}, color={85,170,255}),
              Line(points={{-90,0},{-60,0}}, color={85,170,255}),
              Rectangle(
                  extent={{-70,30},{70,-30}},
                  lineColor={85,170,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
                    Text(
                  extent={{150,-80},{-150,-40}},
                  textString="m=%m")}),
        Documentation(info="<html>
<p>
The linear resistors connect the complex currents <code><u>i</u></code> with the complex
voltages <code><u>v</u></code> by <code><u>v</u>*G = <u>i</u></code>,
using <code>m</code> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor\">single phase variable Conductors</a>.
The conductances <code>G</code> are given as <code>m</code> input signals.
</p>

<p>
The conductor model also has <code>m</code> optional
<a href=\"modelica://Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort\">conditional heat ports</a>.
A linear temperature dependency of the conductances is also taken into account.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableConductor\">VariableConductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor\">Variable inductor</a>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end VariableConductor;

    model VariableCapacitor "Multiphase variable capacitor"
      extends Interfaces.TwoPlug;
      Modelica.Blocks.Interfaces.RealInput C[m](each unit="F")
        "Variable capacitance" annotation (Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,120})));
      QuasiStationary.SinglePhase.Basic.VariableCapacitor variableCapacitor[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(variableCapacitor.pin_p, plugToPins_p.pin_p) annotation (Line(
            points={{-10,0},{-24.5,0},{-24.5,0},{-39,0},{-39,0},{-68,0}}, color={85,170,255}));
      connect(variableCapacitor.pin_n, plugToPins_n.pin_n) annotation (Line(
            points={{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
      connect(C, variableCapacitor.C) annotation (Line(
          points={{0,120},{0,12}}, color={0,0,127}));
      annotation (defaultComponentName="capacitor",
        Icon(graphics={Line(points={{-90,0},{-6,0}}, color={85,170,255}),
              Line(points={{6,0},{90,0}}, color={85,170,255}),
            Line(
              points={{-6,28},{-6,-28}},
              color={0,128,255}),
            Line(
              points={{6,28},{6,-28}},
              color={0,128,255}),
            Text(
              extent={{-150,90},{150,50}},
                  textString="%name",
              lineColor={0,0,255}),
                    Text(
                  extent={{150,-80},{-150,-40}},
                  textString="m=%m")}),
        Documentation(info="<html>
<p>
The linear capacitors connect the complex currents <code><u>i</u></code> with the complex
voltages <code><u>v</u></code> by <code><u>v</u>*j*&omega;*C = <u>i</u></code>,
using <code>m</code> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor\">single phase variable Capacitors</a>.
The capacitances <code>C</code> are given as <code>m</code> input signals.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableCapacitor\">VariableCapacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor\">Variable inductor</a>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end VariableCapacitor;

    model VariableInductor "Multiphase variable inductor"
      extends Interfaces.TwoPlug;
      Modelica.Blocks.Interfaces.RealInput L[m](each unit="H")
        "Variable inductance" annotation (Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,120})));
      QuasiStationary.SinglePhase.Basic.VariableInductor variableInductor[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(variableInductor.pin_p, plugToPins_p.pin_p) annotation (Line(
            points={{-10,0},{-24.5,0},{-24.5,0},{-39,0},{-39,0},{-68,0}}, color={85,170,255}));
      connect(variableInductor.pin_n, plugToPins_n.pin_n) annotation (Line(
            points={{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
      connect(variableInductor.L, L) annotation (Line(points={{0,12},{0,12},{0,120}}, color={0,0,127}));
      annotation (defaultComponentName="inductor",
        Icon(graphics={Line(points={{60,0},{90,0}},
              color={85,170,255}),Line(points={{-90,0},{-60,0}}, color={85,170,255}),
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
              lineColor={0,0,255}),
                    Text(
                  extent={{150,-80},{-150,-40}},
                  textString="m=%m")}),
        Documentation(info="<html>
<p>
The linear inductors connect the complex voltages <code><u>v</u></code> with the complex
currents <code><u>i</u></code> by <code><u>i</u>*j*&omega;*L = <u>v</u></code>,
using <code>m</code> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableInductor\">single phase variable Inductors</a>.
The inductances <code>L</code> are given as <code>m</code> input signals.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableResistor\">Variable resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableCapacitor\">Variable capacitor</a>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableImpedance\">Variable impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end VariableInductor;

    model VariableImpedance "Multiphase variable impedance"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Temperature T_ref[m]=fill(293.15, m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref[m]=zeros(m)
        "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, T=T_ref);
      parameter Boolean frequencyDependent = false "Consider frequency dependency, if true"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Modelica.SIunits.Frequency f_ref = 1 "Reference frequency, if frequency dependency is considered"
        annotation(Dialog(enable=frequencyDependent));
      ComplexBlocks.Interfaces.ComplexInput Z_ref[m]
        "Variable complex impedances" annotation (Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,120})));
      SinglePhase.Basic.VariableImpedance variableImpedance[m](
        final T_ref=T_ref,
        final alpha_ref=alpha_ref,
        each final useHeatPort=useHeatPort,
        final T=T,
        final frequencyDependent=fill(frequencyDependent, m),
        final f_ref=fill(f_ref, m))
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(variableImpedance.pin_p, plugToPins_p.pin_p) annotation (Line(
            points={{-10,0},{-24.5,0},{-39,0},{-68,0}}, color={85,170,255}));
      connect(variableImpedance.pin_n, plugToPins_n.pin_n)
        annotation (Line(points={{10,0},{39,0},{68,0}}, color={85,170,255}));
      connect(variableImpedance.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}}, color={191,0,0}));
      connect(variableImpedance.Z_ref, Z_ref) annotation (Line(
          points={{0,12},{0,64},{0,120}}, color={85,170,255}));
      annotation (defaultComponentName="impedance",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Line(points={{60,0},{90,0}}, color={85,170,255}),
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
              lineColor={0,0,255}),
                    Text(
                  extent={{150,-80},{-150,-40}},
                  textString="m=%m")}),
        Documentation(info="<html>
<p>The impedance model represents a <strong>series</strong> connection of a resistor and either an inductor or capacitor
in each phase.<br>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/SinglePhase/Basic/RX_impedance.png\"></p>

<p>
The linear impedance connects the complex voltage <code><u>v</u></code> with the
complex current <code><u>i</u></code> by <code><u>i</u>*<u>Z</u> = <u>v</u></code> in each phase,
using <code>m</code>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableImpedance\">
variable singlephase impedances</a>.
The impedances <code>Z_ref = R_ref + j*X_ref</code> are given as complex input signals, representing the
resistive and reactive components of the input impedances. The resistive
components are modeled temperature dependent, so the real part <code>R_actual = real(<u>Z</u>)</code> are determined from
the actual operating temperatures and the reference input resistances <code>real(Z_ref)</code>.
<a href=\"modelica://Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort\">Conditional heat ports</a> are considered.
The reactive components <code>X_actual = imag(<u>Z</u>)</code>
are equal to <code>imag(Z_ref)</code> if <code>frequencyDependent = false</code>.
Frequency dependency is considered by <code>frequencyDependent = true</code>, distinguishing two cases:
</p>

<dl>
<dt>(a) <code>imag(Z_ref) &gt; 0</code>: inductive case</dt>
<dd>The actual reactances <code>X_actual</code> are proportional to <code>f/f_ref</code></dd>
<dt>(b) <code>imag(Z_ref) &lt; 0</code>: capacitive case</dt>
<dd>The actual reactances <code>X_actual</code> are proportional to <code>f_ref/f</code></dd>
</dl>

<h4>Note</h4>
<p>
Zero crossings of the real or imaginary parts of the impedance signals <code>Z_ref</code> could cause
singularities due to the actual structure of the connected network.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor\">VariableResistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor\">Variable inductor</a>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end VariableImpedance;

    model VariableAdmittance "Multiphase variable admittance"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Temperature T_ref[m]=fill(293.15, m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref[m]=zeros(m)
        "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, T=T_ref);
      parameter Boolean frequencyDependent = false "Consider frequency dependency, if true"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Modelica.SIunits.Frequency f_ref = 1 "Reference frequency, if frequency dependency is considered"
        annotation(Dialog(enable=frequencyDependent));
      ComplexBlocks.Interfaces.ComplexInput Y_ref[m]
        "Variable complex admittances" annotation (Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,120})));
      SinglePhase.Basic.VariableAdmittance variableImpedance[m](
        final T_ref=T_ref,
        final alpha_ref=alpha_ref,
        each final useHeatPort=useHeatPort,
        final T=T,
        final frequencyDependent=fill(frequencyDependent, m),
        final f_ref=fill(f_ref, m))
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(variableImpedance.pin_p, plugToPins_p.pin_p) annotation (Line(
            points={{-10,0},{-68,0}}, color={85,170,255}));
      connect(variableImpedance.pin_n, plugToPins_n.pin_n)
        annotation (Line(points={{10,0},{68,0}}, color={85,170,255}));
      connect(variableImpedance.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}}, color={191,0,0}));
      connect(Y_ref, variableImpedance.Y_ref) annotation (Line(
          points={{0,120},{0,12}}, color={85,170,255}));
      annotation (defaultComponentName="admittance",
        Icon(graphics={Line(points={{60,0},{90,0}}, color={85,170,255}),
              Line(points={{-90,0},{-60,0}}, color={85,170,255}),
              Rectangle(
                  extent={{-70,30},{70,-30}},
                  lineColor={85,170,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid), Polygon(
                  points={{-70,-30},{70,30},{70,-30},{-70,-30}},
                  lineColor={85,170,255},
                  fillColor={85,170,255},
                  fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
                    Text(
                  extent={{150,-80},{-150,-40}},
                  textString="m=%m")}),
        Documentation(info="<html>
<p>The admittance model represents a <strong>parallel</strong> connection of a resistor and either a capacitor or inductor
in each phase.<br>
<img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/SinglePhase/Basic/GB_admittance.png\"></p>

<p>
The linear admittance connects the complex voltage <code><u>v</u></code> with the
complex current <code><u>i</u></code> by <code><u>v</u>*<u>Y</u> = <u>i</u></code> in each phase,
using <code>m</code>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableAdmittance\">
variable singlephase admittances</a>.
The admittances <code>Y_ref = G_ref + j*B_ref</code> are given as complex input signals, representing the
resistive and reactive components of the input admittances. The resistive
components are modeled temperature dependent, so the real part <code>G_actual = real(<u>Y</u>)</code> are determined from
the actual operating temperatures and the reference input conductances <code>real(Y_ref)</code>.
<a href=\"modelica://Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort\">Conditional heat ports</a> are considered.
The reactive components <code>B_actual = imag(<u>Y</u>)</code>
are equal to <code>imag(Y_ref)</code> if <code>frequencyDependent = false</code>.
Frequency dependency is considered by <code>frequencyDependent = true</code>, distinguishing two cases:
</p>

<dl>
<dt>(a) <code>imag(Y_ref) &gt; 0</code>: capacitive case</dt>
<dd>The actual susceptances <code>B_actual</code> are proportional to <code>f/f_ref</code></dd>
<dt>(b) <code>imag(Y_ref) &lt; 0</code>: inductive case</dt>
<dd>The actual susceptances <code>B_actual</code> are proportional to <code>f_ref/f</code></dd>
</dl>

<h4>Note</h4>
<p>
Zero crossings of the real or imaginary parts of the admittance signals <code>Y_ref</code> could cause
singularities due to the actual structure of the connected network.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableResistor\">VariableResistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor\">Capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Inductor\">Inductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Impedance\">Impedance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Admittance\">Admittance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableConductor\">Variable conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableCapacitor\">Variable capacitor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor\">Variable inductor</a>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableImpedance\">Variable impedance</a>,
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
<p>This package hosts basic models for quasi stationary multiphase circuits.
Quasi stationary theory can be found in the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic\">SinglePhase.Basic</a>

</html>"));
  end Basic;

  package Ideal "Ideal components for AC multiphase models"
    extends Modelica.Icons.Package;

    model Idle "Idle branch"
      extends Interfaces.TwoPlug;

      QuasiStationary.SinglePhase.Ideal.Idle idle[m] annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));

    equation
      connect(plugToPins_p.pin_p, idle.pin_p)
        annotation (Line(points={{-68,0},{-10,0}}, color={85,170,255}));
      connect(idle.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,0},{
              39,0},{39,0},{68,0}}, color={0,127,0}));
      annotation (Icon(graphics={Rectangle(
                  extent={{-80,80},{80,-80}},
                  lineColor={85,170,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{-90,0},{-41,0}},
              color={85,170,255}),Line(points={{91,0},{40,0}}, color={85,170,255}),
              Text(
                  extent={{-150,130},{150,90}},
                  textString="%name",
                  lineColor={0,0,255}),
            Text(
              extent={{-150,-90},{150,-130}},
              textString="m=%m")}), Documentation(info="<html>
<p>
This model describes <em>m</em> simple idle branches considering the complex currents <em><u>i</u></em> = 0;
it uses <em>m</em> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.Idle\">single phase idle branches</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.Idle\">Idle</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Ideal.Short\">Short</a>
</p>
</html>"));
    end Idle;

    model Short "Short cut branch"
      extends Interfaces.TwoPlug;

      QuasiStationary.SinglePhase.Ideal.Short short[m] annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));

    equation
      connect(plugToPins_p.pin_p, short.pin_p)
        annotation (Line(points={{-68,0},{-10,0}}, color={85,170,255}));
      connect(short.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,0},
              {39,0},{39,0},{68,0}}, color={0,127,0}));
      annotation (Icon(graphics={Rectangle(
                  extent={{-80,80},{80,-80}},
                  lineColor={85,170,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                                       Line(points={{91,0},{-90,0}}, color={85,170,255}),
                    Text(
                  extent={{-150,130},{150,90}},
                  textString="%name",
                  lineColor={0,0,255}),
            Text(
              extent={{-150,-90},{150,-130}},
              textString="m=%m")}),
                           Documentation(info="<html>
<p>
This model describes <em>m</em> simple short branches considering the complex voltages <em><u>v</u></em> = 0;
it uses <em>m</em> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.Short\">single phase short branches</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.Short\">Short</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Ideal.Idle\">Idle</a>
</p>
</html>"));
    end Short;

    model IdealCommutingSwitch "Multiphase ideal commuting switch"
      parameter Integer m(final min=1) = 3 "Number of phases";
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m), start=
            fill(1e-5, m)) "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start=
            fill(1e-5, m)) "Opened switch conductance";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, final T=fill(293.15, m));
      Modelica.Blocks.Interfaces.BooleanInput control[m]
        "true => p--n2 connected, false => p--n1 connected" annotation (
          Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug
        plug_p(final m=m) annotation (Placement(transformation(extent={{-110,-10},
                {-90,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug
        plug_n2(final m=m) annotation (Placement(transformation(extent={{90,-10},
                {110,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug
        plug_n1(final m=m) annotation (Placement(transformation(extent={{90,30},{110,50}}), iconTransformation(extent={{90,30},{110,50}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.IdealCommutingSwitch
        idealCommutingSwitch[m](
        final Ron=Ron,
        final Goff=Goff,
        each final useHeatPort=useHeatPort) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_p
        plugToPins_p(final m=m) annotation (Placement(transformation(extent={{-90,
                -10},{-70,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_n
        plugToPins_n1(final m=m) annotation (Placement(transformation(
            origin={80,60},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_n
        plugToPins_n2(final m=m) annotation (Placement(transformation(
            origin={80,0},
            extent={{-10,-10},{10,10}},
            rotation=180)));
    equation
      connect(control, idealCommutingSwitch.control)
        annotation (Line(points={{0,120},{0,48},{0,12}}, color={255,0,255}));
      connect(idealCommutingSwitch.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}}, color={191,0,0}));
      connect(plugToPins_n1.plug_n, plug_n1) annotation (Line(
          points={{82,60},{92,60},{92,40},{100,40}}, color={85,170,255}));
      connect(plugToPins_n2.plug_n, plug_n2) annotation (Line(
          points={{82,0},{90,0},{90,0},{100,0}}, color={85,170,255}));
      connect(plugToPins_n2.pin_n, idealCommutingSwitch.n2) annotation (Line(
          points={{78,0},{44,0},{44,0},{10,0}}, color={85,170,255}));
      connect(idealCommutingSwitch.n1, plugToPins_n1.pin_n) annotation (Line(
          points={{10,4},{10,60},{78,60}}, color={85,170,255}));
      connect(plugToPins_p.plug_p, plug_p) annotation (Line(
          points={{-82,0},{-100,0}}, color={85,170,255}));
      connect(idealCommutingSwitch.p, plugToPins_p.pin_p) annotation (Line(
          points={{-10,0},{-78,0}}, color={85,170,255}));
      annotation (defaultComponentName="switch", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
                                   Ellipse(extent={{-44,4},{-36,-4}}, lineColor=
               {85,170,255}),Line(points={{-90,0},{-44,0}}, color={85,170,255}),
              Line(points={{-37,2},{40,40}}, color={85,170,255}),Line(points={{40,40},{90,40}},
                               color={85,170,255}),
                                  Line(points={{40,0},{90,0}}, color={85,170,255}),
            Text(
              extent={{-150,90},{150,50}},
                  textString="%name",
              lineColor={0,0,255}),
                    Text(
                  extent={{150,-80},{-150,-40}},
                  textString="m=%m")}), Documentation(info="<html>
<p>
Contains m singlephase ideal commuting switches (Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.IdealCommutingSwitch).
</p>
<p>
<strong>Use with care:</strong>
This switch is only intended to be used for structural changes, not fast switching sequences, due to the quasistationary formulation.
</p>
</html>"));
    end IdealCommutingSwitch;

    model IdealIntermediateSwitch "Multiphase ideal intermediate switch"
      parameter Integer m(final min=1) = 3 "Number of phases";
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m), start=
            fill(1e-5, m)) "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start=
            fill(1e-5, m)) "Opened switch conductance";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, final T=fill(293.15, m));
      Modelica.Blocks.Interfaces.BooleanInput control[m]
        "true => p1--n2, p2--n1 connected, otherwise p1--n1, p2--n2 connected"
        annotation (Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug
        plug_p1(final m=m) annotation (Placement(transformation(extent={{-110,30},{-90,50}}), iconTransformation(extent={{-110,30},{-90,50}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug
        plug_p2(final m=m) annotation (Placement(transformation(extent={{-110,-10},
                {-90,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug
        plug_n2(final m=m) annotation (Placement(transformation(extent={{90,-10},
                {110,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug
        plug_n1(final m=m) annotation (Placement(transformation(extent={{90,30},{110,50}}), iconTransformation(extent={{90,30},{110,50}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.IdealIntermediateSwitch
        idealIntermediateSwitch[m](
        final Ron=Ron,
        final Goff=Goff,
        each final useHeatPort=useHeatPort) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_p
        plugToPins_p1(final m=m) annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_n
        plugToPins_n1(final m=m) annotation (Placement(transformation(
            origin={80,60},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_p
        plugToPins_p2(final m=m) annotation (Placement(transformation(extent={{
                -90,-10},{-70,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_n
        plugToPins_n2(final m=m) annotation (Placement(transformation(
            origin={80,0},
            extent={{-10,-10},{10,10}},
            rotation=180)));
    equation
      connect(control, idealIntermediateSwitch.control)
        annotation (Line(points={{0,120},{0,12}}, color={255,0,255}));
      connect(idealIntermediateSwitch.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}}, color={191,0,0}));
      connect(plug_p1, plugToPins_p1.plug_p) annotation (Line(
          points={{-100,40},{-100,60},{-82,60}}, color={85,170,255}));
      connect(plug_p2, plugToPins_p2.plug_p) annotation (Line(
          points={{-100,0},{-82,0}}, color={85,170,255}));
      connect(plugToPins_n1.plug_n, plug_n1) annotation (Line(
          points={{82,60},{92,60},{92,40},{100,40}}, color={85,170,255}));
      connect(plugToPins_n2.plug_n, plug_n2) annotation (Line(
          points={{82,0},{90,0},{90,0},{100,0}}, color={85,170,255}));
      connect(idealIntermediateSwitch.p2, plugToPins_p2.pin_p) annotation (Line(
          points={{-10,0},{-78,0}}, color={85,170,255}));
      connect(idealIntermediateSwitch.n2, plugToPins_n2.pin_n) annotation (Line(
          points={{10,0},{44,0},{44,0},{78,0}}, color={85,170,255}));
      connect(idealIntermediateSwitch.n1, plugToPins_n1.pin_n) annotation (Line(
          points={{10,4},{10,60},{78,60}}, color={85,170,255}));
      connect(idealIntermediateSwitch.p1, plugToPins_p1.pin_p) annotation (Line(
          points={{-10,4},{-10,60},{-78,60}}, color={85,170,255}));
      annotation (defaultComponentName="switch", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
                                   Ellipse(extent={{-4,14},{4,6}},  lineColor={
              85,170,255}),Line(points={{-90,0},{-40,0}}, color={85,170,255}),
              Line(points={{-90,40},{-40,40}}, color={85,170,255}),Line(points={{-40,0},{40,40}},
                                 color={85,170,255}),Line(points={{-40,40},{40,0}},
                   color={85,170,255}),Line(points={{40,40},{90,40}}, color={85,170,255}),
               Line(
              points={{40,0},{90,0}}, color={85,170,255}),
            Text(
              extent={{-150,90},{150,50}},
                  textString="%name",
              lineColor={0,0,255}),
                    Text(
                  extent={{150,-80},{-150,-40}},
                  textString="m=%m")}), Documentation(info=
             "<html>
<p>
Contains m ideal intermediate switches (Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.IdealIntermediateSwitch).
</p>
<p>
<strong>Use with care:</strong>
This switch is only intended to be used for structural changes, not fast switching sequences, due to the quasistationary formulation.
</p>
</html>"));
    end IdealIntermediateSwitch;

    model IdealOpeningSwitch "Multiphase ideal opener"
      extends Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m), start=
            fill(1e-5, m)) "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start=
            fill(1e-5, m)) "Opened switch conductance";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, final T=fill(293.15, m));
      Modelica.Blocks.Interfaces.BooleanInput control[m]
        "true => switch open, false => p--n connected" annotation (Placement(
            transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.IdealOpeningSwitch
        idealOpeningSwitch[m](
        final Ron=Ron,
        final Goff=Goff,
        each final useHeatPort=useHeatPort) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(control, idealOpeningSwitch.control)
        annotation (Line(points={{0,120},{0,46},{0,12}}, color={255,0,255}));
      connect(idealOpeningSwitch.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}}, color={191,0,0}));
      connect(idealOpeningSwitch.pin_n, plugToPins_n.pin_n) annotation (Line(
          points={{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
      connect(plugToPins_p.pin_p, idealOpeningSwitch.pin_p) annotation (Line(
          points={{-68,0},{-10,0}}, color={85,170,255}));
      annotation (defaultComponentName="switch", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
                                       Line(points={{-90,0},{-44,0}}, color={85,170,255}),
              Ellipse(extent={{-44,4},{-36,-4}}, lineColor={85,170,
              255}),Line(points={{-37,2},{40,40}}, color={85,170,255}),
                                                          Line(points={{40,0},{
              90,0}}, color={85,170,255}),
                                   Line(points={{40,20},{40,0}}, color={85,170,255}),
            Text(
              extent={{-150,90},{150,50}},
                  textString="%name",
              lineColor={0,0,255}),
                    Text(
                  extent={{150,-80},{-150,-40}},
                  textString="m=%m")}), Documentation(info="<html>
<p>
Contains m ideal opening switches (Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.IdealOpeningSwitch).
</p>
<p>
<strong>Use with care:</strong>
This switch is only intended to be used for structural changes, not fast switching sequences, due to the quasistationary formulation.
</p>
</html>"));
    end IdealOpeningSwitch;

    model IdealClosingSwitch "Multiphase ideal closer"
      extends Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m), start=
            fill(1e-5, m)) "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start=
            fill(1e-5, m)) "Opened switch conductance";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, final T=fill(293.15, m));
      Modelica.Blocks.Interfaces.BooleanInput control[m]
        "true => p--n connected, false => switch open" annotation (Placement(
            transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.IdealClosingSwitch
        idealClosingSwitch[m](
        final Ron=Ron,
        final Goff=Goff,
        each final useHeatPort=useHeatPort) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(control, idealClosingSwitch.control)
        annotation (Line(points={{0,120},{0,50},{0,12}}, color={255,0,255}));
      connect(idealClosingSwitch.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}}, color={191,0,0}));
      connect(idealClosingSwitch.pin_p, plugToPins_p.pin_p) annotation (Line(
          points={{-10,0},{-68,0}}, color={85,170,255}));
      connect(idealClosingSwitch.pin_n, plugToPins_n.pin_n) annotation (Line(
          points={{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
      annotation (defaultComponentName="switch", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
                                       Line(points={{-90,0},{-44,0}}, color={85,170,255}),
              Ellipse(extent={{-44,4},{-36,-4}}, lineColor={85,170,
              255}),Line(points={{-37,2},{40,40}}, color={85,170,255}),
                                                          Line(points={{40,0},{
              90,0}}, color={85,170,255}),
            Text(
              extent={{-150,90},{150,50}},
                  textString="%name",
              lineColor={0,0,255}),
                    Text(
                  extent={{150,-80},{-150,-40}},
                  textString="m=%m")}), Documentation(info="<html>
<p>
Contains m ideal closing switches (Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.IdealClosingSwitch).
</p>
<p>
<strong>Use with care:</strong>
This switch is only intended to be used for structural changes, not fast switching sequences, due to the quasistationary formulation.
</p>
</html>"));
    end IdealClosingSwitch;
    annotation (Icon(coordinateSystem(extent={{-100,-100},{100,100}},
            preserveAspectRatio=true), graphics={
          Line(origin={10,34}, points={{-100,-60},{-54,-60}}),
          Ellipse(origin={10,34}, extent={{-54,-64},{-46,-56}}),
          Line(origin={10,34}, points={{-47,-58},{30,-10}}),
          Line(origin={10,34}, points={{30,-40},{30,-60}}),
          Line(origin={10,34}, points={{30,-60},{80,-60}})}), Documentation(
          info="<html>
<p>This package hosts ideal models for quasi stationary multiphase circuits.
Quasi stationary theory can be found in the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Ideal\">SinglePhase.Ideal</a>

</html>"));
  end Ideal;

  package Functions
    extends Modelica.Icons.FunctionsPackage;
    function quasiRMS
      "Overall quasi-RMS value of complex input (current or voltage)"
      extends Modelica.Icons.Function;
      import Modelica.ComplexMath.'abs';
      input Complex u[:];
      output Real y;
      import Modelica.Constants.pi;
    protected
      Integer m=size(u, 1) "Number of phases";
    algorithm
      // y := sum({'abs'(u[k]) for k in 1:m})/m;
      // Alternative implementation due to https://trac.openmodelica.org/OpenModelica/ticket/4496
      y :=sum({sqrt(u[k].re^2 + u[k].im^2) for k in 1:m})/m;
      annotation (Inline=true, Documentation(info="<html>
  This function determines the continuous quasi <a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">RMS</a> value of a multi phase system,
  represented by m quasi static time domain phasors.
</html>"));
    end quasiRMS;

    function activePower
      "Calculate active power of complex input voltage and current"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.ComplexVoltage v[:]
        "QuasiStationary voltage phasors";
      input Modelica.SIunits.ComplexCurrent i[size(v, 1)]
        "QuasiStationary current phasors";
      output Modelica.SIunits.Power p "Active power";
    algorithm
      p := sum(Modelica.ComplexMath.real({v[k]*Modelica.ComplexMath.conj(i[k])
        for k in 1:size(v, 1)}));
      annotation (Inline=true, Documentation(info="<html>
<p>
Calculates instantaneous power from multiphase voltages and currents.
In quasistationary operation, instantaneous power equals active power;
</p>
</html>"));
    end activePower;
  end Functions;

  package Blocks "Blocks for quasi stationary multi phase systems"
    extends Modelica.Icons.Package;

    block QuasiRMS
      extends Modelica.Blocks.Interfaces.SO;
      parameter Integer m(min=2) = 3 "Number of phases";
      Modelica.ComplexBlocks.Interfaces.ComplexInput u[m]
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    equation
      y = Modelica.Electrical.QuasiStationary.MultiPhase.Functions.quasiRMS(u);

      annotation (defaultComponentName="rms", Documentation(info="<html>
<p>
This block determines the continuous quasi <a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">RMS</a> value of a multi phase system, representing an equivalent RMS vector or phasor.
</p>
<pre>
 y = sqrt(sum(u[k]^2 for k in 1:m)/m)
</pre>
</html>"));
    end QuasiRMS;

    block SymmetricalComponents
      "Creates symmetrical components from signals representing quasi static phasors"
      extends Modelica.ComplexBlocks.Interfaces.ComplexMIMOs(final n=m,final useConjugateInput=fill(false,m));
      import Modelica.ComplexMath.'abs';
      import Modelica.ComplexMath.arg;
      parameter Integer m=3 "Number of phases";
      output Real abs_u[m] = 'abs'(u) "Absolute of input";
      output Modelica.SIunits.Angle arg_u[m](each displayUnit="deg") = arg(u)
        "Argument of input";
      output Real abs_y[m] = 'abs'(y) "Absolute of output";
      output Modelica.SIunits.Angle arg_y[m](each displayUnit="deg") = arg(y)
        "Argument of output";
    protected
      final parameter Complex sTM[m,m]=
        Electrical.MultiPhase.Functions.symmetricTransformationMatrix(m);
    equation
      // Symmetrical components (preferred): y = sTM*u;
      for j in 1:m loop
        y[j] = Complex(sum({sTM[j,k].re*u[k].re - sTM[j,k].im*u[k].im for k in 1:m}),
                       sum({sTM[j,k].re*u[k].im + sTM[j,k].im*u[k].re for k in 1:m}));
      end for;
      annotation (defaultComponentName="symComp", Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={
            Line(
              points={{-44,0},{-44,0},{-8,-20},{-22,-16},{-18,-10},{-8,-20}},
              color={85,170,255}),
            Line(
              points={{-44,0},{-44,40},{-40,26},{-48,26},{-44,40}},
              color={85,170,255}),
            Line(
              points={{-18,10},{-18,10},{2,-24},{-8,-14},{-2,-10},{2,-24}},
              color={85,170,255},
              origin={-54,-18},
              rotation=-90),
            Line(
              points={{42,48},{42,48},{78,28},{64,32},{68,38},{78,28}},
              color={85,170,255}),
            Line(
              points={{42,48},{42,88},{46,74},{38,74},{42,88}},
              color={85,170,255}),
            Line(
              points={{-18,10},{-18,10},{2,-24},{-8,-14},{-2,-10},{2,-24}},
              color={85,170,255},
              origin={32,30},
              rotation=-90),
            Line(
              points={{42,-22},{42,-22},{78,-42},{64,-38},{68,-32},{78,-42}},
              color={85,170,255}),
            Line(
              points={{42,-22},{42,18},{46,4},{38,4},{42,18}},
              color={85,170,255}),
            Line(
              points={{-18,10},{-18,10},{2,-24},{-8,-14},{-2,-10},{2,-24}},
              color={85,170,255},
              origin={32,-40},
              rotation=-90),
            Line(
              points={{42,-88},{42,-48},{46,-62},{38,-62},{42,-48}},
              color={85,170,255}),
            Line(
              points={{52,-88},{52,-48},{56,-62},{48,-62},{52,-48}},
              color={85,170,255}),
            Line(
              points={{32,-88},{32,-48},{36,-62},{28,-62},{32,-48}},
              color={85,170,255})}), Documentation(info="<html>
<p>
Calculates the symmetric components according to Charles L. Fortescue from the time phasors.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.MultiPhase.UsersGuide.PhaseOrientation\">User's guide</a> on symmetrical components and orientation.
</p>
</html>"));
    end SymmetricalComponents;

    block FromSymmetricalComponents
      "Creates quasi static phasors from symmetrical components"
      extends Modelica.ComplexBlocks.Interfaces.ComplexMIMOs(final n=m,final useConjugateInput=fill(false,m));
      import Modelica.ComplexMath.'abs';
      import Modelica.ComplexMath.arg;
      parameter Integer m=3 "Number of phases";
      output Real abs_u[m] = 'abs'(u) "Absolute of input";
      output Modelica.SIunits.Angle arg_u[m](displayUnit="deg") = arg(u)
        "Argument of input";
      output Real abs_y[m] = 'abs'(y) "Absolute of output";
      output Modelica.SIunits.Angle arg_y[m](displayUnit="deg") = arg(y)
        "Argument of output";
    protected
      final parameter Complex sbTM[m,m]=
        Electrical.MultiPhase.Functions.symmetricBackTransformationMatrix(m);
    equation
      // Symmetrical components (preferred): y = sbTM*u;
      for j in 1:m loop
        y[j] = Complex(sum({sbTM[j,k].re*u[k].re - sbTM[j,k].im*u[k].im for k in 1:m}),
                       sum({sbTM[j,k].re*u[k].im + sbTM[j,k].im*u[k].re for k in 1:m}));
      end for;
      annotation (defaultComponentName="symComp", Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={
            Line(
              points={{-18,10},{-18,10},{2,-24},{-8,-14},{-2,-10},{2,-24}},
              color={85,170,255},
              origin={-54,-40},
              rotation=-90),
            Line(
              points={{-44,-22},{-44,-22},{-8,-42},{-22,-38},{-18,-32},{-8,-42}},
              color={85,170,255}),
            Line(
              points={{-44,-22},{-44,18},{-40,4},{-48,4},{-44,18}},
              color={85,170,255}),
            Line(
              points={{-18,10},{-18,10},{2,-24},{-8,-14},{-2,-10},{2,-24}},
              color={85,170,255},
              origin={-54,30},
              rotation=-90),
            Line(
              points={{-44,48},{-44,88},{-40,74},{-48,74},{-44,88}},
              color={85,170,255}),
            Line(
              points={{-44,48},{-44,48},{-8,28},{-22,32},{-18,38},{-8,28}},
              color={85,170,255}),
            Line(
              points={{-54,-88},{-54,-48},{-50,-62},{-58,-62},{-54,-48}},
              color={85,170,255}),
            Line(
              points={{-44,-88},{-44,-48},{-40,-62},{-48,-62},{-44,-48}},
              color={85,170,255}),
            Line(
              points={{-34,-88},{-34,-48},{-30,-62},{-38,-62},{-34,-48}},
              color={85,170,255}),
            Line(
              points={{42,-10},{42,30},{46,16},{38,16},{42,30}},
              color={85,170,255}),
            Line(
              points={{-18,10},{-18,10},{2,-24},{-8,-14},{-2,-10},{2,-24}},
              color={85,170,255},
              origin={32,-28},
              rotation=-90),
            Line(
              points={{42,-10},{42,-10},{78,-30},{64,-26},{68,-20},{78,-30}},
              color={85,170,255})}), Documentation(info="<html>
<p>
Calculates the time phasors from the symmetric components according to Charles L. Fortescue.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.MultiPhase.UsersGuide.PhaseOrientation\">User's guide</a> on symmetrical components and orientation.
</p>
</html>"));
    end FromSymmetricalComponents;

    block SingleToMultiPhase
      "Extends complex phase signal to complex multi phase signals using symmetricOrientation"
      extends Modelica.ComplexBlocks.Interfaces.ComplexSIMO(final nout=m,final useConjugateInput=false);
      parameter Integer m=3 "Number of phases";
    equation
      y = u*Modelica.ComplexMath.fromPolar(fill(1, m), -
        Electrical.MultiPhase.Functions.symmetricOrientation(m));
      annotation (defaultComponentName="adaptor", Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics={Line(
                  points={{-60,-20},{-60,20},{-56,8},{-64,8},{-60,20}},
                  color={0,0,255}),Line(
                  points={{40,-20},{40,20},{44,8},{36,8},{40,20}},
                  color={0,0,255}),Line(
                  points={{40,-20},{40,-20},{76,-40},{64,-38},{68,-30},{76,-40}},
                  color={0,0,255}),Line(
                  points={{-18,10},{-18,10},{2,-24},{-8,-16},{-2,-10},{2,-24}},
                  color={0,0,255},
                  origin={30,-38},
                  rotation=-90)}), Icon(graphics={
            Line(
              points={{-60,-20},{-60,20},{-56,8},{-64,8},{-60,20}},
              color={85,170,255}),
            Line(
              points={{40,-20},{40,20},{44,6},{36,6},{40,20}},
              color={85,170,255}),
            Line(
              points={{40,-20},{40,-20},{76,-40},{62,-36},{66,-30},{76,-40}},
              color={85,170,255}),
            Line(
              points={{-18,10},{-18,10},{2,-24},{-8,-14},{-2,-10},{2,-24}},
              color={85,170,255},
              origin={30,-38},
              rotation=-90)}),
        Documentation(info="<html>
<p>
This function propagates the input phasor to m output phasors with <a href=\"modelica://Modelica.Electrical.MultiPhase.UsersGuide.PhaseOrientation\">symmetricOrientation</a>.
</p>
</html>"));
    end SingleToMultiPhase;

    block ToSpacePhasor "Conversion: m phase -> space phasor"
      extends Modelica.Blocks.Icons.Block;
      import Modelica.ComplexMath.j;
      import Modelica.ComplexMath.exp;
      import Modelica.ComplexMath.'sum';
      parameter Integer m(min=1) = 3 "Number of phases";
      Modelica.ComplexBlocks.Interfaces.ComplexInput u[m]
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y[2]
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    protected
      parameter Modelica.SIunits.Angle phi[m]=
          Electrical.MultiPhase.Functions.symmetricOrientation(m);
      Complex c;
    equation
      // c = sqrt(2)/m*'sum'({u[k]*exp(j*phi[k]) for k in 1:m});
      // Alternative implementation due to https://trac.openmodelica.org/OpenModelica/ticket/4496
      c.re = sqrt(2)/m*sum(u[k].re*cos(phi[k])-u[k].im*sin(phi[k]) for k in 1:m);
      c.im = sqrt(2)/m*sum(u[k].re*sin(phi[k])+u[k].im*cos(phi[k]) for k in 1:m);
      y = {c.re,c.im};
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{0,0},{80,80},{60,72},{72,60},{80,80}}, color={85,170,255}),
            Line(points={{0,0},{80,-80},{72,-60},{60,-72},{80,-80}}, color={85,170,255}),
            Line(
              points={{-80,0},{-73.33,10},{-66.67,17.32},{-60,20},{-53.33,17.32},
                  {-46.67,10},{-40,0},{-33.33,-10},{-26.67,-17.32},{-20,-20},{-13.33,
                  -17.32},{-6.67,-10},{0,0}},
              color={85,170,255},
              smooth=Smooth.Bezier),
            Line(
              points={{-90,0},{-83.33,10},{-76.67,17.32},{-70,20},{-63.33,17.32},
                  {-56.67,10},{-50,0},{-43.33,-10},{-36.67,-17.32},{-30,-20},{-23.33,
                  -17.32},{-16.67,-10},{-10,0}},
              color={85,170,255},
              smooth=Smooth.Bezier),
            Line(
              points={{-70,0},{-63.33,10},{-56.67,17.32},{-50,20},{-43.33,17.32},
                  {-36.67,10},{-30,0},{-23.33,-10},{-16.67,-17.32},{-10,-20},{-3.33,
                  -17.32},{3.33,-10},{10,0}},
              color={85,170,255},
              smooth=Smooth.Bezier),
            Text(
              extent={{-12,-74},{64,-86}},
              textString="zero")}),
        Documentation(info="<html>
<p>
Transformation of m phase values (voltages or currents) to space phasor.
</p>
</html>"));
    end ToSpacePhasor;

    block FromSpacePhasor "Conversion: space phasor -> m phase"
      extends Modelica.Blocks.Icons.Block;
      import Modelica.ComplexMath.j;
      import Modelica.ComplexMath.exp;
      parameter Integer m(min=1) = 3 "Number of phases";
      Modelica.Blocks.Interfaces.RealInput u[2]
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.ComplexBlocks.Interfaces.ComplexOutput y[m]
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    protected
      parameter Modelica.SIunits.Angle phi[m]=
          Electrical.MultiPhase.Functions.symmetricOrientation(m);
    equation
      y = {Complex(u[1], u[2])*exp(-j*phi[k])/sqrt(2) for k in 1:m};
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{0,0},{-80,80},{-60,72},{-72,60},{-80,80}}, color={85,170,255}),
            Line(points={{0,0},{-80,-80},{-72,-60},{-60,-72},{-80,-80}}, color=
                  {85,170,255}),
            Line(
              points={{0,0},{6.67,10},{13.33,17.32},{20,20},{26.67,17.32},{
                  33.33,10},{40,0},{46.67,-10},{53.33,-17.32},{60,-20},{66.67,-17.32},
                  {73.33,-10},{80,0}},
              color={85,170,255},
              smooth=Smooth.Bezier),
            Line(
              points={{-10,0},{-3.33,10},{3.33,17.32},{10,20},{16.67,17.32},{
                  23.33,10},{30,0},{36.67,-10},{43.33,-17.32},{50,-20},{56.67,-17.32},
                  {63.33,-10},{70,0}},
              color={85,170,255},
              smooth=Smooth.Bezier),
            Line(
              points={{10,0},{16.67,10},{23.33,17.32},{30,20},{36.67,17.32},{
                  43.33,10},{50,0},{56.67,-10},{63.33,-17.32},{70,-20},{76.67,-17.32},
                  {83.33,-10},{90,0}},
              color={85,170,255},
              smooth=Smooth.Bezier),
            Text(
              extent={{-62,-74},{14,-86}},
              textString="zero")}), Documentation(info="<html>
<p>
Transformation of space phasor to m phase values (voltages or currents).
</p>
</html>"));
    end FromSpacePhasor;
  end Blocks;

  package Sensors "AC multiphase sensors"
    extends Modelica.Icons.SensorsPackage;

    model ReferenceSensor "Sensor of reference angle gamma"
      extends
        Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.AbsoluteSensor;
      Modelica.Blocks.Interfaces.RealOutput y "Reference angle" annotation (
          Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      y = plug_p.reference.gamma;
      plug_p.pin.i = fill(Complex(0), m);
      annotation (
        Icon(graphics={Text(
              extent={{60,-60},{-60,-30}},
              textString="ref")}), Documentation(info="<html>
<p>
This sensor can be used to measure the reference angle.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.ReferenceSensor\">SinglePhase.Sensors.ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageQuasiRMSSensor\">VoltageQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor\">CurrentQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"));
    end ReferenceSensor;

    model FrequencySensor "Frequency sensor"
      extends Interfaces.AbsoluteSensor;
      SinglePhase.Sensors.FrequencySensor frequencySensor annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
      Basic.PlugToPin_p plugToPin_p(final m=m, final k=1) annotation (Placement(
            transformation(extent={{-80,-10},{-60,10}})));
      Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(
            transformation(extent={{100,-10},{120,10}})));
    equation

      connect(plug_p, plugToPin_p.plug_p) annotation (Line(
          points={{-100,0},{-72,0}}, color={85,170,255}));
      connect(plugToPin_p.pin_p, frequencySensor.pin) annotation (Line(
          points={{-68,0},{-10,0}}, color={85,170,255}));
      connect(frequencySensor.y, y) annotation (Line(
          points={{11,0},{110,0}}, color={0,0,127}));
      annotation (
        Icon(graphics={Line(points={{70,0},{80,0},{90,0},{100,0}},
                color={0,0,127}), Text(
              extent={{-29,-11},{30,-70}},
              textString="f")}), Documentation(info="<html>

<p>
This sensor can be used to measure the frequency of the reference system, using <em>one</em>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.FrequencySensor\">single phase FrequencySensor</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.FrequencySensor\">SinglePhase.Sensors.FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageQuasiRMSSensor\">VoltageQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor\">CurrentQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"));
    end FrequencySensor;

    model PotentialSensor "Potential sensor"
      extends Interfaces.AbsoluteSensor;
      QuasiStationary.SinglePhase.Sensors.PotentialSensor potentialSensor[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Basic.PlugToPins_p plugToPins_p(final m=m) annotation (Placement(
            transformation(extent={{-80,-10},{-60,10}})));
      ComplexBlocks.Interfaces.ComplexOutput y[m] annotation (Placement(
            transformation(extent={{100,-10},{120,10}})));
      Modelica.SIunits.Voltage abs_y[m]=Modelica.ComplexMath.'abs'(y)
        "Magnitude of complex potential";
      Modelica.SIunits.Angle arg_y[m]=Modelica.ComplexMath.arg(y)
        "Argument of complex potential";

    equation
      connect(potentialSensor.y, y) annotation (Line(points={{11,0},{35.75,0},{
              35.75,0},{60.5,0},{60.5,0},{110,0}}, color={85,170,255}));
      connect(plug_p, plugToPins_p.plug_p) annotation (Line(
          points={{-100,0},{-72,0}}, color={85,170,255}));
      connect(plugToPins_p.pin_p, potentialSensor.pin) annotation (Line(
          points={{-68,0},{-10,0}}, color={85,170,255}));
      annotation (
        Icon(graphics={Text(
              extent={{-29,-11},{30,-70}},
              textString="V")}), Documentation(info="<html>

<p>
This sensor can be used to measure <em>m</em> complex potentials, using <em>m</em>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">single phase PotentialSensors</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">SinglePhase.Sensors.PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageQuasiRMSSensor\">VoltageQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor\">CurrentQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"));
    end PotentialSensor;

    model VoltageSensor "Voltage sensor"
      extends Interfaces.RelativeSensor;
      QuasiStationary.SinglePhase.Sensors.VoltageSensor voltageSensor[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.SIunits.Voltage abs_y[m]=Modelica.ComplexMath.'abs'(y)
        "Magnitude of complex voltage";
      Modelica.SIunits.Angle arg_y[m]=Modelica.ComplexMath.arg(y)
        "Argument of complex voltage";

    equation
      connect(plugToPins_p.pin_p, voltageSensor.pin_p) annotation (Line(points=
              {{-68,0},{-53.5,0},{-53.5,0},{-39,0},{-39,0},{-10,0}}, color={85,
              170,255}));
      connect(voltageSensor.pin_n, plugToPins_n.pin_n) annotation (Line(points=
              {{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
      connect(voltageSensor.y, y) annotation (Line(points={{0,-11},{0,-35.75},{
              0,-35.75},{0,-60.5},{0,-60.5},{0,-110}}, color={85,170,255}));
      annotation (
        Icon(graphics={Text(
              extent={{-29,-11},{30,-70}},
              textString="V")}), Documentation(info="<html>

<p>
This sensor can be used to measure <em>m</em> complex voltages, using <em>m</em>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">single phase VoltageSensors</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">SinglePhase.Sensors.VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageQuasiRMSSensor\">VoltageQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor\">CurrentQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"));
    end VoltageSensor;

    model VoltageQuasiRMSSensor
      "Continuous quasi voltage RMS sensor for multi phase system"
      extends Modelica.Icons.RotationalSensor;
      extends Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.TwoPlug;
      parameter Integer m(min=1) = 3 "Number of phases";
      Modelica.Blocks.Interfaces.RealOutput V
        "Continuous quasi average RMS of current" annotation (Placement(
            transformation(
            origin={0,-100},
            extent={{-10,-10},{10,10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-110})));
      SinglePhase.Sensors.VoltageSensor voltageSensor[m] annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Blocks.QuasiRMS quasiRMS(final m=m) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-50})));
    equation
      connect(quasiRMS.y, V) annotation (Line(
          points={{0,-61},{0,-100}}, color={0,0,127}));
      connect(plugToPins_p.pin_p, voltageSensor.pin_p) annotation (Line(
          points={{-68,0},{-10,0}}, color={85,170,255}));
      connect(voltageSensor.pin_n, plugToPins_n.pin_n) annotation (Line(
          points={{10,0},{68,0}}, color={85,170,255}));
      connect(voltageSensor.y, quasiRMS.u) annotation (Line(
          points={{0,-11},{0,-38}}, color={85,170,255}));
      annotation (defaultComponentName="voltageRMSSensor",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{150,-100},{-150,-70}},
              textString="m=%m"),
            Line(points={{-90,0},{-70,0}}, color={0,0,255}),
            Line(points={{0,-70},{0,-100}}, color={85,170,255}),
            Line(points={{70,0},{90,0}}, color={0,0,255}),
            Text(
              lineColor={0,0,255},
              extent={{-150,80},{150,120}},
              textString="%name")}),
        Documentation(revisions="<html>
</html>", info="<html>
<p>
This sensor determines the continuous quasi <a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">RMS</a>
value of a multi phase voltage system, by averaging the phase RMS voltage phasors <code>v</code>.
</p>
<pre>
  V = sum({'abs'(v[k]) for k in 1:m})/m
</pre>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageQuasiRMSSensor\">VoltageQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor\">CurrentQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.MultiSensor\">MultiSensor</a>
</p>
</html>"));
    end VoltageQuasiRMSSensor;

    model CurrentSensor "Current Sensor"
      extends Interfaces.RelativeSensor;
      QuasiStationary.SinglePhase.Sensors.CurrentSensor currentSensor[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.SIunits.Current abs_y[m]=Modelica.ComplexMath.'abs'(y)
        "Magnitude of complex current";
      Modelica.SIunits.Angle arg_y[m]=Modelica.ComplexMath.arg(y)
        "Argument of complex current";
    equation
      connect(plugToPins_p.pin_p, currentSensor.pin_p) annotation (Line(points=
              {{-68,0},{-53.5,0},{-53.5,0},{-39,0},{-39,0},{-10,0}}, color={85,
              170,255}));
      connect(currentSensor.pin_n, plugToPins_n.pin_n) annotation (Line(points=
              {{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
      connect(currentSensor.y, y) annotation (Line(points={{0,-11},{0,-35.75},{
              0,-35.75},{0,-60.5},{0,-60.5},{0,-110}}, color={85,170,255}));
      annotation (
        Icon(graphics={Text(
              extent={{-29,-11},{30,-70}},
              textString="I")}), Documentation(info="<html>

<p>
This sensor can be used to measure <em>m</em> complex currents, using <em>m</em>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">single phase CurrentSensors</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">SinglePhase.Sensors.CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageQuasiRMSSensor\">VoltageQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor\">CurrentQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"));
    end CurrentSensor;

    model CurrentQuasiRMSSensor
      "Continuous quasi current RMS sensor for multi phase system"
      extends Modelica.Icons.RotationalSensor;
      extends Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.TwoPlug;
      parameter Integer m(min=1) = 3 "Number of phases";
      Modelica.Blocks.Interfaces.RealOutput I
        "Continuous quasi average RMS of current" annotation (Placement(
            transformation(
            origin={0,-100},
            extent={{-10,-10},{10,10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-110})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor
        currentSensor[m] annotation (Placement(transformation(extent={{-10,-10},
                {10,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Blocks.QuasiRMS quasiRMS(final m=m) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-50})));
    equation
      connect(quasiRMS.y, I) annotation (Line(
          points={{0,-61},{0,-100}}, color={0,0,127}));
      connect(plugToPins_p.pin_p, currentSensor.pin_p) annotation (Line(
          points={{-68,0},{-10,0}}, color={85,170,255}));
      connect(currentSensor.pin_n, plugToPins_n.pin_n) annotation (Line(
          points={{10,0},{68,0}}, color={85,170,255}));
      connect(currentSensor.y, quasiRMS.u) annotation (Line(
          points={{0,-11},{0,-38}}, color={85,170,255}));
      annotation (defaultComponentName="currentRMSSensor",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{-90,0},{-70,0}}, color={0,0,255}),
            Line(points={{70,0},{90,0}}, color={0,0,255}),
            Line(points={{0,-70},{0,-100}}, color={85,170,255}),
            Text(
              extent={{150,-100},{-150,-70}},
              textString="m=%m"),
            Text(
              lineColor={0,0,255},
              extent={{-150,80},{150,120}},
              textString="%name")}),
        Documentation(revisions="<html>
</html>", info="<html>
<p>
This sensor determines the continuous quasi <a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">RMS</a>
value of a multi phase current system, by averaging the phase RMS current phasors <code>i</code>.
</p>
<pre>
  I = sum({'abs'(i[k]) for k in 1:m})/m
</pre>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageQuasiRMSSensor\">VoltageQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.MultiSensor\">MultiSensor</a>
</p>
</html>"));
    end CurrentQuasiRMSSensor;

    model PowerSensor "Power sensor"
      extends Modelica.Icons.RotationalSensor;
      parameter Integer m(min=1) = 3 "number of phases";
      Modelica.SIunits.AngularVelocity omega=der(currentP.reference.gamma);
      Interfaces.PositivePlug currentP(final m=m) annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      Interfaces.NegativePlug currentN(final m=m) annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
      Interfaces.PositivePlug voltageP(final m=m) annotation (Placement(
            transformation(extent={{-10,90},{10,110}})));
      Interfaces.NegativePlug voltageN(final m=m) annotation (Placement(
            transformation(extent={{-10,-110},{10,-90}})));
      Modelica.ComplexBlocks.Interfaces.ComplexOutput y annotation (Placement(
            transformation(
            origin={-100,-110},
            extent={{-10,-10},{10,10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-100,-110})));
      Basic.PlugToPins_p plugToPinsCurrentP(final m=m) annotation (Placement(
            transformation(extent={{-80,-10},{-60,10}})));
      Basic.PlugToPins_p plugToPinsVoltageP(final m=m) annotation (Placement(
            transformation(
            origin={0,70},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Basic.PlugToPins_n plugToPinsCurrentN(final m=m) annotation (Placement(
            transformation(extent={{80,-10},{60,10}})));
      Basic.PlugToPins_n plugToPinsVoltageN(final m=m) annotation (Placement(
            transformation(
            origin={0,-70},
            extent={{-10,10},{10,-10}},
            rotation=90)));
      QuasiStationary.SinglePhase.Sensors.PowerSensor powerSensor[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.ComplexBlocks.ComplexMath.Sum sum(final nin=m) annotation (
          Placement(transformation(
            origin={-80,-70},
            extent={{-10,-10},{10,10}},
            rotation=270)));

      Modelica.SIunits.ApparentPower abs_y=Modelica.ComplexMath.'abs'(y)
        "Magnitude of complex apparent power";
      Modelica.SIunits.Angle arg_y=Modelica.ComplexMath.arg(y)
        "Argument of complex apparent power";

    equation
      connect(plugToPinsCurrentP.plug_p, currentP) annotation (Line(points={{-72,
              0},{-79,0},{-86,0},{-100,0}}, color={85,170,255}));
      connect(currentN, plugToPinsCurrentN.plug_n) annotation (Line(points={{
              100,0},{93,0},{86,0},{72,0}}, color={85,170,255}));
      connect(voltageP, plugToPinsVoltageP.plug_p)
        annotation (Line(points={{0,100},{0,100},{0,72}}, color={85,170,255}));
      connect(plugToPinsVoltageN.plug_n, voltageN) annotation (Line(points={{0,
              -72},{0,-72},{0,-100}}, color={85,170,255}));
      connect(plugToPinsCurrentP.pin_p, powerSensor.currentP) annotation (Line(
            points={{-68,0},{-53.5,0},{-53.5,0},{-39,0},{-39,0},{-10,0}}, color={85,170,255}));
      connect(powerSensor.currentN, plugToPinsCurrentN.pin_n) annotation (Line(
            points={{10,0},{24.5,0},{24.5,0},{39,0},{39,0},{68,0}}, color={85,
              170,255}));
      connect(powerSensor.voltageP, plugToPinsVoltageP.pin_p) annotation (Line(
            points={{0,10},{0,10},{0,68},{0,68}}, color={85,170,255}));
      connect(powerSensor.voltageN, plugToPinsVoltageN.pin_n) annotation (Line(
            points={{0,-10},{0,-10},{0,-68},{0,-68}}, color={85,170,255}));
      connect(powerSensor.y, sum.u) annotation (Line(points={{-10,-11},{-10,-40},{-80,-40},{-80,-58}}, color={85,170,255}));
      connect(sum.y, y)
        annotation (Line(points={{-80,-81},{-80,-90},{-100,-90},{-100,-110}}, color={85,170,255}));
      annotation (
        Icon(graphics={
            Line(points={{0,100},{0,70}}, color={85,170,255}),
            Line(points={{0,-70},{0,-100}}, color={85,170,255}),
            Text(extent={{-29,-70},{30,-11}}, textString="P"),
            Text(
              lineColor={0,0,255},
              extent={{-150,110},{150,150}},
              textString="%name"),
            Line(points={{-100,0},{100,0}}, color={85,170,255}),
          Line(points={{-100,-100},{-100,-80},{-58,-38}}, color = {0,0,127})}),
        Documentation(info="<html>

<p>
This sensor can be used to measure <em>m</em> complex apparent power values, using <em>m</em>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">single phase PowerSensors</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">SinglePhase.Sensors.PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageQuasiRMSSensor\">VoltageQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor\">CurrentQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"));
    end PowerSensor;

  model MultiSensor "Multiphase sensor to measure current, voltage and power"
    extends Modelica.Icons.RotationalSensor;
    import Modelica.ComplexMath.conj;
    import Modelica.ComplexMath.'sum';
    import Modelica.ComplexMath.'abs';
    import Modelica.ComplexMath.arg;
    parameter Integer m(min=1) = 3 "Number of phases";
    Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug pc(final m=m)
        "Positive plug, current path"
      annotation (Placement(transformation(extent={{-90,-10},{-110,10}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug nc(final m=m)
        "Negative plug, current path"
      annotation (Placement(transformation(extent={{110,-10},{90,10}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug pv(final m=m)
        "Positive plug, voltage path"
      annotation (Placement(transformation(extent={{-10,110},{10,90}})));
    Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug nv(final m=m)
        "Negative plug, voltage path"
      annotation (Placement(transformation(extent={{10,-110},{-10,-90}})));
    Modelica.ComplexBlocks.Interfaces.ComplexOutput i[m](
      redeclare each final Modelica.SIunits.Current re, redeclare each final Modelica.SIunits.Current im)
      "Current as complex output signal" annotation (Placement(transformation(
          origin={-60,-110},
          extent={{10,10},{-10,-10}},
          rotation=90)));
    Modelica.ComplexBlocks.Interfaces.ComplexOutput v[m](
      redeclare each final Modelica.SIunits.Voltage re, redeclare each final Modelica.SIunits.Voltage im)
      "Voltage as complex output signal" annotation (Placement(transformation(
          origin={60,-110},
          extent={{10,10},{-10,-10}},
          rotation=90)));
    Modelica.ComplexBlocks.Interfaces.ComplexOutput apparentPower[m](
      redeclare each final Modelica.SIunits.ActivePower re, redeclare each final Modelica.SIunits.ReactivePower im)
      "Instantaneous apparent power as complex output signal" annotation (Placement(transformation(
          origin={-110,-60},
          extent={{-10,10},{10,-10}},
          rotation=180)));
    Modelica.ComplexBlocks.Interfaces.ComplexOutput apparentPowerTotal(
      redeclare final Modelica.SIunits.ActivePower re, redeclare final Modelica.SIunits.ReactivePower im)
      "Sum of instantaneous apparent power as complex output signal" annotation (Placement(transformation(
          origin={110,-60},
          extent={{10,10},{-10,-10}},
          rotation=180)));
    output Modelica.SIunits.Current abs_i[m]='abs'(i) "Absolute of complex currents";
    output Modelica.SIunits.Angle arg_i[m]=arg(i) "Argument of complex currents";
    output Modelica.SIunits.Voltage abs_v[m]='abs'(v) "Absolute of complex voltages";
    output Modelica.SIunits.Angle arg_v[m]=arg(v) "Argument of complex voltages";
    output Modelica.SIunits.ApparentPower abs_apparentPower[m]='abs'(apparentPower) "Absolute of complex apparent power signals";
    output Modelica.SIunits.Angle arg_apparentPower[m]=arg(apparentPower) "Argument of complex apparent power signals";
    output Modelica.SIunits.ApparentPower abs_apparentPowerTotal='abs'(apparentPowerTotal) "Absolute of sum complex apparent power";
    output Modelica.SIunits.Angle arg_apparentPowerTotal=arg(apparentPowerTotal) "Argument of sum complex apparent power";
  equation
    Connections.branch(pc.reference, nc.reference);
    pc.reference.gamma = nc.reference.gamma;
    Connections.branch(pv.reference, nv.reference);
    pv.reference.gamma = nv.reference.gamma;
    Connections.branch(pc.reference, pv.reference);
    pc.reference.gamma = pv.reference.gamma;
    pc.pin.i + nc.pin.i = fill(Complex(0), m);
    pc.pin.v - nc.pin.v = fill(Complex(0), m);
    pv.pin.i = fill(Complex(0), m);
    nv.pin.i = fill(Complex(0), m);
    i = pc.pin.i;
    v = pv.pin.v - nv.pin.v;
    apparentPower = v.*conj(i);
    apparentPowerTotal = Complex(sum(apparentPower.re),sum(apparentPower.im));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Line(points = {{0,100},{0,70}}, color={85,170,255}),
        Line(points = {{0,-70},{0,-100}}, color={85,170,255}),
        Line(points = {{-100,0},{100,0}}, color={85,170,255}),
        Line(points = {{0,70},{0,40}}),
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
            textString="v"),
          Line(points={{100,-60},{80,-60},{56,-42}}, color={85,170,255}),
          Text(
            extent={{-150,110},{150,150}},
            textString="%name",
            lineColor={0,0,255})}),
      Documentation(info="<html>
<p>This multi sensor measures currents, voltages and instantaneous electrical power of a multiphase system and has separated voltage and current paths.
The plugs of the voltage paths are pv and nv, the plugs of the current paths are pc and nc.
The internal resistance of each current path is zero, the internal resistance of each voltage path is infinite.</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.MultiSensor\">SinglePhase.Sensors.MultiSensor</a>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageQuasiRMSSensor\">VoltageQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentQuasiRMSSensor\">CurrentQuasiRMSSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor\">PowerSensor</a>
</p>
</html>",          revisions="<html>
<ul>
<li><em>20170306</em> first implementation by Anton Haumer</li>
</ul>
</html>"));
  end MultiSensor;

    model AronSensor "threephase Aron sensor for active power"
      import Modelica;
      extends Modelica.Icons.RotationalSensor;
      final parameter Integer m(final min=1) = 3 "Number of phases";
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug plug_n(final m=m)
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.Blocks.Interfaces.RealOutput power "active power" annotation (
          Placement(transformation(
            origin={0,-110},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_p plugToPins_p(final m=m)
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_n plugToPins_n(final m=m)
        annotation (Placement(transformation(extent={{80,-10},{60,10}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor powerSensor1
        annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor powerSensor3
        annotation (Placement(transformation(extent={{20,-30},{40,-50}})));
      Modelica.Blocks.Math.Add add annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-70})));
      Modelica.ComplexBlocks.ComplexMath.ComplexToReal complexToReal1(final
          useConjugateInput=false) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-40,-20})));
      Modelica.ComplexBlocks.ComplexMath.ComplexToReal complexToReal3(final
          useConjugateInput=false) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-22})));
    equation
      connect(add.y, power)
        annotation (Line(points={{0,-81},{0,-110}}, color={0,0,127}));
      connect(plug_p, plugToPins_p.plug_p)
        annotation (Line(points={{-100,0},{-72,0}}, color={85,170,255}));
      connect(plugToPins_n.plug_n, plug_n)
        annotation (Line(points={{72,0},{100,0}}, color={85,170,255}));
      connect(plugToPins_p.pin_p[1], powerSensor1.currentP) annotation (Line(
            points={{-68,0},{-68,40},{-40,40}}, color={85,170,255}));
      connect(powerSensor1.currentP, powerSensor1.voltageP) annotation (Line(
            points={{-40,40},{-40,50},{-30,50}}, color={85,170,255}));
      connect(powerSensor1.currentN, plugToPins_n.pin_n[1]) annotation (Line(
            points={{-20,40},{68,40},{68,0}}, color={85,170,255}));
      connect(plugToPins_p.pin_p[2], plugToPins_n.pin_n[2])
        annotation (Line(points={{-68,0},{68,0}}, color={85,170,255}));
      connect(plugToPins_p.pin_p[3], powerSensor3.currentP) annotation (Line(
            points={{-68,0},{-68,-40},{20,-40}}, color={85,170,255}));
      connect(powerSensor3.currentP, powerSensor3.voltageP) annotation (Line(
            points={{20,-40},{20,-50},{30,-50}}, color={85,170,255}));
      connect(powerSensor3.currentN, plugToPins_n.pin_n[3]) annotation (Line(
            points={{40,-40},{68,-40},{68,0}}, color={85,170,255}));
      connect(complexToReal3.re, add.u1)
        annotation (Line(points={{6,-34},{6,-58}}, color={0,0,127}));
      connect(complexToReal1.re, add.u2) annotation (Line(points={{-34,-32},{
              -34,-50},{-6,-50},{-6,-58}}, color={0,0,127}));
      connect(powerSensor3.y, complexToReal3.u) annotation (Line(points={{20,
              -29},{20,10},{0,10},{0,-10}}, color={85,170,255}));
      connect(powerSensor1.y, complexToReal1.u)
        annotation (Line(points={{-40,29},{-40,-8}}, color={85,170,255}));
      connect(plugToPins_p.pin_p[2], powerSensor1.voltageN) annotation (Line(
            points={{-68,0},{-30,0},{-30,30}}, color={85,170,255}));
      connect(plugToPins_p.pin_p[2], powerSensor3.voltageN) annotation (Line(
            points={{-68,0},{30,0},{30,-30}}, color={85,170,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-29,-11},{30,-70}},
              textString="W"),  Line(points={{-70,0},{-90,0}}),
              Line(points={{70,0},{90,0}}),Line(points={{0,-100},
              {0,-70}}, color={0,0,127}),
            Text(
              extent={{150,-100},{-150,-70}},
              textString="m=%m"),
            Text(
              extent={{-150,80},{150,120}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
<p>
Contains 2 power meters (Modelica.Electrical.Analog.Sensors.PowerSensor) to measure total active power in a threephase system.
</p>
<p>
This device works only for sinusoidal voltages and currents in threephase systems without neutral.
</p>
<p>
Elmar Schr&uuml;fer, Leonhard Reindl, Bernhard Zagar: Elektrische Messtechnik. Carl Hanser Verlag.<br>
Reinhard Lerch: Elektrische Messtechnik. Springer Vieweg.
</p>
</html>"));
    end AronSensor;

    model ReactivePowerSensor "threephase sensor for reactive power"
      import Modelica;
      extends Modelica.Icons.RotationalSensor;
      final parameter Integer m(final min=1) = 3 "Number of phases";
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug plug_n(final m=m)
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.Blocks.Interfaces.RealOutput reactivePower "reactive power"
        annotation (Placement(transformation(
            origin={0,-110},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_p plugToPins_p(final m=m)
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_n plugToPins_n(final m=m)
        annotation (Placement(transformation(extent={{80,20},{60,40}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor powerSensor1
        annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor powerSensor2
        annotation (Placement(transformation(extent={{10,40},{30,20}})));
      Modelica.Blocks.Math.Add3 add(
        final k1=1/sqrt(3),
        final k2=1/sqrt(3),
        final k3=1/sqrt(3))        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={0,-80})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor powerSensor3
        annotation (Placement(transformation(extent={{30,-10},{50,10}})));
      Modelica.ComplexBlocks.ComplexMath.ComplexToReal complexToReal1(final
          useConjugateInput=false) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-40,-30})));
      Modelica.ComplexBlocks.ComplexMath.ComplexToReal complexToReal2(final
          useConjugateInput=false) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-30})));
      Modelica.ComplexBlocks.ComplexMath.ComplexToReal complexToReal3(final
          useConjugateInput=false) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={30,-30})));
    equation
      connect(add.y, reactivePower)
        annotation (Line(points={{0,-91},{0,-110}}, color={0,0,127}));
      connect(plug_p, plugToPins_p.plug_p)
        annotation (Line(points={{-100,0},{-90,0},{-90,30},{-72,30}},
                                                    color={85,170,255}));
      connect(plugToPins_n.plug_n, plug_n)
        annotation (Line(points={{72,30},{90,30},{90,0},{100,0}},
                                                  color={85,170,255}));
      connect(plugToPins_p.pin_p[1], powerSensor1.currentP)
        annotation (Line(points={{-68,30},{-68,60},{-40,60}},color={85,170,255}));
      connect(plugToPins_p.pin_p[2], powerSensor1.voltageP) annotation (Line(points={{-68,30},
              {-50,30},{-50,70},{-30,70}},        color={85,170,255}));
      connect(powerSensor1.currentN, plugToPins_n.pin_n[1])
        annotation (Line(points={{-20,60},{68,60},{68,30}},color={85,170,255}));
      connect(plugToPins_p.pin_p[3], powerSensor1.voltageN) annotation (Line(points={{-68,30},
              {-68,0},{-30,0},{-30,50}},             color={85,170,255}));
      connect(plugToPins_p.pin_p[2], powerSensor2.currentP)
        annotation (Line(points={{-68,30},{10,30}},
                                                  color={85,170,255}));
      connect(powerSensor2.currentN, plugToPins_n.pin_n[2])
        annotation (Line(points={{30,30},{68,30}},
                                                 color={85,170,255}));
      connect(plugToPins_p.pin_p[3], powerSensor2.voltageP) annotation (Line(points={{-68,30},
              {-68,0},{20,0},{20,20}},              color={85,170,255}));
      connect(powerSensor1.currentN, powerSensor2.voltageN)
        annotation (Line(points={{-20,60},{20,60},{20,40}}, color={85,170,255}));
      connect(plugToPins_p.pin_p[3], powerSensor3.currentP) annotation (Line(
            points={{-68,30},{-68,0},{30,0}}, color={85,170,255}));
      connect(powerSensor3.currentN, plugToPins_n.pin_n[3])
        annotation (Line(points={{50,0},{68,0},{68,30}}, color={85,170,255}));
      connect(powerSensor1.currentN, powerSensor3.voltageP) annotation (Line(
            points={{-20,60},{40,60},{40,10}}, color={85,170,255}));
      connect(powerSensor3.voltageN, plugToPins_n.pin_n[2]) annotation (Line(
            points={{40,-10},{40,-20},{60,-20},{60,30},{68,30}}, color={85,170,
              255}));
      connect(powerSensor1.y, complexToReal1.u)
        annotation (Line(points={{-40,49},{-40,-18}}, color={85,170,255}));
      connect(complexToReal2.u, powerSensor2.y) annotation (Line(points={{0,-18},
              {0,50},{10,50},{10,41}}, color={85,170,255}));
      connect(powerSensor3.y, complexToReal3.u)
        annotation (Line(points={{30,-11},{30,-18}}, color={85,170,255}));
      connect(complexToReal1.re, add.u1) annotation (Line(points={{-34,-42},{
              -34,-60},{-8,-60},{-8,-68}}, color={0,0,127}));
      connect(complexToReal2.re, add.u2) annotation (Line(points={{6,-42},{6,
              -50},{0,-50},{0,-68}}, color={0,0,127}));
      connect(complexToReal3.re, add.u3) annotation (Line(points={{36,-42},{36,
              -60},{8,-60},{8,-68}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-29,-11},{30,-70}},
              textString="var"),   Line(points={{-70,0},{-90,0}}),
              Line(points={{70,0},{90,0}}),Line(points={{0,-100},
              {0,-70}}, color={0,0,127}),
            Text(
              extent={{150,-100},{-150,-70}},
              textString="m=%m"),
            Text(
              extent={{-150,80},{150,120}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
<p>
Contains 3 power meters (Modelica.Electrical.Analog.Sensors.PowerSensor) to measure total reactive power in a threephase system.
</p>
<p>
Thomas M&uuml;hl: Elektrische Messtechnik. Springer Vieweg.
</p>
</html>"));
    end ReactivePowerSensor;
    annotation (Documentation(info="<html>
<p>This package hosts sensors for quasi stationary multiphase circuits.
Quasi stationary theory can be found in the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors\">SinglePhase.Sensors</a>

</html>"));
  end Sensors;

  package Sources "AC multiphase sources"
    extends Modelica.Icons.SourcesPackage;

    model VoltageSource "Constant multiphase AC voltage"
      extends Interfaces.Source;
      import Modelica.ComplexMath.j;
      import Modelica.ComplexMath.exp;
      parameter Modelica.SIunits.Frequency f(start=1) "Frequency of the source";
      parameter Modelica.SIunits.Voltage V[m](start=fill(1, m))
        "RMS voltage of the source";
      parameter Modelica.SIunits.Angle phi[m]=-
          Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m)
        "Phase shift of the source";
    equation
      omega = 2*Modelica.Constants.pi*f;
      v = {V[k]*exp(j*phi[k]) for k in 1:m};
      annotation (
        Icon(graphics={
            Line(points={{-50,0},{50,0}}, color={85,170,255}),
            Line(points={{-70,30},{-70,10}}, color={85,170,255}),
            Line(points={{-80,20},{-60,20}}, color={85,170,255}),
            Line(points={{60,20},{80,20}}, color={85,170,255})}),
        Documentation(info="<html>

<p>
This model describes <em>m</em> constant voltage sources, specifying the complex voltages by the RMS voltages and the phase shifts
(defaults are
<a href=\"modelica://Modelica.Electrical.MultiPhase.Functions.symmetricOrientation\">-symmetricOrientation</a>).
<em>m</em> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">single phase VoltageSources</a> are used.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">SinglePhase.VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
    end VoltageSource;

    model VariableVoltageSource "Variable multiphase AC voltage"
      extends Interfaces.Source;
      Modelica.Blocks.Interfaces.RealInput f annotation (Placement(
            transformation(
            origin={60,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.ComplexBlocks.Interfaces.ComplexInput V[m] annotation (Placement(
            transformation(
            origin={-60,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      omega = 2*Modelica.Constants.pi*f;
      v = V;
      annotation (defaultComponentName="voltageSource",
        Icon(graphics={
            Line(points={{-50,0},{50,0}}, color={85,170,255}),
            Line(points={{-70,30},{-70,10}}, color={85,170,255}),
            Line(points={{-80,20},{-60,20}}, color={85,170,255}),
            Line(points={{60,20},{80,20}}, color={85,170,255})}),
                                     Documentation(info="<html>

<p>
This model describes <em>m</em> variable voltage sources, with <em>m</em> complex signal inputs,
specifying the complex voltages by the complex RMS voltage components.
Additionally, the frequency of the voltage source is defined by a real signal input.
<em>m</em> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource\">single phase VariableVoltageSources</a> are used.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">SinglePhase.VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
    end VariableVoltageSource;

    model ReferenceVoltageSource
      "Variable multiphase AC voltage with reference angle input"
      extends Electrical.QuasiStationary.MultiPhase.Interfaces.ReferenceSource;
      import Modelica.Constants.pi;
      Modelica.Blocks.Interfaces.RealInput gamma
        "Reference angle of voltage source" annotation (Placement(
            transformation(
            origin={60,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.ComplexBlocks.Interfaces.ComplexInput V[m] annotation (Placement(
            transformation(
            origin={-60,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      plug_p.reference.gamma = gamma;
      v = V;
      annotation (
        defaultComponentName="voltageSource", Documentation(info="<html>

<p>
This model describes <em>m</em> variable current sources, with <em>m</em> complex signal inputs,
specifying the complex current by the complex RMS voltage components.
Additionally, the frequency of the current source is defined by a real signal input.
<em>m</em> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource\">single phase VariableCurrentSources</a> are used.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">SinglePhase.VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.CurrentSource\">CurrentSource</a>.
</p>
</html>"), Icon(graphics={
            Line(points={{-70,30},{-70,10}}, color={85,170,255}),
            Line(points={{-80,20},{-60,20}}, color={85,170,255}),
            Line(points={{60,20},{80,20}}, color={85,170,255}),
            Line(points={{-50,0},{50,0}},  color={85,170,255})}));
    end ReferenceVoltageSource;

    model FrequencySweepVoltageSource "Voltage source with integrated frequency sweep"
      extends Interfaces.TwoPlug;
      import Modelica.Constants.eps;
      Modelica.SIunits.Angle gamma(start=0) = plug_p.reference.gamma;
      parameter Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Frequency fStart(final min=eps, start=1) "Start sweep frequency";
      parameter Modelica.SIunits.Frequency fStop(final min=eps, start=1) "Stop sweep frequency";
      parameter Modelica.SIunits.Time startTime=0 "Start time of frequency sweep";
      parameter Modelica.SIunits.Time duration(start=1) "Duration of frequency sweep";
      parameter Modelica.SIunits.Voltage V[m](start=fill(1,m)) "RMS voltage of the source";
      parameter Modelica.SIunits.Angle phi[m]=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m) "Phase shift of the source";
      Modelica.SIunits.Frequency f = voltageSource.f "Actual frequency";
      VariableVoltageSource voltageSource(final m=m) annotation (Placement(transformation(extent={{-10,10},{10,-10}})));
      ComplexBlocks.Sources.LogFrequencySweep logFrequencySweep(
        final wMin=fStart,
        final wMax=fStop,
        final startTime=startTime,
        final duration=duration) annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
      ComplexBlocks.Sources.ComplexConstant const[m](final k=Modelica.ComplexMath.fromPolar(len=V, phi=phi)) annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
    equation
      connect(logFrequencySweep.y, voltageSource.f) annotation (Line(points={{19,-50},{6,-50},{6,-12}},   color={0,0,127}));
      connect(plug_p, voltageSource.plug_p) annotation (Line(points={{-100,0},{-10,0}}, color={85,170,255}));
      connect(voltageSource.plug_n, plug_n) annotation (Line(points={{10,0},{100,0}}, color={85,170,255}));
      connect(const.y, voltageSource.V) annotation (Line(points={{-39,-50},{-6,-50},{-6,-12}}, color={85,170,255}));
      annotation (defaultComponentName="voltageSource",Icon(graphics={
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
              smooth=Smooth.Bezier),
            Text(
              extent={{160,-100},{-160,-60}},
              textString="m=%m")}),
        Documentation(info="<html>
<p>This source provides polyphase constant RMS phase voltages <code>V</code> and phase angles <code>phi</code>,
whereas the frequency sweeps from
<code>fStart</code> to <code>fStop</code> with <code>duration</code>. The frequency sweeps such
way that on a logarithmic frequency scale, the frequency curve appears linear.</p>

<p><img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/SinglePhase/Sources/FrequencySweepSource.png\"
     alt=\"FrequencySweepSource.png\"></p>

</html>"));
    end FrequencySweepVoltageSource;

    model CurrentSource "Constant multiphase AC current"
      extends Interfaces.Source;
      import Modelica.ComplexMath.j;
      import Modelica.ComplexMath.exp;
      parameter Modelica.SIunits.Frequency f(start=1) "Frequency of the source";
      parameter Modelica.SIunits.Current I[m](start=fill(1, m))
        "RMS current of the source";
      parameter Modelica.SIunits.Angle phi[m]=-
          Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m)
        "Phase shift of the source";
    equation
      omega = 2*Modelica.Constants.pi*f;
      i = {I[k]*exp(j*phi[k]) for k in 1:m};
      annotation (
        Icon(graphics={Line(points={{0,50},{0,-50}}, color={85,170,255}),
              Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>

<p>
This model describes <em>m</em> constant current sources, specifying the complex currents by the RMS currents and the phase shifts
(defaults are
<a href=\"modelica://Modelica.Electrical.MultiPhase.Functions.symmetricOrientation\">-symmetricOrientation</a>).
<em>m</em> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.CurrentSource\">single phase CurrentSources</a> are used.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.CurrentSource\">SinglePhase.CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>
</p>
</html>"));
    end CurrentSource;

    model VariableCurrentSource "Variable multiphase AC current"
      extends Interfaces.Source;
      Modelica.Blocks.Interfaces.RealInput f annotation (Placement(
            transformation(
            origin={40,100},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={60,120})));
      Modelica.ComplexBlocks.Interfaces.ComplexInput I[m] annotation (Placement(
            transformation(
            origin={-40,100},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={-62,120})));
    equation
      omega = 2*Modelica.Constants.pi*f;
      i = I;
      annotation (defaultComponentName="currentSource",
        Icon(graphics={Line(points={{0,-50},{0,50}}, color={85,170,255}),
            Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid)}), Documentation(info="<html>

<p>
This model describes <em>m</em> variable current sources, with <em>m</em> complex signal inputs,
specifying the complex current by the complex RMS voltage components.
Additionally, the frequency of the current source is defined by a real signal input.
<em>m</em> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource\">single phase VariableCurrentSources</a> are used.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">SinglePhase.VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.CurrentSource\">CurrentSource</a>.
</p>
</html>"));
    end VariableCurrentSource;

    model ReferenceCurrentSource
      "Variable multiphase AC current with reference angle input"
      extends Electrical.QuasiStationary.MultiPhase.Interfaces.ReferenceSource;
      import Modelica.Constants.pi;
      Modelica.Blocks.Interfaces.RealInput gamma
        "Reference angle of current source" annotation (Placement(
            transformation(
            origin={40,100},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={60,120})));
      Modelica.ComplexBlocks.Interfaces.ComplexInput I[m] annotation (Placement(
            transformation(
            origin={-40,100},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={-60,120})));
    equation
      plug_p.reference.gamma = gamma;
      i = I;
      annotation (
        defaultComponentName="currentSource",
        Icon(graphics={Line(points={{0,-50},{0,50}}, color={85,170,255}),
              Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>

<p>
This model describes <em>m</em> variable current sources, with <em>m</em> complex signal inputs,
specifying the complex current by the complex RMS voltage components.
Additionally, the frequency of the current source is defined by a real signal input.
<em>m</em> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource\">single phase VariableCurrentSources</a> are used.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">SinglePhase.VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.CurrentSource\">CurrentSource</a>.
</p>
</html>"));
    end ReferenceCurrentSource;

    model FrequencySweepCurrentSource "Current source with integrated frequency sweep"
      extends Interfaces.TwoPlug;
      import Modelica.Constants.eps;
      Modelica.SIunits.Angle gamma(start=0) = plug_p.reference.gamma;
      parameter Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Frequency fStart(final min=eps, start=1) "Start sweep frequency";
      parameter Modelica.SIunits.Frequency fStop(final min=eps, start=1) "Stop sweep frequency";
      parameter Modelica.SIunits.Time startTime=0 "Start time of frequency sweep";
      parameter Modelica.SIunits.Time duration(start=1) "Duration of frequency sweep";
      parameter Modelica.SIunits.Current I[m](start=fill(1,m)) "RMS current of the source";
      parameter Modelica.SIunits.Angle phi[m]=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m) "Phase shift of the source";
      Modelica.SIunits.Frequency f=currentSource.f   "Actual frequency";
      VariableCurrentSource currentSource(final m=m) annotation (Placement(transformation(extent={{-10,10},{10,-10}})));
      ComplexBlocks.Sources.LogFrequencySweep logFrequencySweep(
        final wMin=fStart,
        final wMax=fStop,
        final startTime=startTime,
        final duration=duration) annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
      ComplexBlocks.Sources.ComplexConstant const[m](final k=Modelica.ComplexMath.fromPolar(len=I, phi=phi)) annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
    equation
      connect(logFrequencySweep.y,currentSource. f) annotation (Line(points={{19,-50},{6,-50},{6,-12}},   color={0,0,127}));
      connect(plug_p,currentSource. plug_p) annotation (Line(points={{-100,0},{-10,0}}, color={85,170,255}));
      connect(currentSource.plug_n, plug_n) annotation (Line(points={{10,0},{100,0}}, color={85,170,255}));
      connect(currentSource.I, const.y) annotation (Line(points={{-6.2,-12},{-6,-12},{-6,-50},{-39,-50}}, color={85,170,255}));
      annotation (defaultComponentName="currentSource",Icon(graphics={
            Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-50,0}}, color={85,170,255}),
            Line(points={{50,0},{90,0}}, color={85,170,255}),
            Line(points={{0,-50},{0,50}}, color={85,170,255}),
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
            Text(
              extent={{160,-100},{-160,-60}},
              textString="m=%m")}),
        Documentation(info="<html>
<p>This source provides polyphase constant RMS phase currents <code>I</code> and phase angles <code>phi</code>,
whereas the frequency sweeps from
<code>fStart</code> to <code>fStop</code> with <code>duration</code>. The frequency sweeps such
way that on a logarithmic frequency scale, the frequency curve appears linear.</p>

<p><img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/SinglePhase/Sources/FrequencySweepSource.png\"
     alt=\"FrequencySweepSource.png\"></p>

</html>"));
    end FrequencySweepCurrentSource;
    annotation (Documentation(info="<html>
<p>This package hosts sources for quasi stationary multiphase circuits.
Quasi stationary theory can be found in the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>

<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources\">SinglePhase.Sources</a>

</html>"));
  end Sources;

  package Interfaces "Interfaces for AC multiphase models"
    extends Modelica.Icons.InterfacesPackage;

    connector Plug "Quasi-static polyphase plug"
      parameter Integer m=3 "Number of phases";
      QuasiStationary.SinglePhase.Interfaces.Pin pin[m] "Pins of plug";
      annotation (Documentation(info="<html>

<p>
This multiphase plug contains a vector of <em>m</em> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">single phase pins</a>.
The <a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">positive</a> and
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">negative plug</a> are
derived from this base connector.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">Pin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">NegativePlug</a>
</p>
</html>"));
    end Plug;

    connector PositivePlug "Positive quasi-static polyphase plug"
      extends Plug;
      QuasiStationary.Types.Reference reference "Reference";
      annotation (
        Icon(graphics={Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid)}),
        Diagram(graphics={Ellipse(
              extent={{-40,40},{40,-40}},
              lineColor={85,170,255},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-100,100},{100,60}},
              lineColor={0,0,255},
              textString="%name")}),
        Documentation(info="<html>

<p>
The positive plug is based on <a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.Plug\">Plug</a>.
Additionally the reference angle is specified in the connector. The time derivative of the reference angle is the actual angular velocity of each quasi stationary voltage and current. The symbol is also designed such way to look different than the <a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">negative plug</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">Pin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.Plug\">Plug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">NegativePlug</a>
</p>
</html>"));
    end PositivePlug;

    connector NegativePlug "Negative quasi-static polyphase plug"
      extends Plug;
      QuasiStationary.Types.Reference reference;
      annotation (
        Icon(graphics={Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Diagram(graphics={Ellipse(
              extent={{-40,40},{40,-40}},
              lineColor={85,170,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-100,100},{100,60}},
              lineColor={0,0,255},
              textString="%name")}),
        Documentation(info="<html>

<p>
The negative plug is based on <a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.Plug\">Plug</a>.
Additionally the reference angle is specified in the connector. The time derivative of the reference angle is the actual angular velocity of each quasi stationary voltage and current. The symbol is also designed such way to look different than the <a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">positive plug</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">Pin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">PositivePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.NegativePin\">NegativePin</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.Plug\">Plug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">PositivePlug</a>,
</p>
</html>"));
    end NegativePlug;

    partial model TwoPlug "Two plugs with pin-adapter"
      parameter Integer m(min=1) = 3 "Number of phases";
      Modelica.SIunits.ComplexVoltage v[m] "Complex voltage";
      Modelica.SIunits.Voltage abs_v[m]=Modelica.ComplexMath.'abs'(v)
        "Magnitude of complex voltage";
      Modelica.SIunits.Angle arg_v[m]=Modelica.ComplexMath.arg(v)
        "Argument of complex voltage";
      Modelica.SIunits.ComplexCurrent i[m] "Complex current";
      Modelica.SIunits.Current abs_i[m]=Modelica.ComplexMath.'abs'(i)
        "Magnitude of complex current";
      Modelica.SIunits.Angle arg_i[m]=Modelica.ComplexMath.arg(i)
        "Argument of complex current";
      Modelica.SIunits.ActivePower P[m]={Modelica.ComplexMath.real(v[k]*
          Modelica.ComplexMath.conj(i[k])) for k in 1:m} "Active power";
      Modelica.SIunits.ActivePower P_total=sum(P) "Total active power";
      Modelica.SIunits.ReactivePower Q[m]={Modelica.ComplexMath.imag(v[k]*
          Modelica.ComplexMath.conj(i[k])) for k in 1:m} "Reactive power";
      Modelica.SIunits.ReactivePower Q_total=sum(Q) "Total reactive power";
      Modelica.SIunits.ApparentPower S[m]={Modelica.ComplexMath.'abs'(v[k]*
          Modelica.ComplexMath.conj(i[k])) for k in 1:m}
        "Magnitude of complex apparent power";
      Modelica.SIunits.ApparentPower S_total=sqrt(P_total^2 + Q_total^2)
        "Magnitude of total complex apparent power";
      Real pf[m]={cos(Modelica.ComplexMath.arg(Complex(P[k], Q[k]))) for k in 1
          :m} "Power factor";
      /*
  Real pf_total = cos(Modelica.ComplexMath.arg(Complex(P_total,Q_total)))
   "Total power factor";
  */
      Modelica.SIunits.AngularVelocity omega
        "Angular velocity of reference frame";

      PositivePlug plug_p(final m=m)
        "Positive quasi-static polyphase plug" annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      NegativePlug plug_n(final m=m)
        "Negative quasi-static polyphase plug" annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
      Basic.PlugToPins_p plugToPins_p(final m=m) annotation (Placement(
            transformation(extent={{-80,-10},{-60,10}})));
      Basic.PlugToPins_n plugToPins_n(final m=m) annotation (Placement(
            transformation(
            origin={70,0},
            extent={{-10,-10},{10,10}},
            rotation=180)));
    equation
      omega = der(plug_p.reference.gamma);
      v = plug_p.pin.v - plug_n.pin.v;
      i = plug_p.pin.i;
      connect(plug_p, plugToPins_p.plug_p) annotation (Line(points={{-100,0},{-93,
              0},{-86,0},{-72,0}}, color={85,170,255}));
      connect(plugToPins_n.plug_n, plug_n)
        annotation (Line(points={{72,0},{86,0},{100,0}}, color={85,170,255}));
      annotation (Documentation(info="<html>
<p>
This partial model uses a <a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">positive</a>
and <a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">negative plug</a> and defines the complex voltage differences as well as the complex currents (into the positive plug). A <a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_p\">positive</a> and
a <a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_n\">negative adapter</a> are used to give easy access to the single pins of both plugs. Additionally, the angular velocity of the quasi stationary system is explicitly defined as variable. This model is mainly intended to be used with graphical representation of user models.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">PositivePlug</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug\">NegativePlug</a>,
</p>
</html>"));
    end TwoPlug;

    partial model OnePort
      parameter Integer m(min=1) = 3 "Number of phases";
      Modelica.SIunits.ComplexVoltage v[m] "Complex voltage";
      Modelica.SIunits.Voltage abs_v[m]=Modelica.ComplexMath.'abs'(v)
        "Magnitude of complex voltage";
      Modelica.SIunits.Angle arg_v[m]=Modelica.ComplexMath.arg(v)
        "Argument of complex voltage";
      Modelica.SIunits.ComplexCurrent i[m] "Complex current";
      Modelica.SIunits.Current abs_i[m]=Modelica.ComplexMath.'abs'(i)
        "Magnitude of complex current";
      Modelica.SIunits.Angle arg_i[m]=Modelica.ComplexMath.arg(i)
        "Argument of complex current";
      Modelica.SIunits.ActivePower P[m]={Modelica.ComplexMath.real(v[k]*
          Modelica.ComplexMath.conj(i[k])) for k in 1:m} "Active power";
      Modelica.SIunits.ActivePower P_total=sum(P) "Total active power";
      Modelica.SIunits.ReactivePower Q[m]={Modelica.ComplexMath.imag(v[k]*
          Modelica.ComplexMath.conj(i[k])) for k in 1:m} "Reactive power";
      Modelica.SIunits.ReactivePower Q_total=sum(Q) "Total reactive power";
      Modelica.SIunits.ApparentPower S[m]={Modelica.ComplexMath.'abs'(v[k]*
          Modelica.ComplexMath.conj(i[k])) for k in 1:m}
        "Magnitude of complex apparent power";
      Modelica.SIunits.ApparentPower S_total=sqrt(P_total^2 + Q_total^2)
        "Magnitude of total complex apparent power";
      Real pf[m]={cos(Modelica.ComplexMath.arg(Complex(P[k], Q[k]))) for k in 1
          :m} "Power factor";
      /*
  Real pf_total = cos(Modelica.ComplexMath.arg(Complex(P_total,Q_total)))
    "Total power factor";
  */
      Modelica.SIunits.AngularVelocity omega
        "Angular velocity of reference frame";

      PositivePlug plug_p(final m=m)
        "Positive quasi-static polyphase plug" annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      NegativePlug plug_n(final m=m)
        "Negative quasi-static polyphase plug" annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
    equation
      Connections.branch(plug_p.reference, plug_n.reference);
      plug_p.reference.gamma = plug_n.reference.gamma;
      omega = der(plug_p.reference.gamma);
      v = plug_p.pin.v - plug_n.pin.v;
      i = plug_p.pin.i;
      plug_p.pin.i + plug_n.pin.i = fill(Complex(0), m);
    end OnePort;

    partial model AbsoluteSensor "Partial potential sensor"
      extends Modelica.Icons.RotationalSensor;
      parameter Integer m(min=1) = 3 "number of phases";
      Modelica.SIunits.AngularVelocity omega;
      PositivePlug plug_p(final m=m)
        "Positive quasi-static polyphase plug" annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
    equation
      omega = der(plug_p.reference.gamma);
      annotation (Icon(graphics={
            Line(points={{-70,0},{-94,0}}, color={85,170,255}),
            Line(points={{70,0},{80,0},{90,0},{100,0}}),
            Text(
              extent={{150,-100},{-150,-70}},
              textString="m=%m"),
            Text(
              lineColor={0,0,255},
              extent={{-150,80},{150,120}},
              textString="%name")}), Documentation(info="<html>

<p>
The absolute sensor partial model relies on the a
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug\">positive plug</a> to measure the complex potential. Additionally this model contains a proper icon and a definition of the angular velocity.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.RelativeSensor\">RelativeSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.AbsoluteSensor\">SinglePhase.Interfaces.AbsoluteSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.RelativeSensor\">SinglePhase.Interfaces.RelativeSensor</a>
</p>

</html>"));
    end AbsoluteSensor;

    partial model RelativeSensor "Partial voltage / current sensor"
      extends Modelica.Icons.RotationalSensor;
      extends TwoPlug;
      Modelica.ComplexBlocks.Interfaces.ComplexOutput y[m] annotation (
          Placement(transformation(
            origin={0,-110},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      annotation (Icon(graphics={
            Line(points={{-70,0},{-94,0}}, color={85,170,255}),
            Line(points={{70,0},{94,0}}, color={85,170,255}),
            Line(points={{0,-70},{0,-80},{0,-90},{0,-100}}, color={85,170,255}),
            Text(
              extent={{150,-100},{-150,-70}},
              textString="m=%m"),
            Text(
              lineColor={0,0,255},
              extent={{-150,80},{150,120}},
              textString="%name")}), Documentation(info="<html>
<p>
The relative sensor partial model relies on the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.TwoPlug\">TwoPlug</a> to measure the complex voltages, currents or power. Additionally this model contains a proper icon and a definition of the angular velocity.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.AbsoluteSensor\">AbsoluteSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.AbsoluteSensor\">SinglePhase.Interfaces.AbsoluteSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.RelativeSensor\">SinglePhase.Interfaces.RelativeSensor</a>
</p>

</html>"));

    end RelativeSensor;

    partial model Source "Partial voltage / current source"
      extends OnePort;
      constant Modelica.SIunits.Angle pi=Modelica.Constants.pi;
      Modelica.SIunits.Angle gamma(start=0) = plug_p.reference.gamma;
    equation
      Connections.root(plug_p.reference);
      annotation (
        Icon(graphics={Ellipse(
                  extent={{-50,50},{50,-50}},
                  lineColor={85,170,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-50,0}}, color={85,170,255}),
            Line(points={{50,0},{90,0}}, color={85,170,255}),
            Text(
              extent={{160,-100},{-160,-60}},
              textString="m=%m"),
                               Text(
                  extent={{-160,60},{160,100}},
                  textString="%name",
                  lineColor={0,0,255})}),
        Documentation(info="<html>
<p>
The source partial model relies on the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.TwoPlug\">TwoPlug</a> and contains a proper icon.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Source\">SinglePhase.Interfaces.Source</a>.
</p>
</html>"));
    end Source;

    partial model ReferenceSource
      "Partial of voltage or current source with reference input"
      extends Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.OnePort;
      import Modelica.Constants.pi;
    equation
      Connections.root(plug_p.reference);
      annotation (Icon(graphics={Ellipse(
                  extent={{-50,50},{50,-50}},
                  lineColor={85,170,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-50,0}}, color={85,170,255}),
            Line(points={{50,0},{90,0}}, color={85,170,255}),
            Text(
              extent={{160,-100},{-160,-60}},
              textString="m=%m"),
                               Text(
                  extent={{-160,60},{160,100}},
                  textString="%name",
                  lineColor={0,0,255})}), Documentation(info="<html>
<p>
The source partial model relies on the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.TwoPlug\">TwoPlug</a> and contains a proper icon.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.CurrentSource\">CurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableCurrentSource\">VariableCurrentSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Source\">SinglePhase.Interfaces.Source</a>.
</p>
</html>"));
    end ReferenceSource;
  end Interfaces;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Ellipse(
          origin={14,56},
          lineColor={0,0,255},
          extent={{-84,-126},{56,14}}),
        Ellipse(
          origin={-0,40},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          extent={{-40,-34},{-20,-14}}),
        Ellipse(
          origin={20,40},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          extent={{0,-34},{20,-14}}),
        Ellipse(
          origin={10,34},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          extent={{-20,-74},{0,-54}})}), Documentation(info="<html>
<p>This package hosts models for quasi stationary multi phase circuits.
Quasi stationary theory can be found in
[<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">Vaske1973</a>]
and other
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">references</a>.
</p>
<h4>See also</h4>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase\">SinglePhase</a>

</html>"));
end MultiPhase;
