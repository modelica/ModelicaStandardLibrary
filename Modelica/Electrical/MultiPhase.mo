within Modelica.Electrical;


package MultiPhase "Library for electrical components with 2, 3 or more phases"
  extends Modelica.Icons.Library2;

  package Examples "Multiphase test examples"
    extends Modelica.Icons.Library2;

    model TransformerYY "Test example with multiphase components"
      extends Modelica.Icons.Example;
      parameter Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage V=1 "Amplitude of Star-Voltage";
      parameter Modelica.SIunits.Frequency f=5 "Frequency";
      parameter Modelica.SIunits.Inductance LT=0.003
        "Transformer stray inductance";
      parameter Modelica.SIunits.Resistance RT=0.05 "Transformer resistance";
      parameter Modelica.SIunits.Resistance RL=1 "Load Resistance";
      Sources.SineVoltage sineVoltage(
        V=fill(V, m),
        freqHz=fill(f, m),
        m=m) annotation (Placement(transformation(
            origin={-80,20},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Basic.Star starS(m=m)
        annotation (Placement(transformation(
            origin={-90,-62},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundS
        annotation (Placement(transformation(extent={{-100,-100},{-80,-80}},
              rotation=0)));
      Ideal.IdealTransformer idealTransformer(m=m)
        annotation (Placement(transformation(extent={{-40,0},{-20,20}},
              rotation=0)));
      Basic.Star starT1(m=m)
        annotation (Placement(transformation(
            origin={-40,-62},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Basic.Star starT2(m=m)
        annotation (Placement(transformation(
            origin={-20,-62},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundT2
        annotation (Placement(transformation(extent={{-30,-100},{-10,-80}},
              rotation=0)));
      Basic.Resistor transformerR(m=m, R=fill(RT, m))
                                             annotation (Placement(
            transformation(extent={{0,10},{20,30}}, rotation=0)));
      Basic.Inductor transformerL(m=m, L=fill(LT, m))
        annotation (Placement(transformation(extent={{30,10},{50,30}}, rotation=
               0)));
      Basic.Resistor loadR(m=m, R=fill(RL, m))
        annotation (Placement(transformation(extent={{70,10},{90,30}}, rotation=
               0)));
      Basic.Star starL(m=m)
        annotation (Placement(transformation(
            origin={90,-62},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundT1
        annotation (Placement(transformation(extent={{-50,-100},{-30,-80}},
              rotation=0)));
    equation
      connect(starS.pin_n, groundS.p)
        annotation (Line(points={{-90,-72},{-90,-80}}, color={0,0,255}));
      connect(starT1.pin_n,groundT1. p)
        annotation (Line(points={{-40,-72},{-40,-80}}, color={0,0,255}));
      connect(starT2.pin_n,groundT2. p)
        annotation (Line(points={{-20,-72},{-20,-76},{-20,-76},{-20,-80}},
                                                       color={0,0,255}));
      connect(starS.plug_p, sineVoltage.plug_n)
        annotation (Line(points={{-90,-52},{-90,20}}, color={0,0,255}));
      connect(sineVoltage.plug_p, idealTransformer.plug_p1)
        annotation (Line(points={{-70,20},{-40,20}}, color={0,0,255}));
      connect(idealTransformer.plug_n1, starT1.plug_p)
        annotation (Line(points={{-40,0},{-40,-52}}, color={0,0,255}));
      connect(starT2.plug_p, idealTransformer.plug_n2)
        annotation (Line(points={{-20,-52},{-20,-26},{-20,-26},{-20,0}},
                                                     color={0,0,255}));
      connect(idealTransformer.plug_p2, transformerR.plug_p)
        annotation (Line(points={{-20,20},{0,20}}, color={0,0,255}));
      connect(transformerR.plug_n, transformerL.plug_p)
        annotation (Line(points={{20,20},{30,20}}, color={0,0,255}));
      connect(transformerL.plug_n, loadR.plug_p)
        annotation (Line(points={{50,20},{70,20}}, color={0,0,255}));
      connect(loadR.plug_n, starL.plug_p)
        annotation (Line(points={{90,20},{90,-52}}, color={0,0,255}));
      annotation (Documentation(info="<HTML>
<p>
Test example with multiphase components:<br>
Star-connected voltage source feeds via a Y-Y-transformer with internal impedance (RT, LT) a load resistor RT.<br>
Using f=5 Hz LT=3mH defines nominal voltage drop of approximately 10 %.<br>
Simulate for 1 second (2 periods) and compare voltages and currents of source, transformer and load.
</p>
</HTML>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),
                   graphics));
    end TransformerYY;

    model TransformerYD "Test example with multiphase components"
      extends Modelica.Icons.Example;
      parameter Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage V=1 "Amplitude of Star-Voltage";
      parameter Modelica.SIunits.Frequency f=5 "Frequency";
      parameter Modelica.SIunits.Inductance LT=0.003
        "Transformer stray inductance";
      parameter Modelica.SIunits.Resistance RT=0.05 "Transformer resistance";
      parameter Modelica.SIunits.Resistance RL=1 "Load Resistance";
      parameter Real nT=1/sqrt((1 - Modelica.Math.cos(2*Modelica.Constants.pi/m))
          ^2 + (Modelica.Math.sin(2*Modelica.Constants.pi/m))^2)
        "Transformer ratio";
      Sources.SineVoltage sineVoltage(
        V=fill(V, m),
        freqHz=fill(f, m),
        m=m) annotation (Placement(transformation(
            origin={-80,20},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Basic.Star starS(m=m)
        annotation (Placement(transformation(
            origin={-90,-62},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundS
        annotation (Placement(transformation(extent={{-100,-100},{-80,-80}},
              rotation=0)));
      Ideal.IdealTransformer idealTransformer(m=m, n=fill(nT, m))
        annotation (Placement(transformation(extent={{-40,0},{-20,20}},
              rotation=0)));
      Basic.Star starT(m=m)
        annotation (Placement(transformation(
            origin={-40,-62},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Basic.Delta deltaT2(m=m)
                              annotation (Placement(transformation(
            origin={50,10},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundT
        annotation (Placement(transformation(extent={{-50,-100},{-30,-80}},
              rotation=0)));
      Basic.Resistor transformerR(m=m, R=fill(RT/nT^2, m))
        annotation (Placement(transformation(extent={{-10,10},{10,30}},
              rotation=0)));
      Basic.Inductor transformerL(m=m, L=fill(LT/nT^2, m))
        annotation (Placement(transformation(extent={{20,10},{40,30}}, rotation=
               0)));
      Basic.Resistor loadR(m=m, R=fill(RL, m))
        annotation (Placement(transformation(extent={{70,10},{90,30}}, rotation=
               0)));
      Basic.Star starL(m=m)
        annotation (Placement(transformation(
            origin={90,-62},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundL
        annotation (Placement(transformation(extent={{80,-100},{100,-80}},
              rotation=0)));
    equation
      connect(groundS.p, starS.pin_n)
        annotation (Line(points={{-90,-80},{-90,-72}}, color={0,0,255}));
      connect(groundT.p, starT.pin_n)
        annotation (Line(points={{-40,-80},{-40,-72}}, color={0,0,255}));
      connect(starS.plug_p, sineVoltage.plug_n)
        annotation (Line(points={{-90,-52},{-90,20}}, color={0,0,255}));
      connect(sineVoltage.plug_p, idealTransformer.plug_p1)
        annotation (Line(points={{-70,20},{-40,20}}, color={0,0,255}));
      connect(idealTransformer.plug_n1, starT.plug_p)
        annotation (Line(points={{-40,0},{-40,-52}}, color={0,0,255}));
      connect(idealTransformer.plug_p2, transformerR.plug_p)
        annotation (Line(points={{-20,20},{-10,20}}, color={0,0,255}));
      connect(transformerR.plug_n, transformerL.plug_p)
        annotation (Line(points={{10,20},{20,20}}, color={0,0,255}));
      connect(transformerL.plug_n, deltaT2.plug_p)
        annotation (Line(points={{40,20},{50,20}}, color={0,0,255}));
      connect(deltaT2.plug_n, idealTransformer.plug_n2)
        annotation (Line(points={{50,0},{-20,0}}, color={0,0,255}));
      connect(deltaT2.plug_p, loadR.plug_p)
        annotation (Line(points={{50,20},{70,20}}, color={0,0,255}));
      connect(loadR.plug_n, starL.plug_p)
        annotation (Line(points={{90,20},{90,-52}}, color={0,0,255}));
      connect(starL.pin_n, groundL.p)
        annotation (Line(points={{90,-72},{90,-80}}, color={0,0,255}));
      annotation (Documentation(info="<HTML>
<p>
Test example with multiphase components:<br>
Star-connected voltage source feeds via a Y-D-transformer with internal impedance (RT, LT) a load resistor RT.<br>
Using f=5 Hz LT=3mH defines nominal voltage drop of approximately 10 %.<br>
Simulate for 1 second (2 periods) and compare voltages and currents of source, transformer and load.
</p>
</HTML>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),
                   graphics));
    end TransformerYD;

    model Rectifier "Test example with multiphase components"
      extends Modelica.Icons.Example;
      parameter Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage V=1 "Amplitude of Star-Voltage";
      parameter Modelica.SIunits.Frequency f=5 "Frequency";
      parameter Modelica.SIunits.Inductance L=0.001 "Line Inductance";
      parameter Modelica.SIunits.Resistance RL=2 "Load Resistance";
      parameter Modelica.SIunits.Capacitance C=0.05 "Total DC-Capacitance";
      parameter Modelica.SIunits.Resistance RE=1E6 "Earthing Resistance";
      Sources.SineVoltage sineVoltage(
        m=m,
        V=fill(V, m),
        freqHz=fill(f, m)) annotation (Placement(transformation(extent={{-70,10},
                {-90,-10}}, rotation=0)));
      Basic.Star starS(m=m)
        annotation (Placement(transformation(
            origin={-90,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Basic.Inductor supplyL(m=m, L=fill(L, m))
        annotation (Placement(transformation(extent={{-52,-10},{-32,10}},
              rotation=0)));
      Ideal.IdealDiode idealDiode1(m=m)
        annotation (Placement(transformation(
            origin={10,20},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Basic.Star star1(m=m) annotation (Placement(transformation(
            origin={10,50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Ideal.IdealDiode idealDiode2(m=m)
        annotation (Placement(transformation(
            origin={10,-20},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Basic.Star star2(m=m) annotation (Placement(transformation(
            origin={10,-50},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Resistor loadR(R=RL)
        annotation (Placement(transformation(
            origin={50,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Capacitor cDC1(C=2*C)
        annotation (Placement(transformation(
            origin={70,30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Capacitor cDC2(C=2*C)
        annotation (Placement(transformation(
            origin={70,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundDC
        annotation (Placement(transformation(extent={{80,-80},{100,-60}},
              rotation=0)));
    equation
      connect(cDC1.n, cDC2.p)
        annotation (Line(points={{70,20},{70,-20}}, color={0,0,255}));
      connect(cDC1.n, groundDC.p)
        annotation (Line(points={{70,20},{70,0},{90,0},{90,-60}}, color={0,0,
              255}));
      connect(starS.plug_p, sineVoltage.plug_n)
        annotation (Line(points={{-90,-40},{-90,0}}, color={0,0,255}));
      connect(sineVoltage.plug_p, supplyL.plug_p)
        annotation (Line(points={{-70,0},{-52,0}}, color={0,0,255}));
      connect(idealDiode1.plug_p, supplyL.plug_n)
        annotation (Line(points={{10,10},{10,0},{-32,0}}, color={0,0,255}));
      connect(idealDiode2.plug_n, supplyL.plug_n)
        annotation (Line(points={{10,-10},{10,0},{-32,0}}, color={0,0,255}));
      connect(idealDiode1.plug_n, star1.plug_p)
        annotation (Line(points={{10,30},{10,40}}, color={0,0,255}));
      connect(idealDiode2.plug_p, star2.plug_p)
        annotation (Line(points={{10,-30},{10,-35},{10,-40},{10,-40}},
                                                     color={0,0,255}));
      connect(star2.pin_n, loadR.n)
        annotation (Line(points={{10,-60},{50,-60},{50,-10}}, color={0,0,255}));
      connect(star2.pin_n, cDC2.n)
        annotation (Line(points={{10,-60},{70,-60},{70,-40}}, color={0,0,255}));
      connect(star1.pin_n,loadR. p)
        annotation (Line(points={{10,60},{50,60},{50,10}}, color={0,0,255}));
      connect(star1.pin_n, cDC1.p)
        annotation (Line(points={{10,60},{70,60},{70,40}}, color={0,0,255}));
      annotation (Documentation(info="<HTML>
<p>
Test example with multiphase components:<br>
Star-connected voltage source feeds via a line reactor a diode bridge rectifier with a DC burden.<br>
Using f=5 Hz, simulate for 1 second (2 periods) and compare voltages and currents of source and DC burden,
neglecting initial transient.
</p>
</HTML>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),
                   graphics));
    end Rectifier;
    annotation (Documentation(info="<HTML>
<p>
This package contains test examples of analog electrical multiphase circuits.
</p>

</HTML>", revisions="<html>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Release Notes:</b></dt>
  <dd>
  <ul>
  <li> v1.0 2004/10/01 Anton Haumer</li>
  </ul>
  </dd>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={Ellipse(extent={{-60,12},{40,-88}},
              lineColor={135,135,135}), Polygon(
            points={{-30,-10},{-30,-66},{28,-38},{-30,-10}},
            lineColor={135,135,135},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid)}));
  end Examples;

  package Basic "Basic components for electrical multiphase models"
    extends Modelica.Icons.Library2;

    model Star "Star-connection"
      parameter Integer m(final min=1) = 3 "number of phases";
      Interfaces.PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
              rotation=0)));
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
        annotation (Placement(transformation(extent={{90,-10},{110,10}},
              rotation=0)));

    equation
      for j in 1:m loop
        connect(plug_p.pin[j],pin_n);
      end for;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Text(
              extent={{-150,60},{150,120}},
              textString="%name",
              lineColor={0,0,255}),
            Line(
              points={{80,0},{0,0}},
              thickness=0.5,
              color={0,0,255}),
            Line(
              points={{0,0},{-39,68}},
              thickness=0.5,
              color={0,0,255}),
            Line(
              points={{0,0},{-38,-69}},
              thickness=0.5,
              color={0,0,255}),
            Text(
              extent={{-100,-110},{100,-70}},
              lineColor={0,0,0},
              textString="m=%m"),
            Line(points={{-90,0},{-40,0}}, color={0,0,255}),
            Line(points={{80,0},{90,0}}, color={0,0,255})}),
          Documentation(
            info="<HTML>
<p>
Connects all pins of plug_p to pin_n, thus establishing a so-called star-connection.
</p>
</HTML>"));
    end Star;

    model Delta "Delta (polygon) connection"
      parameter Integer m(final min=2) = 3 "number of phases";
      Interfaces.PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
              rotation=0)));
      Interfaces.NegativePlug plug_n(final m=m)
        annotation (Placement(transformation(extent={{90,-10},{110,10}},
              rotation=0)));

    equation
      for j in 1:m loop
        if j<m then
          connect(plug_n.pin[j],plug_p.pin [j+1]);
        else
          connect(plug_n.pin[j],plug_p.pin [1]);
        end if;
      end for;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Text(
              extent={{-150,60},{150,120}},
              lineColor={0,0,255},
              textString="%name"),
            Line(
              points={{-40,68},{-40,-70},{79,0},{-40,68},{-40,67}},
              thickness=0.5,
              color={0,0,255}),
            Text(
              extent={{-100,-110},{100,-70}},
              lineColor={0,0,0},
              textString="m=%m"),
            Line(points={{-90,0},{-40,0}}, color={0,0,255}),
            Line(points={{80,0},{90,0}}, color={0,0,255})}),
          Documentation(
            info="<HTML>
<p>
Connects in a cyclic way plug_n.pin[j] to plug_p.pin[j+1],
thus establishing a so-called delta (or polygon) connection
when used in parallel to another component.
</p>
</HTML>"));
    end Delta;

    model PlugToPin_p "Connect one (positive) Pin"
      parameter Integer m(final min=1) = 3 "number of phases";
      parameter Integer k(final min=1, final max=m, start = 1) "phase index";
      Interfaces.PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}},
              rotation=0)));
      Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
        annotation (Placement(transformation(extent={{10,-10},{30,10}},
              rotation=0)));
    equation
      pin_p.v = plug_p.pin[k].v;
      for j in 1:m loop
        plug_p.pin[j].i = if j == k then -pin_p.i else 0;
      end for;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,100},{150,40}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,-60},{100,-100}},
              lineColor={0,0,0},
              textString="k = %k"),
            Line(points={{-20,20},{40,20},{40,-20},{-20,-20}}, color={0,0,0}),
            Rectangle(
              extent={{-20,20},{40,-20}},
              pattern=LinePattern.None,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Ellipse(
              extent={{-40,20},{0,-20}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Line(points={{-20,20},{40,20},{40,-20},{-20,-20}}, color={0,0,0})}),
        Documentation(info="<HTML>
<p>
Connects pin <i>k</i> of plug_p to pin_p, leaving the other pins of plug_p unconnected.
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                graphics));
    end PlugToPin_p;

    model PlugToPin_n "Connect one (negative) Pin"
      parameter Integer m(final min=1) = 3 "number of phases";
      parameter Integer k(final min=1, final max=m, start = 1) "phase index";
      Interfaces.NegativePlug plug_n(final m=m)
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}},
              rotation=0)));
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
        annotation (Placement(transformation(extent={{10,-10},{30,10}},
              rotation=0)));
    equation
      pin_n.v = plug_n.pin[k].v;
      for j in 1:m loop
        plug_n.pin[j].i = if j == k then -pin_n.i else 0;
      end for;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Text(
              extent={{-150,100},{150,40}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,-60},{100,-100}},
              lineColor={0,0,0},
              textString="k = %k"),
            Line(points={{-20,20},{40,20},{40,-20},{-20,-20}}, color={0,0,0}),
            Rectangle(
              extent={{-20,20},{40,-20}},
              pattern=LinePattern.None,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Ellipse(
              extent={{-40,20},{0,-20}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Line(points={{-20,20},{40,20},{40,-20},{-20,-20}}, color={0,0,0})}),
           Documentation(info="<HTML>
<p>
Connects pin <i>k</i> of plug_n to pin_n, leaving the other pins of plug_n unconnected.
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                graphics));
    end PlugToPin_n;

    model Resistor "Ideal linear electrical resistors"
      extends Interfaces.TwoPlug;
        parameter Modelica.SIunits.Resistance R[m](start=fill(1,m))
        "Resistances R_ref at temperatures T_ref";
      parameter Modelica.SIunits.Temperature T_ref[m]=fill(300.15,m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha[m]=zeros(m)
        "Temperature coefficients of resistances at reference temperatures";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, T = T_ref);
      Modelica.Electrical.Analog.Basic.Resistor resistor[m](
        final R=R,
        final T_ref=T_ref,
        final alpha=alpha,
        each final useHeatPort = useHeatPort,
        final T=T)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
    equation
      connect(resistor.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(resistor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(resistor.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-70,0}}, color={0,0,255}),
            Line(points={{70,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-150,40},{150,100}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,-100},{100,-60}},
              lineColor={0,0,0},
              textString="m=%m")}),
        Documentation(info="<HTML>
<p>
Contains m resistors (Modelica.Electrical.Analog.Basic.Resistor)
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                {100,100}}),
                graphics));
    end Resistor;

    model Conductor "Ideal linear electrical conductors"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Conductance G[m](start=fill(1,m))
        "Conductances G_ref at temperatures T_ref";
      parameter Modelica.SIunits.Temperature T_ref[m]=fill(300.15,m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha[m]=zeros(m)
        "Temperature coefficients of conductances at reference temperatures";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, T = T_ref);
      Modelica.Electrical.Analog.Basic.Conductor conductor[m](
        final G=G,
        final T_ref=T_ref,
        final alpha=alpha,
        each final useHeatPort = useHeatPort,
        final T=T)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
    equation
      connect(plug_p.pin, conductor.p)
        annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
      connect(plug_n.pin, conductor.n)
        annotation (Line(points={{100,0},{10,0}}, color={0,0,255}));
      connect(conductor.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-70,0}}, color={0,0,255}),
            Line(points={{70,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-150,40},{150,100}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,-100},{100,-60}},
              lineColor={0,0,0},
              textString="m=%m")}),
        Documentation(info="<HTML>
<p>
Contains m conductors (Modelica.Electrical.Analog.Basic.Conductor)
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                {100,100}}),
                graphics));
    end Conductor;

    model Capacitor "Ideal linear electrical capacitors"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Capacitance C[m](start=fill(1, m))
        "Capacitance";
      Modelica.Electrical.Analog.Basic.Capacitor capacitor[m](final C=C)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
    equation
      connect(capacitor.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(capacitor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,40},{150,100}},
              textString="%name",
              lineColor={0,0,255}),
            Line(
              points={{-14,28},{-14,-28}},
              thickness=0.5,
              color={0,0,255}),
            Line(
              points={{14,28},{14,-28}},
              thickness=0.5,
              color={0,0,255}),
            Line(points={{-90,0},{-14,0}}, color={0,0,255}),
            Line(points={{14,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-100,-100},{100,-60}},
              lineColor={0,0,0},
              textString="m=%m")}),
        Documentation(info="<HTML>
<p>
Contains m capacitors (Modelica.Electrical.Analog.Basic.Capacitor)
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                graphics));
    end Capacitor;

    model Inductor "Ideal linear electrical inductors"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Inductance L[m](start=fill(1, m)) "Inductance";
      Modelica.Electrical.Analog.Basic.Inductor inductor[m](final L=L)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
    equation
      connect(inductor.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(inductor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Ellipse(extent={{-60,-15},{-30,15}}, lineColor={0,0,255}),
            Ellipse(extent={{-30,-15},{0,15}}, lineColor={0,0,255}),
            Ellipse(extent={{0,-15},{30,15}}, lineColor={0,0,255}),
            Ellipse(extent={{30,-15},{60,15}}, lineColor={0,0,255}),
            Rectangle(
              extent={{-60,-30},{60,0}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{60,0},{90,0}}, color={0,0,255}),
            Line(points={{-90,0},{-60,0}}, color={0,0,255}),
            Text(
              extent={{-150,40},{150,100}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,-100},{100,-60}},
              lineColor={0,0,0},
              textString="m=%m")}),
        Documentation(info="<HTML>
<p>
Contains m inductors (Modelica.Electrical.Analog.Basic.Inductor)
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                graphics));
    end Inductor;

    model SaturatingInductor "Simple model of inductors with saturation"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Current Inom[m](start=fill(1,m))
        "Nominal current";
      parameter Modelica.SIunits.Inductance Lnom[m](start=fill(1,m))
        "Nominal inductance at Nominal current";
      parameter Modelica.SIunits.Inductance Lzer[m](start={2*Lnom[j] for j in 1:m})
        "Inductance near current=0";
      parameter Modelica.SIunits.Inductance Linf[m](start={Lnom[j]/2 for j in 1:m})
        "Inductance at large currents";
      Modelica.Electrical.Analog.Basic.SaturatingInductor saturatingInductor[m](
        final Inom=Inom,
        final Lnom=Lnom,
        final Lzer=Lzer,
        final Linf=Linf)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
    equation
      connect(saturatingInductor.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(saturatingInductor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Ellipse(extent={{-60,-15},{-30,15}}, lineColor={0,0,255}),
            Ellipse(extent={{-30,-15},{0,15}}, lineColor={0,0,255}),
            Ellipse(extent={{0,-15},{30,15}}, lineColor={0,0,255}),
            Ellipse(extent={{30,-15},{60,15}}, lineColor={0,0,255}),
            Rectangle(
              extent={{-60,-20},{60,0}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{60,0},{90,0}}, color={0,0,255}),
            Line(points={{-90,0},{-60,0}}, color={0,0,255}),
            Rectangle(
              extent={{-60,-10},{60,-20}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Sphere,
              fillColor={0,0,255}),
            Text(
              extent={{-150,40},{150,100}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,-100},{100,-60}},
              lineColor={0,0,0},
              textString="m=%m")}),
          Documentation(
            info="<HTML>
<p>
Contains m saturating inductors (Modelica.Electrical.Analog.Basic.SaturatingInductor)
</p>
<p>
<b>Attention!!!</b><br>
Each element of the array of saturatingInductors is only dependent on the current flowing through this element.
</p>
</HTML>"));
    end SaturatingInductor;

    model Transformer "Multiphase Transformer"
      extends Interfaces.FourPlug;
      parameter Modelica.SIunits.Inductance L1[m](start=fill(1, m))
        "Primary inductance";
      parameter Modelica.SIunits.Inductance L2[m](start=fill(1, m))
        "Secondary inductance";
      parameter Modelica.SIunits.Inductance M[m](start=fill(1, m))
        "Coupling inductance";
      Modelica.Electrical.Analog.Basic.Transformer transformer[m](
        final L1=L1,
        final L2=L2,
        final M=M) annotation (Placement(transformation(extent={{-10,-10},{10,
                10}}, rotation=0)));
    equation

      connect(plug_p1.pin, transformer.p1) annotation (Line(
          points={{-100,100},{-10,100},{-10,5}},
          color={0,0,255}));
      connect(plug_p2.pin, transformer.p2) annotation (Line(
          points={{100,100},{10,100},{10,5}},
          color={0,0,255}));
      connect(plug_n1.pin, transformer.n1) annotation (Line(
          points={{-100,-100},{-10,-100},{-10,-5}},
          color={0,0,255}));
      connect(plug_n2.pin, transformer.n2) annotation (Line(
          points={{100,-100},{10,-100},{10,-5}},
          color={0,0,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Ellipse(extent={{-45,-50},{-20,-25}}, lineColor={0,0,255}),
            Ellipse(extent={{-45,-25},{-20,0}}, lineColor={0,0,255}),
            Ellipse(extent={{-45,0},{-20,25}}, lineColor={0,0,255}),
            Ellipse(extent={{-45,25},{-20,50}}, lineColor={0,0,255}),
            Rectangle(
              extent={{-72,-60},{-33,60}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,50},{-32,50}}, color={0,0,255}),
            Line(points={{-90,-50},{-32,-50}}, color={0,0,255}),
            Ellipse(extent={{20,-50},{45,-25}}, lineColor={0,0,255}),
            Ellipse(extent={{20,-25},{45,0}}, lineColor={0,0,255}),
            Ellipse(extent={{20,0},{45,25}}, lineColor={0,0,255}),
            Ellipse(extent={{20,25},{45,50}}, lineColor={0,0,255}),
            Rectangle(
              extent={{33,-60},{72,60}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{32,50},{90,50}}, color={0,0,255}),
            Line(points={{32,-50},{90,-50}}, color={0,0,255}),
            Text(
              extent={{-100,20},{-58,-20}},
              textString="L1",
              lineColor={0,0,255}),
            Text(
              extent={{60,20},{100,-20}},
              textString="L2",
              lineColor={0,0,255}),
            Text(
              extent={{-20,20},{20,-20}},
              textString="M",
              lineColor={0,0,255}),
            Text(
              extent={{-80,-100},{80,-60}},
              lineColor={0,0,0},
              textString="m=%m"),
            Text(
              extent={{-100,50},{100,110}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<HTML>
<p>
Contains m transformers (Modelica.Electrical.Analog.Basic.Transformer)
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                graphics));
    end Transformer;

    model VariableResistor
      "Ideal linear electrical resistors with variable resistance"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Temperature T_ref[m]=fill(300.15,m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha[m]=zeros(m)
        "Temperature coefficients of resistances at reference temperatures";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, T = T_ref);
      Modelica.Blocks.Interfaces.RealInput R[m]
        annotation (Placement(transformation(
            origin={0,100},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.VariableResistor variableResistor[m](
        final T_ref=T_ref,
        final alpha=alpha,
        each final useHeatPort=useHeatPort,
        final T=T)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
    equation
      connect(variableResistor.p, plug_p.pin) annotation (Line(points={{-10,0},
              {-100,0}}, color={0,0,255}));
      connect(variableResistor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(R, variableResistor.R)
        annotation (Line(points={{0,100},{0,11}}, color={0,0,255}));
      connect(variableResistor.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-90,0},{-70,0}}, color={0,0,255}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{70,0},{90,0}}, color={0,0,255}),
            Line(points={{0,90},{0,30}}, color={0,0,255}),
            Text(
              extent={{-150,-100},{150,-40}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,40},{100,80}},
              lineColor={0,0,0},
              textString="m=%m")}),
          Documentation(                                                     info="<HTML>
<p>
Contains m variable resistors (Modelica.Electrical.Analog.Basic.VariableResistor)
</p>
<P>
<b>Attention!!!</b><br>
  It is recomended that none of the R_Port signals should not cross the zero value.
  Otherwise depending on the surrounding circuit the probability of singularities is high.
</P>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                {100,100}}),
                graphics));
    end VariableResistor;

    model VariableConductor
      "Ideal linear electrical conductors with variable conductance"
      extends Interfaces.TwoPlug;
     parameter Modelica.SIunits.Temperature T_ref[m]=fill(300.15,m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha[m]=zeros(m)
        "Temperature coefficients of conductances at reference temperatures";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, T = T_ref);
      Modelica.Blocks.Interfaces.RealInput G[m]
        annotation (Placement(transformation(
            origin={0,100},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.VariableConductor variableConductor[m](
        final T_ref=T_ref,
        final alpha=alpha,
        each final useHeatPort=useHeatPort,
        final T=T)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
    equation
      connect(variableConductor.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(variableConductor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(G, variableConductor.G)
        annotation (Line(points={{0,100},{0,11}}, color={0,0,255}));
      connect(variableConductor.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-90,0},{-70,0}}, color={0,0,255}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{70,0},{90,0}}, color={0,0,255}),
            Line(points={{0,90},{0,30}}, color={0,0,255}),
            Text(
              extent={{-150,-100},{150,-40}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,40},{100,80}},
              lineColor={0,0,0},
              textString="m=%m")}),
          Documentation(                                                     info="<HTML>
<p>
Contains m variable conductors (Modelica.Electrical.Analog.Basic.VariableConductor)
</p>
<P>
<b>Attention!!!</b><br>
  It is recomended that none of the G_Port signals should not cross the zero value.
  Otherwise depending on the surrounding circuit the probability of singularities is high.
</P>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                {100,100}}),
                graphics));
    end VariableConductor;

    model VariableCapacitor
      "Ideal linear electrical capacitors with variable capacitance"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Capacitance Cmin[m]=fill(Modelica.Constants.eps,m)
        "minimum Capacitance";
      Modelica.Blocks.Interfaces.RealInput C[m]
        annotation (Placement(transformation(
            origin={0,100},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.VariableCapacitor variableCapacitor[m](final Cmin = Cmin)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
    equation
      connect(variableCapacitor.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(variableCapacitor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(C, variableCapacitor.C)
        annotation (Line(points={{0,100},{0,11}}, color={0,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{0,90},{0,30}}, color={0,0,255}),
            Text(
              extent={{-150,-100},{150,-40}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,40},{100,80}},
              lineColor={0,0,0},
              textString="m=%m"),
            Line(points={{-90,0},{-14,0}}, color={0,0,255}),
            Line(points={{14,0},{90,0}}, color={0,0,255}),
            Line(
              points={{-14,28},{-14,-28}},
              thickness=0.5,
              color={0,0,255}),
            Line(
              points={{14,28},{14,-28}},
              thickness=0.5,
              color={0,0,255})}),
          Documentation(                                                     info="<HTML>
<p>
Contains m variable capacitors (Modelica.Electrical.Analog.Basic.VariableCapacitor)
</p>
<P>
It is required that each C_Port.signal &ge; 0, otherwise an
assertion is raised. To avoid a variable index system,<br>
C = Cmin, if 0 &le; C_Port.signal &lt; Cmin, where
Cmin is a parameter with default value Modelica.Constants.eps.
</P>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                graphics));
    end VariableCapacitor;

    model VariableInductor
      "Ideal linear electrical inductors with variable inductance"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Inductance Lmin[m]=fill(Modelica.Constants.eps,m)
        "minimum Inductance";
      Modelica.Blocks.Interfaces.RealInput L[m]
        annotation (Placement(transformation(
            origin={0,100},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.VariableInductor variableInductor[m](final Lmin
          =    Lmin)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));

    equation
      connect(variableInductor.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(variableInductor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(L, variableInductor.L)
        annotation (Line(points={{0,100},{0,10.8}}, color={0,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Text(
              extent={{-150,-100},{150,-40}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,40},{100,80}},
              lineColor={0,0,0},
              textString="m=%m"),
            Line(points={{-90,0},{-60,0}}, color={0,0,255}),
            Line(points={{60,0},{90,0}}, color={0,0,255}),
            Line(points={{0,90},{0,8}}, color={0,0,255}),
            Ellipse(extent={{-60,-15},{-30,15}}, lineColor={0,0,255}),
            Ellipse(extent={{-30,-15},{0,15}}, lineColor={0,0,255}),
            Ellipse(extent={{0,-15},{30,15}}, lineColor={0,0,255}),
            Ellipse(extent={{30,-15},{60,15}}, lineColor={0,0,255}),
            Rectangle(
              extent={{-60,-30},{60,0}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
          Documentation(                                                     info="<HTML>
<p>
Contains m variable inductors (Modelica.Electrical.Analog.Basic.VariableInductor)
</p>
<P>
It is required that each L_Port.signal &ge; 0, otherwise an
assertion is raised. To avoid a variable index system,<br>
L = Lmin, if 0 &le; L_Port.signal &lt; Lmin, where
Lmin is a parameter with default value Modelica.Constants.eps.
</P>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                graphics));
    end VariableInductor;
    annotation (Documentation(info="<HTML>
<p>
This package contains basic analog electrical multiphase components.
</p>

</HTML>", revisions="<html>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Release Notes:</b></dt>
  <dd>
  <ul>
  <li> v1.0 2004/10/01 Anton Haumer</li>
  </ul>
  </dd>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Rectangle(
            extent={{-80,-10},{60,-70}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{60,-40},{80,-40}}, color={0,0,255}),
          Line(points={{-100,-40},{-80,-40}}, color={0,0,255})}));
  end Basic;

  package Ideal "Multiphase components with idealized behaviour"
    extends Modelica.Icons.Library2;

    model IdealThyristor "Multiphase ideal thyristor"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m), start= fill(1.E-5, m))
        "Closed thyristor resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start = fill(1.E-5, m))
        "Opened thyristor conductance";
      parameter Modelica.SIunits.Voltage Vknee[m](final min=zeros(m), start = zeros(m))
        "Treshold voltage";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, final T=fill(293.15,m));
      Modelica.Blocks.Interfaces.BooleanInput fire[m]
        annotation (Placement(transformation(
            origin={70,110},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.Analog.Ideal.IdealThyristor idealThyristor[m](
        final Ron=Ron,
        final Goff=Goff,
        final Vknee=Vknee,
        each final useHeatPort=useHeatPort) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}}, rotation=0)));
    equation
      connect(plug_p.pin, idealThyristor.p)
        annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
      connect(idealThyristor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(fire, idealThyristor.fire) annotation (Line(points={{70,110},{70,
              80},{7,80},{7,11}}, color={255,0,255}));
      connect(idealThyristor.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}},
          color={191,0,0},
          pattern=LinePattern.None,
          smooth=Smooth.None));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,-40},{150,-100}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{-90,0},{40,0}}, color={0,0,255}),
            Polygon(
              points={{30,0},{-30,40},{-30,-40},{30,0}},
              lineColor={0,0,0},
              fillColor={255,255,255}),
            Line(points={{30,40},{30,-40}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255}),
            Line(points={{40,50},{60,30}}, color={0,0,255}),
            Line(points={{30,20},{70,60},{70,90}}, color={0,0,255}),
            Text(
              extent={{-100,100},{60,60}},
              lineColor={0,0,0},
              textString="m=%m")}),
        Documentation(info="<HTML>
<p>
Contains m ideal thyristors (Modelica.Electrical.Analog.Ideal.IdealThyristor).
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                {100,100}}),
                graphics));
    end IdealThyristor;

    model IdealGTOThyristor "Multiphase ideal GTO thyristor"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m), start = fill(1.E-5, m))
        "Closed thyristor resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start = fill(1.E-5, m))
        "Opened thyristor conductance";
      parameter Modelica.SIunits.Voltage Vknee[m](final min=zeros(m), start = zeros(m))
        "Treshold voltage";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, final T=fill(293.15,m));
      Modelica.Blocks.Interfaces.BooleanInput fire[m]
        annotation (Placement(transformation(
            origin={70,110},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor idealGTOThyristor[m](
        final Ron=Ron,
        final Goff=Goff,
        final Vknee=Vknee,
        each final useHeatPort=useHeatPort) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}}, rotation=0)));
    equation
      connect(idealGTOThyristor.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(idealGTOThyristor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(fire, idealGTOThyristor.fire) annotation (Line(points={{70,110},{
              70,80},{7,80},{7,11}}, color={255,0,255}));
      connect(idealGTOThyristor.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}},
          color={191,0,0},
          pattern=LinePattern.None,
          smooth=Smooth.None));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,-40},{150,-100}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{-90,0},{40,0}}, color={0,0,255}),
            Polygon(
              points={{30,0},{-30,40},{-30,-40},{30,0}},
              lineColor={0,0,0},
              fillColor={255,255,255}),
            Line(points={{30,40},{30,-40}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255}),
            Line(points={{40,50},{60,30}}, color={0,0,255}),
            Line(points={{30,20},{70,60},{70,90}}, color={0,0,255}),
            Text(
              extent={{-100,100},{60,60}},
              lineColor={0,0,0},
              textString="m=%m")}),
        Documentation(info="<HTML>
<p>
Contains m ideal GTO thyristors (Modelica.Electrical.Analog.Ideal.IdealGTOThyristor).
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                {100,100}}),
                graphics));
    end IdealGTOThyristor;

    model IdealCommutingSwitch "Multiphase ideal commuting switch"
      parameter Integer m(final min=1) = 3 "number of phases";
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m), start = fill(1.E-5, m))
        "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start = fill(1.E-5, m))
        "Opened switch conductance";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, final T=fill(293.15,m));
      Modelica.Blocks.Interfaces.BooleanInput control[m]
        "true => p--n2 connected, false => p--n1 connected" annotation (Placement(
            transformation(
            origin={0,80},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Interfaces.PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
              rotation=0)));
      Interfaces.NegativePlug plug_n2(final m=m)
        annotation (Placement(transformation(extent={{90,-10},{110,10}},
              rotation=0)));
      Interfaces.NegativePlug plug_n1(final m=m)
        annotation (Placement(transformation(extent={{90,40},{110,60}},
              rotation=0)));
      Modelica.Electrical.Analog.Ideal.IdealCommutingSwitch
        idealCommutingSwitch[                                                    m](
        final Ron=Ron,
        final Goff=Goff,
        each final useHeatPort=useHeatPort)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
    equation
      connect(plug_p.pin, idealCommutingSwitch.p) annotation (Line(
          points={{-100,0},{-10,0}},
          color={0,0,255}));
      connect(idealCommutingSwitch.n2, plug_n2.pin) annotation (Line(
          points={{10,0},{100,0}},
          color={0,0,255}));
      connect(idealCommutingSwitch.n1, plug_n1.pin) annotation (Line(
          points={{10,5},{10,50},{100,50}},
          color={0,0,255}));
      connect(control, idealCommutingSwitch.control)
        annotation (Line(points={{0,80},{0,8}}, color={255,0,255}));
      connect(idealCommutingSwitch.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}},
          color={191,0,0},
          pattern=LinePattern.None,
          smooth=Smooth.None));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,-40},{150,-100}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,100},{-20,60}},
              lineColor={0,0,0},
              textString="m="),
            Text(
              extent={{20,100},{100,60}},
              lineColor={0,0,0},
              textString="%m"),
            Ellipse(extent={{-44,4},{-36,-4}}, lineColor={0,0,255}),
            Line(points={{-90,0},{-44,0}}, color={0,0,255}),
            Line(points={{-37,2},{40,50}}, color={0,0,255}),
            Line(points={{40,50},{90,50}}, color={0,0,255}),
            Line(points={{0,90},{0,25}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255})}),
        Documentation(info="<HTML>
<p>
Contains m ideal commuting switches (Modelica.Electrical.Analog.Ideal.IdealCommutingSwitch).
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                {100,100}}),
                graphics));
    end IdealCommutingSwitch;

    model IdealIntermediateSwitch "Multiphase ideal intermediate switch"
      parameter Integer m(final min=1) = 3 "number of phases";
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m), start = fill(1.E-5, m))
        "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start = fill(1.E-5, m))
        "Opened switch conductance";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, final T=fill(293.15,m));
      Modelica.Blocks.Interfaces.BooleanInput control[m]
        "true => p1--n2, p2--n1 connected, otherwise p1--n1, p2--n2 connected"
            annotation (Placement(transformation(
            origin={0,80},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Interfaces.PositivePlug plug_p1(final m=m)
        annotation (Placement(transformation(extent={{-110,40},{-90,60}},
              rotation=0)));
      Interfaces.PositivePlug plug_p2(final m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}},
              rotation=0)));
      Interfaces.NegativePlug plug_n2(final m=m)
        annotation (Placement(transformation(extent={{90,-10},{110,10}},
              rotation=0)));
      Interfaces.NegativePlug plug_n1(final m=m)
        annotation (Placement(transformation(extent={{90,40},{110,60}},
              rotation=0)));
      Modelica.Electrical.Analog.Ideal.IdealIntermediateSwitch
        idealIntermediateSwitch[m](
        final Ron=Ron,
        final Goff=Goff,
        each final useHeatPort=useHeatPort)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
    equation
      connect(plug_p2.pin, idealIntermediateSwitch.p2) annotation (Line(
          points={{-100,0},{-10,0}},
          color={0,0,255}));
      connect(idealIntermediateSwitch.n2, plug_n2.pin) annotation (Line(
          points={{10,0},{100,0}},
          color={0,0,255}));
      connect(idealIntermediateSwitch.p1, plug_p1.pin) annotation (Line(
          points={{-10,5},{-10,50},{-100,50}},
          color={0,0,255}));
      connect(idealIntermediateSwitch.n1, plug_n1.pin) annotation (Line(
          points={{10,5},{10,50},{100,50}},
          color={0,0,255}));
      connect(control, idealIntermediateSwitch.control)
        annotation (Line(points={{0,80},{0,8}}, color={255,0,255}));
      connect(idealIntermediateSwitch.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}},
          color={191,0,0},
          pattern=LinePattern.None,
          smooth=Smooth.None));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,-40},{150,-100}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,100},{-20,60}},
              lineColor={0,0,0},
              textString="m="),
            Text(
              extent={{20,100},{100,60}},
              lineColor={0,0,0},
              textString="%m"),
            Ellipse(extent={{-4,30},{4,22}}, lineColor={0,0,255}),
            Line(points={{-90,0},{-44,0}}, color={0,0,255}),
            Line(points={{-90,50},{-44,50}}, color={0,0,255}),
            Line(points={{-44,0},{40,50}}, color={0,0,255}),
            Line(points={{-44,50},{40,0}}, color={0,0,255}),
            Line(points={{40,50},{90,50}}, color={0,0,255}),
            Line(points={{0,90},{0,25}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255})}),
        Documentation(info="<HTML>
<p>
Contains m ideal intermediate switches (Modelica.Electrical.Analog.Ideal.IdealIntermediateSwitch).
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                {100,100}}),
                graphics));
    end IdealIntermediateSwitch;

    model IdealDiode "Multiphase ideal diode"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m), start = fill(1.E-5, m))
        "Closed diode resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start = fill(1.E-5, m))
        "Opened diode conductance";
      parameter Modelica.SIunits.Voltage Vknee[m](final min=zeros(m), start = zeros(m))
        "Treshold voltage";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, final T=fill(293.15,m));
      Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode[m](
        final Ron=Ron,
        final Goff=Goff,
        final Vknee=Vknee,
        each final useHeatPort=useHeatPort) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}}, rotation=0)));
    equation
      connect(plug_p.pin, idealDiode.p)
        annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
      connect(idealDiode.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,-40},{150,-100}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{-90,0},{40,0}}, color={0,0,255}),
            Polygon(
              points={{30,0},{-30,40},{-30,-40},{30,0}},
              lineColor={0,0,0},
              fillColor={255,255,255}),
            Line(points={{30,40},{30,-40}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-80,100},{80,60}},
              lineColor={0,0,0},
              textString="m=%m")}),
        Documentation(info="<HTML>
<p>
Contains m ideal diodes (Modelica.Electrical.Analog.Ideal.IdealDiode).
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                graphics));
    end IdealDiode;

    model IdealTransformer "Multiphase ideal transformer"
      extends Interfaces.FourPlug;
      parameter Real n[m](start=fill(1, m)) "Turns ratio";
      parameter Boolean considerMagnetization=false;
      parameter SIunits.Inductance Lm1[m](start=fill(1,m))
        "Magnetization inductances w.r.t. primary side";
      Modelica.Electrical.Analog.Ideal.IdealTransformer idealTransformer[m](
          final n=n,
          each final considerMagnetization=considerMagnetization,
          final Lm1=Lm1)     annotation (Placement(transformation(extent={{-10,-10},{10,
                10}}, rotation=0)));
    equation
      connect(plug_p1.pin, idealTransformer.p1)
        annotation (Line(points={{-100,100},{-10,100},{-10,5}}, color={0,0,255}));
      connect(plug_p2.pin, idealTransformer.p2)
        annotation (Line(points={{100,100},{10,100},{10,5}}, color={0,0,255}));
      connect(plug_n1.pin, idealTransformer.n1)
        annotation (Line(points={{-100,-100},{-10,-100},{-10,-5}}, color={0,0,
              255}));
      connect(plug_n2.pin, idealTransformer.n2)
        annotation (Line(points={{100,-100},{10,-100},{10,-5}}, color={0,0,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-80,100},{80,60}},
              lineColor={0,0,0},
              textString="m=%m"),
            Text(
              extent={{-100,-100},{100,-40}},
              lineColor={0,0,255},
              textString="%name"),
            Ellipse(extent={{-80,50},{20,-50}}, lineColor={0,0,255}),
            Ellipse(extent={{-20,50},{80,-50}}, lineColor={0,0,255}),
            Text(
              extent={{-20,20},{20,-20}},
              lineColor={0,0,255},
              textString="="),
            Line(
              points={{-96,50},{-30,50}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{30,50},{96,50}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{30,-50},{96,-50}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{-96,-50},{-30,-50}},
              color={0,0,255},
              smooth=Smooth.None)}),
        Documentation(info="<HTML>
<p>
Contains m ideal transformers (Modelica.Electrical.Analog.Ideal.IdealTransformer).
</p>
<p>
<b>Note:</b> Due to the above equations, also DC signals will be transformed!
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                graphics));
    end IdealTransformer;

    model Idle "Multiphase idle branch"
      extends Interfaces.TwoPlug;
      Modelica.Electrical.Analog.Ideal.Idle idle[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
    equation

      connect(plug_p.pin, idle.p) annotation (Line(
          points={{-100,0},{-10,0}},
          color={0,0,255}));
      connect(idle.n, plug_n.pin) annotation (Line(
          points={{10,0},{100,0}},
          color={0,0,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,50},{150,110}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,-100},{100,-60}},
              lineColor={0,0,0},
              textString="m=%m"),
            Rectangle(
              extent={{-60,60},{60,-60}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Line(points={{-90,0},{-41,0}}, color={0,0,255}),
            Line(points={{91,0},{40,0}}, color={0,0,255})}),
        Documentation(info="<HTML>
<p>
Contains m idles (Modelica.Electrical.Analog.Ideal.Idle)
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                graphics));
    end Idle;

    model Short "Multiphase short cut branch"
      extends Interfaces.TwoPlug;
      Modelica.Electrical.Analog.Ideal.Short short[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
    equation

      connect(plug_p.pin, short.p) annotation (Line(
          points={{-100,0},{-10,0}},
          color={0,0,255}));
      connect(short.n, plug_n.pin) annotation (Line(
          points={{10,0},{100,0}},
          color={0,0,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,50},{150,110}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,-100},{100,-60}},
              lineColor={0,0,0},
              textString="m=%m"),
            Rectangle(
              extent={{-60,60},{60,-60}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Line(points={{-90,0},{90,0}}, color={0,0,255})}),
        Documentation(info="<HTML>
<p>
Contains m short cuts (Modelica.Electrical.Analog.Ideal.Short)
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                graphics));
    end Short;

    model IdealOpeningSwitch "Multiphase ideal opener"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m), start = fill(1.E-5, m))
        "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start = fill(1.E-5, m))
        "Opened switch conductance";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, final T=fill(293.15,m));
      Modelica.Blocks.Interfaces.BooleanInput control[m]
        "true => switch open, false => p--n connected" annotation (Placement(
            transformation(
            origin={0,70},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch idealOpeningSwitch[m](
        final Ron=Ron,
        final Goff=Goff,
        each final useHeatPort=useHeatPort) annotation (Placement(transformation(extent={{-10,
                -10},{10,10}}, rotation=0)));
    equation
      connect(plug_p.pin, idealOpeningSwitch.p)
        annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
      connect(idealOpeningSwitch.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(control, idealOpeningSwitch.control)
        annotation (Line(points={{0,70},{0,7}}, color={255,0,255}));
      connect(idealOpeningSwitch.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}},
          color={191,0,0},
          pattern=LinePattern.None,
          smooth=Smooth.None));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,-40},{150,-100}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{-90,0},{-44,0}}, color={0,0,255}),
            Ellipse(extent={{-44,4},{-36,-4}}, lineColor={0,0,255}),
            Line(points={{-37,2},{40,50}}, color={0,0,255}),
            Line(points={{0,88},{0,26}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-100,100},{-20,60}},
              lineColor={0,0,0},
              textString="m="),
            Text(
              extent={{20,100},{100,60}},
              lineColor={0,0,0},
              textString="%m"),
            Line(points={{40,20},{40,0}}, color={0,0,255})}),
        Documentation(info="<HTML>
<p>
Contains m ideal opening switches (Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch).
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                {100,100}}),
                graphics));
    end IdealOpeningSwitch;

    model IdealClosingSwitch "Multiphase ideal closer"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m), start = fill(1.E-5, m))
        "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start = fill(1.E-5, m))
        "Opened switch conductance";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, final T=fill(293.15,m));
      Modelica.Blocks.Interfaces.BooleanInput control[m]
        "true => p--n connected, false => switch open" annotation (Placement(
            transformation(
            origin={0,70},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealClosingSwitch[m](
        final Ron=Ron,
        final Goff=Goff,
        each final useHeatPort=useHeatPort) annotation (Placement(transformation(extent={{-10,
                -10},{10,10}}, rotation=0)));
    equation
      connect(plug_p.pin, idealClosingSwitch.p)
        annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
      connect(idealClosingSwitch.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(control, idealClosingSwitch.control)
        annotation (Line(points={{0,70},{0,7}}, color={255,0,255}));
      connect(idealClosingSwitch.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}},
          color={191,0,0},
          pattern=LinePattern.None,
          smooth=Smooth.None));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,-40},{150,-100}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{-90,0},{-44,0}}, color={0,0,255}),
            Ellipse(extent={{-44,4},{-36,-4}}, lineColor={0,0,255}),
            Line(points={{-37,2},{40,50}}, color={0,0,255}),
            Line(points={{0,88},{0,26}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-100,100},{-20,60}},
              lineColor={0,0,0},
              textString="m="),
            Text(
              extent={{20,100},{100,60}},
              lineColor={0,0,0},
              textString="%m")}),
        Documentation(info="<HTML>
<p>
Contains m ideal closing switches (Modelica.Electrical.Analog.Ideal.IdealClosingSwitch).
</p><
/HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                {100,100}}),
                graphics));
    end IdealClosingSwitch;

    model OpenerWithArc "Multiphase opener with arc"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m), start = fill(1.E-5, m))
        "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start = fill(1.E-5, m))
        "Opened switch conductance";
      parameter Modelica.SIunits.Voltage V0[m](start=fill(30,m))
        "Initial arc voltage";
      parameter Modelica.SIunits.VoltageSlope dVdt[m](start=fill(10E3,m))
        "Arc voltage slope";
      parameter Modelica.SIunits.Voltage Vmax[m](start=fill(60,m))
        "Max. arc voltage";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, final T=fill(293.15,m));
      Modelica.Blocks.Interfaces.BooleanInput control[m]
        "true => switch open, false => p--n connected" annotation (Placement(
            transformation(
            origin={0,70},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.Analog.Ideal.OpenerWithArc openerWithArc[m](
        final Ron=Ron,
        final Goff=Goff,
        final V0=V0,
        final dVdt=dVdt,
        final Vmax=Vmax,
        each final useHeatPort=useHeatPort) annotation (Placement(transformation(extent={{-10,
                -10},{10,10}}, rotation=0)));
    equation
      connect(plug_p.pin, openerWithArc.p)
        annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
      connect(openerWithArc.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(control, openerWithArc.control)
        annotation (Line(points={{0,70},{0,10}},color={255,0,255}));
      connect(openerWithArc.heatPort, heatPort)      annotation (Line(
          points={{0,-10},{0,-100}},
          color={191,0,0},
          pattern=LinePattern.None,
          smooth=Smooth.None));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,-40},{150,-100}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{-90,0},{-44,0}}, color={0,0,255}),
            Ellipse(extent={{-44,4},{-36,-4}}, lineColor={0,0,255}),
            Line(points={{-37,2},{40,50}}, color={0,0,255}),
            Line(points={{0,88},{0,26}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-100,100},{-20,60}},
              lineColor={0,0,0},
              textString="m="),
            Text(
              extent={{20,100},{100,60}},
              lineColor={0,0,0},
              textString="%m"),
            Line(points={{40,20},{40,0}}, color={0,0,255}),
            Line(points={{40,50},{32,34},{48,30},{40,20}}, color={255,0,0})}),
        Documentation(info="<html>
<p>Contains m opening switches with arc (Modelica.Electrical.Analog.Ideal.OpenerWithArc). </p>
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                {100,100}}),
                graphics));
    end OpenerWithArc;

    model CloserWithArc "Multiphase closer with arc"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m), start = fill(1.E-5, m))
        "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start = fill(1.E-5, m))
        "Opened switch conductance";
      parameter Modelica.SIunits.Voltage V0[m](start=fill(30,m))
        "Initial arc voltage";
      parameter Modelica.SIunits.VoltageSlope dVdt[m](start=fill(10E3,m))
        "Arc voltage slope";
      parameter Modelica.SIunits.Voltage Vmax[m](start=fill(60,m))
        "Max. arc voltage";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(final mh=m, final T=fill(293.15,m));
      Modelica.Blocks.Interfaces.BooleanInput control[m]
        "true => switch open, false => p--n connected" annotation (Placement(
            transformation(
            origin={0,70},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.Analog.Ideal.CloserWithArc closerWithArc[m](
        final Ron=Ron,
        final Goff=Goff,
        final V0=V0,
        final dVdt=dVdt,
        final Vmax=Vmax,
        each final useHeatPort=useHeatPort) annotation (Placement(transformation(extent={{-10,
                -10},{10,10}}, rotation=0)));
    equation
      connect(plug_p.pin,closerWithArc. p)
        annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
      connect(closerWithArc.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(control,closerWithArc. control)
        annotation (Line(points={{0,70},{0,10}},color={255,0,255}));
      connect(closerWithArc.heatPort, heatPort)      annotation (Line(
          points={{0,-10},{0,-100}},
          color={191,0,0},
          pattern=LinePattern.None,
          smooth=Smooth.None));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-150,-40},{150,-100}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{-90,0},{-44,0}}, color={0,0,255}),
            Ellipse(extent={{-44,4},{-36,-4}}, lineColor={0,0,255}),
            Line(points={{-37,2},{40,50}}, color={0,0,255}),
            Line(points={{0,88},{0,26}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-100,100},{-20,60}},
              lineColor={0,0,0},
              textString="m="),
            Text(
              extent={{20,100},{100,60}},
              lineColor={0,0,0},
              textString="%m"),
            Line(points={{40,50},{32,24},{48,28},{40,0}}, color={255,0,0})}),
        Documentation(info="<html>
<p>Contains m closing switches with arc (Modelica.Electrical.Analog.Ideal.CloserWithArc). </p>
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
                {100,100}}),
                graphics));
    end CloserWithArc;
    annotation (Documentation(info="<HTML>
<p>
This package contains analog electrical multiphase components with idealized behaviour,
like thyristor, diode, switch, transformer.
</p>

</HTML>", revisions="<html>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Release Notes:</b></dt>
  <dd>
  <ul>
  <li> v1.0 2004/10/01 Anton Haumer</li>
  </ul>
  </dd>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Line(points={{-100,-40},{80,-40}}, color={0,0,255}),
          Polygon(
            points={{20,-40},{-40,0},{-40,-80},{20,-40}},
            lineColor={0,0,0},
            fillColor={255,255,255}),
          Line(points={{20,0},{20,-80}}, color={0,0,255})}));
  end Ideal;

  package Interfaces "Interfaces for electrical multiphase models"
    extends Modelica.Icons.Library2;

    connector Plug "Plug with m pins for an electric component"
      parameter Integer m(final min=1) = 3 "number of phases";
      Modelica.Electrical.Analog.Interfaces.Pin pin[m];

      annotation (Documentation(info="<HTML>
<p>
Connectors PositivePlug and NegativePlug are nearly identical.
The only difference is that the icons are different in order
to identify more easily the plugs of a component.
Usually, connector PositivePlug is used for the positive and
connector NegativePlug for the negative plug of an electrical component.<br>
Connector Plug is a composite connector containing m Pins (Modelica.Electrical.Analog.Interfaces.Pin).
</p>
</HTML>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
              extent={{-100,-99},{100,-179}},
              lineColor={0,0,255},
              textString="%name")}));
    end Plug;

    connector PositivePlug "Positive plug with m pins"
      extends Plug;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Ellipse(
              extent={{-40,40},{40,-40}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<HTML>
<p>
Connectors PositivePlug and NegativePlug are nearly identical.
The only difference is that the icons are different in order
to identify more easily the plugs of a component.
Usually, connector PositivePlug is used for the positive and
connector NegativePlug for the negative plug of an electrical component.<br>
Connector Plug is a composite connector containing m Pins (Modelica.Electrical.Analog.Interfaces.Pin).
</p>
</HTML>"));

    end PositivePlug;

    connector NegativePlug "Negative plug with m pins"
      extends Plug;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Ellipse(
              extent={{-40,40},{40,-40}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<HTML>
<p>
Connectors PositivePlug and NegativePlug are nearly identical.
The only difference is that the icons are different in order
to identify more easily the plugs of a component.
Usually, connector PositivePlug is used for the positive and
connector NegativePlug for the negative plug of an electrical component.<br>
Connector Plug is a composite connector containing m Pins (Modelica.Electrical.Analog.Interfaces.Pin).
</p>
</HTML>"));
    end NegativePlug;

    partial model ConditionalHeatPort
      "Partial model to include conditional HeatPorts in order to describe the power loss via a thermal network"
      parameter Integer mh(min=1)=3 "Number of heatPorts=number of phases";
      parameter Boolean useHeatPort = false
        "=true, if all HeatPorts are enabled"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
      parameter Modelica.SIunits.Temperature T[mh]=fill(293.15, mh)
        "Fixed device temperatures if useHeatPort = false" annotation(Dialog(enable=not useHeatPort));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort[mh] if useHeatPort
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),
            iconTransformation(extent={{-10,-110},{10,-90}})));
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}),                                                                 graphics),
        Documentation(revisions="<html>
<p><ul>
<li><i>August 26, 2009 </i>by Anton Haumer initially implemented</li>
</ul></p>
</html>",     info="<html>
<p>
This partial model provides conditional heat ports for the connection to a thermal network.
</p>
<ul>
<li> If <b>useHeatPort</b> is set to <b>false</b> (default), no heat port is available, and the thermal
     loss power flows internally to the ground. In this case, the parameter <b>T</b> specifies
     the fixed device temperatures.</li>.
<li> If <b>useHeatPort</b> is set to <b>true</b>, all heat ports are available.</li>
</ul>
</html>"));
    end ConditionalHeatPort;

    partial model TwoPlug "Component with one m-phase electric port"
      parameter Integer m(min=1) = 3 "number of phases";
      Modelica.SIunits.Voltage v[m] "Voltage drops between the two plugs";
      Modelica.SIunits.Current i[m] "Currents flowing into positive plugs";
      PositivePlug plug_p(final m=m) annotation (Placement(transformation(
              extent={{-110,-10},{-90,10}}, rotation=0)));
      NegativePlug plug_n(final m=m) annotation (Placement(transformation(
              extent={{90,-10},{110,10}}, rotation=0)));
    equation
      v = plug_p.pin.v - plug_n.pin.v;
      i = plug_p.pin.i;
      annotation (Documentation(info="<HTML>
<p>
Superclass of elements which have <b>two</b> electrical plugs:
the positive plug connector <i>plug_p</i>, and the negative plug connector <i>plug_n</i>.
The currents flowing into plug_p are provided explicitly as currents i[m].
</p>
</HTML>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),
                   graphics));
    end TwoPlug;

    partial model OnePort
      "Component with two electrical plugs and currents from plug_p to plug_n"

      extends TwoPlug;
    equation
      plug_p.pin.i + plug_n.pin.i = zeros(m);
      annotation (Documentation(info="<HTML>
<p>
Superclass of elements which have <b>two</b> electrical plugs:
the positive plug connector <i>plug_p</i>, and the negative plug connector <i>plug_n</i>.
The currents flowing into plug_p are provided explicitly as currents i[m].
It is assumed that the currents flowing into plug_p are identical to the currents flowing out of plug_n.
</p>
</HTML>"));
    end OnePort;

    partial model FourPlug "Component with two m-phase electric ports"
      parameter Integer m(final min=1) = 3 "number of phases";
      Modelica.SIunits.Voltage v1[m] "Voltage drops over the left port";
      Modelica.SIunits.Voltage v2[m] "Voltage drops over the right port";
      Modelica.SIunits.Current i1[m]
        "Current flowing into positive plug of the left port";
      Modelica.SIunits.Current i2[m]
        "Current flowing into positive plug of the right port";
      PositivePlug plug_p1(final m=m) annotation (Placement(transformation(
              extent={{-110,90},{-90,110}}, rotation=0)));
      PositivePlug plug_p2(final m=m) annotation (Placement(transformation(
              extent={{90,90},{110,110}}, rotation=0)));
      NegativePlug plug_n1(final m=m) annotation (Placement(transformation(
              extent={{-110,-110},{-90,-90}}, rotation=0)));
      NegativePlug plug_n2(final m=m) annotation (Placement(transformation(
              extent={{90,-110},{110,-90}}, rotation=0)));
    equation
      v1 = plug_p1.pin.v - plug_n1.pin.v;
      v2 = plug_p2.pin.v - plug_n2.pin.v;
      i1 = plug_p1.pin.i;
      i2 = plug_p2.pin.i;
      annotation (Documentation(info="<HTML>
<p>
Superclass of elements which have <b>four</b> electrical plugs.
</p>
</HTML>"));
    end FourPlug;

    partial model TwoPort
      "Component with two m-phase electric ports, including currents"
      extends FourPlug;
    equation
      plug_p1.pin.i + plug_n1.pin.i = zeros(m);
      plug_p2.pin.i + plug_n2.pin.i = zeros(m);
      annotation (Documentation(info="<HTML>
<p>
Superclass of elements which have <b>four</b> electrical plugs.
It is assumed that the currents flowing into plug_p1 are identical to the currents flowing out of plug_n1,
and that the currents flowing into plug_p2 are identical to the currents flowing out of plug_n2.
</p>
</HTML>"));
    end TwoPort;
    annotation (Documentation(info="<HTML>
<p>
This package contains connectors and interfaces (partial models) for
electrical multiphase components, based on Modelica.Electrical.Analog.
</p>

</HTML>", revisions="<html>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Release Notes:</b></dt>
  <dd>
  <ul>
  <li>v1.0 2004/10/01 Anton Haumer</li>
  <li>v1.2 2006/05/12 Anton Haumer<br>
      removed annotation from pin of Interfaces.Plug</li>
  </ul>
  </dd>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Ellipse(extent={{-60,10},{40,-90}}, lineColor={0,0,255}),
          Ellipse(
            extent={{-40,-14},{-20,-34}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{0,-14},{20,-34}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-20,-54},{0,-74}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid)}));
  end Interfaces;

  package Sensors "Multiphase potential, voltage and current Sensors"
    extends Modelica.Icons.Library2;

    model PotentialSensor "Multiphase potential sensor"
      extends Modelica.Icons.RotationalSensor;
      parameter Integer m(final min=1) = 3 "number of phases";
      Interfaces.PositivePlug plug_p(final m=m)
                                        annotation (Placement(transformation(
              extent={{-110,-10},{-90,10}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealOutput phi[m]
        "Absolute voltage potential as output signal"
          annotation (Placement(transformation(extent={{100,-10},{120,10}},
              rotation=0)));
      Modelica.Electrical.Analog.Sensors.PotentialSensor potentialSensor[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
    equation
      connect(potentialSensor.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(potentialSensor.phi, phi)
        annotation (Line(points={{11,0},{110,0}}, color={0,0,255}));
      annotation (
        Icon(graphics={
            Line(points={{70,0},{100,0}}, color={0,0,255}),
            Line(points={{-70,0},{-90,0}}, color={0,0,0}),
            Text(
              extent={{-100,-70},{100,-110}},
              lineColor={0,0,0},
              textString="m=%m"),
            Text(
              extent={{-150,60},{150,120}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<HTML>
<p>
Contains m potential sensors (Modelica.Electrical.Analog.Sensors.PotentialSensor),
thus measuring the m potentials <i>phi[m]</i> of the m pins of plug_p.
</p>
</HTML>"),
        Diagram(graphics));
    end PotentialSensor;

    model VoltageSensor "Multiphase voltage sensor"
      extends Modelica.Icons.RotationalSensor;
      parameter Integer m(final min=1) = 3 "number of phases";
      Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
      Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
            transformation(extent={{90,-10},{110,10}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealOutput v[m]
        "Voltage between pin p and n (= p.v - n.v) as output signal"
         annotation (Placement(transformation(
            origin={0,-110},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
    equation
      connect(voltageSensor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(voltageSensor.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(voltageSensor.v, v)
        annotation (Line(points={{0,-10},{0,-110}}, color={0,0,255}));
      annotation (
        Icon(graphics={
            Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString="V"),
            Text(
              extent={{-100,60},{100,120}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,-60},{-20,-100}},
              lineColor={0,0,0},
              textString="m="),
            Line(points={{-70,0},{-90,0}}, color={0,0,0}),
            Line(points={{70,0},{90,0}}, color={0,0,0}),
            Line(points={{0,-100},{0,-70}}, color={0,0,255}),
            Text(
              extent={{20,-60},{100,-100}},
              lineColor={0,0,0},
              textString="%m")}),
        Documentation(info="<HTML>
<p>
Contains m voltage sensors (Modelica.Electrical.Analog.Sensors.VoltageSensor),
thus measuring the m potential differences <i>v[m]</i> between the m pins of plug_p and plug_n.
</p>
</HTML>"),
        Diagram(graphics));
    end VoltageSensor;

    model CurrentSensor "Multiphase current sensor"
      extends Modelica.Icons.RotationalSensor;
      parameter Integer m(final min=1) = 3 "number of phases";
      Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
      Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
            transformation(extent={{90,-10},{110,10}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealOutput i[m]
        "current in the branch from p to n as output signal"
         annotation (Placement(transformation(
            origin={0,-110},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
    equation
      connect(plug_p.pin, currentSensor.p)
        annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
      connect(currentSensor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(currentSensor.i, i)
        annotation (Line(points={{0,-10},{0,-110}}, color={0,0,255}));
      annotation (
        Icon(graphics={
            Text(
              extent={{-29,-11},{30,-70}},
              lineColor={0,0,0},
              textString="A"),
            Text(
              extent={{-150,60},{150,120}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,-60},{-20,-100}},
              lineColor={0,0,0},
              textString="m="),
            Line(points={{-70,0},{-90,0}}, color={0,0,0}),
            Line(points={{70,0},{90,0}}, color={0,0,0}),
            Line(points={{0,-100},{0,-70}}, color={0,0,255}),
            Text(
              extent={{20,-60},{100,-100}},
              lineColor={0,0,0},
              textString="%m")}),
        Documentation(info="<HTML>
<p>
Contains m current sensors (Modelica.Electrical.Analog.Sensors.CurrentSensor),
thus measuring the m currents <i>i[m]</i> flowing from the m pins of plug_p to the m pins of plug_n.
</p>
</HTML>"),
        Diagram(graphics));
    end CurrentSensor;

  model PowerSensor "Multiphase instantaneous power sensor"
    parameter Integer m(min=1) = 3 "number of phases";
    MultiPhase.Interfaces.PositivePlug pc(final m=m)
        "Positive plug, current path"
      annotation (Placement(transformation(extent={{-110,10},{-90,-10}},
              rotation=0)));
    MultiPhase.Interfaces.NegativePlug nc(final m=m)
        "Negative plug, current path"
      annotation (Placement(transformation(extent={{90,10},{110,-10}}, rotation=
               0)));
    MultiPhase.Interfaces.PositivePlug pv(final m=m)
        "Positive plug, voltage path"
      annotation (Placement(transformation(extent={{-10,90},{10,110}}, rotation=
               0)));
    MultiPhase.Interfaces.NegativePlug nv(final m=m)
        "Negative plug, voltage path"
      annotation (Placement(transformation(extent={{-10,-90},{10,-110}},
              rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput power
      annotation (Placement(transformation(
            origin={-80,-110},
            extent={{10,-10},{-10,10}},
            rotation=90)));
    MultiPhase.Sensors.VoltageSensor voltageSensor(final m=m)
      annotation (Placement(transformation(
            origin={0,-20},
            extent={{10,-10},{-10,10}},
            rotation=90)));
    MultiPhase.Sensors.CurrentSensor currentSensor(final m=m)
      annotation (Placement(transformation(extent={{-50,-10},{-30,10}},
              rotation=0)));
    Modelica.Blocks.Math.Product product[m]
      annotation (Placement(transformation(
            origin={-30,-40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
    Modelica.Blocks.Math.Sum sum(final nin=m, final k=ones(m))
      annotation (Placement(transformation(
            origin={-30,-70},
            extent={{10,-10},{-10,10}},
            rotation=90)));
  equation
    connect(pc, currentSensor.plug_p) annotation (Line(points={{-100,0},{-50,0}},
            color={0,0,255}));
    connect(currentSensor.plug_n, nc)
      annotation (Line(points={{-30,0},{100,0}}, color={0,0,255}));
    connect(voltageSensor.plug_p, pv) annotation (Line(points={{6.12323e-016,
              -10},{0,-10},{0,100}}, color={0,0,255}));
    connect(voltageSensor.plug_n, nv) annotation (Line(points={{-6.12323e-016,
              -30},{0,-30},{0,-100}}, color={0,0,255}));
    connect(currentSensor.i, product.u2) annotation (Line(points={{-40,-11},{
              -40,-20},{-36,-20},{-36,-28}}, color={0,0,127}));
    connect(product.u1, voltageSensor.v) annotation (Line(points={{-24,-28},{
              -24,-20},{11,-20}},  color={0,0,127}));
    connect(product.y, sum.u) annotation (Line(points={{-30,-51},{-30,-54.5},{
              -30,-54.5},{-30,-58}},
            color={0,0,127}));
    connect(sum.y, power) annotation (Line(points={{-30,-81},{-30,-90},{-80,-90},
              {-80,-110}}, color={0,0,127}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}), graphics={
            Line(points={{0,100},{0,70}}, color={0,0,255}),
            Line(points={{0,-70},{0,-100}}, color={0,0,255}),
            Line(points={{-80,-100},{-80,0}}, color={0,0,255}),
            Text(
              extent={{150,120},{-150,160}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{0,-80},{140,-120}},
              lineColor={0,0,0},
              textString="m=%m"),
            Ellipse(
              extent={{-70,70},{70,-70}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
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
              textString="P"),
            Line(points={{-100,0},{100,0}}, color={0,0,255})}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}),
              graphics),
      Documentation(info="<html><p>
This power sensor measures instantaneous electrical power of a multiphase system and has a separated voltage and current path. The plugs of the voltage path are <code>pv</code> and <code>nv</code>, the plugs of the current path are <code>pc</code> and <code>nc</code>. The internal resistance of each current path is zero, the internal resistance of each voltage path is infinite.
</p></html>"));
  end PowerSensor;
    annotation (Documentation(info="<HTML>
<p>
This package contains multiphase potential, voltage, and current sensors.
</p>

</HTML>", revisions="<html>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Release Notes:</b></dt>
  <dd>
  <ul>
  <li>v1.0 2004/10/01 Anton Haumer</li>
  <li>v1.1 2006/01/12 Anton Haumer<br>
      added PowerSensor</li>
  </ul>
  </dd>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Ellipse(
            extent={{-60,10},{40,-90}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{-50,-16},{-36,-25}}, color={0,0,0}),
          Line(points={{-35,0},{-25,-14}}, color={0,0,0}),
          Line(points={{-10,7},{-10,-10}}, color={0,0,0}),
          Line(points={{15,0},{5,-14}}, color={0,0,0}),
          Line(points={{30,-15},{16,-25}}, color={0,0,0}),
          Ellipse(
            extent={{-15,-35},{-5,-45}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-10,-40},{-6,-26}}, color={0,0,0}),
          Polygon(
            points={{-12,-24},{-0.5,-27},{2,1.5},{-12,-24}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}));
  end Sensors;

  package Sources "Multiphase voltage and current sources"
    extends Modelica.Icons.Library2;

    model SignalVoltage "Multiphase signal voltage source"
      parameter Integer m(min=1) = 3 "number of phases";
      Modelica.SIunits.Current i[m] "Currents flowing into positive plugs";
      Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
      Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
            transformation(extent={{90,-10},{110,10}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealInput v[m]
        "Voltage between pin p and n (= p.v - n.v) as input signal"
         annotation (Placement(transformation(
            origin={0,70},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
    equation
      i = plug_p.pin.i;
      connect(signalVoltage.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(signalVoltage.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(v, signalVoltage.v)
        annotation (Line(points={{0,70},{0,7}}, color={0,0,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{-90,0},{-50,0}}, color={0,0,255}),
            Line(points={{50,0},{90,0}}, color={0,0,255}),
            Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-50,0},{50,0}}, color={0,0,255}),
            Text(
              extent={{-150,-110},{150,-50}},
              textString="%name",
              lineColor={0,0,255}),
            Text(extent={{-100,100},{-20,60}}, lineColor={0,0,0}),
            Text(
              extent={{20,100},{100,60}},
              lineColor={0,0,0},
              textString="%m"),
            Text(
              extent={{30,60},{110,0}},
              lineColor={0,0,255},
              textString="-"),
            Text(
              extent={{-110,60},{-30,0}},
              lineColor={0,0,255},
              textString="+")}),
        Documentation(info="<HTML>
<p>
Contains m signal controlled voltage sources (Modelica.Electrical.Analog.Sources.SignalVoltage)
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                graphics));
    end SignalVoltage;

    model ConstantVoltage "Multiphase constant voltage source"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Voltage V[m](start=fill(1, m))
        "Value of constant voltage";
      Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage[m](
        final V=V) annotation (Placement(transformation(extent={{-10,-10},{10,
                10}}, rotation=0)));
    equation
      connect(constantVoltage.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(constantVoltage.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{-90,0},{-50,0}}, color={0,0,255}),
            Line(points={{50,0},{90,0}}, color={0,0,255}),
            Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-50,0},{50,0}}, color={0,0,255}),
            Text(
              extent={{-150,-110},{150,-50}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,100},{100,60}},
              lineColor={0,0,0},
              textString="m=%m"),
            Text(
              extent={{30,60},{110,0}},
              lineColor={0,0,255},
              textString="-"),
            Text(
              extent={{-110,60},{-30,0}},
              lineColor={0,0,255},
              textString="+")}),
        Documentation(info="<HTML>
<p>
Contains m constant voltage sources (Modelica.Electrical.Analog.Sources.ConstantVoltage)
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                graphics));
    end ConstantVoltage;

    model SineVoltage "Multiphase sine voltage source"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Voltage V[m](start=fill(1, m))
        "Amplitudes of sine waves";
      parameter Modelica.SIunits.Angle phase[m]=-{(j - 1)/m*2*Modelica.
          Constants.pi for j in 1:m} "Phases of sine waves";
      parameter Modelica.SIunits.Frequency freqHz[m](start=fill(1, m))
        "Frequencies of sine waves";
      parameter Modelica.SIunits.Voltage offset[m]=zeros(m) "Voltage offsets";
      parameter Modelica.SIunits.Time startTime[m]=zeros(m) "Time offsets";
      Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage[m](
        final V=V,
        final phase=phase,
        final freqHz=freqHz,
        final offset=offset,
        final startTime=startTime) annotation (Placement(transformation(extent=
                {{-10,-10},{10,10}}, rotation=0)));
    equation
      connect(sineVoltage.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(sineVoltage.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{-90,0},{-50,0}}, color={0,0,255}),
            Line(points={{50,0},{90,0}}, color={0,0,255}),
            Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-50,0},{50,0}}, color={0,0,255}),
            Line(points={{-70,0},{-60.2,29.9},{-53.8,46.5},{-48.2,58.1},{-43.3,
                  65.2},{-38.3,69.2},{-33.4,69.8},{-28.5,67},{-23.6,61},{-18.6,
                  52},{-13,38.6},{-5.98,18.6},{8.79,-26.9},{15.1,-44},{20.8,-56.2},
                  {25.7,-64},{30.6,-68.6},{35.5,-70},{40.5,-67.9},{45.4,-62.5},
                  {50.3,-54.1},{55.9,-41.3},{63,-21.7},{70,0}}, color={192,192,
                  192}),
            Text(
              extent={{-150,-110},{150,-50}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,100},{100,60}},
              lineColor={0,0,0},
              textString="m=%m"),
            Text(
              extent={{30,60},{110,0}},
              lineColor={0,0,255},
              textString="-"),
            Text(
              extent={{-110,60},{-30,0}},
              lineColor={0,0,255},
              textString="+")}),
        Documentation(info="<HTML>
<p>
Contains m sine voltage sources (Modelica.Electrical.Analog.Sources.SineVoltage)
with a default phase shift of -(j-1)/m * 2*pi for j in 1:m.
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                graphics));
    end SineVoltage;

    model SignalCurrent "Multiphase sine current source"
      parameter Integer m(min=1) = 3 "number of phases";
      Modelica.SIunits.Voltage v[m] "Voltage drops between the two plugs";
      Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
      Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
            transformation(extent={{90,-10},{110,10}}, rotation=0)));
      Modelica.Blocks.Interfaces.RealInput i[m]
        "Current flowing from pin p to pin n as input signal"
         annotation (Placement(transformation(
            origin={0,70},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0)));
    equation
      v = plug_p.pin.v - plug_n.pin.v;
      connect(signalCurrent.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(signalCurrent.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(i, signalCurrent.i)
        annotation (Line(points={{0,70},{0,7}}, color={0,0,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{-90,0},{-50,0}}, color={0,0,255}),
            Line(points={{50,0},{90,0}}, color={0,0,255}),
            Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{0,50},{0,-50}}, color={0,0,255}),
            Text(
              extent={{-150,-110},{150,-50}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,100},{-20,60}},
              lineColor={0,0,0},
              textString="m="),
            Text(
              extent={{20,100},{100,60}},
              lineColor={0,0,0},
              textString="%m"),
            Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<HTML>
<p>
Contains m signal controlled current sources (Modelica.Electrical.Analog.Sources.SignalCurrent)
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                graphics));
    end SignalCurrent;

    model ConstantCurrent "Multiphase constant current source"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Current I[m](start=fill(1, m))
        "Value of constant current";
      Modelica.Electrical.Analog.Sources.ConstantCurrent constantCurrent[m](
        final I=I) annotation (Placement(transformation(extent={{-10,-10},{10,
                10}}, rotation=0)));
    equation
      connect(constantCurrent.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(constantCurrent.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{-90,0},{-50,0}}, color={0,0,255}),
            Line(points={{50,0},{90,0}}, color={0,0,255}),
            Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{0,50},{0,-50}}, color={0,0,255}),
            Text(
              extent={{-150,-110},{150,-50}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,100},{100,60}},
              lineColor={0,0,0},
              textString="m=%m"),
            Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<HTML>
<p>
Contains m constant current sources (Modelica.Electrical.Analog.Sources.ConstantCurrent)
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                graphics));
    end ConstantCurrent;

    model SineCurrent "Multiphase sine current source"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Current I[m](start=fill(1, m))
        "Amplitudes of sine waves";
      parameter Modelica.SIunits.Angle phase[m]=-{(j - 1)/m*2*Modelica.
          Constants.pi for j in 1:m} "Phases of sine waves";
      parameter Modelica.SIunits.Frequency freqHz[m](start=fill(1, m))
        "Frequencies of sine waves";
      parameter Modelica.SIunits.Current offset[m]=zeros(m) "Current offsets";
      parameter Modelica.SIunits.Time startTime[m]=zeros(m) "Time offsets";
      Modelica.Electrical.Analog.Sources.SineCurrent sineCurrent[m](
        final I=I,
        final phase=phase,
        final freqHz=freqHz,
        final offset=offset,
        final startTime=startTime) annotation (Placement(transformation(extent=
                {{-10,-10},{10,10}}, rotation=0)));
    equation
      connect(sineCurrent.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(sineCurrent.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{-90,0},{-50,0}}, color={0,0,255}),
            Line(points={{50,0},{90,0}}, color={0,0,255}),
            Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{0,50},{0,-50}}, color={0,0,255}),
            Line(points={{-70,0},{-60.2,29.9},{-53.8,46.5},{-48.2,58.1},{-43.3,
                  65.2},{-38.3,69.2},{-33.4,69.8},{-28.5,67},{-23.6,61},{-18.6,
                  52},{-13,38.6},{-5.98,18.6},{8.79,-26.9},{15.1,-44},{20.8,-56.2},
                  {25.7,-64},{30.6,-68.6},{35.5,-70},{40.5,-67.9},{45.4,-62.5},
                  {50.3,-54.1},{55.9,-41.3},{63,-21.7},{70,0}}, color={192,192,
                  192}),
            Text(
              extent={{-150,-110},{150,-50}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-100,100},{100,60}},
              lineColor={0,0,0},
              textString="m=%m"),
            Polygon(
              points={{90,0},{60,10},{60,-10},{90,0}},
              lineColor={0,0,255},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<HTML>
<p>
Contains m sine current sources (Modelica.Electrical.Analog.Sources.SineCurrent)
with a default phase shift of -(j-1)/m * 2*pi for j in 1:m.
</p>
</HTML>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),
                graphics));
    end SineCurrent;
    annotation (Documentation(info="<HTML>
<p>
This package contains time-dependend and controlled multiphase voltage and current sources:
<ul>
<li>SignalVoltage: fed by Modelica.Blocks.Sources arbitrary waveforms of voltages are possible</li>
<li>SineVoltage : phase shift between consecutive voltages by default <tt>= pi/m</tt></li>
<li>SignalCurrent: fed by Modelica.Blocks.Sources arbitrary waveforms of currents are possible</li>
<li>SineCurrent : phase shift between consecutive currents by default <tt>= pi/m</tt></li>
</ul>
</p>

</HTML>", revisions="<html>
<dl>
<p>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
<p>
  <dt><b>Release Notes:</b></dt>
  <dd>
  <ul>
  <li> v1.0 2004/10/01 Anton Haumer</li>
  </ul>
  </dd>
<p>
  <dt><b>Copyright:</b></dt>
  <dd>Copyright &copy; 1998-2006, Modelica Association and Anton Haumer.<br>
  <i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
  under the terms of the <b>Modelica license</b>, see the license conditions
  and the accompanying <b>disclaimer</b> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</i></dd>
</p>
</dl>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Line(points={{-100,-40},{-60,-40}}, color={0,0,255}),
          Line(points={{-60,-40},{40,-40}}, color={0,0,255}),
          Line(points={{40,-40},{80,-40}}, color={0,0,255}),
          Ellipse(
            extent={{-60,10},{40,-90}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}));
  end Sources;
  annotation (
     Documentation(info="<HTML>
<p>
This package contains packages for electrical multiphase components, based on Modelica.Electrical.Analog:
<ul>
<li>Basic: basic components (resistor, capacitor, inductor, ...)</li>
<li>Ideal: ideal elements (switches, diode, transformer, ...)</li>
<li>Sensors: sensors to measure potentials, voltages, and currents</li>
<li>Sources: time-dependend and controlled voltage and current sources</li>
</ul>
This package is intended to be used the same way as Modelica.Electrical.Analog
but to make design of multiphase models easier.<br>
The package is based on the plug: a composite connector containing m pins.<br>
It is possible to connect plugs to plugs or single pins of a plug to single pins.<br>
Potentials may be accessed as <tt>plug.pin[].v</tt>, currents may be accessed as <tt>plug.pin[].i</tt>.
</p>
<p>
Further development:
<ul>
<li>temperature-dependent resistor</li>
<li>lines (m-phase models)</li>
</ul>
</p>
<dl>
<p>
  <dt><b>Main Author:</b></dt>
  <dd>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern<br>Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
</p>
</dl>
<p>
Copyright &copy; 1998-2005, Modelica Association and Anton Haumer.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b>
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a>.</i>
</p><br>
</HTML>", revisions="<html>
  <ul>
  <li>v1.0 2004/10/01 Anton Haumer</li>
  <li>v1.1 2006/01/12 Anton Haumer<br>
      added Sensors.PowerSensor</li>
  <li>v1.2 2006/07/05 Anton Haumer<br>
      removed annotation from pin of Interfaces.Plug<br>
      corrected usage of resistance/conductance</li>
  <li>v1.3.0 2007/01/23 Anton Haumer<br>
      improved some icons</li>
  <li>v1.3.1 2007/08/12 Anton Haumer<br>
      improved documentation</li>
  <li>v1.3.2 2007/08/24 Anton Haumer<br>
      removed redeclare type SignalType</li>
  <li>v1.4.0 2009/08/26 Anton Haumer<br>
      added conditional HeatPorts as Electrical.Analog<br>
      added switches with arc as Electrical.Analog</li>
  </ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Ellipse(extent={{-60,10},{40,-90}}, lineColor={0,0,255}),
        Ellipse(
          extent={{-40,-14},{-20,-34}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{0,-14},{20,-34}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-20,-54},{0,-74}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}));
end MultiPhase;
