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
        annotation (Line(points={{-20,10},{8,10}},  color={85,170,255}));
      connect(currentSensor.plug_n, plugToPin_p3.plug_p) annotation (Line(
            points={{-20,10},{-20,10},{-10,10},{-10,-30},{8,-30}},
                                                  color={85,170,255}));
      connect(currentSensor.plug_n, plugToPin_p1.plug_p) annotation (Line(
            points={{-20,10},{-20,10},{-10,10},{-10,50},{8,50}},
                                                color={85,170,255}));
      connect(plugToPin_p1.pin_p, inductor.pin_p)
        annotation (Line(points={{12,50},{30,50}},color={85,170,255}));
      connect(plugToPin_p2.pin_p, capacitor.pin_p)
        annotation (Line(points={{12,10},{30,10}},color={85,170,255}));
      connect(plugToPin_p3.pin_p, resistor.pin_p)
        annotation (Line(points={{12,-30},{30,-30}},color={85,170,255}));
      connect(inductor.pin_n, plugToPin_n1.pin_n)
        annotation (Line(points={{50,50},{68,50}}, color={85,170,255}));
      connect(capacitor.pin_n, plugToPin_n2.pin_n)
        annotation (Line(points={{50,10},{68,10}}, color={85,170,255}));
      connect(resistor.pin_n, plugToPin_n3.pin_n)
        annotation (Line(points={{50,-30},{68,-30}}, color={85,170,255}));
      connect(plugToPin_n1.plug_n, star2.plug_p) annotation (Line(points={{72,50},{90,
              50},{90,-40}},         color={85,170,255}));
      connect(plugToPin_n2.plug_n, star2.plug_p) annotation (Line(points={{72,10},{90,
              10},{90,-40}},         color={85,170,255}));
      connect(plugToPin_n3.plug_n, star2.plug_p) annotation (Line(points={{72,-30},{
              90,-30},{90,-40}},  color={85,170,255}));
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
              -40},{-80,-40}},         color={85,170,255}));
      connect(currentSensor.plug_n, plugToPin_p2.plug_p)
        annotation (Line(points={{-20,10},{8,10}},  color={85,170,255}));
      connect(currentSensor.plug_n, plugToPin_p1.plug_p) annotation (Line(
            points={{-20,10},{-10,10},{-10,80},{10,80}},
                                                     color={85,170,255}));
      connect(currentSensor.plug_n, plugToPin_p3.plug_p) annotation (Line(
            points={{-20,10},{-10,10},{-10,-60},{8,-60}},
                                                       color={85,170,255}));
      connect(currentSensor12.pin_p, plugToPin_p1.pin_p) annotation (Line(
            points={{30,72},{30,80},{14,80}}, color={85,170,255}));
      connect(currentSensor12.pin_n, capacitor.pin_p)
        annotation (Line(points={{30,52},{30,42}}, color={85,170,255}));
      connect(capacitor.pin_n, plugToPin_p2.pin_p) annotation (Line(points={{30,22},
              {30,10},{12,10}},     color={85,170,255}));
      connect(plugToPin_p2.pin_p, currentSensor23.pin_p)
        annotation (Line(points={{12,10},{30,10},{30,2}}, color={85,170,255}));
      connect(currentSensor23.pin_n, inductor.pin_p)
        annotation (Line(points={{30,-18},{30,-28}}, color={85,170,255}));
      connect(inductor.pin_n, plugToPin_p3.pin_p) annotation (Line(points={{30,-48},
              {30,-60},{12,-60}},      color={85,170,255}));
      connect(plugToPin_p1.pin_p, resistor.pin_n) annotation (Line(points={{14,80},{
              60,80},{60,40}},      color={85,170,255}));
      connect(resistor.pin_p, currentSensor31.pin_n)
        annotation (Line(points={{60,20},{60,0}}, color={85,170,255}));
      connect(currentSensor31.pin_p, plugToPin_p3.pin_p) annotation (Line(
            points={{60,-20},{60,-60},{12,-60}}, color={85,170,255}));
      connect(currentSensor.y, complexToPolar.u) annotation (Line(
          points={{-30,-1},{-30,-8}},
          color={85,170,255}));
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
      annotation (Icon(graphics={Text(
                  extent={{-150,60},{150,120}},
                  textString="%name",
                  lineColor={0,0,255}),Line(
                  points={{80,0},{0,0}},
                  color={85,170,255},
                  thickness=0.5),Line(
                  points={{0,0},{-39,68}},
                  color={85,170,255},
                  thickness=0.5),Line(
                  points={{0,0},{-38,-69}},
                  color={85,170,255},
                  thickness=0.5),Text(
                  extent={{-100,-110},{100,-70}},
                  lineColor={0,0,0},
                  textString="m=%m"),Line(points={{-90,0},{-40,0}}, color={85,
              170,255}),Line(points={{80,0},{90,0}}, color={0,0,255})}),
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
      annotation (Icon(graphics={Text(
                  extent={{-150,60},{150,120}},
                  lineColor={0,0,255},
                  textString="%name"),Line(
                  points={{-40,68},{-40,-70},{79,0},{-40,68},{-40,67}},
                  color={85,170,255},
                  thickness=0.5),Text(
                  extent={{-100,-110},{100,-70}},
                  lineColor={0,0,0},
                  textString="m=%m"),Line(points={{-90,0},{-40,0}}, color={85,
              170,255}),Line(points={{80,0},{90,0}}, color={85,170,255})}),
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
      import Modelica;
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
          points={{72,0},{100,0}},
          color={85,170,255}));
      annotation (
        Icon(graphics={Text(
                  extent={{-150,60},{150,120}},
                  textString="%name",
                  lineColor={0,0,255}),Line(
                  points={{86,4},{6,4}},
                  color={85,170,255},
                  thickness=0.5),Line(
                  points={{6,4},{-33,72}},
                  color={85,170,255},
                  thickness=0.5),Line(
                  points={{6,4},{-32,-65}},
                  color={85,170,255},
                  thickness=0.5),Text(
                  extent={{-100,-110},{100,-70}},
                  lineColor={0,0,0},
                  textString="m=%m"),Line(points={{-90,0},{-40,0}}, color={85,
              170,255}),Line(points={{80,0},{90,0}}, color={0,0,255}),Line(
                  points={{-6,-4},{-45,64}},
                  color={85,170,255},
                  thickness=0.5),Line(
                  points={{74,-4},{-6,-4}},
                  color={85,170,255},
                  thickness=0.5),Line(
                  points={{-6,-4},{-44,-73}},
                  color={85,170,255},
                  thickness=0.5)}),
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
      import Modelica;
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
      annotation (Icon(graphics={Text(
                  extent={{-150,60},{150,120}},
                  lineColor={0,0,255},
                  textString="%name"),Line(
                  points={{-44,62},{-44,-76},{75,-6},{-44,62},{-44,61}},
                  color={85,170,255},
                  thickness=0.5),Text(
                  extent={{-100,-110},{100,-70}},
                  lineColor={0,0,0},
                  textString="m=%m"),Line(points={{-90,0},{-44,0}}, color={85,
              170,255}),Line(points={{80,0},{90,0}}, color={85,170,255}),Line(
                  points={{-36,74},{-36,-64},{83,6},{-36,74},{-36,73}},
                  color={85,170,255},
                  thickness=0.5)}), Documentation(info="<html>
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
          points={{-100,0},{-60,0}},
          color={85,170,255}));
      connect(multiStar.starpoints, resistor.plug_p) annotation (Line(
          points={{-40,0},{-10,0}},
          color={85,170,255}));
      connect(resistor.plug_n, star.plug_p) annotation (Line(
          points={{10,0},{40,0}},
          color={85,170,255}));
      connect(star.pin_n, pin) annotation (Line(
          points={{60,0},{100,0}},
          color={85,170,255}));
      annotation (
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
                  rotation=90)}),
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
      annotation (Icon(graphics={Rectangle(
                  extent={{-20,20},{40,-20}},
                  lineColor={0,0,0},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid),Ellipse(
                  extent={{-40,20},{0,-20}},
                  lineColor={0,0,0},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-100,100},{100,40}},
                  textString="%name",
                  lineColor={0,0,255}),Text(
                  extent={{-100,-60},{100,-100}},
                  lineColor={0,0,0},
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
      annotation (Icon(graphics={Rectangle(
                  extent={{-20,20},{40,-20}},
                  lineColor={0,0,0},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid),Ellipse(
                  extent={{-40,20},{0,-20}},
                  lineColor={0,0,0},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-100,100},{100,40}},
                  textString="%name",
                  lineColor={0,0,255}),Text(
                  extent={{-100,-60},{100,-100}},
                  lineColor={0,0,0},
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
      annotation (Icon(graphics={
            Rectangle(
              extent={{-20,20},{40,-20}},
              lineColor={0,0,0},
              fillColor={170,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-40,20},{0,-20}},
              lineColor={0,0,0},
              fillColor={170,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-100,100},{100,40}},
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
      annotation (Icon(graphics={
            Rectangle(
              extent={{-20,20},{40,-20}},
              lineColor={0,0,0},
              fillColor={170,255,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-40,20},{0,-20}},
              lineColor={0,0,0},
              fillColor={170,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-100,100},{100,40}},
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
      annotation (Icon(graphics={Text(
                  extent={{100,60},{-100,100}},
                  textString="%name",
                  lineColor={0,0,255}),Line(points={{60,0},{90,0}}, color={85,
              170,255}),Line(points={{-90,0},{-60,0}}, color={85,170,255}),
              Rectangle(
                  extent={{-70,30},{70,-30}},
                  lineColor={85,170,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{100,-80},{-100,-40}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid,
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
      annotation (Icon(graphics={Text(
                  extent={{100,60},{-100,100}},
                  textString="%name",
                  lineColor={0,0,255}),Line(points={{60,0},{90,0}}, color={85,
              170,255}),Line(points={{-90,0},{-60,0}}, color={85,170,255}),
              Rectangle(
                  extent={{-70,30},{70,-30}},
                  lineColor={85,170,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{100,-80},{-100,-40}},
                  lineColor={0,0,0},
                  textString="m=%m")}), Documentation(info="<html>
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
                  extent={{100,60},{-100,100}},
                  textString="%name",
                  lineColor={0,0,255}),Line(
                  points={{-14,28},{-14,-28}},
                  color={85,170,255},
                  thickness=0.5),Line(
                  points={{14,28},{14,-28}},
                  color={85,170,255},
                  thickness=0.5),Line(points={{-90,0},{-14,0}}, color={85,170,
              255}),Line(points={{14,0},{90,0}}, color={85,170,255}),Text(
                  extent={{100,-80},{-100,-40}},
                  lineColor={0,0,0},
                  textString="m=%m")}), Documentation(info="<html>
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
      annotation (Icon(graphics={Text(
                  extent={{100,60},{-100,100}},
                  textString="%name",
                  lineColor={0,0,255}),Ellipse(extent={{-60,-15},{-30,15}},
              lineColor={85,170,255}),Ellipse(extent={{-30,-15},{0,15}},
              lineColor={85,170,255}),Ellipse(extent={{0,-15},{30,15}},
              lineColor={85,170,255}),Ellipse(extent={{30,-15},{60,15}},
              lineColor={85,170,255}),Rectangle(
                  extent={{-60,-30},{60,0}},
                  lineColor={255,255,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{60,0},{90,0}},
              color={85,170,255}),Line(points={{-90,0},{-60,0}}, color={85,170,
              255}),Text(
                  extent={{100,-80},{-100,-40}},
                  lineColor={0,0,0},
                  textString="m=%m")}), Documentation(info="<html>
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

    model Impedance "Multiphase linear impedance"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.ComplexImpedance Z_ref[m](re(start=fill(1,m)),im(start=fill(0,m)))
        "Complex impedances R_ref + j*X_ref";
      parameter Modelica.SIunits.Temperature T_ref[m]=fill(293.15, m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref[m]=
          zeros(m)
        "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, T=T_ref);
      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Impedance impedance[m](
        final Z_ref=Z_ref,
        final T_ref=T_ref,
        final alpha_ref=alpha_ref,
        final useHeatPort=fill(useHeatPort,m),
        final T=T_ref) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation

      connect(plugToPins_p.pin_p, impedance.pin_p) annotation (Line(points={{-68,0},{-53.5,0},{-39,0},{-10,0}}, color={85,170,255}));
      connect(impedance.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,0},{39,0},{68,0}}, color={85,170,255}));
      connect(impedance.heatPort, heatPort) annotation (Line(points={{0,-10},{0,-10},{0,-100}}, color={191,0,0}));
      annotation (Icon(graphics={Text(
                  extent={{100,60},{-100,100}},
                  textString="%name",
                  lineColor={0,0,255}),
                    Text(
                  extent={{100,-80},{-100,-40}},
                  lineColor={0,0,0},
                  textString="m=%m"),  Line(points={{60,0},{90,0}}, color={85,
              170,255}),Line(points={{-90,0},{-60,0}}, color={85,170,255}),
              Rectangle(
                  extent={{-70,30},{70,-30}},
                  lineColor={85,170,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                                     Polygon(
                  points={{-70,-30},{70,30},{70,-30},{-70,-30}},
                  lineColor={85,170,255},
                  fillColor={85,170,255},
                  fillPattern=FillPattern.Solid)}),
                                        Documentation(info="<html>
<p>
The linear impedance connects the complex voltages <code><u>v</u></code> with the complex
currents <code><u>i</u></code> by <code><u>v</u> = <u>Z</u>*<u>i</u></code>,
using <code>m</code> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Impedance\">single phase impedances</a>. The resistive
components are modeled temperature dependent, so the real parts <code>R = real(<u>Z</u>)</code>
are determined from
the actual operating temperature and the reference input resistances <code>real(<u>Z</u>_ref)</code>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductance\">Inductance</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Resistor\">Resistor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Conductor\">Conductor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.Capacitor\">Capacitor</a>,
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
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref[m]=
          zeros(m)
        "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, T=T_ref);
      Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Admittance admittance[m](
        final Y_ref=Y_ref,
        final T_ref=T_ref,
        final alpha_ref=alpha_ref,
        final useHeatPort=fill(useHeatPort,m),
        final T=T) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

    equation
      connect(plugToPins_p.pin_p, admittance.pin_p) annotation (Line(points={{-68,0},{-53.5,0},{-39,0},{-10,0}}, color={85,170,255}));
      connect(admittance.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,0},{39,0},{68,0}}, color={85,170,255}));
      connect(admittance.heatPort, heatPort) annotation (Line(points={{0,-10},{0,-10},{0,-100}}, color={191,0,0}));
      annotation (Icon(graphics={Text(
                  extent={{100,60},{-100,100}},
                  textString="%name",
                  lineColor={0,0,255}),
                    Text(
                  extent={{100,-80},{-100,-40}},
                  lineColor={0,0,0},
                  textString="m=%m"),
                    Text(
                  extent={{100,-80},{-100,-40}},
                  lineColor={0,0,0},
                  textString="m=%m"),  Line(points={{60,0},{90,0}}, color={85,
              170,255}),Line(points={{-90,0},{-60,0}}, color={85,170,255}),
              Rectangle(
                  extent={{-70,30},{70,-30}},
                  lineColor={85,170,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                                     Polygon(
                  points={{-70,-30},{70,30},{70,-30},{-70,-30}},
                  lineColor={85,170,255},
                  fillColor={85,170,255},
                  fillPattern=FillPattern.Solid)}),
                                        Documentation(info="<html>
<p>
The linear admittance connects the complex voltages <code><u>v</u></code> with the complex
currents <code><u>i</u></code> by <code><u>i</u>*<u>Y</u> = <u>v</u></code>,
using <code>m</code> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.Inductor\">single phase admittances</a>. The resistive
components are modeled temperature dependent, so the real parts <code>G = real(<u>Y</u>)</code>
are determined from
the actual operating temperature and the reference input conductances <code>real(<u>Y</u>_ref)</code>.
</p>

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
            origin={0,110},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      QuasiStationary.SinglePhase.Basic.VariableResistor variableResistor[m](
        final T_ref=T_ref,
        final alpha_ref=alpha_ref,
        each final useHeatPort=useHeatPort,
        final T=T) annotation (Placement(transformation(extent={{-10,-10},{10,
                10}})));
    equation

      connect(variableResistor.pin_p, plugToPins_p.pin_p) annotation (Line(
            points={{-10,0},{-24.5,0},{-24.5,0},{-39,0},{-39,0},{-68,0}}, color=
             {85,170,255}));
      connect(variableResistor.pin_n, plugToPins_n.pin_n) annotation (Line(
            points={{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
      connect(variableResistor.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-10},{0,-100}},
          color={191,0,0}));
      connect(R_ref, variableResistor.R_ref) annotation (Line(
          points={{0,110},{0,11}},
          color={0,0,127}));
      annotation (
        Icon(graphics={Text(
                  extent={{100,-80},{-100,-40}},
                  textString="%name",
                  lineColor={0,0,255}),Line(points={{60,0},{90,0}}, color={85,
              170,255}),Line(points={{-90,0},{-60,0}}, color={85,170,255}),
              Rectangle(
                  extent={{-70,30},{70,-30}},
                  lineColor={85,170,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(
                  points={{0,90},{0,30}},
                  color={85,170,255}),Text(
                  extent={{100,40},{-100,80}},
                  lineColor={0,0,0},
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
            origin={0,110},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      QuasiStationary.SinglePhase.Basic.VariableConductor variableResistor[m](
        final T_ref=T_ref,
        final alpha_ref=alpha_ref,
        each final useHeatPort=useHeatPort,
        final T=T) annotation (Placement(transformation(extent={{-10,-10},{10,
                10}})));
    equation
      connect(variableResistor.pin_p, plugToPins_p.pin_p) annotation (Line(
            points={{-10,0},{-24.5,0},{-24.5,0},{-39,0},{-39,0},{-68,0}}, color=
             {85,170,255}));
      connect(variableResistor.pin_n, plugToPins_n.pin_n) annotation (Line(
            points={{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
      connect(variableResistor.heatPort, heatPort) annotation (Line(points={{0,
              -10},{0,-32.5},{0,-32.5},{0,-55},{0,-55},{0,-100}}, color={191,0,
              0}));
      connect(G_ref, variableResistor.G_ref) annotation (Line(points={{0,110},{
              0,85.25},{0,60.5},{0,11}}, color={0,0,127}));
      annotation (
        Icon(graphics={Text(
                  extent={{100,-80},{-100,-40}},
                  textString="%name",
                  lineColor={0,0,255}),Line(points={{60,0},{90,0}}, color={85,
              170,255}),Line(points={{-90,0},{-60,0}}, color={85,170,255}),
              Rectangle(
                  extent={{-70,30},{70,-30}},
                  lineColor={85,170,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(
                  points={{0,90},{0,30}},
                  color={85,170,255}),Text(
                  extent={{100,40},{-100,80}},
                  lineColor={0,0,0},
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
            origin={0,110},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      QuasiStationary.SinglePhase.Basic.VariableCapacitor variableCapacitor[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(variableCapacitor.pin_p, plugToPins_p.pin_p) annotation (Line(
            points={{-10,0},{-24.5,0},{-24.5,0},{-39,0},{-39,0},{-68,0}}, color=
             {85,170,255}));
      connect(variableCapacitor.pin_n, plugToPins_n.pin_n) annotation (Line(
            points={{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
      connect(C, variableCapacitor.C) annotation (Line(
          points={{0,110},{0,11}},
          color={0,0,127}));
      annotation (
        Icon(graphics={Text(
                  extent={{100,-80},{-100,-40}},
                  textString="%name",
                  lineColor={0,0,255}),Line(
                  points={{-14,28},{-14,-28}},
                  color={85,170,255},
                  thickness=0.5),Line(
                  points={{14,28},{14,-28}},
                  color={85,170,255},
                  thickness=0.5),Line(points={{-90,0},{-14,0}}, color={85,170,
              255}),Line(points={{14,0},{90,0}}, color={85,170,255}),Line(
              points={{0,90},{0,30}}, color={85,170,255}),Text(
                  extent={{100,40},{-100,80}},
                  lineColor={0,0,0},
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
            origin={0,110},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      QuasiStationary.SinglePhase.Basic.VariableInductor variableInductor[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(variableInductor.pin_p, plugToPins_p.pin_p) annotation (Line(
            points={{-10,0},{-24.5,0},{-24.5,0},{-39,0},{-39,0},{-68,0}}, color=
             {85,170,255}));
      connect(variableInductor.pin_n, plugToPins_n.pin_n) annotation (Line(
            points={{10,0},{39,0},{39,0},{68,0}}, color={85,170,255}));
      connect(variableInductor.L, L) annotation (Line(points={{0,10.8},{0,35.6},
              {0,60.4},{0,110}}, color={0,0,127}));
      annotation (
        Icon(graphics={Text(
                  extent={{100,-80},{-100,-40}},
                  textString="%name",
                  lineColor={0,0,255}),Ellipse(extent={{-60,-15},{-30,15}},
              lineColor={85,170,255}),Ellipse(extent={{-30,-15},{0,15}},
              lineColor={85,170,255}),Ellipse(extent={{0,-15},{30,15}},
              lineColor={85,170,255}),Ellipse(extent={{30,-15},{60,15}},
              lineColor={85,170,255}),Rectangle(
                  extent={{-60,-30},{60,0}},
                  lineColor={255,255,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{60,0},{90,0}},
              color={85,170,255}),Line(points={{-90,0},{-60,0}}, color={85,170,
              255}),Line(points={{0,90},{0,8}}, color={85,170,255}),Text(
                  extent={{100,40},{-100,80}},
                  lineColor={0,0,0},
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
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref[m]=
          zeros(m)
        "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, T=T_ref);
      ComplexBlocks.Interfaces.ComplexInput Z_ref[m]
        "Variable complex impedances" annotation (Placement(transformation(
            origin={0,110},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      SinglePhase.Basic.VariableImpedance variableImpedance[m](
        final T_ref=T_ref,
        final alpha_ref=alpha_ref,
        each final useHeatPort=useHeatPort,
        final T=T) annotation (Placement(transformation(extent={{-10,-10},{10,
                10}})));
    equation

      connect(variableImpedance.pin_p, plugToPins_p.pin_p) annotation (Line(
            points={{-10,0},{-24.5,0},{-39,0},{-68,0}}, color={85,170,255}));
      connect(variableImpedance.pin_n, plugToPins_n.pin_n)
        annotation (Line(points={{10,0},{39,0},{68,0}}, color={85,170,255}));
      connect(variableImpedance.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}},
          color={191,0,0}));
      connect(variableImpedance.Z_ref, Z_ref) annotation (Line(
          points={{0,11},{0,110}},
          color={85,170,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Text(
                  extent={{100,-80},{-100,-40}},
                  textString="%name",
                  lineColor={0,0,255}),Line(points={{60,0},{90,0}}, color={85,
              170,255}),Line(points={{-90,0},{-60,0}}, color={85,170,255}),
              Rectangle(
                  extent={{-70,30},{70,-30}},
                  lineColor={85,170,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(
                  points={{0,90},{0,30}},
                  color={85,170,255}),Text(
                  extent={{100,40},{-100,80}},
                  lineColor={0,0,0},
                  textString="m=%m"),Polygon(
                  points={{-70,-30},{70,30},{70,-30},{-70,-30}},
                  lineColor={85,170,255},
                  fillColor={85,170,255},
                  fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
The linear impedances connect the complex voltages <code><u>v</u></code> with the complex
currents <code><u>i</u></code> by <code><u>i</u>*Z = <u>v</u></code>,
using <code>m</code>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableImpedance\">
single phase variable impedance</a>.
The impedances <code>Z_ref</code> are given as complex input signals, representing the
resistive and reactive components of the input impedances. The resistive
components are modeled temperature dependent, so the real parts <code>R = real(<u>Z</u>)</code>
are determined from
the actual operating temperature and the reference input resistances <code>real(<u>Z</u>_ref)</code>.
</p>

<p>
The impedance model also has <code>m</code> optional
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
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableInductor\">Variable inductor</a>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Basic.VariableAdmittance\">Variable admittance</a>
</p>
</html>"));
    end VariableImpedance;

    model VariableAdmittance "Multiphase variable admittance"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Temperature T_ref[m]=fill(293.15, m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha_ref[m]=
          zeros(m)
        "Temperature coefficient of resistance (R_actual = R_ref*(1 + alpha_ref*(heatPort.T - T_ref))";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, T=T_ref);
      ComplexBlocks.Interfaces.ComplexInput Y_ref[m]
        "Variable complex admittances" annotation (Placement(transformation(
            origin={0,110},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      SinglePhase.Basic.VariableAdmittance variableImpedance[m](
        final T_ref=T_ref,
        final alpha_ref=alpha_ref,
        each final useHeatPort=useHeatPort,
        final T=T) annotation (Placement(transformation(extent={{-10,-10},{10,
                10}})));
    equation

      connect(variableImpedance.pin_p, plugToPins_p.pin_p) annotation (Line(
            points={{-10,0},{-24.5,0},{-39,0},{-68,0}}, color={85,170,255}));
      connect(variableImpedance.pin_n, plugToPins_n.pin_n)
        annotation (Line(points={{10,0},{39,0},{68,0}}, color={85,170,255}));
      connect(variableImpedance.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}},
          color={191,0,0}));
      connect(Y_ref, variableImpedance.Y_ref) annotation (Line(
          points={{0,110},{0,61},{0,61},{0,11}},
          color={85,170,255}));
      annotation (
        Icon(graphics={Text(
                  extent={{100,-80},{-100,-40}},
                  textString="%name",
                  lineColor={0,0,255}),Line(points={{60,0},{90,0}}, color={85,
              170,255}),Line(points={{-90,0},{-60,0}}, color={85,170,255}),
              Rectangle(
                  extent={{-70,30},{70,-30}},
                  lineColor={85,170,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(
                  points={{0,90},{0,30}},
                  color={85,170,255}),Text(
                  extent={{100,40},{-100,80}},
                  lineColor={0,0,0},
                  textString="m=%m"),Polygon(
                  points={{-70,-30},{70,30},{70,-30},{-70,-30}},
                  lineColor={85,170,255},
                  fillColor={85,170,255},
                  fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
The linear admittances connect the complex voltages <code><u>v</u></code> with the complex
currents <code><u>i</u></code> by <code><u>v</u>*Z = <u>i</u></code>,
using <code>m</code>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Basic.VariableAdmittance\">
single phase variable admittances</a>.
The admittances <code>Y_ref</code> are given as complex input signals, representing the
resistive and reactive components of the input admittance. The resistive
components are modeled temperature dependent, so the real parts <code>G = real(<u>Y</u>)</code>
are determined from
the actual operating temperature and the reference input conductances <code>real(<u>Y</u>_ref)</code>.
</p>

<p>
The admittance model also has <code>m</code> optional
<a href=\"modelica://Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort\">conditional heat ports</a>.
A linear temperature dependency of the conductances is also taken into account.
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
            lineColor={0,0,255},
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
                  extent={{-60,60},{60,-60}},
                  lineColor={85,170,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{-90,0},{-41,0}},
              color={85,170,255}),Line(points={{91,0},{40,0}}, color={85,170,
              255}),Text(
                  extent={{-100,100},{100,70}},
                  textString="%name",
                  lineColor={0,0,255})}), Documentation(info="<html>
<p>
This model describes <i>m</i> simple idle branches considering the complex currents <i><u>i</u></i> = 0;
it uses <i>m</i> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.Idle\">single phase idle branches</a>.
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
                  extent={{-60,60},{60,-60}},
                  lineColor={85,170,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-100,100},{100,70}},
                  textString="%name",
                  lineColor={0,0,255}),Line(points={{91,0},{-90,0}}, color={85,
              170,255})}), Documentation(info="<html>
<p>
This model describes <i>m</i> simple short branches considering the complex voltages <i><u>v</u></i> = 0;
it uses <i>m</i> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.Short\">single phase short branches</a>.
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
            fill(1.E-5, m)) "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start=
            fill(1.E-5, m)) "Opened switch conductance";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, final T=fill(293.15, m));
      Modelica.Blocks.Interfaces.BooleanInput control[m]
        "true => p--n2 connected, false => p--n1 connected" annotation (
          Placement(transformation(
            origin={0,80},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug
        plug_p(final m=m) annotation (Placement(transformation(extent={{-110,-10},
                {-90,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug
        plug_n2(final m=m) annotation (Placement(transformation(extent={{90,-10},
                {110,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug
        plug_n1(final m=m) annotation (Placement(transformation(extent={{90,40},
                {110,60}})));
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
            origin={80,50},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_n
        plugToPins_n2(final m=m) annotation (Placement(transformation(
            origin={80,0},
            extent={{-10,-10},{10,10}},
            rotation=180)));
    equation
      connect(control, idealCommutingSwitch.control)
        annotation (Line(points={{0,80},{0,8}}, color={255,0,255}));
      connect(idealCommutingSwitch.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}},
          color={191,0,0}));
      connect(plugToPins_n1.plug_n, plug_n1) annotation (Line(
          points={{82,50},{100,50}},
          color={85,170,255}));
      connect(plugToPins_n2.plug_n, plug_n2) annotation (Line(
          points={{82,0},{90,0},{90,0},{100,0}},
          color={85,170,255}));
      connect(plugToPins_n2.pin_n, idealCommutingSwitch.n2) annotation (Line(
          points={{78,0},{44,0},{44,0},{10,0}},
          color={85,170,255}));
      connect(idealCommutingSwitch.n1, plugToPins_n1.pin_n) annotation (Line(
          points={{10,5},{10,50},{78,50}},
          color={85,170,255}));
      connect(plugToPins_p.plug_p, plug_p) annotation (Line(
          points={{-82,0},{-100,0}},
          color={85,170,255}));
      connect(idealCommutingSwitch.p, plugToPins_p.pin_p) annotation (Line(
          points={{-10,0},{-78,0}},
          color={85,170,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-150,-40},{150,-100}},
                  textString="%name",
                  lineColor={0,0,255}),Text(
                  extent={{-100,100},{-20,60}},
                  lineColor={0,0,0},
                  textString="m="),Text(
                  extent={{20,100},{100,60}},
                  lineColor={0,0,0},
                  textString="%m"),Ellipse(extent={{-44,4},{-36,-4}}, lineColor=
               {85,170,255}),Line(points={{-90,0},{-44,0}}, color={85,170,255}),
              Line(points={{-37,2},{40,50}}, color={85,170,255}),Line(points={{
              40,50},{90,50}}, color={85,170,255}),Line(points={{0,90},{0,25}},
              color={85,170,255}),Line(points={{40,0},{90,0}}, color={85,170,
              255})}), Documentation(info="<html>
<p>
Contains m singlephase ideal commuting switches (Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.IdealCommutingSwitch).
</p>
<p>
<b>Use with care:</b>
This switch is only intended to be used for structural changes, not fast switching sequences, due to the quasistationary formulation.
</p>
</html>"));
    end IdealCommutingSwitch;

    model IdealIntermediateSwitch "Multiphase ideal intermediate switch"
      parameter Integer m(final min=1) = 3 "Number of phases";
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m), start=
            fill(1.E-5, m)) "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start=
            fill(1.E-5, m)) "Opened switch conductance";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, final T=fill(293.15, m));
      Modelica.Blocks.Interfaces.BooleanInput control[m]
        "true => p1--n2, p2--n1 connected, otherwise p1--n1, p2--n2 connected"
        annotation (Placement(transformation(
            origin={0,80},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug
        plug_p1(final m=m) annotation (Placement(transformation(extent={{-110,
                40},{-90,60}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.PositivePlug
        plug_p2(final m=m) annotation (Placement(transformation(extent={{-110,-10},
                {-90,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug
        plug_n2(final m=m) annotation (Placement(transformation(extent={{90,-10},
                {110,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.NegativePlug
        plug_n1(final m=m) annotation (Placement(transformation(extent={{90,40},
                {110,60}})));
      Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.IdealIntermediateSwitch
        idealIntermediateSwitch[m](
        final Ron=Ron,
        final Goff=Goff,
        each final useHeatPort=useHeatPort) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_p
        plugToPins_p1(final m=m) annotation (Placement(transformation(extent={{
                -90,40},{-70,60}})));
      Modelica.Electrical.QuasiStationary.MultiPhase.Basic.PlugToPins_n
        plugToPins_n1(final m=m) annotation (Placement(transformation(
            origin={80,50},
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
        annotation (Line(points={{0,80},{0,8}}, color={255,0,255}));
      connect(idealIntermediateSwitch.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}},
          color={191,0,0}));
      connect(plug_p1, plugToPins_p1.plug_p) annotation (Line(
          points={{-100,50},{-92,50},{-92,50},{-82,50}},
          color={85,170,255}));
      connect(plug_p2, plugToPins_p2.plug_p) annotation (Line(
          points={{-100,0},{-82,0}},
          color={85,170,255}));
      connect(plugToPins_n1.plug_n, plug_n1) annotation (Line(
          points={{82,50},{100,50}},
          color={85,170,255}));
      connect(plugToPins_n2.plug_n, plug_n2) annotation (Line(
          points={{82,0},{90,0},{90,0},{100,0}},
          color={85,170,255}));
      connect(idealIntermediateSwitch.p2, plugToPins_p2.pin_p) annotation (Line(
          points={{-10,0},{-78,0}},
          color={85,170,255}));
      connect(idealIntermediateSwitch.n2, plugToPins_n2.pin_n) annotation (Line(
          points={{10,0},{44,0},{44,0},{78,0}},
          color={85,170,255}));
      connect(idealIntermediateSwitch.n1, plugToPins_n1.pin_n) annotation (Line(
          points={{10,5},{10,50},{78,50}},
          color={85,170,255}));
      connect(idealIntermediateSwitch.p1, plugToPins_p1.pin_p) annotation (Line(
          points={{-10,5},{-10,50},{-78,50}},
          color={85,170,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-150,-40},{150,-100}},
                  textString="%name",
                  lineColor={0,0,255}),Text(
                  extent={{-100,100},{-20,60}},
                  lineColor={0,0,0},
                  textString="m="),Text(
                  extent={{20,100},{100,60}},
                  lineColor={0,0,0},
                  textString="%m"),Ellipse(extent={{-4,30},{4,22}}, lineColor={
              85,170,255}),Line(points={{-90,0},{-40,0}}, color={85,170,255}),
              Line(points={{-90,50},{-40,50}}, color={85,170,255}),Line(points=
              {{-40,0},{40,50}}, color={85,170,255}),Line(points={{-40,50},{40,
              0}}, color={85,170,255}),Line(points={{40,50},{90,50}}, color={85,
              170,255}),Line(points={{0,90},{0,25}}, color={85,170,255}),Line(
              points={{40,0},{90,0}}, color={85,170,255})}), Documentation(info=
             "<html>
<p>
Contains m ideal intermediate switches (Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.IdealIntermediateSwitch).
</p>
<p>
<b>Use with care:</b>
This switch is only intended to be used for structural changes, not fast switching sequences, due to the quasistationary formulation.
</p>
</html>"));
    end IdealIntermediateSwitch;

    model IdealOpeningSwitch "Multiphase ideal opener"
      extends Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m), start=
            fill(1.E-5, m)) "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start=
            fill(1.E-5, m)) "Opened switch conductance";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, final T=fill(293.15, m));
      Modelica.Blocks.Interfaces.BooleanInput control[m]
        "true => switch open, false => p--n connected" annotation (Placement(
            transformation(
            origin={0,70},
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
        annotation (Line(points={{0,70},{0,7}}, color={255,0,255}));
      connect(idealOpeningSwitch.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}},
          color={191,0,0}));
      connect(idealOpeningSwitch.pin_n, plugToPins_n.pin_n) annotation (Line(
          points={{10,0},{39,0},{39,0},{68,0}},
          color={85,170,255}));
      connect(plugToPins_p.pin_p, idealOpeningSwitch.pin_p) annotation (Line(
          points={{-68,0},{-10,0}},
          color={85,170,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-150,-40},{150,-100}},
                  textString="%name",
                  lineColor={0,0,255}),Line(points={{-90,0},{-44,0}}, color={85,
              170,255}),Ellipse(extent={{-44,4},{-36,-4}}, lineColor={85,170,
              255}),Line(points={{-37,2},{40,50}}, color={85,170,255}),Line(
              points={{0,88},{0,26}}, color={85,170,255}),Line(points={{40,0},{
              90,0}}, color={85,170,255}),Text(
                  extent={{-100,100},{-20,60}},
                  lineColor={0,0,0},
                  textString="m="),Text(
                  extent={{20,100},{100,60}},
                  lineColor={0,0,0},
                  textString="%m"),Line(points={{40,20},{40,0}}, color={85,170,
              255})}), Documentation(info="<html>
<p>
Contains m ideal opening switches (Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.IdealOpeningSwitch).
</p>
<p>
<b>Use with care:</b>
This switch is only intended to be used for structural changes, not fast switching sequences, due to the quasistationary formulation.
</p>
</html>"));
    end IdealOpeningSwitch;

    model IdealClosingSwitch "Multiphase ideal closer"
      extends Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m), start=
            fill(1.E-5, m)) "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start=
            fill(1.E-5, m)) "Opened switch conductance";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, final T=fill(293.15, m));
      Modelica.Blocks.Interfaces.BooleanInput control[m]
        "true => p--n connected, false => switch open" annotation (Placement(
            transformation(
            origin={0,70},
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
        annotation (Line(points={{0,70},{0,7}}, color={255,0,255}));
      connect(idealClosingSwitch.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}},
          color={191,0,0}));
      connect(idealClosingSwitch.pin_p, plugToPins_p.pin_p) annotation (Line(
          points={{-10,0},{-68,0}},
          color={85,170,255}));
      connect(idealClosingSwitch.pin_n, plugToPins_n.pin_n) annotation (Line(
          points={{10,0},{39,0},{39,0},{68,0}},
          color={85,170,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-150,-40},{150,-100}},
                  textString="%name",
                  lineColor={0,0,255}),Line(points={{-90,0},{-44,0}}, color={85,
              170,255}),Ellipse(extent={{-44,4},{-36,-4}}, lineColor={85,170,
              255}),Line(points={{-37,2},{40,50}}, color={85,170,255}),Line(
              points={{0,88},{0,26}}, color={85,170,255}),Line(points={{40,0},{
              90,0}}, color={85,170,255}),Text(
                  extent={{-100,100},{-20,60}},
                  lineColor={0,0,0},
                  textString="m="),Text(
                  extent={{20,100},{100,60}},
                  lineColor={0,0,0},
                  textString="%m")}), Documentation(info="<html>
<p>
Contains m ideal closing switches (Modelica.Electrical.QuasiStationary.SinglePhase.Ideal.IdealClosingSwitch).
</p>
<p>
<b>Use with care:</b>
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

  package Blocks "Blocks for quasi stationary multi phase systems"
    extends Modelica.Icons.Package;
    block QuasiRMS
      import Modelica;
      extends Modelica.Blocks.Interfaces.SO;
      parameter Integer m(min=2) = 3 "Number of phases";
      Modelica.ComplexBlocks.Interfaces.ComplexInput u[m]
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    equation
      y = Modelica.Electrical.QuasiStationary.MultiPhase.Functions.quasiRMS(u);

      annotation (Documentation(info="<html>
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
      extends Modelica.ComplexBlocks.Interfaces.ComplexMIMO(final nin=m,final nout=m);
      parameter Integer m=3 "Number of phases";
    protected
      final parameter Complex sTM[m, m]=
        Modelica.Electrical.MultiPhase.Functions.symmetricTransformationMatrix(m);
    equation
      // Symmetrical components (preferred): y = sTM*u;
      for j in 1:m loop
        y[j] = Complex(sum({sTM[j,k].re*u[k].re - sTM[j,k].im*u[k].im for k in 1:m}),
                       sum({sTM[j,k].re*u[k].im + sTM[j,k].im*u[k].re for k in 1:m}));
      end for;
      annotation ( Icon(coordinateSystem(
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
              color={85,170,255})}));
    end SymmetricalComponents;

    block SingleToMultiPhase
      "Extends complex phase signal to complex multi phase signals using symmetricOrientation"
      extends Modelica.ComplexBlocks.Interfaces.ComplexSIMO(final nout=m);
      parameter Integer m=3 "Number of phases";
    equation
      y = u*Modelica.ComplexMath.fromPolar(fill(1, m), -
        Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
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
              rotation=-90)}));
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
          Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m);
      Complex c;
    equation
      c = sqrt(2)/m*'sum'({u[k]*exp(j*phi[k]) for k in 1:m});
      y = {c.re,c.im};
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{0,0},{80,80},{60,72},{72,60},{80,80}}, color={85,170,
                  255}),
            Line(points={{0,0},{80,-80},{72,-60},{60,-72},{80,-80}}, color={85,
                  170,255}),
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
              lineColor={0,0,0},
              textString="zero")}),
        Documentation(info="<html>
    Transformation of m phase values (voltages or currents) to space phasor.
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
          Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m);
    equation
      y = {Complex(u[1], u[2])*exp(-j*phi[k])/sqrt(2) for k in 1:m};
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{0,0},{-80,80},{-60,72},{-72,60},{-80,80}}, color={85,
                  170,255}),
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
              lineColor={0,0,0},
              textString="zero")}), Documentation(info="<html>
          Transformation of space phasor to m phase values (voltages or currents).
</html>"));
    end FromSpacePhasor;
  end Blocks;

  package Functions
    extends Modelica.Icons.Package;
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
      y := sum({'abs'(u[k]) for k in 1:m})/m;
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
      annotation (Icon(graphics={Text(
              extent={{60,-60},{-60,-30}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="ref")}));
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
          points={{-100,0},{-72,0}},
          color={85,170,255}));
      connect(plugToPin_p.pin_p, frequencySensor.pin) annotation (Line(
          points={{-68,0},{-10,0}},
          color={85,170,255}));
      connect(frequencySensor.y, y) annotation (Line(
          points={{11,0},{110,0}},
          color={0,0,127}));
      annotation (Icon(graphics={Line(points={{70,0},{80,0},{90,0},{100,0}},
                color={0,0,127}), Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString="f")}), Documentation(info="<html>

<p>
This sensor can be used to measure the frequency of the reference system, using <i>1</i>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.FrequencySensor\">single phase FrequencySensor</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.FrequencySensor\">SinglePhase.FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PotentialSensor\">PotentialSensor</a>
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
          points={{-100,0},{-72,0}},
          color={85,170,255}));
      connect(plugToPins_p.pin_p, potentialSensor.pin) annotation (Line(
          points={{-68,0},{-10,0}},
          color={85,170,255}));
      annotation (Icon(graphics={Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString="V")}), Documentation(info="<html>

<p>
This sensor can be used to measure <i>m</i> complex potentials, using <i>m</i>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">single phase PotentialSensors</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">SinglePhase.PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor\">PowerSensor</a>
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
      annotation (Icon(graphics={Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString="V")}), Documentation(info="<html>

<p>
This sensor can be used to measure <i>m</i> complex voltages, using <i>m</i>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">single phase VoltageSensors</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">SinglePhase.VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor\">PowerSensor</a>
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
            rotation=270)));
      SinglePhase.Sensors.VoltageSensor voltageSensor[m] annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
      Blocks.QuasiRMS quasiRMS(final m=m) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-50})));
    equation
      connect(quasiRMS.y, V) annotation (Line(
          points={{0,-61},{0,-100}},
          color={0,0,127}));
      connect(plugToPins_p.pin_p, voltageSensor.pin_p) annotation (Line(
          points={{-68,0},{-10,0}},
          color={85,170,255}));
      connect(voltageSensor.pin_n, plugToPins_n.pin_n) annotation (Line(
          points={{10,0},{68,0}},
          color={85,170,255}));
      connect(voltageSensor.y, quasiRMS.u) annotation (Line(
          points={{0,-11},{0,-38}},
          color={85,170,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{-90,0},{-70,0}}, color={0,0,255}),
            Line(points={{0,-70},{0,-90}}, color={0,0,255}),
            Text(
              extent={{-100,60},{100,120}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,-60},{-20,-100}},
              lineColor={0,0,0},
              textString="m="),
            Text(
              extent={{20,-60},{100,-100}},
              lineColor={0,0,0},
              textString="%m"),
            Line(points={{70,0},{90,0}}, color={0,0,255})}),
        Documentation(revisions="<html>
</html>", info="<html>
<p>
This sensor determines the continuous quasi <a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">RMS</a> value of a multi phase voltage system, representing an equivalent RMS voltage vector <code>I</code> or phasor.
</p>
<pre>
 V = sqrt(sum(v[k]^2 for k in 1:m)/m)
</pre>
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
      annotation (Icon(graphics={Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString="I")}), Documentation(info="<html>

<p>
This sensor can be used to measure <i>m</i> complex currents, using <i>m</i>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">single phase CurrentSensors</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">SinglePhase.CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor\">PowerSensor</a>
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
            rotation=270)));
      Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor
        currentSensor[m] annotation (Placement(transformation(extent={{-10,-10},
                {10,10}})));
      Blocks.QuasiRMS quasiRMS(final m=m) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-50})));
    equation
      connect(quasiRMS.y, I) annotation (Line(
          points={{0,-61},{0,-100}},
          color={0,0,127}));
      connect(plugToPins_p.pin_p, currentSensor.pin_p) annotation (Line(
          points={{-68,0},{-10,0}},
          color={85,170,255}));
      connect(currentSensor.pin_n, plugToPins_n.pin_n) annotation (Line(
          points={{10,0},{68,0}},
          color={85,170,255}));
      connect(currentSensor.y, quasiRMS.u) annotation (Line(
          points={{0,-11},{0,-38}},
          color={85,170,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{-90,0},{-70,0}}, color={0,0,255}),
            Line(points={{0,-70},{0,-90}}, color={0,0,255}),
            Text(
              extent={{-100,60},{100,120}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,-60},{-20,-100}},
              lineColor={0,0,0},
              textString="m="),
            Text(
              extent={{20,-60},{100,-100}},
              lineColor={0,0,0},
              textString="%m"),
            Line(points={{70,0},{90,0}}, color={0,0,255})}),
        Documentation(revisions="<html>
</html>", info="<html>
<p>
This sensor determines the continuous quasi <a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">RMS</a> value of a multi phase current system, representing an equivalent RMS current vector <code>I</code> or phasor.
</p>
<pre>
 I = sqrt(sum(i[k]^2 for k in 1:m)/m)
</pre>
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
            origin={-80,-110},
            extent={{-10,-10},{10,10}},
            rotation=270)));
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
            points={{-68,0},{-53.5,0},{-53.5,0},{-39,0},{-39,0},{-10,0}}, color=
             {85,170,255}));
      connect(powerSensor.currentN, plugToPinsCurrentN.pin_n) annotation (Line(
            points={{10,0},{24.5,0},{24.5,0},{39,0},{39,0},{68,0}}, color={85,
              170,255}));
      connect(powerSensor.voltageP, plugToPinsVoltageP.pin_p) annotation (Line(
            points={{0,10},{0,10},{0,68},{0,68}}, color={85,170,255}));
      connect(powerSensor.voltageN, plugToPinsVoltageN.pin_n) annotation (Line(
            points={{0,-10},{0,-10},{0,-68},{0,-68}}, color={85,170,255}));
      connect(powerSensor.y, sum.u) annotation (Line(points={{-8,-11},{-8,-40},
              {-80,-40},{-80,-58}}, color={85,170,255}));
      connect(sum.y, y)
        annotation (Line(points={{-80,-81},{-80,-110}}, color={85,170,255}));
      annotation (
        Icon(graphics={
            Line(points={{0,100},{0,70}}, color={0,0,255}),
            Line(points={{0,-70},{0,-100}}, color={0,0,255}),
            Text(extent={{-29,-70},{30,-11}}, textString="P"),
            Line(points={{-80,-100},{-80,0}}, color={85,170,255}),
            Text(
              textColor={0,0,255},
              extent={{-100,110},{100,150}},
              textString="%name"),
            Line(points={{-100,0},{100,0}}, color={0,0,255})}),
        Documentation(info="<html>

<p>
This sensor can be used to measure <i>m</i> complex apparent power values, using <i>m</i>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">single phase PowerSensors</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">SinglePhase.PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor\">CurrentSensor</a>
</p>

</html>"));
    end PowerSensor;
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
        Icon(graphics={Line(points={{50,0},{-50,0}}),Text(
                  extent={{-120,50},{-20,0}},
                  lineColor={0,0,255},
                  textString="+"),Text(
                  extent={{20,50},{120,0}},
                  lineColor={0,0,255},
                  textString="-")}),
        Documentation(info="<html>

<p>
This model describes <i>m</i> constant voltage sources, specifying the complex voltages by the RMS voltages and the phase shifts
(defaults are
<a href=\"modelica://Modelica.Electrical.MultiPhase.Functions.symmetricOrientation\">-symmetricOrientation</a>).
<i>m</i> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">single phase VoltageSources</a> are used.
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
            origin={40,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.ComplexBlocks.Interfaces.ComplexInput V[m] annotation (Placement(
            transformation(
            origin={-40,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      omega = 2*Modelica.Constants.pi*f;
      v = V;
      annotation (Icon(graphics={Line(points={{50,0},{-50,0}}),
              Text(
                  extent={{-120,50},{-20,0}},
                  lineColor={0,0,255},
                  textString="+"),Text(
                  extent={{20,50},{120,0}},
                  lineColor={0,0,255},
                  textString="-")}), Documentation(info="<html>

<p>
This model describes <i>m</i> variable voltage sources, with <i>m</i> complex signal inputs,
specifying the complex voltages by the complex RMS voltage components.
Additionally, the frequency of the voltage source is defined by a real signal input.
<i>m</i> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableVoltageSource\">single phase VariableVoltageSources</a> are used.
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
            origin={40,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.ComplexBlocks.Interfaces.ComplexInput V[m] annotation (Placement(
            transformation(
            origin={-40,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      plug_p.reference.gamma = gamma;
      v = V;
      annotation (Documentation(info="<html>

<p>
This model describes <i>m</i> variable current sources, with <i>m</i> complex signal inputs,
specifying the complex current by the complex RMS voltage components.
Additionally, the frequency of the current source is defined by a real signal input.
<i>m</i> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource\">single phase VariableCurrentSources</a> are used.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VoltageSource\">SinglePhase.VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VoltageSource\">VoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.VariableVoltageSource\">VariableVoltageSource</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.CurrentSource\">CurrentSource</a>.
</p>
</html>"));
    end ReferenceVoltageSource;

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
      annotation (Icon(graphics={Line(points={{-60,60},{60,60}}, color={0,0,255}),
              Polygon(
                  points={{60,60},{30,70},{30,50},{60,60}},
                  lineColor={0,0,255},
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid),Line(points={{0,-50},{0,50}})}), Documentation(info="<html>

<p>
This model describes <i>m</i> constant current sources, specifying the complex currents by the RMS currents and the the phase shifts
(defaults are
<a href=\"modelica://Modelica.Electrical.MultiPhase.Functions.symmetricOrientation\">-symmetricOrientation</a>).
<i>m</i> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.CurrentSource\">single phase CurrentSources</a> are used.
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
            rotation=270)));
      Modelica.ComplexBlocks.Interfaces.ComplexInput I[m] annotation (Placement(
            transformation(
            origin={-40,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      omega = 2*Modelica.Constants.pi*f;
      i = I;
      annotation (Icon(graphics={Line(points={{-60,60},{60,60}}, color={85,170,
              255}),Polygon(
                  points={{60,60},{30,70},{30,50},{60,60}},
                  lineColor={0,0,255},
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid),Line(points={{0,-50},{0,50}})}), Documentation(info="<html>

<p>
This model describes <i>m</i> variable current sources, with <i>m</i> complex signal inputs,
specifying the complex current by the complex RMS voltage components.
Additionally, the frequency of the current source is defined by a real signal input.
<i>m</i> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource\">single phase VariableCurrentSources</a> are used.
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
            rotation=270)));
      Modelica.ComplexBlocks.Interfaces.ComplexInput I[m] annotation (Placement(
            transformation(
            origin={-40,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
    equation
      plug_p.reference.gamma = gamma;
      i = I;
      annotation (
        Icon(graphics={Line(points={{-60,60},{60,60}}, color={85,170,255}),
              Polygon(
                  points={{60,60},{30,70},{30,50},{60,60}},
                  lineColor={0,0,255},
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid),Line(points={{0,-50},{0,50}})}),
        Documentation(info="<html>

<p>
This model describes <i>m</i> variable current sources, with <i>m</i> complex signal inputs,
specifying the complex current by the complex RMS voltage components.
Additionally, the frequency of the current source is defined by a real signal input.
<i>m</i> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.VariableCurrentSource\">single phase VariableCurrentSources</a> are used.
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

    connector Plug "Basic multiphase plug"
      parameter Integer m=3 "number of phases";
      QuasiStationary.SinglePhase.Interfaces.Pin pin[m];
      annotation (Documentation(info="<html>

<p>
This multiphase plug contains a vector of <i>m</i> <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.Pin\">single phase pins</a>.
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

    connector PositivePlug "Positive multiphase connector"
      extends Plug;
      QuasiStationary.Types.Reference reference;
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
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
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

    connector NegativePlug "Negative multiphase connector"
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
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
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
        "Positive quasi stationary multi phase plug" annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      NegativePlug plug_n(final m=m)
        "Negative quasi stationary multi phase plug" annotation (Placement(
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
        "Positive quasi stationary multi phase plug" annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      NegativePlug plug_n(final m=m)
        "Negative quasi stationary multi phase plug" annotation (Placement(
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
        "Positive quasi stationary multi phase plug" annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
    equation
      omega = der(plug_p.reference.gamma);
      annotation (Icon(graphics={
            Line(points={{-70,0},{-94,0}}, color={85,170,255}),
            Line(points={{70,0},{80,0},{90,0},{100,0}}, color={85,170,255}),
            Text(
              extent={{100,-100},{-100,-70}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="m=%m")}), Documentation(info="<html>

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
            Line(points={{-70,0},{-94,0}}),
            Line(points={{70,0},{94,0}}),
            Line(points={{0,-70},{0,-80},{0,-90},{0,-100}}, color={85,170,255}),
            Text(
              extent={{100,-100},{-100,-70}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid,
              textString="m=%m")}), Documentation(info="<html>
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
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{100,-100},{-100,-60}},
                  textString="%name",
                  lineColor={0,0,255}),Line(points={{-90,0},{-50,0}}, color={0,
              0,0}),Line(points={{50,0},{90,0}}),Text(
                  extent={{100,60},{-100,100}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  textString="m=%m")}),
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
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{100,-100},{-100,-60}},
                  textString="%name",
                  lineColor={0,0,255}),Line(points={{-90,0},{-50,0}}, color={0,
              0,0}),Line(points={{50,0},{90,0}}),Text(
                  extent={{100,60},{-100,100}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  textString="m=%m")}), Documentation(info="<html>
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
