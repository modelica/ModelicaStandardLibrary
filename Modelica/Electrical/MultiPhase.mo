within Modelica.Electrical;
package MultiPhase "Library for electrical components of one or more phases"
  extends Modelica.Icons.Package;

  package UsersGuide "User's Guide"
    extends Modelica.Icons.Information;

    class PhaseOrientation "Orientation of phases"
      extends Modelica.Icons.Information;
      annotation (preferredView="info",
        DocumentationClass=true,
        Documentation(info="<html>
<p>
<strong>In multiphase systems, the angular displacement of voltages and currents of the phases as well as the spatial displacement of machine windings have to follow the same rules, i.e., they are based on the same
<a href=\"modelica://Modelica.Electrical.MultiPhase.Functions.symmetricOrientation\">orientation function</a>.</strong>
</p>
<h4>Symmetrical three phase system</h4>
<p>
A symmetrical three phases system consists of three sinusoidal sine waves with an angular displacement of 2 &pi; / 3.
</p>
<h4>Symmetrical multi phase system</h4>
<p>
In symmetrical multi phase systems odd and even phase numbers have to be distinguished.
</p>
<h5>Odd number of phases</h5>
<p>
For a symmetrical multi phase system with m phases the displacement of the sine waves is 2 &pi; / m.
</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 1: </strong>Symmetrical (a) three phase and (b) five phase current system</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/MultiPhase/phase35.png\"
           alt=\"phase35.png\">
    </td>
  </tr>
</table>
<h5>Even number of phases</h5>
<p>
In case of an even number of phases the aligned orientation does not add any information. Instead the m phases are divided into two or more different groups (the base systems).
</p>
<p>
The number of phases m can be divided by 2 recursively until the result is either an odd number or 2. The result of this division is called m<sub>Base</sub>, the number of phases of the base system.
The number of base systems n<sub>Base</sub> is defined by the number of divisions, i.e., m = n<sub>Base</sub> * m<sub>Base</sub>.
</p>
<p>
For a base system with m<sub>Base</sub> phases the displacement of the sine waves belonging to that base system is 2 &pi; / m<sub>Base</sub>.
</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 2: </strong>Symmetrical (a) six and (b) ten phase current system</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/MultiPhase/phase610.png\"
           alt=\"phase610.png\">
    </td>
  </tr>
</table>
<p>
The displacement of the base systems is defined as &pi; / n<sub>Base</sub>.
</p>
<h4>Note</h4>
<p>
In array or matrices, the base systems are stored one after another.
</p>
<h4>Symmetrical components</h4>
<p>
For each base system of time phasors, symmetrical components can be calculated according to the idea of Charles L. Fortescue.
</p>
<p>
The first symmetrical component is the direct component with positive sequence.<br>
In case of  m<sub>Base</sub> = 2, the second component is the inverse component with negative sequence.<br>
In case of  m<sub>Base</sub> &gt; 2, the components [2..m<sub>Base</sub> - 1] are components with non-positive sequence,<br>
and the last component [m<sub>Base</sub>] is the zero sequence component.
</p>
<p>
This set of symmetrical components is repeated for each of the n<sub>Base</sub> base systems.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.MultiPhase\">User's guide</a> on multi phase winding.
</p>
</html>"));
    end PhaseOrientation;

    class Contact "Contact"
      extends Modelica.Icons.Contact;
      annotation (preferredView="info",
        DocumentationClass=true, Documentation(info="<html>
<h4>Main authors</h4>

<p>
<strong>Dr. Christian Kral</strong><br>
Electric Machines, Drives and Systems<br>
1060 Vienna, Austria<br>
email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a><br>
</p>

<p>
<strong>Anton Haumer</strong><br>
<a href=\"https://www.haumer.at\">Technical Consulting &amp; Electrical Engineering</a><br>
D-93049 Regensburg, Germany<br>
email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a><br>
</p>
</html>"));
    end Contact;

    class ReleaseNotes "Release Notes"
      extends Modelica.Icons.ReleaseNotes;
      annotation (preferredView="info",
        DocumentationClass=true, Documentation(info="<html>

<h5>Version 3.2.3, 2018-09-26 (Anton Haumer, Christian Kral)</h5>
<ul>
  <li>Shortened default component names, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2301\">#2301</a></li>
<li>Removed redundant (and not identical) parameter m from
    <a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.MutualInductor\">MutualInductor</a>,
    see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2202\">#2202</a></li>
<li>Changed epsilon from constant to parameter in
    <a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.MutualInductor\">MutualInductor</a>,
    see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2200\">#2200</a></li>
<li>Added User's Guide</li>
<li>Added blocks and functions for multiple base systems</li>
</ul>

<h5>Version 1.4.0, 2009-08-26 (Anton Haumer)</h5>
<ul>
<li>Added conditional HeatPorts as in Electrical.Analog</li>
<li>Added switches with arc as in Electrical.Analog</li>
</ul>

<h5>Version 1.3.2, 2007-08-24 (Anton Haumer)</h5>
<ul>
<li>Removed redeclare type SignalType</li>
</ul>

<h5>Version 1.3.1, 2007-08-12 (Anton Haumer)</h5>
<ul>
<li>Improved documentation</li>
</ul>

<h5>Version 1.3.0, 2007-01-23 (Anton Haumer)</h5>
<ul>
<li>Improved some icons</li>
</ul>

<h5>Version 1.2, 2006-07-05 (Anton Haumer)</h5>
<ul>
<li>Removed annotation from pin of Interfaces.Plug</li>
<li>Corrected usage of resistance/conductance</li>
</ul>

<h5>Version 1.1, 2006-01-12 (Anton Haumer)</h5>
<ul>
<li>Added Sensors.PowerSensor</li>
</ul>

<h5>Version 1.0, 2004-10-01 (Anton Haumer)</h5>
<ul>
  <li>Initial release version</li>
</ul></html>"));
    end ReleaseNotes;

    class References "References"
      extends Modelica.Icons.References;
      annotation (preferredView="info",
        DocumentationClass=true, Documentation(info="<html>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <td>[Vaske1963]</td>
      <td>P. Vaske,
        &quot;&Uuml;ber die Drehfelder und Drehmomente symmetrischer Komponenten in Induktionsmaschinen,&quot;
        (in German), <em>Archiv f&uuml;r Elektrotechnik</em>
        vol 2, 1963, pp. 97-117.</td>
    </tr>
</table>
</html>"));
    end References;
    annotation (preferredView="info",
      DocumentationClass=true,
      Documentation(info="<html>
<p>
This library contains components for modelling of multiphase electrical circuits.
The number of phases m is not restricted to three.
The connector (named plug) contains an array of m singlephase <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.Pin\">pins</a>.
Most of the components use an array of singlephase components from <a href=\"modelica://Modelica.Electrical.Analog\">Modelica.Electrical.Analog</a>.
</p>
<h4>Note</h4>
<p>
For the orientation of an arbitrary number of phases m &gt; 3, see the <a href=\"modelica://Modelica.Electrical.MultiPhase.UsersGuide.PhaseOrientation\">phase orientation concept</a>.
</p>
</html>"));
  end UsersGuide;

  package Examples "Multiphase test examples"
    extends Modelica.Icons.ExamplesPackage;

    model TransformerYY "Test example with multiphase components"
      extends Modelica.Icons.Example;
      parameter Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage V=1 "Amplitude of Star-Voltage";
      parameter Modelica.SIunits.Frequency f=5 "Frequency";
      parameter Modelica.SIunits.Inductance Lm=1 "Transformer main inductance";
      parameter Modelica.SIunits.Inductance LT=0.003
        "Transformer stray inductance";
      parameter Modelica.SIunits.Resistance RT=0.05 "Transformer resistance";
      parameter Modelica.SIunits.Resistance RL=1 "Load Resistance";
      parameter Real nT=1 "Transformer ratio";
      Sources.SineVoltage sineVoltage(
        V=fill(V, m),
        freqHz=fill(f, m),
        m=m) annotation (Placement(transformation(
            origin={-80,20},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Basic.Star starS(m=m) annotation (Placement(transformation(
            origin={-90,-62},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundS annotation (Placement(
            transformation(extent={{-100,-100},{-80,-80}})));
      Ideal.IdealTransformer idealTransformer(
        m=m,
        Lm1=fill(Lm, m),
        n=fill(nT, m)) annotation (Placement(transformation(extent={{-40,0},{-20,
                20}})));
      Basic.Star starT1(m=m) annotation (Placement(transformation(
            origin={-40,-62},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Basic.Star starT2(m=m) annotation (Placement(transformation(
            origin={-20,-62},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundT2 annotation (Placement(
            transformation(extent={{-30,-100},{-10,-80}})));
      Basic.Resistor transformerR(m=m, R=fill(RT, m)) annotation (Placement(
            transformation(extent={{0,10},{20,30}})));
      Basic.Inductor transformerL(m=m, L=fill(LT, m)) annotation (Placement(
            transformation(extent={{30,10},{50,30}})));
      Basic.Resistor loadR(m=m, R=fill(RL, m)) annotation (Placement(
            transformation(extent={{70,10},{90,30}})));
      Basic.Star starL(m=m) annotation (Placement(transformation(
            origin={90,-62},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundT1 annotation (Placement(
            transformation(extent={{-50,-100},{-30,-80}})));
    initial equation
      transformerL.i[1:m - 1] = zeros(m - 1) "Y-connection";

    equation
      connect(starS.pin_n, groundS.p)
        annotation (Line(points={{-90,-72},{-90,-80}}, color={0,0,255}));
      connect(starT1.pin_n, groundT1.p)
        annotation (Line(points={{-40,-72},{-40,-80}}, color={0,0,255}));
      connect(starT2.pin_n, groundT2.p) annotation (Line(points={{-20,-72},{-20,
              -76},{-20,-76},{-20,-80}}, color={0,0,255}));
      connect(starS.plug_p, sineVoltage.plug_n)
        annotation (Line(points={{-90,-52},{-90,20}}, color={0,0,255}));
      connect(sineVoltage.plug_p, idealTransformer.plug_p1)
        annotation (Line(points={{-70,20},{-40,20}}, color={0,0,255}));
      connect(idealTransformer.plug_n1, starT1.plug_p)
        annotation (Line(points={{-40,0},{-40,-52}}, color={0,0,255}));
      connect(starT2.plug_p, idealTransformer.plug_n2) annotation (Line(points=
              {{-20,-52},{-20,-26},{-20,0}}, color={0,0,255}));
      connect(idealTransformer.plug_p2, transformerR.plug_p)
        annotation (Line(points={{-20,20},{0,20}}, color={0,0,255}));
      connect(transformerR.plug_n, transformerL.plug_p)
        annotation (Line(points={{20,20},{30,20}}, color={0,0,255}));
      connect(transformerL.plug_n, loadR.plug_p)
        annotation (Line(points={{50,20},{70,20}}, color={0,0,255}));
      connect(loadR.plug_n, starL.plug_p)
        annotation (Line(points={{90,20},{90,-52}}, color={0,0,255}));
      annotation (Documentation(info="<html>
<p>
Test example with multiphase components:<br>
Star-connected voltage source feeds via a Y-Y-transformer with internal impedance (RT, LT) a load resistor RT.<br>
Using f=5 Hz LT=3mH defines nominal voltage drop of approximately 10 %.<br>
Simulate for 1 second (2 periods) and compare voltages and currents of source, transformer and load.
</p>
</html>"), experiment(StopTime=1.0, Interval=0.001));
    end TransformerYY;

    model TransformerYD "Test example with multiphase components"
      extends Modelica.Icons.Example;
      parameter Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage V=1 "Amplitude of Star-Voltage";
      parameter Modelica.SIunits.Frequency f=5 "Frequency";
      parameter Modelica.SIunits.Inductance Lm=1 "Transformer main inductance";
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
      Basic.Star starS(m=m) annotation (Placement(transformation(
            origin={-90,-62},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundS annotation (Placement(
            transformation(extent={{-100,-100},{-80,-80}})));
      Ideal.IdealTransformer idealTransformer(
        m=m,
        n=fill(nT, m),
        Lm1=fill(Lm, m)) annotation (Placement(transformation(extent={{-40,0},{
                -20,20}})));
      Basic.Star starT(m=m) annotation (Placement(transformation(
            origin={-40,-62},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Basic.Delta deltaT2(m=m) annotation (Placement(transformation(
            origin={50,10},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundT annotation (Placement(
            transformation(extent={{-50,-100},{-30,-80}})));
      Basic.Resistor transformerR(m=m, R=fill(RT/nT^2, m)) annotation (
          Placement(transformation(extent={{-10,10},{10,30}})));
      Basic.Inductor transformerL(m=m, L=fill(LT/nT^2, m)) annotation (
          Placement(transformation(extent={{20,10},{40,30}})));
      Basic.Resistor loadR(m=m, R=fill(RL, m)) annotation (Placement(
            transformation(extent={{70,10},{90,30}})));
      Basic.Star starL(m=m) annotation (Placement(transformation(
            origin={90,-62},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundL annotation (Placement(
            transformation(extent={{80,-100},{100,-80}})));
    initial equation
      transformerL.i[1:m] = zeros(m) "D-connection";

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
      annotation (Documentation(info="<html>
<p>
Test example with multiphase components:<br>
Star-connected voltage source feeds via a Y-D-transformer with internal impedance (RT, LT) a load resistor RT.<br>
Using f=5 Hz LT=3mH defines nominal voltage drop of approximately 10 %.<br>
Simulate for 1 second (2 periods) and compare voltages and currents of source, transformer and load.
</p>
</html>"), experiment(StopTime=1.0, Interval=0.001));
    end TransformerYD;

    model Rectifier "Test example with multiphase components"
      extends Modelica.Icons.Example;
      import Modelica.Electrical.MultiPhase.Functions.factorY2DC;
      final parameter Integer m=3 "Number of phases";
      parameter Modelica.SIunits.Voltage V=100 "RMS of Star-Voltage";
      parameter Modelica.SIunits.Frequency f=50 "Frequency";
      parameter Modelica.SIunits.Inductance L=0.0001 "Line Inductance";
      parameter Modelica.SIunits.Resistance RL=2 "Load Resistance";
      parameter Modelica.SIunits.Capacitance C=0.005 "Total DC-Capacitance";
      parameter Modelica.SIunits.Resistance RE=1E6 "Earthing Resistance";
      parameter Modelica.SIunits.Resistance Ron=1e-5 "Closed diode resistance";
      parameter Modelica.SIunits.Conductance Goff=1e-5
        "Opened diode conductance";
      parameter Modelica.SIunits.Voltage Vknee=0 "Threshold diode voltage";
      final parameter Modelica.SIunits.Voltage VDC=factorY2DC(m)*V "Estimated average DC voltage";
      final parameter Modelica.SIunits.Current IDC=VDC/RL "Estimated average DC current";
      Sources.SineVoltage sineVoltage(
        m=m,
        freqHz=fill(f, m),
        V=sqrt(2)*fill(V, m))
                           annotation (Placement(transformation(extent={{10,10},{-10,
                -10}},
            rotation=90,
            origin={-90,-50})));
      Basic.Star starS(m=m) annotation (Placement(transformation(
            origin={-90,-80},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Basic.Inductor supplyL(m=m, L=fill(L, m)) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-90,-20})));
      Ideal.IdealDiode idealDiode1(
        m=m,
        Ron=fill(Ron, m),
        Goff=fill(Goff, m),
        Vknee=fill(Vknee, m)) annotation (Placement(transformation(
            origin={40,20},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Basic.Star star1(m=m) annotation (Placement(transformation(
            origin={40,50},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Ideal.IdealDiode idealDiode2(
        m=m,
        Ron=fill(Ron, m),
        Goff=fill(Goff, m),
        Vknee=fill(Vknee, m)) annotation (Placement(transformation(
            origin={40,-20},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Basic.Star star2(m=m) annotation (Placement(transformation(
            origin={40,-50},
            extent={{-10,10},{10,-10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Resistor loadR(R=RL) annotation (
          Placement(transformation(
            origin={60,0},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Capacitor cDC1(C=2*C) annotation (
          Placement(transformation(
            origin={80,30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Capacitor cDC2(C=2*C) annotation (
          Placement(transformation(
            origin={80,-30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.Ground groundDC annotation (Placement(
            transformation(extent={{80,-80},{100,-60}})));
      Machines.Sensors.ElectricalPowerSensor powerSensorSpacePhasor annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={-40,0})));
      Sensors.AronSensor aronSensor annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={-12,0})));
      Sensors.PowerSensor powerSensor(m=m) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={-70,0})));
      Sensors.ReactivePowerSensor reactivePowerSensor annotation (Placement(
            transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={20,0})));
    initial equation
      cDC1.v = VDC/2;
      cDC2.v = VDC/2;
    //supplyL.i[1:m - 1] = zeros(m - 1) "Y-connection";
      supplyL.i[2]=-IDC;
      supplyL.i[3]= IDC;
    equation
      connect(cDC1.n, cDC2.p)
        annotation (Line(points={{80,20},{80,-20}}, color={0,0,255}));
      connect(cDC1.n, groundDC.p) annotation (Line(points={{80,20},{80,0},{90,0},{90,
              -60}},     color={0,0,255}));
      connect(starS.plug_p, sineVoltage.plug_n)
        annotation (Line(points={{-90,-70},{-90,-60}},
                                                     color={0,0,255}));
      connect(sineVoltage.plug_p, supplyL.plug_p)
        annotation (Line(points={{-90,-40},{-90,-30}},
                                                   color={0,0,255}));
      connect(idealDiode1.plug_n, star1.plug_p)
        annotation (Line(points={{40,30},{40,40}}, color={0,0,255}));
      connect(idealDiode2.plug_p, star2.plug_p) annotation (Line(points={{40,-30},{40,
              -40}},              color={0,0,255}));
      connect(star2.pin_n, loadR.n) annotation (Line(points={{40,-60},{60,-60},{60,-10}},
                         color={0,0,255}));
      connect(star2.pin_n, cDC2.n) annotation (Line(points={{40,-60},{80,-60},{80,-40}},
                        color={0,0,255}));
      connect(star1.pin_n, loadR.p)
        annotation (Line(points={{40,60},{60,60},{60,10}}, color={0,0,255}));
      connect(star1.pin_n, cDC1.p)
        annotation (Line(points={{40,60},{80,60},{80,40}}, color={0,0,255}));
      connect(idealDiode1.plug_p, idealDiode2.plug_n)
        annotation (Line(points={{40,10},{40,-10}}, color={0,0,255}));
      connect(supplyL.plug_n, powerSensor.pc)
        annotation (Line(points={{-90,-10},{-90,0},{-80,0}}, color={0,0,255}));
      connect(powerSensor.nc, powerSensorSpacePhasor.plug_p)
        annotation (Line(points={{-60,0},{-50,0}}, color={0,0,255}));
      connect(powerSensorSpacePhasor.plug_ni, aronSensor.plug_p)
        annotation (Line(points={{-30,0},{-22,0}}, color={0,0,255}));
      connect(aronSensor.plug_n, reactivePowerSensor.plug_p)
        annotation (Line(points={{-2,0},{10,0}}, color={0,0,255}));
      connect(idealDiode1.plug_p, reactivePowerSensor.plug_n)
        annotation (Line(points={{40,10},{40,0},{30,0}}, color={0,0,255}));
      connect(powerSensor.pc, powerSensor.pv)
        annotation (Line(points={{-80,0},{-80,10},{-70,10}}, color={0,0,255}));
      connect(starS.plug_p, powerSensor.nv)
        annotation (Line(points={{-90,-70},{-70,-70},{-70,-10}}, color={0,0,255}));
      connect(starS.plug_p, powerSensorSpacePhasor.plug_nv)
        annotation (Line(points={{-90,-70},{-40,-70},{-40,-10}}, color={0,0,255}));
      annotation (Documentation(info="<html>
<p>
Test example with multiphase components:<br>
Star-connected voltage source feeds via a line reactor a diode bridge rectifier with a DC burden.<br>
Using f=50 Hz, simulate for 0.1 second and compare voltages and currents of source and DC burden, neglecting initial transient.<br>
We may also compare: Active power measured by powerSensor, powerSensorSpacePhasor and aronSensor,
as well as reactive power measured by powerSensorSpacePhasor and reactivePowerSensor.
</p>
</html>"), experiment(StopTime=0.1, Interval=1e-005));
    end Rectifier;

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
      Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
        final m=m,
        V=fill(sqrt(2)*VRMS, m),
        freqHz=fill(f, m)) annotation (Placement(transformation(
            origin={-20,-30},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-20,-70})));
      Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
            transformation(
            origin={-20,-100},
            extent={{-10,-10},{10,10}})));
      Modelica.Electrical.MultiPhase.Basic.Resistor resistor(m=m, R=fill(R, m))
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={20,-20})));
      Modelica.Electrical.MultiPhase.Basic.Inductor inductor(m=m, L=fill(L, m))
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={20,-50})));
      Modelica.Electrical.MultiPhase.Basic.Star starLoad(m=m) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={20,-80})));
      Modelica.Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor
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

      Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor(m=m) annotation (
          Placement(transformation(
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
      Sensors.PowerSensor powerSensor(m=m) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={20,10})));
      Modelica.Blocks.Math.Feedback feedbackP
        annotation (Placement(transformation(extent={{40,10},{60,30}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=
            Modelica.Electrical.MultiPhase.Functions.activePower(
            voltageQuasiRMSSensor.v, currentQuasiRMSSensor.i)) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={50,-20})));
      Machines.Sensors.ElectricalPowerSensor powerSensorSpacePhasor annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-20,70})));
      Modelica.Blocks.Math.Feedback feedbackSpacePhasor annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-60,60})));
      Sensors.AronSensor aronSensor annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={20,40})));
      Modelica.Blocks.Math.Feedback feedbackAron
        annotation (Placement(transformation(extent={{80,30},{100,50}})));
      Sensors.ReactivePowerSensor reactivePowerSensor annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={20,70})));
      Modelica.Blocks.Math.Feedback feedbackQ
        annotation (Placement(transformation(extent={{40,80},{60,60}})));
    initial equation
      for k in 1:m - 1 loop
        inductor.i[k] = 0;
      end for;

    equation
      connect(star.pin_n, ground.p)
        annotation (Line(points={{-20,-80},{-20,-90}}, color={0,0,255}));

      connect(resistor.plug_n, inductor.plug_p) annotation (Line(
          points={{20,-30},{20,-40}}, color={0,0,255}));
      connect(inductor.plug_n, starLoad.plug_p) annotation (Line(
          points={{20,-60},{20,-70}}, color={0,0,255}));
      connect(voltageQuasiRMSSensor.plug_n, sineVoltage.plug_n) annotation (
          Line(
          points={{-50,-40},{-20,-40}},
                                      color={0,0,255}));
      connect(voltageQuasiRMSSensor.plug_p, sineVoltage.plug_p) annotation (
          Line(
          points={{-50,-20},{-20,-20}},
                                      color={0,0,255}));
      connect(feedbackV.u1, voltageQuasiRMSSensor.V) annotation (Line(
          points={{-72,-30},{-61,-30}},
                                      color={0,0,127}));
      connect(constV.y, feedbackV.u2) annotation (Line(
          points={{-80,-49},{-80,-38}},
                                      color={0,0,127}));
      connect(powerSensor.nc, resistor.plug_p) annotation (Line(
          points={{20,0},{20,-10}},color={0,0,255}));
      connect(powerSensor.pc, powerSensor.pv) annotation (Line(
          points={{20,20},{10,20},{10,10}}, color={0,0,255}));
      connect(powerSensor.nv, starLoad.plug_p) annotation (Line(
          points={{30,10},{30,-70},{20,-70}}, color={0,0,255}));
      connect(powerSensor.power, feedbackP.u1) annotation (Line(
          points={{31,20},{42,20}},                 color={0,0,127}));
      connect(aronSensor.plug_n, powerSensor.pc)
        annotation (Line(points={{20,30},{20,20}}, color={0,0,255}));
      connect(sineVoltage.plug_n, star.plug_p)
        annotation (Line(points={{-20,-40},{-20,-60}}, color={0,0,255}));
      connect(feedbackI.u2, constI.y)
        annotation (Line(points={{-80,32},{-80,21}}, color={0,0,127}));
      connect(feedbackI.u1, currentQuasiRMSSensor.I)
        annotation (Line(points={{-72,40},{-31,40}}, color={0,0,127}));
      connect(currentQuasiRMSSensor.plug_p, sineVoltage.plug_p)
        annotation (Line(points={{-20,30},{-20,-20}}, color={0,0,255}));
      connect(feedbackP.u2, realExpression.y)
        annotation (Line(points={{50,12},{50,-9}},  color={0,0,127}));
      connect(powerSensorSpacePhasor.plug_p, currentQuasiRMSSensor.plug_n)
        annotation (Line(points={{-20,60},{-20,50}}, color={0,0,255}));
      connect(powerSensorSpacePhasor.plug_nv, starLoad.plug_p) annotation (Line(
            points={{-10,70},{-10,70},{0,70},{0,-70},{20,-70}}, color={0,0,255}));
      connect(powerSensorSpacePhasor.plug_ni, reactivePowerSensor.plug_p)
        annotation (Line(points={{-20,80},{20,80}}, color={0,0,255}));
      connect(reactivePowerSensor.plug_n, aronSensor.plug_p)
        annotation (Line(points={{20,60},{20,50}}, color={0,0,255}));
      connect(reactivePowerSensor.reactivePower, feedbackQ.u1)
        annotation (Line(points={{31,70},{42,70}}, color={0,0,127}));
      connect(powerSensorSpacePhasor.Q, feedbackQ.u2) annotation (Line(points={{-31,
              75},{-40,75},{-40,90},{50,90},{50,78}}, color={0,0,127}));
      connect(aronSensor.power, feedbackAron.u1)
        annotation (Line(points={{31,40},{82,40}}, color={0,0,127}));
      connect(feedbackSpacePhasor.u1, powerSensorSpacePhasor.P) annotation (Line(
            points={{-52,60},{-40,60},{-40,65},{-31,65}}, color={0,0,127}));
      connect(realExpression.y, feedbackAron.u2)
        annotation (Line(points={{50,-9},{50,0},{90,0},{90,32}}, color={0,0,127}));
      connect(realExpression.y, feedbackSpacePhasor.u2) annotation (Line(points={{50,
              -9},{50,0},{70,0},{70,98},{-60,98},{-60,68}}, color={0,0,127}));
      annotation (experiment(StopTime=0.1, Interval=0.0001), Documentation(info="<html>
<p>
Test multiphase quasiRMS and power sensors: A sinusoidal source feeds a load consisting of resistor and inductor.
</p>
</html>"));
    end TestSensors;
    annotation (Documentation(info="<html>
<p>
This package contains test examples of analog electrical multiphase circuits.
</p>

</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Release Notes:</strong></dt>
  <dd>
  <ul>
  <li> v1.0 2004/10/01 Anton Haumer</li>
  </ul>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
</html>"));
  end Examples;

  package Basic "Basic components for electrical multiphase models"
    extends Modelica.Icons.Package;

    model Star "Star-connection"
      parameter Integer m(final min=1) = 3 "Number of phases";
      Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (
          Placement(transformation(extent={{90,-10},{110,10}})));

    equation
      for j in 1:m loop
        plug_p.pin[j].v = pin_n.v;
      end for;
      sum(plug_p.pin.i) + pin_n.i = 0;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Text(
              extent={{-150,70},{150,110}},
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
              extent={{-150,-110},{150,-70}},
              textString="m=%m"),
            Line(points={{-90,0},{-40,0}}, color={0,0,255}),
            Line(points={{80,0},{90,0}}, color={0,0,255})}), Documentation(info=
             "<html>
<p>
Connects all pins of plug_p to pin_n, thus establishing a so-called star-connection.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.Delta\">Delta</a>,
<a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.MultiStar\">MultiStar</a>,
<a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.MultiDelta\">MultiDelta</a>
</p>

</html>"));
    end Star;

    model Delta "Delta (polygon) connection"
      parameter Integer m(final min=2) = 3 "Number of phases";
      Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));

    equation
      for j in 1:m loop
        if j < m then
          plug_n.pin[j].v = plug_p.pin[j + 1].v;
          plug_n.pin[j].i + plug_p.pin[j + 1].i = 0;
        else
          plug_n.pin[j].v = plug_p.pin[1].v;
          plug_n.pin[j].i + plug_p.pin[1].i = 0;
        end if;
      end for;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(
              points={{-40,68},{-40,-70},{79,0},{-40,68},{-40,67}},
              thickness=0.5,
              color={0,0,255}),
            Line(points={{-90,0},{-40,0}}, color={0,0,255}),
            Line(points={{80,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-150,-110},{150,-70}},
              textString="m=%m"),
            Text(
              extent={{-150,70},{150,110}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info=
             "<html>
<p>
Connects in a cyclic way plug_n.pin[j] to plug_p.pin[j+1],
thus establishing a so-called delta (or polygon) connection
when used in parallel to another component.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.Star\">Star</a>,
<a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.MultiStar\">MultiStar</a>,
<a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.MultiDelta\">MultiDelta</a>
</p>
</html>"));
    end Delta;

    model MultiStar
      "Star connection of multi phase systems consisting of multiple base systems"
      parameter Integer m(final min=1) = 3 "Number of phases";
      final parameter Integer mSystems=
          Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(
          m) "Number of base systems";
      final parameter Integer mBasic=integer(m/mSystems)
        "Phase number of base systems";
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug starpoints(final m=
           mSystems) annotation (Placement(transformation(extent={{90,-10},{110,
                10}})));
    equation
      for k in 1:mSystems loop
        for j in 1:mBasic loop
          connect(plug_p.pin[(k - 1)*mBasic + j], starpoints.pin[k]);
        end for;
      end for;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(
              points={{74,-4},{-6,-4}},
              thickness=0.5,
              color={0,0,255}),
            Line(
              points={{-6,-4},{-45,64}},
              thickness=0.5,
              color={0,0,255}),
            Line(
              points={{-6,-4},{-44,-73}},
              thickness=0.5,
              color={0,0,255}),
            Line(points={{-90,0},{-40,0}}, color={0,0,255}),
            Line(points={{80,0},{90,0}}, color={0,0,255}),
            Line(
              points={{6,4},{-33,72}},
              thickness=0.5,
              color={0,0,255}),
            Line(
              points={{86,4},{6,4}},
              thickness=0.5,
              color={0,0,255}),
            Line(
              points={{6,4},{-32,-65}},
              thickness=0.5,
              color={0,0,255}),
            Text(
              extent={{-150,-110},{150,-70}},
              textString="m=%m"),
            Text(
              extent={{-150,70},{150,110}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>
<p>
Star (wye) connection of a multi phase circuit consisting of multiple base systems (see
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.MultiPhase\">multi phase guidelines</a>). The potentials at the star points are all equal.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.Star\">Star</a>,
<a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.Delta\">Delta</a>,
<a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.MultiDelta\">MultiDelta</a>
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

      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m)
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    equation
      for k in 1:mSystems loop
        for j in 1:mBasic - 1 loop
          connect(plug_n.pin[(k - 1)*mBasic + j], plug_p.pin[(k - 1)*mBasic + j
             + 1]);
        end for;
        connect(plug_n.pin[k*mBasic], plug_p.pin[(k - 1)*mBasic + 1]);
      end for;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-90,0},{-46,0}}, color={0,0,255}),
            Line(
              points={{-44,62},{-44,-76},{75,-6},{-44,62},{-44,61}},
              thickness=0.5,
              color={0,0,255}),
            Line(points={{80,0},{90,0}}, color={0,0,255}),
            Line(
              points={{-36,74},{-36,-64},{83,6},{-36,74},{-36,73}},
              thickness=0.5,
              color={0,0,255}),
            Text(
              extent={{-150,-110},{150,-70}},
              textString="m=%m"),
            Text(
              extent={{-150,70},{150,110}},
              textString="%name",
              lineColor={0,0,255})}),
                                  Documentation(info="<html>
<p>
Delta (polygon) connection of a multi phase circuit consisting of multiple base systems (see
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.MultiPhase\">multi phase guidelines</a>).
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.Star\">Star</a>,
<a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.Delta\">Delta</a>,
<a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.MultiStar\">MultiStar</a>
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
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug(m=m)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Electrical.MultiPhase.Basic.MultiStar multiStar(m=m) annotation (
         Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={-50,0})));
      Modelica.Electrical.MultiPhase.Basic.Resistor resistor(m=mBasic, R=fill(R,
            mBasic)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}})));
      Modelica.Electrical.MultiPhase.Basic.Star star(m=mBasic) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={50,0})));
      Modelica.Electrical.Analog.Interfaces.NegativePin pin annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={100,0})));
    equation
      connect(plug, multiStar.plug_p) annotation (Line(
          points={{-100,0},{-100,0},{-60,0},{-60,0}}, color={0,0,255}));
      connect(multiStar.starpoints, resistor.plug_p) annotation (Line(
          points={{-40,0},{-40,0},{-10,0}}, color={0,0,255}));
      connect(resistor.plug_n, star.plug_p) annotation (Line(
          points={{10,0},{10,0},{34,0},{34,0},{40,0},{40,0}}, color={0,0,255}));
      connect(star.pin_n, pin) annotation (Line(
          points={{60,0},{60,0},{98,0},{98,0},{100,0},{100,
              0}}, color={0,0,255}));
      annotation (defaultComponentName="multiStar",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(
              points={{-40,40},{0,0},{40,40},{0,0},{0,-40}},
              color={0,0,255},
              origin={-60,0},
              rotation=90),
            Rectangle(
              extent={{-10,20},{10,-20}},
              lineColor={0,0,255},
              rotation=90),
            Line(
              points={{-40,40},{0,0},{40,40},{0,0},{0,-40}},
              color={0,0,255},
              origin={60,0},
              rotation=90),
            Text(
              extent={{-150,-90},{150,-50}},
              textString="R=%R"),
            Text(
              extent={{-150,60},{150,100}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>
<p>
Multi star points are connected by resistors. This model is required to operate multi phase systems with even phase numbers to avoid ideal connections of start points of base systems; see
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.MultiPhase\">multi phase guidelines</a>.
</p>
</html>"));
    end MultiStarResistance;

    model PlugToPin_p "Connect one (positive) Pin"
      parameter Integer m(final min=1) = 3 "Number of phases";
      parameter Integer k(
        final min=1,
        final max=m,
        start=1) "Phase index";
      Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
            transformation(extent={{-30,-10},{-10,10}})));
      Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation (
          Placement(transformation(extent={{10,-10},{30,10}})));
    equation
      pin_p.v = plug_p.pin[k].v;
      for j in 1:m loop
        plug_p.pin[j].i = if j == k then -pin_p.i else 0;
      end for;
      annotation (defaultComponentName="plugToPin", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Text(
              extent={{-150,-30},{150,-70}},
              textString="k = %k"),
            Line(points={{-20,20},{40,20},{40,-20},{-20,-20}}),
            Rectangle(
              extent={{-20,20},{40,-20}},
              pattern=LinePattern.None,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Ellipse(
              extent={{-40,20},{0,-20}},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Line(points={{-20,20},{40,20},{40,-20},{-20,-20}}),
            Text(
              extent={{-150,40},{150,80}},
              textString="%name",
              lineColor={0,0,255})}),
          Documentation(info="<html>
<p>
Connects pin <em>k</em> of plug_p to pin_p, leaving the other pins of plug_p unconnected.
</p>
</html>"));
    end PlugToPin_p;

    model PlugToPin_n "Connect one (negative) Pin"
      parameter Integer m(final min=1) = 3 "Number of phases";
      parameter Integer k(
        final min=1,
        final max=m,
        start=1) "Phase index";
      Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
            transformation(extent={{-30,-10},{-10,10}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (
          Placement(transformation(extent={{10,-10},{30,10}})));
    equation
      pin_n.v = plug_n.pin[k].v;
      for j in 1:m loop
        plug_n.pin[j].i = if j == k then -pin_n.i else 0;
      end for;
      annotation (defaultComponentName="plugToPin", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-20,20},{40,20},{40,-20},{-20,-20}}),
            Rectangle(
              extent={{-20,20},{40,-20}},
              pattern=LinePattern.None,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Ellipse(
              extent={{-40,20},{0,-20}},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Line(points={{-20,20},{40,20},{40,-20},{-20,-20}}),
            Text(
              extent={{-150,40},{150,80}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-30},{150,-70}},
              textString="k = %k")}),
          Documentation(info="<html>
<p>
Connects pin <em>k</em> of plug_n to pin_n, leaving the other pins of plug_n unconnected.
</p>
</html>"));
    end PlugToPin_n;

    model PlugToPins_p "Connect all (positive) Pins"
      parameter Integer m(final min=1) = 3 "Number of phases";
      Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
            transformation(extent={{-30,-10},{-10,10}})));
      Modelica.Electrical.Analog.Interfaces.PositivePin pin_p[m] annotation (
          Placement(transformation(extent={{10,-10},{30,10}})));
    equation
      pin_p.v = plug_p.pin.v;
      plug_p.pin.i = -pin_p.i;
      annotation (defaultComponentName="plugToPins", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-20,20},{40,20},{40,-20},{-20,-20}}),
            Rectangle(
              extent={{-20,20},{40,-20}},
              pattern=LinePattern.None,
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Ellipse(
              extent={{-40,20},{0,-20}},
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-20,20},{40,20},{40,-20},{-20,-20}}),
            Text(
              extent={{-150,40},{150,80}},
              textString="%name",
              lineColor={0,0,255})}),
          Documentation(info="<html>
<p>
Connects all pins of plug_p to the pin array pin_p.
</p>
</html>"));
    end PlugToPins_p;

    model PlugToPins_n "Connect all (negative) Pins"
      parameter Integer m(final min=1) = 3 "Number of phases";
      Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
            transformation(extent={{-30,-10},{-10,10}})));
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_n[m] annotation (
          Placement(transformation(extent={{10,-10},{30,10}})));
    equation
      pin_n.v = plug_n.pin.v;
      plug_n.pin.i = -pin_n.i;
      annotation (defaultComponentName="plugToPins", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-20,20},{40,20},{40,-20},{-20,-20}}),
            Rectangle(
              extent={{-20,20},{40,-20}},
              pattern=LinePattern.None,
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Ellipse(
              extent={{-40,20},{0,-20}},
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-20,20},{40,20},{40,-20},{-20,-20}}),
            Text(
              extent={{-150,40},{150,80}},
              textString="%name",
              lineColor={0,0,255})}),
          Documentation(info="<html>
<p>
Connects all pins of plug_n to the pin array pin_n.
</p>
</html>"));
    end PlugToPins_n;

    model Resistor "Ideal linear electrical resistors"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance R[m](start=fill(1, m))
        "Resistances R_ref at temperatures T_ref";
      parameter Modelica.SIunits.Temperature T_ref[m]=fill(300.15, m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha[m]=zeros(m)
        "Temperature coefficients of resistances at reference temperatures";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, T=T_ref);
      Modelica.Electrical.Analog.Basic.Resistor resistor[m](
        final R=R,
        final T_ref=T_ref,
        final alpha=alpha,
        each final useHeatPort=useHeatPort) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(resistor.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(resistor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(resistor.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}}, color={191,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-70,0}}, color={0,0,255}),
            Line(points={{70,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-150,-80},{150,-40}},
              textString="m=%m"),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
<p>
Contains m resistors (Modelica.Electrical.Analog.Basic.Resistor)
</p>
</html>"));
    end Resistor;

    model Conductor "Ideal linear electrical conductors"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Conductance G[m](start=fill(1, m))
        "Conductances G_ref at temperatures T_ref";
      parameter Modelica.SIunits.Temperature T_ref[m]=fill(300.15, m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha[m]=zeros(m)
        "Temperature coefficients of conductances at reference temperatures";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, T=T_ref);
      Modelica.Electrical.Analog.Basic.Conductor conductor[m](
        final G=G,
        final T_ref=T_ref,
        final alpha=alpha,
        each final useHeatPort=useHeatPort) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(plug_p.pin, conductor.p)
        annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
      connect(plug_n.pin, conductor.n)
        annotation (Line(points={{100,0},{10,0}}, color={0,0,255}));
      connect(conductor.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}}, color={191,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,0},{-70,0}}, color={0,0,255}),
            Line(points={{70,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-150,-80},{150,-40}},
              textString="m=%m"),
            Text(
              extent={{-150,50},{150,90}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
<p>
Contains m conductors (Modelica.Electrical.Analog.Basic.Conductor)
</p>
</html>"));
    end Conductor;

    model Capacitor "Ideal linear electrical capacitors"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Capacitance C[m](start=fill(1, m))
        "Capacitance";
      Modelica.Electrical.Analog.Basic.Capacitor capacitor[m](final C=C)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(capacitor.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(capacitor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(
              points={{-6,28},{-6,-28}},
              color={0,0,255}),
            Line(
              points={{6,28},{6,-28}},
              color={0,0,255}),
            Line(points={{-90,0},{-6,0}}, color={0,0,255}),
            Line(points={{6,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-80},{150,-40}},
              textString="m=%m")}), Documentation(info="<html>
<p>
Contains m capacitors (Modelica.Electrical.Analog.Basic.Capacitor)
</p>
</html>"));
    end Capacitor;

    model Inductor "Ideal linear electrical inductors"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Inductance L[m](start=fill(1, m)) "Inductance";
      Modelica.Electrical.Analog.Basic.Inductor inductor[m](final L=L)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(inductor.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(inductor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{60,0},{90,0}}, color={0,0,255}),
            Line(points={{-90,0},{-60,0}}, color={0,0,255}),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
            Line(
              points={{-60,0},{-59,6},{-52,14},{-38,14},{-31,6},{-30,0}},
              color={0,0,255},
              smooth=Smooth.Bezier),
            Line(
              points={{-30,0},{-29,6},{-22,14},{-8,14},{-1,6},{0,0}},
              color={0,0,255},
              smooth=Smooth.Bezier),
            Line(
              points={{0,0},{1,6},{8,14},{22,14},{29,6},{30,0}},
              color={0,0,255},
              smooth=Smooth.Bezier),
            Line(
              points={{30,0},{31,6},{38,14},{52,14},{59,6},{60,0}},
              color={0,0,255},
              smooth=Smooth.Bezier),
            Text(
              extent={{-150,-80},{150,-40}},
              textString="m=%m")}), Documentation(info="<html>
<p>
Contains m inductors (Modelica.Electrical.Analog.Basic.Inductor)
</p>
</html>"));
    end Inductor;

    model SaturatingInductor "Simple model of inductors with saturation"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Current Inom[m](start=fill(1, m))
        "Nominal current";
      parameter Modelica.SIunits.Inductance Lnom[m](start=fill(1, m))
        "Nominal inductance at Nominal current";
      parameter Modelica.SIunits.Inductance Lzer[m](start={2*Lnom[j] for j in 1
            :m}) "Inductance near current=0";
      parameter Modelica.SIunits.Inductance Linf[m](start={Lnom[j]/2 for j in 1
            :m}) "Inductance at large currents";
      Modelica.Electrical.Analog.Basic.SaturatingInductor saturatingInductor[m](
        final Inom=Inom,
        final Lnom=Lnom,
        final Lzer=Lzer,
        final Linf=Linf) annotation (Placement(transformation(extent={{-10,-10},
                {10,10}})));
    equation
      connect(saturatingInductor.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(saturatingInductor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      annotation (defaultComponentName="inductor", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{60,0},{90,0}}, color={0,0,255}),
            Line(points={{-90,0},{-60,0}}, color={0,0,255}),
            Rectangle(
              extent={{-60,-10},{60,-20}},
              fillPattern=FillPattern.Sphere,
              fillColor={0,0,255}),
            Line(
              points={{-60,0},{-59,6},{-52,14},{-38,14},{-31,6},{-30,0}},
              color={0,0,255},
              smooth=Smooth.Bezier),
            Line(
              points={{-30,0},{-29,6},{-22,14},{-8,14},{-1,6},{0,0}},
              color={0,0,255},
              smooth=Smooth.Bezier),
            Line(
              points={{0,0},{1,6},{8,14},{22,14},{29,6},{30,0}},
              color={0,0,255},
              smooth=Smooth.Bezier),
            Line(
              points={{30,0},{31,6},{38,14},{52,14},{59,6},{60,0}},
              color={0,0,255},
              smooth=Smooth.Bezier),
            Text(
              extent={{-150,-80},{150,-40}},
              textString="m=%m"),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
<p>
Contains m saturating inductors (Modelica.Electrical.Analog.Basic.SaturatingInductor)
</p>
<p>
<strong>Attention!!!</strong><br>
Each element of the array of saturatingInductors is only dependent on the current flowing through this element.
</p>
</html>"));
    end SaturatingInductor;

    model MutualInductor "Linear mutual inductor"
      extends Modelica.Electrical.MultiPhase.Interfaces.OnePort;
      parameter Real epsilon=1e-9 "Relative accuracy tolerance of matrix symmetry";
      parameter Modelica.SIunits.Inductance L[m, m] "Mutual inductance matrix";
    initial equation
      if abs(Modelica.Math.Matrices.det(L)) < epsilon then
        Modelica.Utilities.Streams.print("Warning: mutual inductance matrix singular!");
      end if;
    equation
      assert(sum(abs(L - transpose(L))) < epsilon*sum(abs(L)),"Mutual inductance matrix is not symmetric");
      for j in 1:m loop
        v[j] = sum(L[j, k]*der(i[k]) for k in 1:m);
      end for;
      annotation (defaultComponentName="inductor", Documentation(info="<html>
<p>
Model of a multi phase inductor providing a mutual inductance matrix model.
</p>
<h4>Implementation</h4>
<pre>
  v[1] = L[1,1]*der(i[1]) + L[1,2]*der(i[2]) + ... + L[1,m]*der(i[m])
  v[2] = L[2,1]*der(i[1]) + L[2,2]*der(i[2]) + ... + L[2,m]*der(i[m])
    :              :                         :                                :
  v[m] = L[m,1]*der(i[1]) + L[m,2]*der(i[2]) + ... + L[m,m]*der(i[m])
</pre>

</html>"), Icon(graphics={
            Line(points={{-80,20},{-80,-20},{-60,-20}}, color={0,0,255}),
            Line(points={{-80,20},{-60,20}}, color={0,0,255}),
            Line(points={{60,20},{80,20}}, color={0,0,255}),
            Line(points={{80,20},{80,-20},{60,-20}}, color={0,0,255}),
            Line(points={{-90,0},{-80,0}}, color={0,0,255}),
            Line(points={{80,0},{90,0}}, color={0,0,255}),
            Line(
              points={{-60,20},{-59,26},{-52,34},{-38,34},{-31,26},{-30,20}},
              color={0,0,255},
              smooth=Smooth.Bezier),
            Line(
              points={{-30,20},{-29,26},{-22,34},{-8,34},{-1,26},{0,20}},
              color={0,0,255},
              smooth=Smooth.Bezier),
            Line(
              points={{0,20},{1,26},{8,34},{22,34},{29,26},{30,20}},
              color={0,0,255},
              smooth=Smooth.Bezier),
            Line(
              points={{30,20},{31,26},{38,34},{52,34},{59,26},{60,20}},
              color={0,0,255},
              smooth=Smooth.Bezier),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-45,-27},
              rotation=180),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-15,-27},
              rotation=180),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={15,-27},
              rotation=180),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={45,-27},
              rotation=180),
            Text(
              extent={{-150,50},{150,90}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-80},{150,-40}},
              textString="m=%m")}));
    end MutualInductor;

    model ZeroInductor "Linear zero sequence inductor"
      extends Modelica.Electrical.MultiPhase.Interfaces.OnePort;
      parameter Modelica.SIunits.Inductance Lzero "Zero sequence inductance";
      Modelica.SIunits.Current i0;
      Modelica.SIunits.Voltage v0;
    equation
      m*i0 = sum(i);
      v0 = Lzero*der(i0);
      v = fill(v0, m);
      annotation (defaultComponentName="inductor", Documentation(info="<html>
<p>
Model of a multi phase zero sequence inductor.
</p>
<h4>Implementation</h4>
<pre>
  v = Lzero*sum(der(i)) = Lzero*der(sum(i))
</pre>

</html>"), Icon(graphics={
            Line(points={{-90,0},{-50,0}}, color={0,0,255}),
            Line(points={{52,0},{90,0}}, color={0,0,255}),
            Ellipse(extent={{-50,30},{-8,-32}}, lineColor={0,0,255}),
            Ellipse(extent={{-20,30},{22,-32}}, lineColor={0,0,255}),
            Ellipse(extent={{10,30},{52,-32}}, lineColor={0,0,255}),
            Text(
              extent={{-150,50},{150,90}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-80},{150,-40}},
              textString="m=%m")}));
    end ZeroInductor;

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
                10}})));
    equation

      connect(plug_p1.pin, transformer.p1) annotation (Line(points={{-100,100},{-10,100},{-10,10}}, color={0,0,255}));
      connect(plug_p2.pin, transformer.p2)
        annotation (Line(points={{100,100},{10,100},{10,10}}, color={0,0,255}));
      connect(plug_n1.pin, transformer.n1) annotation (Line(points={{-100,-100},{-10,-100},{-10,-10}}, color={0,0,255}));
      connect(plug_n2.pin, transformer.n2) annotation (Line(points={{100,-100},{10,-100},{10,-10}}, color={0,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Text(
              extent={{-100,20},{-58,-20}},
              textString="L1",
              lineColor={0,0,255}),
            Text(
              extent={{60,20},{100,-20}},
              textString="L2",
              lineColor={0,0,255}),
            Text(
              extent={{-20,-60},{20,-100}},
              textString="M",
              lineColor={0,0,255}),
            Text(
              extent={{-150,110},{150,150}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{-40,60},{-40,100},{-90,100}}, color={0,0,255}),
            Line(points={{40,60},{40,100},{90,100}}, color={0,0,255}),
            Line(points={{-40,-60},{-40,-100},{-90,-100}}, color={0,0,255}),
            Line(points={{40,-60},{40,-100},{90,-100}}, color={0,0,255}),
            Text(
              extent={{-150,-150},{150,-110}},
              textString="m=%m"),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-33,45},
              rotation=270),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-33,15},
              rotation=270),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-33,-15},
              rotation=270),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-33,-45},
              rotation=270),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={33,45},
              rotation=90),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={33,15},
              rotation=90),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={33,-15},
              rotation=90),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={33,-45},
              rotation=90)}), Documentation(info="<html>
<p>
Contains m transformers (Modelica.Electrical.Analog.Basic.Transformer)
</p>
</html>"));
    end Transformer;

    model VariableResistor
      "Ideal linear electrical resistors with variable resistance"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Temperature T_ref[m]=fill(300.15, m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha[m]=zeros(m)
        "Temperature coefficients of resistances at reference temperatures";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, T=T_ref);
      Modelica.Blocks.Interfaces.RealInput R[m](each unit="Ohm") annotation (
          Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,120})));
      Modelica.Electrical.Analog.Basic.VariableResistor variableResistor[m](
        final T_ref=T_ref,
        final alpha=alpha,
        each final useHeatPort=useHeatPort) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(variableResistor.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(variableResistor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(R, variableResistor.R)
        annotation (Line(points={{0,120},{0,56},{0,12}}, color={0,0,255}));
      connect(variableResistor.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}}, color={191,0,0}));
      annotation (defaultComponentName="resistor", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-90,0},{-70,0}}, color={0,0,255}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{70,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-150,-80},{150,-40}},
              textString="m=%m"),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
<p>
Contains m variable resistors (Modelica.Electrical.Analog.Basic.VariableResistor)
</p>
<p>
<strong>Attention!!!</strong><br>
  It is recommended that none of the R_Port signals should not cross the zero value.
  Otherwise depending on the surrounding circuit the probability of singularities is high.
</p>
</html>"));
    end VariableResistor;

    model VariableConductor
      "Ideal linear electrical conductors with variable conductance"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Temperature T_ref[m]=fill(300.15, m)
        "Reference temperatures";
      parameter Modelica.SIunits.LinearTemperatureCoefficient alpha[m]=zeros(m)
        "Temperature coefficients of conductances at reference temperatures";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, T=T_ref);
      Modelica.Blocks.Interfaces.RealInput G[m](each unit="S") annotation (
          Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,120})));
      Modelica.Electrical.Analog.Basic.VariableConductor variableConductor[m](
        final T_ref=T_ref,
        final alpha=alpha,
        each final useHeatPort=useHeatPort) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(variableConductor.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(variableConductor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(G, variableConductor.G)
        annotation (Line(points={{0,120},{0,56},{0,12}}, color={0,0,255}));
      connect(variableConductor.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}}, color={191,0,0}));
      annotation (defaultComponentName="conductor", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-90,0},{-70,0}}, color={0,0,255}),
            Rectangle(
              extent={{-70,30},{70,-30}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{70,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-150,-80},{150,-40}},
              textString="m=%m"),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
<p>
Contains m variable conductors (Modelica.Electrical.Analog.Basic.VariableConductor)
</p>
<p>
<strong>Attention!!!</strong><br>
  It is recommended that none of the G_Port signals should not cross the zero value.
  Otherwise depending on the surrounding circuit the probability of singularities is high.
</p>
</html>"));
    end VariableConductor;

    model VariableCapacitor
      "Ideal linear electrical capacitors with variable capacitance"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Capacitance Cmin[m]=fill(Modelica.Constants.eps,
          m) "minimum Capacitance";
      Modelica.Blocks.Interfaces.RealInput C[m](each unit="F") annotation (
          Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.Analog.Basic.VariableCapacitor variableCapacitor[m](
          final Cmin=Cmin) annotation (Placement(transformation(extent={{-10,-10},
                {10,10}})));
    equation
      connect(variableCapacitor.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(variableCapacitor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(C, variableCapacitor.C)
        annotation (Line(points={{0,120},{0,56},{0,12}}, color={0,0,255}));
      annotation (defaultComponentName="capacitor", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-90,0},{-6,0}}, color={0,0,255}),
            Line(points={{6,0},{90,0}}, color={0,0,255}),
            Line(points={{-6,28},{-6,-28}}, color={0,0,255}),
            Line(points={{6,28},{6,-28}}, color={0,0,255}),
            Text(
              extent={{-150,-80},{150,-40}},
              textString="m=%m"),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}),
                                  Documentation(info="<html>
<p>
Contains m variable capacitors (Modelica.Electrical.Analog.Basic.VariableCapacitor)
</p>
<p>
It is required that each C_Port.signal &ge; 0, otherwise an
assertion is raised. To avoid a variable index system,<br>
C = Cmin, if 0 &le; C_Port.signal &lt; Cmin, where
Cmin is a parameter with default value Modelica.Constants.eps.
</p>
</html>"));
    end VariableCapacitor;

    model VariableInductor
      "Ideal linear electrical inductors with variable inductance"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Inductance Lmin[m]=fill(Modelica.Constants.eps,
          m) "minimum Inductance";
      Modelica.Blocks.Interfaces.RealInput L[m](each unit="H") annotation (
          Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,120})));
      Modelica.Electrical.Analog.Basic.VariableInductor variableInductor[m](
          final Lmin=Lmin) annotation (Placement(transformation(extent={{-10,-10},
                {10,10}})));

    equation
      connect(variableInductor.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(variableInductor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(L, variableInductor.L)
        annotation (Line(points={{0,120},{0,56},{0,12}}, color={0,0,255}));
      annotation (defaultComponentName="inductor", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-90,0},{-60,0}}, color={0,0,255}),
            Line(points={{60,0},{90,0}}, color={0,0,255}),
            Line(
              points={{-60,0},{-59,6},{-52,14},{-38,14},{-31,6},{-30,0}},
              color={0,0,255},
              smooth=Smooth.Bezier),
            Line(
              points={{-30,0},{-29,6},{-22,14},{-8,14},{-1,6},{0,0}},
              color={0,0,255},
              smooth=Smooth.Bezier),
            Line(
              points={{0,0},{1,6},{8,14},{22,14},{29,6},{30,0}},
              color={0,0,255},
              smooth=Smooth.Bezier),
            Line(
              points={{30,0},{31,6},{38,14},{52,14},{59,6},{60,0}},
              color={0,0,255},
              smooth=Smooth.Bezier),
            Text(
              extent={{-150,-80},{150,-40}},
              textString="m=%m"),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
<p>
Contains m variable inductors (Modelica.Electrical.Analog.Basic.VariableInductor)
</p>
<p>
It is required that each L_Port.signal &ge; 0, otherwise an
assertion is raised. To avoid a variable index system,<br>
L = Lmin, if 0 &le; L_Port.signal &lt; Lmin, where
Lmin is a parameter with default value Modelica.Constants.eps.
</p>
</html>"));
    end VariableInductor;
    annotation (Documentation(info="<html>
<p>
This package contains basic analog electrical multiphase components.
</p>

</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Release Notes:</strong></dt>
  <dd>
  <ul>
  <li> v1.0 2004/10/01 Anton Haumer</li>
  </ul>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Rectangle(
            origin={11.626,40},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            extent={{-80,-70},{60,-10}}),
          Line(
            origin={11.626,40},
            points={{60,-40},{80,-40}},
            color={0,0,255}),
          Line(points={{-88.374,0},{-68.374,0}}, color={0,0,255})}));
  end Basic;

  package Ideal "Multiphase components with idealized behaviour"
    extends Modelica.Icons.Package;

    model IdealDiode "Multiphase ideal diode"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m), start=
            fill(1e-5, m)) "Closed diode resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start=
            fill(1e-5, m)) "Opened diode conductance";
      parameter Modelica.SIunits.Voltage Vknee[m](final min=zeros(m), start=
            zeros(m)) "Threshold voltage";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, final T=fill(293.15, m));
      Modelica.Electrical.Analog.Ideal.IdealDiode idealDiode[m](
        final Ron=Ron,
        final Goff=Goff,
        final Vknee=Vknee,
        each final useHeatPort=useHeatPort) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(plug_p.pin, idealDiode.p)
        annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
      connect(idealDiode.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(idealDiode.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}}, color={191,0,0}));
      annotation (defaultComponentName="diode",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{-90,0},{40,0}}, color={0,0,255}),
            Polygon(
              points={{30,0},{-30,40},{-30,-40},{30,0}},
              lineColor={0,0,255},
              fillColor={255,255,255}),
            Line(points={{30,40},{30,-40}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-150,-80},{150,-40}},
              textString="m=%m"),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>
<p>
Contains m ideal diodes (Modelica.Electrical.Analog.Ideal.IdealDiode).
</p>
</html>"));
    end IdealDiode;

    model IdealThyristor "Multiphase ideal thyristor"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m), start=
            fill(1e-5, m)) "Closed thyristor resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start=
            fill(1e-5, m)) "Opened thyristor conductance";
      parameter Modelica.SIunits.Voltage Vknee[m](final min=zeros(m), start=
            zeros(m)) "Threshold voltage";
      Boolean off[m] = idealThyristor.off "Alias of boolean thyristor off";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, final T=fill(293.15, m));
      Modelica.Blocks.Interfaces.BooleanInput fire[m] annotation (Placement(
            transformation(
            origin={100,120},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={100,118})));
      Modelica.Electrical.Analog.Ideal.IdealThyristor idealThyristor[m](
        final Ron=Ron,
        final Goff=Goff,
        final Vknee=Vknee,
        each final useHeatPort=useHeatPort) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(plug_p.pin, idealThyristor.p) annotation (Line(points={{-100,0},{
              -60,0},{-38,0},{-10,0}}, color={0,0,255}));
      connect(idealThyristor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(fire, idealThyristor.fire) annotation (Line(points={{100,120},{100,80},{10,80},{10,12}}, color={255,0,255}));
      connect(idealThyristor.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}}, color={191,0,0}));
      annotation (defaultComponentName="thyristor", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-90,0},{40,0}}, color={0,0,255}),
            Polygon(
              points={{30,0},{-30,40},{-30,-40},{30,0}},
              lineColor={0,0,255},
              fillColor={255,255,255}),
            Line(points={{30,40},{30,-40}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-150,-80},{150,-40}},
              textString="m=%m"),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{40,50},{60,30}}, color={0,0,255}),
            Line(points={{30,20},{58,48}}, color={0,0,255}),
            Line(points={{100,90},{100,100}}, color={0,0,255})}),
                                    Documentation(info="<html>
<p>
Contains m ideal thyristors (Modelica.Electrical.Analog.Ideal.IdealThyristor).
</p>
</html>"));
    end IdealThyristor;

    model IdealGTOThyristor "Multiphase ideal GTO thyristor"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m), start=
            fill(1e-5, m)) "Closed thyristor resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start=
            fill(1e-5, m)) "Opened thyristor conductance";
      parameter Modelica.SIunits.Voltage Vknee[m](final min=zeros(m), start=
            zeros(m)) "Threshold voltage";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, final T=fill(293.15, m));
      Modelica.Blocks.Interfaces.BooleanInput fire[m] annotation (Placement(
            transformation(
            origin={100,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.Analog.Ideal.IdealGTOThyristor idealGTOThyristor[m](
        final Ron=Ron,
        final Goff=Goff,
        final Vknee=Vknee,
        each final useHeatPort=useHeatPort) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(idealGTOThyristor.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(idealGTOThyristor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(fire, idealGTOThyristor.fire) annotation (Line(points={{100,120},{100,80},{10,80},{10,12}}, color={255,0,255}));
      connect(idealGTOThyristor.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}}, color={191,0,0}));
      annotation (defaultComponentName="gto", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-90,0},{40,0}}, color={0,0,255}),
            Polygon(
              points={{30,0},{-30,40},{-30,-40},{30,0}},
              lineColor={0,0,255},
              fillColor={255,255,255}),
            Line(points={{30,40},{30,-40}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255}),
            Line(points={{100,90},{100,100}}, color={0,0,255}),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-80},{150,-40}},
              textString="m=%m"),
            Line(points={{48,52},{68,32}}, color={0,0,255}),
            Polygon(
              points={{44,43},{44,36},{51,36},{44,43}},
              lineColor={0,0,255},
              fillPattern=FillPattern.Solid,
              fillColor={0,0,255}),
            Polygon(
              points={{46,33},{53,33},{53,26},{46,33}},
              lineColor={0,0,255},
              fillPattern=FillPattern.Solid,
              fillColor={0,0,255}),
            Line(points={{30,10},{68,48}}, color={0,0,255}),
            Line(points={{30,22},{56,48}}, color={0,0,255})}),
                                    Documentation(info="<html>
<p>
Contains m ideal GTO thyristors (Modelica.Electrical.Analog.Ideal.IdealGTOThyristor).
</p>
</html>"));
    end IdealGTOThyristor;

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
      Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      Interfaces.NegativePlug plug_n2(final m=m) annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
      Interfaces.NegativePlug plug_n1(final m=m) annotation (Placement(
            transformation(extent={{90,30},{110,50}}), iconTransformation(extent={{90,30},{110,50}})));
      Modelica.Electrical.Analog.Ideal.IdealCommutingSwitch idealCommutingSwitch[m](
        final Ron=Ron,
        final Goff=Goff,
        each final useHeatPort=useHeatPort) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(plug_p.pin, idealCommutingSwitch.p)
        annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
      connect(idealCommutingSwitch.n2, plug_n2.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(idealCommutingSwitch.n1, plug_n1.pin)
        annotation (Line(points={{10,4},{10,40},{100,40}}, color={0,0,255}));
      connect(control, idealCommutingSwitch.control)
        annotation (Line(points={{0,120},{0,46},{0,12}}, color={255,0,255}));
      connect(idealCommutingSwitch.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}}, color={191,0,0}));
      annotation (defaultComponentName="switch", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Ellipse(extent={{-44,4},{-36,-4}}, lineColor={0,0,255}),
            Line(points={{-90,0},{-44,0}}, color={0,0,255}),
            Line(points={{-37,2},{40,40}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255}),
            Line(points={{40,40},{90,40}},
                                         color={0,0,255}),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-80},{150,-40}},
              textString="m=%m")}), Documentation(info=
             "<html>
<p>
Contains m ideal commuting switches (Modelica.Electrical.Analog.Ideal.IdealCommutingSwitch).
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
      Interfaces.PositivePlug plug_p1(final m=m) annotation (Placement(
            transformation(extent={{-110,30},{-90,50}}), iconTransformation(extent={{-110,30},{-90,50}})));
      Interfaces.PositivePlug plug_p2(final m=m) annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      Interfaces.NegativePlug plug_n2(final m=m) annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
      Interfaces.NegativePlug plug_n1(final m=m) annotation (Placement(
            transformation(extent={{90,30},{110,50}}), iconTransformation(extent={{90,30},{110,50}})));
      Modelica.Electrical.Analog.Ideal.IdealIntermediateSwitch idealIntermediateSwitch[m](
        final Ron=Ron,
        final Goff=Goff,
        each final useHeatPort=useHeatPort) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(plug_p2.pin, idealIntermediateSwitch.p2)
        annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
      connect(idealIntermediateSwitch.n2, plug_n2.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(idealIntermediateSwitch.p1, plug_p1.pin) annotation (Line(points={{-10,4},{-10,40},{-100,40}}, color={0,0,255}));
      connect(idealIntermediateSwitch.n1, plug_n1.pin)
        annotation (Line(points={{10,4},{10,40},{100,40}}, color={0,0,255}));
      connect(control, idealIntermediateSwitch.control)
        annotation (Line(points={{0,120},{0,64},{0,12}}, color={255,0,255}));
      connect(idealIntermediateSwitch.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}}, color={191,0,0}));
      annotation (defaultComponentName="switch", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Ellipse(extent={{-4,24},{4,16}}, lineColor={0,0,255}),
            Line(points={{-90,0},{-40,0}}, color={0,0,255}),
            Line(points={{-90,40},{-40,40}}, color={0,0,255}),
            Line(points={{-40,0},{40,40}}, color={0,0,255}),
            Line(points={{-40,40},{40,0}}, color={0,0,255}),
            Line(points={{40,40},{90,40}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-80},{150,-40}},
              textString="m=%m")}), Documentation(info=
             "<html>
<p>
Contains m ideal intermediate switches (Modelica.Electrical.Analog.Ideal.IdealIntermediateSwitch).
</p>
</html>"));
    end IdealIntermediateSwitch;

    model IdealTransformer "Multiphase ideal transformer"
      extends Interfaces.FourPlug;
      parameter Real n[m](start=fill(1, m)) "Turns ratio primary:secondary voltage";
      parameter Boolean considerMagnetization=false
        "Choice of considering magnetization";
      parameter SIunits.Inductance Lm1[m](start=fill(1, m))
        "Magnetization inductances w.r.t. primary side";
      Modelica.Electrical.Analog.Ideal.IdealTransformer idealTransformer[m](
        final n=n,
        each final considerMagnetization=considerMagnetization,
        final Lm1=Lm1) annotation (Placement(transformation(extent={{-10,-10},{
                10,10}})));
    equation
      connect(plug_p1.pin, idealTransformer.p1) annotation (Line(points={{-100,100},{-10,100},{-10,10}}, color={0,0,255}));
      connect(plug_p2.pin, idealTransformer.p2)
        annotation (Line(points={{100,100},{10,100},{10,10}}, color={0,0,255}));
      connect(plug_n1.pin, idealTransformer.n1) annotation (Line(points={{-100,-100},{-10,-100},{-10,-10}}, color={0,0,255}));
      connect(plug_n2.pin, idealTransformer.n2) annotation (Line(points={{100,-100},{10,-100},{10,-10}}, color={0,0,255}));
      annotation (defaultComponentName="transformer", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Text(
              extent={{-150,-110},{150,-150}},
              textString="m=%m"),
            Line(points={{-40,60},{-40,100},{-90,100}}, color={0,0,255}),
            Line(points={{40,60},{40,100},{90,100}}, color={0,0,255}),
            Line(points={{-40,-60},{-40,-100},{-90,-100}}, color={0,0,255}),
            Line(points={{40,-60},{40,-100},{90,-100}}, color={0,0,255}),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-33,45},
              rotation=270),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-33,15},
              rotation=270),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-33,-15},
              rotation=270),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-33,-45},
              rotation=270),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={33,45},
              rotation=90),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={33,15},
              rotation=90),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={33,-15},
              rotation=90),
            Line(
              points={{-15,-7},{-14,-1},{-7,7},{7,7},{14,-1},{15,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={33,-45},
              rotation=90),
            Text(
              extent={{-100,20},{-60,-20}},
              lineColor={0,0,255},
              textString="1"),
            Text(
              extent={{60,20},{100,-20}},
              lineColor={0,0,255},
              textString="2"),
            Text(
              extent={{-150,149},{150,109}},
              textString="%name",
              lineColor={0,0,255})}),
                                  Documentation(info="<html>
<p>
Contains m ideal transformers (Modelica.Electrical.Analog.Ideal.IdealTransformer).
</p>
<p>
<strong>Note:</strong> Due to the above equations, also DC signals will be transformed!
</p>
</html>"));
    end IdealTransformer;

    model Idle "Multiphase idle branch"
      extends Interfaces.TwoPlug;
      Modelica.Electrical.Analog.Ideal.Idle idle[m] annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
    equation

      connect(plug_p.pin, idle.p)
        annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
      connect(idle.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Rectangle(
              extent={{-80,80},{80,-80}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Line(points={{-90,0},{-41,0}}, color={0,0,255}),
            Line(points={{91,0},{40,0}}, color={0,0,255}),
            Text(
              extent={{-150,130},{150,90}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-90},{150,-130}},
              textString="m=%m")}), Documentation(info=
             "<html>
<p>
Contains m idles (Modelica.Electrical.Analog.Ideal.Idle)
</p>
</html>"));
    end Idle;

    model Short "Multiphase short cut branch"
      extends Interfaces.TwoPlug;
      Modelica.Electrical.Analog.Ideal.Short short[m] annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
    equation

      connect(plug_p.pin, short.p)
        annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
      connect(short.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Rectangle(
              extent={{-80,80},{80,-80}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,255}),
            Line(points={{-90,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-150,130},{150,90}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-90},{150,-130}},
              textString="m=%m")}), Documentation(
            info="<html>
<p>
Contains m short cuts (Modelica.Electrical.Analog.Ideal.Short)
</p>
</html>"));
    end Short;

    model IdealOpeningSwitch "Multiphase ideal opener"
      extends Interfaces.TwoPlug;
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
      Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch idealOpeningSwitch[m](
        final Ron=Ron,
        final Goff=Goff,
        each final useHeatPort=useHeatPort) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(plug_p.pin, idealOpeningSwitch.p)
        annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
      connect(idealOpeningSwitch.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(control, idealOpeningSwitch.control)
        annotation (Line(points={{0,120},{0,48},{0,12}}, color={255,0,255}));
      connect(idealOpeningSwitch.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}}, color={191,0,0}));
      annotation (defaultComponentName="switch", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-90,0},{-44,0}}, color={0,0,255}),
            Ellipse(extent={{-44,4},{-36,-4}}, lineColor={0,0,255}),
            Line(points={{-37,2},{40,40}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255}),
            Line(points={{40,20},{40,0}}, color={0,0,255}),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-80},{150,-40}},
              textString="m=%m")}), Documentation(
            info="<html>
<p>
Contains m ideal opening switches (Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch).
</p>
</html>"));
    end IdealOpeningSwitch;

    model IdealClosingSwitch "Multiphase ideal closer"
      extends Interfaces.TwoPlug;
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
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealClosingSwitch[m](
        final Ron=Ron,
        final Goff=Goff,
        each final useHeatPort=useHeatPort) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(plug_p.pin, idealClosingSwitch.p)
        annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
      connect(idealClosingSwitch.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(control, idealClosingSwitch.control)
        annotation (Line(points={{0,120},{0,48},{0,12}}, color={255,0,255}));
      connect(idealClosingSwitch.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}}, color={191,0,0}));
      annotation (defaultComponentName="switch", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-90,0},{-44,0}}, color={0,0,255}),
            Ellipse(extent={{-44,4},{-36,-4}}, lineColor={0,0,255}),
            Line(points={{-37,2},{40,40}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-80},{150,-40}},
              textString="m=%m")}),
                                  Documentation(info="<html>
<p>
Contains m ideal closing switches (Modelica.Electrical.Analog.Ideal.IdealClosingSwitch).
</p><
</html>"));
    end IdealClosingSwitch;

    model OpenerWithArc "Multiphase opener with arc"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m), start=
            fill(1e-5, m)) "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start=
            fill(1e-5, m)) "Opened switch conductance";
      parameter Modelica.SIunits.Voltage V0[m](start=fill(30, m))
        "Initial arc voltage";
      parameter Modelica.SIunits.VoltageSlope dVdt[m](start=fill(10E3, m))
        "Arc voltage slope";
      parameter Modelica.SIunits.Voltage Vmax[m](start=fill(60, m))
        "Max. arc voltage";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, final T=fill(293.15, m));
      Modelica.Blocks.Interfaces.BooleanInput control[m]
        "true => switch open, false => p--n connected" annotation (Placement(
            transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.Analog.Ideal.OpenerWithArc openerWithArc[m](
        final Ron=Ron,
        final Goff=Goff,
        final V0=V0,
        final dVdt=dVdt,
        final Vmax=Vmax,
        each final useHeatPort=useHeatPort) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(plug_p.pin, openerWithArc.p)
        annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
      connect(openerWithArc.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(control, openerWithArc.control)
        annotation (Line(points={{0,120},{0,40},{0,11}}, color={255,0,255}));
      connect(openerWithArc.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}}, color={191,0,0}));
      annotation (defaultComponentName="switch", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-90,0},{-44,0}}, color={0,0,255}),
            Ellipse(extent={{-44,4},{-36,-4}}, lineColor={0,0,255}),
            Line(points={{-37,2},{40,42}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255}),
            Line(points={{40,20},{40,0}}, color={0,0,255}),
            Line(points={{40,42},{32,32},{48,28},{40,20}}, color={255,0,0}),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-80},{150,-40}},
              textString="m=%m")}),
          Documentation(info="<html>
<p>Contains m opening switches with arc (Modelica.Electrical.Analog.Ideal.OpenerWithArc).</p>
</html>"));
    end OpenerWithArc;

    model CloserWithArc "Multiphase closer with arc"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Resistance Ron[m](final min=zeros(m), start=
            fill(1e-5, m)) "Closed switch resistance";
      parameter Modelica.SIunits.Conductance Goff[m](final min=zeros(m), start=
            fill(1e-5, m)) "Opened switch conductance";
      parameter Modelica.SIunits.Voltage V0[m](start=fill(30, m))
        "Initial arc voltage";
      parameter Modelica.SIunits.VoltageSlope dVdt[m](start=fill(10E3, m))
        "Arc voltage slope";
      parameter Modelica.SIunits.Voltage Vmax[m](start=fill(60, m))
        "Max. arc voltage";
      extends Modelica.Electrical.MultiPhase.Interfaces.ConditionalHeatPort(
          final mh=m, final T=fill(293.15, m));
      Modelica.Blocks.Interfaces.BooleanInput control[m]
        "true => switch open, false => p--n connected" annotation (Placement(
            transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.Analog.Ideal.CloserWithArc closerWithArc[m](
        final Ron=Ron,
        final Goff=Goff,
        final V0=V0,
        final dVdt=dVdt,
        final Vmax=Vmax,
        each final useHeatPort=useHeatPort) annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(plug_p.pin, closerWithArc.p)
        annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
      connect(closerWithArc.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(control, closerWithArc.control)
        annotation (Line(points={{0,120},{0,42},{0,11}}, color={255,0,255}));
      connect(closerWithArc.heatPort, heatPort) annotation (Line(
          points={{0,-10},{0,-100}}, color={191,0,0}));
      annotation (defaultComponentName="switch", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-90,0},{-44,0}}, color={0,0,255}),
            Ellipse(extent={{-44,4},{-36,-4}}, lineColor={0,0,255}),
            Line(points={{-37,2},{40,40}}, color={0,0,255}),
            Line(points={{40,0},{90,0}}, color={0,0,255}),
            Line(points={{40,40},{32,16},{48,24},{40,0}}, color={255,0,0}),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-80},{150,-40}},
              textString="m=%m")}),
          Documentation(info="<html>
<p>Contains m closing switches with arc (Modelica.Electrical.Analog.Ideal.CloserWithArc).</p>
</html>"));
    end CloserWithArc;
    annotation (Documentation(info="<html>
<p>
This package contains analog electrical multiphase components with idealized behaviour,
like thyristor, diode, switch, transformer.
</p>

</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Release Notes:</strong></dt>
  <dd>
  <ul>
  <li> v1.0 2004/10/01 Anton Haumer</li>
  </ul>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Line(
            origin={10,40},
            points={{-100,-40},{80,-40}},
            color={0,0,255}),
          Polygon(
            origin={10,40},
            fillColor={255,255,255},
            points={{20,-40},{-40,0},{-40,-80},{20,-40}}),
          Line(
            origin={-10,0},
            points={{40,40},{40,-40}},
            color={0,0,255})}));
  end Ideal;

  package Blocks "Blocks for multi phase systems"
    extends Modelica.Icons.Package;
    block QuasiRMS
      extends Modelica.Blocks.Interfaces.SO;
      parameter Integer m(min=2) = 3 "Number of phases";
      Modelica.Blocks.Interfaces.RealInput u[m]
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    equation
      y = Modelica.Electrical.MultiPhase.Functions.quasiRMS(u);

      annotation (defaultComponentName="rms", Documentation(info="<html>
<p>
This block determines the continuous quasi <a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">RMS</a> value of a multi phase system, representing an equivalent RMS vector or phasor. If the waveform of the input deviates from a sine curve, the output of the sensor will not be exactly the average RMS value.
</p>
<pre>
 y = sqrt(sum(u[k]^2 for k in 1:m)/m)
</pre>
</html>"));
    end QuasiRMS;
  end Blocks;

  package Functions "Functions for multi phase systems"
    extends Modelica.Icons.FunctionsPackage;

    function quasiRMS "Calculate continuous quasi RMS value of input"
      extends Modelica.Icons.Function;
      input Real x[:];
      output Real y;
    algorithm
      y := sqrt(sum(x .^ 2/size(x, 1)));
      annotation (Inline=true, Documentation(info="<html>
<p>
This function determines the continuous quasi <a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">RMS</a> value of a multi phase system, representing an equivalent RMS vector or phasor. If the waveform of the input deviates from a sine curve, the output of the sensor will not be exactly the average RMS value.
</p>
<pre>
 y = sqrt(sum(u[k]^2 for k in 1:m)/m)
</pre>
</html>"));
    end quasiRMS;

    function activePower "Calculate active power of voltage and current input"
      extends Modelica.Icons.Function;
      input Modelica.SIunits.Voltage v[:] "Phase voltages";
      input Modelica.SIunits.Current i[size(v, 1)] "Phase currents";
      output Modelica.SIunits.Power p "Active power";
    algorithm
      p := sum(v .* i);
      annotation (Inline=true, Documentation(info="<html>
<p>
Calculates instantaneous power from multiphase voltages and currents.
In quasistationary operation, instantaneous power equals active power;
</p>
</html>"));
    end activePower;

    function symmetricOrientation
      "Orientations of the resulting fundamental wave field phasors"
      extends Modelica.Icons.Function;
      input Integer m "Number of phases";
      output Modelica.SIunits.Angle orientation[m]
        "Orientation of the resulting fundamental wave field phasors";
      import Modelica.Constants.pi;
    algorithm
      if mod(m, 2) == 0 then
        // Even number of phases
        if m == 2 then
          // Special case two phase machine
          orientation[1] := 0;
          orientation[2] := +pi/2;
        else
          orientation[1:integer(m/2)] := symmetricOrientation(integer(m/2));
          orientation[integer(m/2) + 1:m] := symmetricOrientation(integer(m/2))
             - fill(pi/m, integer(m/2));
        end if;
      else
        // Odd number of phases
        orientation := {(k - 1)*2*pi/m for k in 1:m};
      end if;
      annotation (Documentation(info="<html>
<p>
This function determines the orientation angles of the symmetrical winding with m phases.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.MultiPhase.UsersGuide.PhaseOrientation\">User's guide</a> on symmetrical components and orientation.
</p>
</html>"));
    end symmetricOrientation;

    function symmetricOrientationMatrix
      "Matrix symmetric orientation angles for creating the symmetric transformation matrix"
      extends Modelica.Icons.Function;
      import Modelica.Constants.pi;
      input Integer m "Number of phases";
      output Modelica.SIunits.Angle oM[m, m]
        "Angles of symmetric transformation matrix";
    protected
      Integer nBase=numberOfSymmetricBaseSystems(m);
      Integer mBase=integer(m/nBase);
      Modelica.SIunits.Angle o[m]=symmetricOrientation(m);
      Modelica.SIunits.Angle oBase[numberOfSymmetricBaseSystems(m)]=o[1:mBase:m];
    algorithm
      // Init transformation matrix with zeros
      oM := zeros(m, m);
      // mBase is either 2
      if mBase==2 then
        oM[1:mBase,1:mBase] := {o[1:mBase],-o[1:mBase]};
      else // or odd
        for j in 1:mBase loop
          oM[j,1:mBase] := j*o[1:mBase];
        end for;
      end if;
      // shift base orientationMatrix nBase times along diagonal
      for i in 2:nBase loop
        for k in 1:mBase loop
          oM[(i - 1)*mBase + k, (i - 1)*mBase + 1:i*mBase] := oM[k, 1:mBase] + fill(oBase[i], mBase);
        end for;
      end for;
      annotation (Documentation(info="<html>
<p>
This function determines the orientation matrix of the symmetrical winding with m phases.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.MultiPhase.UsersGuide.PhaseOrientation\">User's guide</a> on symmetrical components and orientation.
</p>
</html>"));
    end symmetricOrientationMatrix;

    function symmetricTransformationMatrix
      "Transformation matrix for symmetrical components"
      extends Modelica.Icons.Function;
      import Modelica.ComplexMath.fromPolar;
      input Integer m "Number of phases";
      output Complex tM[m, m]
        "Transformation matrix for m phase symmetrical components";
    protected
      Integer nBase=numberOfSymmetricBaseSystems(m);
      Integer mBase=integer(m/nBase);
      Real factor=nBase/m;
      Modelica.SIunits.Angle oM[m,m]=symmetricOrientationMatrix(m);
    algorithm
      //fill only elements within baseSystems
      for i in 1:nBase loop
        for j in 1:nBase loop
          for ii in (i - 1)*mBase + 1:i*mBase loop
            for jj in (j - 1)*mBase + 1:j*mBase loop
              tM[ii,jj] :=fromPolar(if i==j then factor else 0, oM[ii,jj]);
            end for;
          end for;
        end for;
      end for;
      annotation (Documentation(info="<html>
<p>
This function determines the transformation matrix of the symmetrical winding with m phases.
</p>
<p>
The transformation matrix can be used to determine the symmetrical components from time phasors.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.MultiPhase.UsersGuide.PhaseOrientation\">User's guide</a> on symmetrical components and orientation.
</p>
</html>"));
    end symmetricTransformationMatrix;

    function symmetricBackTransformationMatrix
      "Back transformation matrix for symmetrical components"
      extends Modelica.Icons.Function;
      import Modelica.ComplexMath.fromPolar;
      input Integer m "Number of phases";
      output Complex bTM[m, m]
        "Back transformation matrix for m phase symmetrical components";
    protected
      Integer nBase=numberOfSymmetricBaseSystems(m);
      Integer mBase=integer(m/nBase);
      Real factor=1;
      Modelica.SIunits.Angle oM[m,m]=symmetricOrientationMatrix(m);
    algorithm
      //inverse (within baseSystems): conjugate and transpose
      for i in 1:nBase loop
        for j in 1:nBase loop
          for ii in (i - 1)*mBase + 1:i*mBase loop
            for jj in (j - 1)*mBase + 1:j*mBase loop
              bTM[ii,jj] :=fromPolar(if i==j then factor else 0, -oM[jj,ii]);
            end for;
          end for;
        end for;
      end for;
      annotation (Documentation(info="<html>
<p>
This function determines the back transformation matrix of the symmetrical winding with m phases.
</p>
<p>
The back transformation matrix can be used to determine the time phasors from the symmetrical components.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.MultiPhase.UsersGuide.PhaseOrientation\">User's guide</a> on symmetrical components and orientation.
</p>
</html>"));
    end symmetricBackTransformationMatrix;

    function numberOfSymmetricBaseSystems
      "Determines the number of symmetric base systems of m phase symmetric system"
      extends Modelica.Icons.Function;
      input Integer m=3 "Number of phases";
      output Integer n "Number of symmetric base systems";
    algorithm
      // Init number of base systems
      n := 1;
      if mod(m, 2) == 0 then
        // Even number of phases
        if m == 2 then
          // Special case two phase machine
          n := 1;
        else
          n := n*2*numberOfSymmetricBaseSystems(integer(m/2));
        end if;
      else
        // Odd number of phases
        n := 1;
      end if;
      annotation (Documentation(info="<html>
<p>
This function determines the number of base systems of the symmetrical winding with m phases.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.MultiPhase.UsersGuide.PhaseOrientation\">User's guide</a> on symmetrical components and orientation.
</p>
</html>"));
    end numberOfSymmetricBaseSystems;

    function factorY2D "Calculates factor Y voltage to polygon (delta) voltage"
      extends Modelica.Icons.Function;
      import Modelica.Constants.pi;
      input Integer m=3 "Number of phases";
      output Real y "Factor Y to D";
    protected
      parameter Integer mBasic=integer(m/
          Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(
          m));
    algorithm
      y := 2*sin(pi/mBasic);
    end factorY2D;

    function factorY2DC "Calculates factor of DC-voltage from RMS Y-voltage"
      extends Modelica.Icons.Function;
      import Modelica.Constants.pi;
      input Integer m=3 "Number of phases";
      output Real y "Factor Yrms to DC";
    protected
      parameter Integer mBasic=integer(m/
          Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(
          m));
    algorithm
      y := sqrt(2)*2*sin((mBasic - 1)/mBasic*pi/2)*sin(pi/(2*m))/(pi/(2*m));
    end factorY2DC;

    function indexPositiveSequence
      "Determines the indices of the all positive sequences"
      extends Modelica.Icons.Function;
      input Integer m=3 "Number of phases";
      output Integer ind[numberOfSymmetricBaseSystems(m)]
        "Number of symmetric base systems";
    protected
      Integer n=numberOfSymmetricBaseSystems(m);
    algorithm
      if n == 1 then
        ind[1] := 1;
      else
        ind := (0:n - 1)*integer(m/n) + ones(n);
      end if;
      annotation (Documentation(info="<html>
<p>
This function determines the indices of positive sequence of the symmetrical winding with m phases.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.MultiPhase.UsersGuide.PhaseOrientation\">User's guide</a> on symmetrical components and orientation.
</p>
</html>"));
    end indexPositiveSequence;

    function indexNonPositiveSequence
      "Determines the indices of all non positive sequences"
      extends Modelica.Icons.Function;
      input Integer m=3 "Number of phases";
      output Integer ind[numberOfSymmetricBaseSystems(m)*(integer(m/
        numberOfSymmetricBaseSystems(m)) - 1)]
        "Indices of non positive sequences";
    protected
      Integer nBase=numberOfSymmetricBaseSystems(m) "Number of base systems";
      Integer mBase=integer(m/nBase) "Number of phases of base system";
    algorithm
      if mBase == 1 then
        ind := fill(0, 0);
      elseif mBase == 2 then
        for k in 1:nBase loop
          ind[k] := 2 + 2*(k - 1);
        end for;
      else
        for k in 1:nBase loop
          ind[(mBase - 1)*(k - 1) + 1:(mBase - 1)*k] := (2:mBase) + mBase*(k - 1)*ones(mBase - 1);
        end for;
      end if;
      annotation (Documentation(info="<html>
<p>
This function determines the indices of non-positive sequence of the symmetrical winding with m phases.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.MultiPhase.UsersGuide.PhaseOrientation\">User's guide</a> on symmetrical components and orientation.
</p>
</html>"));
    end indexNonPositiveSequence;
  end Functions;

  package Sensors "Multiphase potential, voltage and current Sensors"
    extends Modelica.Icons.SensorsPackage;

    model PotentialSensor "Multiphase potential sensor"
      extends Modelica.Icons.RotationalSensor;
      parameter Integer m(final min=1) = 3 "Number of phases";
      Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Blocks.Interfaces.RealOutput phi[m]
        "Absolute voltage potential as output signal" annotation (Placement(
            transformation(extent={{100,-10},{120,10}})));
      Modelica.Electrical.Analog.Sensors.PotentialSensor potentialSensor[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(potentialSensor.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(potentialSensor.phi, phi) annotation (Line(
          points={{11,0},{110,0}}, color={0,0,127}));
      annotation (
        Icon(graphics={Line(points={{70,0},{100,0}}, color={0,0,127}),
              Line(points={{-70,0},{-90,0}}),
            Text(
              extent={{150,-100},{-150,-70}},
              textString="m=%m"),
            Text(
              extent={{-150,80},{150,120}},
                  textString="%name",
                  lineColor={0,0,255})}), Documentation(info="<html>
<p>
Contains m potential sensors (Modelica.Electrical.Analog.Sensors.PotentialSensor),
thus measuring the m potentials <em>phi[m]</em> of the m pins of plug_p.
</p>
</html>"));
    end PotentialSensor;

    model VoltageSensor "Multiphase voltage sensor"
      extends Modelica.Icons.RotationalSensor;
      parameter Integer m(final min=1) = 3 "Number of phases";
      Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
      Modelica.Blocks.Interfaces.RealOutput v[m]
        "Voltage between pin p and n (= p.v - n.v) as output signal"
        annotation (Placement(transformation(
            origin={0,-110},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(voltageSensor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(voltageSensor.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(voltageSensor.v, v) annotation (Line(
          points={{0,-11},{0,-110}}, color={0,0,127}));
      annotation (
        Icon(graphics={Text(
                  extent={{-29,-11},{30,-70}},
                  textString="V"), Line(points={{-70,0},{-90,0}}),
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
Contains m voltage sensors (Modelica.Electrical.Analog.Sensors.VoltageSensor),
thus measuring the m potential differences <em>v[m]</em> between the m pins of plug_p and plug_n.
</p>
</html>"));
    end VoltageSensor;

    model VoltageQuasiRMSSensor
      "Continuous quasi voltage RMS sensor for multi phase system"
      extends Modelica.Icons.RotationalSensor;
      extends Modelica.Electrical.MultiPhase.Interfaces.TwoPlug;
      parameter Integer m(min=1) = 3 "Number of phases";

      Modelica.Blocks.Interfaces.RealOutput V "Continuous quasi RMS of voltage"
        annotation (Placement(transformation(
            origin={-2,-110},
            extent={{-10,-10},{10,10}},
            rotation=270), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-110})));
      Modelica.Electrical.MultiPhase.Sensors.VoltageSensor voltageSensor(final
          m=m) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Electrical.MultiPhase.Blocks.QuasiRMS quasiRMS(final m=m)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-50})));
    equation
      connect(plug_p, voltageSensor.plug_p) annotation (Line(points={{-100,
              0},{-100,0},{-10,0}}, color={0,0,255}));
      connect(voltageSensor.plug_n, plug_n) annotation (Line(points={{10,0},{
              100,0},{100,0}}, color={0,0,255}));
      connect(voltageSensor.v, quasiRMS.u) annotation (Line(
          points={{0,-11},{0,-38}}, color={0,0,127}));
      connect(quasiRMS.y, V) annotation (Line(
          points={{0,-61},{0,-86},{0,-110},{-2,-110}}, color={0,0,127}));
      annotation (defaultComponentName="voltageRMSSensor", Icon(graphics={Text(
                  extent={{-160,-70},{160,-100}},
                  textString="m=%m"),Line(points={{0,-70},{0,-100}}),
              Line(points={{-90,0},{-70,0}}, color={0,0,255}),Line(points={{70,
              0},{90,0}}, color={0,0,255}),
            Text(
              extent={{-150,80},{150,120}},
                  textString="%name",
              lineColor={0,0,255})}), Documentation(revisions="<html>
</html>", info="<html>
<p>
This sensor determines the continuous quasi <a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">RMS</a> value of a multi phase voltage system, representing an equivalent RMS voltage <code>V</code> vector or phasor. If the voltage waveform deviates from a sine curve, the output of the sensor will not be exactly the average RMS value.
</p>
<pre>
 V = sqrt(sum(v[k]^2 for k in 1:m)/m)
</pre>
</html>"));
    end VoltageQuasiRMSSensor;

    model CurrentSensor "Multiphase current sensor"
      extends Modelica.Icons.RotationalSensor;
      parameter Integer m(final min=1) = 3 "Number of phases";
      Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
      Modelica.Blocks.Interfaces.RealOutput i[m]
        "current in the branch from p to n as output signal" annotation (
          Placement(transformation(
            origin={0,-110},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(plug_p.pin, currentSensor.p)
        annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
      connect(currentSensor.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(currentSensor.i, i) annotation (Line(
          points={{0,-11},{0,-110}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-29,-11},{30,-70}},
                  textString="A"), Line(points={{-70,0},{-90,0}}),
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
Contains m current sensors (Modelica.Electrical.Analog.Sensors.CurrentSensor),
thus measuring the m currents <em>i[m]</em> flowing from the m pins of plug_p to the m pins of plug_n.
</p>
</html>"));
    end CurrentSensor;

    model CurrentQuasiRMSSensor
      "Continuous quasi current RMS sensor for multi phase system"
      extends Modelica.Icons.RotationalSensor;
      extends Modelica.Electrical.MultiPhase.Interfaces.TwoPlug;
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
      Modelica.Electrical.MultiPhase.Sensors.CurrentSensor currentSensor(final
          m=m) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Electrical.MultiPhase.Blocks.QuasiRMS quasiRMS(final m=m)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-50})));
    equation
      connect(plug_p, currentSensor.plug_p) annotation (Line(points={{-100,
              0},{-100,0},{-10,0}}, color={0,0,255}));
      connect(currentSensor.plug_n, plug_n) annotation (Line(points={{10,0},{
              100,0},{100,0}}, color={0,0,255}));
      connect(currentSensor.i, quasiRMS.u) annotation (Line(
          points={{0,-11},{0,-38}}, color={0,0,127}));
      connect(quasiRMS.y, I) annotation (Line(
          points={{0,-61},{0,-100}}, color={0,0,127}));
      annotation (defaultComponentName="currentRMSSensor", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Line(points={{-90,0},{-70,0}},
              color={0,0,255}),Line(points={{0,-70},{0,-100}}),
                                   Line(points={{70,0},{90,0}}, color={0,0,255}),
              Text(
              extent={{150,-100},{-150,-70}},
              textString="m=%m"),
            Text(
              extent={{-150,80},{150,120}},
                  textString="%name",
              lineColor={0,0,255})}),
          Documentation(revisions="<html>
</html>", info="<html>
<p>
This sensor determines the continuous quasi <a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">RMS</a> value of a multi phase current system, representing an equivalent RMS current vector <code>I</code> or phasor. If the current waveform deviates from a sine curve, the output of the sensor will not be exactly the average RMS value.
</p>
<pre>
 I = sqrt(sum(i[k]^2 for k in 1:m)/m)
</pre>
</html>"));
    end CurrentQuasiRMSSensor;

    model PowerSensor "Multiphase instantaneous power sensor"
      extends Modelica.Icons.RotationalSensor;
      parameter Integer m(min=1) = 3 "Number of phases";
      MultiPhase.Interfaces.PositivePlug pc(final m=m)
        "Positive plug, current path" annotation (Placement(transformation(
              extent={{-110,10},{-90,-10}})));
      MultiPhase.Interfaces.NegativePlug nc(final m=m)
        "Negative plug, current path" annotation (Placement(transformation(
              extent={{90,10},{110,-10}})));
      MultiPhase.Interfaces.PositivePlug pv(final m=m)
        "Positive plug, voltage path" annotation (Placement(transformation(
              extent={{-10,90},{10,110}})));
      MultiPhase.Interfaces.NegativePlug nv(final m=m)
        "Negative plug, voltage path" annotation (Placement(transformation(
              extent={{-10,-90},{10,-110}})));
      Modelica.Blocks.Interfaces.RealOutput power annotation (Placement(
            transformation(
            origin={-100,-110},
            extent={{10,-10},{-10,10}},
            rotation=90), iconTransformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-100,-110})));
      MultiPhase.Sensors.VoltageSensor voltageSensor(final m=m) annotation (
          Placement(transformation(
            origin={0,-20},
            extent={{10,10},{-10,-10}},
            rotation=90)));
      MultiPhase.Sensors.CurrentSensor currentSensor(final m=m) annotation (
          Placement(transformation(extent={{-50,-10},{-30,10}})));
      Modelica.Blocks.Math.Product product[m] annotation (Placement(
            transformation(
            origin={-30,-40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Math.Sum sum(final nin=m, final k=ones(m)) annotation (
          Placement(transformation(
            origin={-30,-70},
            extent={{10,-10},{-10,10}},
            rotation=90)));
    equation
      connect(pc, currentSensor.plug_p)
        annotation (Line(points={{-100,0},{-50,0}}, color={0,0,255}));
      connect(currentSensor.plug_n, nc)
        annotation (Line(points={{-30,0},{100,0}}, color={0,0,255}));
      connect(voltageSensor.plug_p, pv) annotation (Line(points={{0,
              -10},{0,-10},{0,100}}, color={0,0,255}));
      connect(voltageSensor.plug_n, nv) annotation (Line(points={{0,
              -30},{0,-30},{0,-100}}, color={0,0,255}));
      connect(voltageSensor.v, product.u1) annotation (Line(
          points={{-11,-20},{-24,-20},{-24,-28}}, color={0,0,127}));
      connect(currentSensor.i, product.u2) annotation (Line(
          points={{-40,-11},{-40,-20},{-36,-20},{-36,-28}}, color={0,0,127}));
      connect(product.y, sum.u) annotation (Line(
          points={{-30,-51},{-30,-58}}, color={0,0,127}));
      connect(sum.y, power) annotation (Line(
          points={{-30,-81},{-30,-90},{-100,-90},{-100,-110}}, color={0,0,127}));
      annotation (
        Icon(graphics={Line(points={{0,100},{0,70}}, color={0,0,255}),
              Line(points={{0,-70},{0,-100}}, color={0,0,255}),
                                 Ellipse(fillPattern=FillPattern.Solid, extent=
              {{-5,-5},{5,5}}),Text(extent={{-29,-70},{30,-11}}, textString="P"),
              Line(points={{-100,0},{100,0}}, color={0,0,255}),
            Text(
              extent={{-150,110},{150,150}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{150,-90},{-150,-70}},
              textString="m=%m"),
          Line(points={{-100,-100},{-100,-80},{-58,-38}}, color = {0,0,127})}),
                                                                  Documentation(
            info="<html><p>
This power sensor measures instantaneous electrical power of a multiphase system and has a separated voltage and current path. The plugs of the voltage path are <code>pv</code> and <code>nv</code>, the plugs of the current path are <code>pc</code> and <code>nc</code>. The internal resistance of each current path is zero, the internal resistance of each voltage path is infinite.
</p></html>"));
    end PowerSensor;

  model MultiSensor "Multiphase sensor to measure current, voltage and power"
    extends Modelica.Icons.RotationalSensor;
    parameter Integer m(min=1) = 3 "Number of phases";
    Modelica.Electrical.MultiPhase.Interfaces.PositivePlug pc(final m=m)
        "Positive plug, current path"
      annotation (Placement(transformation(extent={{-90,-10},{-110,10}})));
    Modelica.Electrical.MultiPhase.Interfaces.NegativePlug nc(final m=m)
        "Negative plug, current path"
      annotation (Placement(transformation(extent={{110,-10},{90,10}})));
    Modelica.Electrical.MultiPhase.Interfaces.PositivePlug pv(final m=m)
        "Positive plug, voltage path"
      annotation (Placement(transformation(extent={{-10,110},{10,90}})));
    Modelica.Electrical.MultiPhase.Interfaces.NegativePlug nv(final m=m)
        "Negative plug, voltage path"
      annotation (Placement(transformation(extent={{10,-110},{-10,-90}})));
    Modelica.Blocks.Interfaces.RealOutput i[m](each final quantity="ElectricCurrent", each final unit="A")
      "Current as output signal" annotation (Placement(transformation(
          origin={-60,-110},
          extent={{10,10},{-10,-10}},
          rotation=90)));
    Modelica.Blocks.Interfaces.RealOutput v[m](each final quantity="ElectricPotential", each final unit="V")
      "Voltage as output signal" annotation (Placement(transformation(
          origin={60,-110},
          extent={{10,10},{-10,-10}},
          rotation=90)));
    Modelica.Blocks.Interfaces.RealOutput power[m](each final quantity="Power", each final unit="W")
      "Instantaneous power as output signal" annotation (Placement(transformation(
          origin={-110,-60},
          extent={{-10,10},{10,-10}},
          rotation=180)));
    Modelica.Blocks.Interfaces.RealOutput powerTotal(final quantity="Power", final unit="W")
      "Sum of instantaneous power as output signal" annotation (Placement(transformation(
          origin={110,-60},
          extent={{10,10},{-10,-10}},
          rotation=180)));
  equation
    pc.pin.i + nc.pin.i = zeros(m);
    pc.pin.v - nc.pin.v = zeros(m);
    pv.pin.i = zeros(m);
    nv.pin.i = zeros(m);
    i = pc.pin.i;
    v = pv.pin.v - nv.pin.v;
    power = v.*i;
    powerTotal = sum(power);
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Line(points = {{0,100},{0,70}}, color = {0,0,255}),
        Line(points = {{0,-70},{0,-100}}, color = {0,0,255}),
        Line(points = {{-100,0},{100,0}}, color = {0,0,255}),
        Line(points = {{0,70},{0,40}}),
          Line(points={{-100,-60},{-80,-60},{-56,-42}},
                                                     color={28,108,200}),
          Line(points={{-60,-100},{-60,-80},{-42,-56}},
                                                     color={28,108,200}),
          Line(points={{60,-100},{60,-80},{42,-56}},
                                                  color={28,108,200}),
          Text(
            extent={{-100,-40},{-60,-80}},
            textString="p"),
          Text(
            extent={{-80,-60},{-40,-100}},
            textString="i"),
          Text(
            extent={{40,-60},{80,-100}},
            textString="v"),
          Line(points={{100,-60},{80,-60},{56,-42}}, color={28,108,200}),
          Text(
            extent={{-150,110},{150,150}},
            textString="%name",
            lineColor={0,0,255})}),
      Documentation(info="<html>
<p>This multi sensor measures currents, voltages and instantaneous electrical power of a multiphase system and has separated voltage and current paths.
The plugs of the voltage paths are pv and nv, the plugs of the current paths are pc and nc.
The internal resistance of each current path is zero, the internal resistance of each voltage path is infinite.</p>
</html>",   revisions="<html>
<ul>
<li><em>20170306</em> first implementation by Anton Haumer</li>
</ul>
</html>"));
  end MultiSensor;

    model AronSensor "threephase Aron sensor for active power"
      import Modelica;
      extends Modelica.Icons.RotationalSensor;
      final parameter Integer m(final min=1) = 3 "Number of phases";
      Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
      Modelica.Blocks.Interfaces.RealOutput power "active power" annotation (
          Placement(transformation(
            origin={0,-110},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Basic.PlugToPins_p plugToPins_p(final m=m)
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      Basic.PlugToPins_n plugToPins_n(final m=m)
        annotation (Placement(transformation(extent={{80,-10},{60,10}})));
      Analog.Sensors.PowerSensor powerSensor1
        annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
      Analog.Sensors.PowerSensor powerSensor3
        annotation (Placement(transformation(extent={{20,-30},{40,-50}})));
      Modelica.Blocks.Math.Add add annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-70})));
    equation
      connect(plug_p, plugToPins_p.plug_p)
        annotation (Line(points={{-100,0},{-72,0}}, color={0,0,255}));
      connect(plugToPins_n.plug_n, plug_n)
        annotation (Line(points={{72,0},{100,0}}, color={0,0,255}));
      connect(plugToPins_p.pin_p[1], powerSensor1.pc) annotation (Line(points={{-68,0},
              {-68,40},{-40,40}},            color={0,0,255}));
      connect(powerSensor1.pc, powerSensor1.pv)
        annotation (Line(points={{-40,40},{-40,50},{-30,50}}, color={0,0,255}));
      connect(powerSensor1.nc, plugToPins_n.pin_n[1]) annotation (Line(points={{-20,40},
              {68,40},{68,0}},            color={0,0,255}));
      connect(plugToPins_p.pin_p[2], plugToPins_n.pin_n[2])
        annotation (Line(points={{-68,0},{68,0}}, color={0,0,255}));
      connect(plugToPins_p.pin_p[3], powerSensor3.pc) annotation (Line(points={{-68,0},
              {-68,-40},{20,-40}},            color={0,0,255}));
      connect(powerSensor3.pc, powerSensor3.pv)
        annotation (Line(points={{20,-40},{20,-50},{30,-50}}, color={0,0,255}));
      connect(powerSensor3.nc, plugToPins_n.pin_n[3]) annotation (Line(points={{40,-40},
              {68,-40},{68,0}},        color={0,0,255}));
      connect(powerSensor1.nv, plugToPins_p.pin_p[2])
        annotation (Line(points={{-30,30},{-30,0},{-68,0}}, color={0,0,255}));
      connect(powerSensor3.nv, plugToPins_p.pin_p[2])
        annotation (Line(points={{30,-30},{30,0},{-68,0}}, color={0,0,255}));
      connect(add.y, power)
        annotation (Line(points={{0,-81},{0,-110}}, color={0,0,127}));
      connect(powerSensor1.power, add.u2) annotation (Line(points={{-40,29},{-40,-50},
              {-6,-50},{-6,-58}}, color={0,0,127}));
      connect(powerSensor3.power, add.u1) annotation (Line(points={{20,-29},{20,-20},
              {6,-20},{6,-58}}, color={0,0,127}));
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
      Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
      Modelica.Blocks.Interfaces.RealOutput reactivePower "reactive power"
        annotation (Placement(transformation(
            origin={0,-110},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Basic.PlugToPins_p plugToPins_p(final m=m)
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      Basic.PlugToPins_n plugToPins_n(final m=m)
        annotation (Placement(transformation(extent={{80,-10},{60,10}})));
      Analog.Sensors.PowerSensor powerSensor1
        annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      Analog.Sensors.PowerSensor powerSensor2
        annotation (Placement(transformation(extent={{10,10},{30,-10}})));
      Modelica.Blocks.Math.Add3 add(
        final k1=1/sqrt(3),
        final k2=1/sqrt(3),
        final k3=1/sqrt(3))        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={0,-80})));
      Analog.Sensors.PowerSensor powerSensor3
        annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
    equation
      connect(plug_p, plugToPins_p.plug_p)
        annotation (Line(points={{-100,0},{-72,0}}, color={0,0,255}));
      connect(plugToPins_n.plug_n, plug_n)
        annotation (Line(points={{72,0},{100,0}}, color={0,0,255}));
      connect(add.y, reactivePower)
        annotation (Line(points={{0,-91},{0,-110}}, color={0,0,127}));
      connect(plugToPins_p.pin_p[1], powerSensor1.pc)
        annotation (Line(points={{-68,0},{-68,30},{-40,30}}, color={0,0,255}));
      connect(powerSensor1.pv, plugToPins_p.pin_p[2]) annotation (Line(points={
              {-30,40},{-50,40},{-50,0},{-68,0}}, color={0,0,255}));
      connect(plugToPins_p.pin_p[3], powerSensor1.nv) annotation (Line(points={
              {-68,0},{-68,-30},{-30,-30},{-30,20}}, color={0,0,255}));
      connect(plugToPins_p.pin_p[3], powerSensor2.pv) annotation (Line(points={
              {-68,0},{-68,-30},{20,-30},{20,-10}}, color={0,0,255}));
      connect(plugToPins_p.pin_p[2], powerSensor2.pc)
        annotation (Line(points={{-68,0},{10,0}}, color={0,0,255}));
      connect(powerSensor1.nc, plugToPins_n.pin_n[1])
        annotation (Line(points={{-20,30},{68,30},{68,0}}, color={0,0,255}));
      connect(powerSensor2.nc, plugToPins_n.pin_n[2])
        annotation (Line(points={{30,0},{68,0}}, color={0,0,255}));
      connect(powerSensor1.nc, powerSensor2.nv)
        annotation (Line(points={{-20,30},{20,30},{20,10}}, color={0,0,255}));
      connect(plugToPins_p.pin_p[3], powerSensor3.pc) annotation (Line(points={
              {-68,0},{-68,-30},{30,-30}}, color={0,0,255}));
      connect(powerSensor3.nc, plugToPins_n.pin_n[3])
        annotation (Line(points={{50,-30},{68,-30},{68,0}}, color={0,0,255}));
      connect(powerSensor1.nc, powerSensor3.pv)
        annotation (Line(points={{-20,30},{40,30},{40,-20}}, color={0,0,255}));
      connect(powerSensor3.nv, plugToPins_n.pin_n[2]) annotation (Line(points={
              {40,-40},{40,-50},{60,-50},{60,0},{68,0}}, color={0,0,255}));
      connect(powerSensor2.power, add.u2) annotation (Line(points={{10,11},{10,
              20},{0,20},{0,-66},{0,-66},{0,-68}}, color={0,0,127}));
      connect(powerSensor1.power, add.u1) annotation (Line(points={{-40,19},{
              -40,-60},{-8,-60},{-8,-68}}, color={0,0,127}));
      connect(powerSensor3.power, add.u3) annotation (Line(points={{30,-41},{30,
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
<p>
This package contains multiphase potential, voltage, and current sensors.
</p>

</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Release Notes:</strong></dt>
  <dd>
  <ul>
  <li>v1.0 2004/10/01 Anton Haumer</li>
  <li>v1.1 2006/01/12 Anton Haumer<br>
      added PowerSensor</li>
  </ul>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
</html>"));
  end Sensors;

  package Sources "Multiphase voltage and current sources"
    extends Modelica.Icons.SourcesPackage;

    model SignalVoltage "Multiphase signal voltage source"
      parameter Integer m(min=1) = 3 "Number of phases";
      Modelica.SIunits.Current i[m]=plug_p.pin.i
        "Currents flowing into positive plugs";
      Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
      Modelica.Blocks.Interfaces.RealInput v[m](each unit="V")
        "Voltage between pin p and n (= p.v - n.v) as input signal" annotation (
         Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(signalVoltage.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(signalVoltage.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(v, signalVoltage.v)
        annotation (Line(points={{0,120},{0,12}}, color={0,0,255}));
      annotation (
        Icon(graphics={Line(points={{-90,0},{-50,0}}, color={0,0,255}),
              Line(points={{50,0},{90,0}}, color={0,0,255}),Ellipse(
                  extent={{-50,50},{50,-50}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{-50,0},{50,0}},
              color={0,0,255}),Text(
                  extent={{-150,60},{150,100}},
                  textString="%name",
                  lineColor={0,0,255}),
            Text(
              extent={{150,-100},{-150,-60}},
              textString="m=%m"),
            Line(points={{-70,30},{-70,10}}, color={0,0,255}),
            Line(points={{-80,20},{-60,20}}, color={0,0,255}),
            Line(points={{60,20},{80,20}}, color={0,0,255})}),
                                     Documentation(info="<html>
<p>
Contains m signal controlled voltage sources (Modelica.Electrical.Analog.Sources.SignalVoltage)
</p>
</html>"));
    end SignalVoltage;

    model ConstantVoltage "Multiphase constant voltage source"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Voltage V[m](start=fill(1, m))
        "Values of constant voltages";
      Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage[m](
          final V=V) annotation (Placement(transformation(extent={{-10,-10},{10,
                10}})));
    equation
      connect(constantVoltage.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(constantVoltage.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      annotation (
        Icon(graphics={Line(points={{-90,0},{-50,0}}, color={0,0,255}),
              Line(points={{50,0},{90,0}}, color={0,0,255}),Ellipse(
                  extent={{-50,50},{50,-50}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{-50,0},{50,0}},
              color={0,0,255}),Text(
                  extent={{-150,60},{150,100}},
                  textString="%name",
                  lineColor={0,0,255}),
            Text(
              extent={{150,-100},{-150,-60}},
              textString="m=%m"),
            Line(points={{-70,30},{-70,10}}, color={0,0,255}),
            Line(points={{-80,20},{-60,20}}, color={0,0,255}),
            Line(points={{60,20},{80,20}}, color={0,0,255})}),
                                     Documentation(info="<html>
<p>
Contains m constant voltage sources (Modelica.Electrical.Analog.Sources.ConstantVoltage)
</p>
</html>"));
    end ConstantVoltage;

    model SineVoltage "Multiphase sine voltage source"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Voltage V[m](start=fill(1, m))
        "Amplitudes of sine waves";
      parameter Modelica.SIunits.Angle phase[m]=-
          Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m)
        "Phases of sine waves";
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
                {{-10,-10},{10,10}})));
    equation
      connect(sineVoltage.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(sineVoltage.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Line(points={{-90,0},{-50,0}},
              color={0,0,255}),Line(points={{50,0},{90,0}}, color={0,0,255}),
              Ellipse(
                  extent={{-50,50},{50,-50}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{-50,0},{50,0}},
              color={0,0,255}),Line(
                  points={{-70,0},{-60.2,29.9},{-53.8,46.5},{-48.2,58.1},{-43.3,
                65.2},{-38.3,69.2},{-33.4,69.8},{-28.5,67},{-23.6,61},{-18.6,52},
                {-13,38.6},{-5.98,18.6},{8.79,-26.9},{15.1,-44},{20.8,-56.2},{
                25.7,-64},{30.6,-68.6},{35.5,-70},{40.5,-67.9},{45.4,-62.5},{
                50.3,-54.1},{55.9,-41.3},{63,-21.7},{70,0}},
                  color={192,192,192},
                  smooth=Smooth.Bezier),
                               Text(
                  extent={{-150,60},{150,100}},
                  textString="%name",
                  lineColor={0,0,255}),
            Text(
              extent={{150,-100},{-150,-60}},
              textString="m=%m")}), Documentation(info="<html>
<p>
Contains m sine voltage sources (Modelica.Electrical.Analog.Sources.SineVoltage)
with a default phase shift determined by
<a href=\"modelica://Modelica.Electrical.MultiPhase.Functions.symmetricOrientation\">symmetricOrientation</a>.
</p>
</html>"));
    end SineVoltage;

    model CosineVoltage "Multiphase cosine voltage source"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Voltage V[m](start=fill(1, m))
        "Amplitudes of cosine waves";
      parameter Modelica.SIunits.Angle phase[m]=-
          Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m)
        "Phases of cosine waves";
      parameter Modelica.SIunits.Frequency freqHz[m](start=fill(1, m))
        "Frequencies of cosine waves";
      parameter Modelica.SIunits.Voltage offset[m]=zeros(m) "Voltage offsets";
      parameter Modelica.SIunits.Time startTime[m]=zeros(m) "Time offsets";
      Analog.Sources.CosineVoltage cosineVoltage[m](
        final V=V,
        final phase=phase,
        final freqHz=freqHz,
        final offset=offset,
        final startTime=startTime) annotation (Placement(transformation(extent=
                {{-10,-10},{10,10}})));
    equation
      connect(cosineVoltage.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(cosineVoltage.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Line(points={{-90,0},{-50,0}},
              color={0,0,255}),Line(points={{50,0},{90,0}}, color={0,0,255}),
              Ellipse(
                  extent={{-50,50},{50,-50}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{-50,0},{50,0}},
              color={0,0,255}), Line(
                  points={{-71,70},{-68.4,69.8},{-63.5,67},{-58.6,61},{-53.6,52},
                {-48,38.6},{-40.98,18.6},{-26.21,-26.9},{-19.9,-44},{-14.2,-56.2},
                {-9.3,-64},{-4.4,-68.6},{0.5,-70},{5.5,-67.9},{10.4,-62.5},{
                15.3,-54.1},{20.9,-41.3},{28,-21.7},{35,0}},
                  color={192,192,192},
                  smooth=Smooth.Bezier),Line(points={{35,0},{44.8,29.9},{51.2,
              46.5},{56.8,58.1},{61.7,65.2},{66.7,69.2},{71.6,69.8}}, color={
              192,192,192}), Text(
                  extent={{-150,60},{150,100}},
                  textString="%name",
                  lineColor={0,0,255}),
            Text(
              extent={{150,-100},{-150,-60}},
              textString="m=%m"),
            Line(points={{-70,30},{-70,10}}, color={0,0,255}),
            Line(points={{-80,20},{-60,20}}, color={0,0,255}),
            Line(points={{60,20},{80,20}}, color={0,0,255})}),
                               Documentation(info="<html>
<p>
Contains m cosine voltage sources (Modelica.Electrical.Analog.Sources.CosineVoltage)
with a default phase shift determined by
<a href=\"modelica://Modelica.Electrical.MultiPhase.Functions.symmetricOrientation\">symmetricOrientation</a>.
</p>
</html>"));
    end CosineVoltage;

    model SignalCurrent "Multiphase signal current source"
      parameter Integer m(min=1) = 3 "Number of phases";
      Modelica.SIunits.Voltage v[m]=plug_p.pin.v - plug_n.pin.v
        "Voltage drops between the two plugs";
      Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
      Modelica.Blocks.Interfaces.RealInput i[m](each unit="A")
        "Current flowing from pin p to pin n as input signal" annotation (
          Placement(transformation(
            origin={0,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent[m]
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      connect(signalCurrent.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(signalCurrent.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      connect(i, signalCurrent.i)
        annotation (Line(points={{0,120},{0,12}}, color={0,0,255}));
      annotation (
        Icon(graphics={Line(points={{-90,0},{-50,0}}, color={0,0,255}),
              Line(points={{50,0},{90,0}}, color={0,0,255}),Ellipse(
                  extent={{-50,50},{50,-50}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{0,50},{0,-50}},
              color={0,0,255}), Polygon(
                  points={{90,0},{60,10},{60,-10},{90,0}},
                  lineColor={0,0,255},
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid),
                               Text(
                  extent={{-150,60},{150,100}},
                  textString="%name",
                  lineColor={0,0,255}),
            Text(
              extent={{150,-100},{-150,-60}},
              textString="m=%m")}), Documentation(info="<html>
<p>
Contains m signal controlled current sources (Modelica.Electrical.Analog.Sources.SignalCurrent)
</p>
</html>"));
    end SignalCurrent;

    model ConstantCurrent "Multiphase constant current source"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Current I[m](start=fill(1, m))
        "Values of constant currents";
      Modelica.Electrical.Analog.Sources.ConstantCurrent constantCurrent[m](
          final I=I) annotation (Placement(transformation(extent={{-10,-10},{10,
                10}})));
    equation
      connect(constantCurrent.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(constantCurrent.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      annotation (
        Icon(graphics={Line(points={{-90,0},{-50,0}}, color={0,0,255}),
              Line(points={{50,0},{90,0}}, color={0,0,255}),Ellipse(
                  extent={{-50,50},{50,-50}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{0,50},{0,-50}},
              color={0,0,255}), Polygon(
                  points={{90,0},{60,10},{60,-10},{90,0}},
                  lineColor={0,0,255},
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid),
                               Text(
                  extent={{-150,60},{150,100}},
                  textString="%name",
                  lineColor={0,0,255}),
            Text(
              extent={{150,-100},{-150,-60}},
              textString="m=%m")}), Documentation(info="<html>
<p>
Contains m constant current sources (Modelica.Electrical.Analog.Sources.ConstantCurrent)
</p>
</html>"));
    end ConstantCurrent;

    model SineCurrent "Multiphase sine current source"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Current I[m](start=fill(1, m))
        "Amplitudes of sine waves";
      parameter Modelica.SIunits.Angle phase[m]=-
          Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m)
        "Phases of sine waves";
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
                {{-10,-10},{10,10}})));
    equation
      connect(sineCurrent.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(sineCurrent.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      annotation (
        Icon(graphics={Line(points={{-90,0},{-50,0}}, color={0,0,255}),
              Line(points={{50,0},{90,0}}, color={0,0,255}),Ellipse(
                  extent={{-50,50},{50,-50}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{0,50},{0,-50}},
              color={0,0,255}),Line(
                  points={{-70,0},{-60.2,29.9},{-53.8,46.5},{-48.2,58.1},{-43.3,
                65.2},{-38.3,69.2},{-33.4,69.8},{-28.5,67},{-23.6,61},{-18.6,52},
                {-13,38.6},{-5.98,18.6},{8.79,-26.9},{15.1,-44},{20.8,-56.2},{
                25.7,-64},{30.6,-68.6},{35.5,-70},{40.5,-67.9},{45.4,-62.5},{
                50.3,-54.1},{55.9,-41.3},{63,-21.7},{70,0}},
                  color={192,192,192},
                  smooth=Smooth.Bezier), Polygon(
                  points={{90,0},{60,10},{60,-10},{90,0}},
                  lineColor={0,0,255},
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid),
                               Text(
                  extent={{-150,60},{150,100}},
                  textString="%name",
                  lineColor={0,0,255}),
            Text(
              extent={{150,-100},{-150,-60}},
              textString="m=%m")}), Documentation(info="<html>
<p>
Contains m sine current sources (Modelica.Electrical.Analog.Sources.SineCurrent)
with a default phase shift determined by
<a href=\"modelica://Modelica.Electrical.MultiPhase.Functions.symmetricOrientation\">symmetricOrientation</a>.
</p>
</html>"));
    end SineCurrent;

    model CosineCurrent "Multiphase cosine current source"
      extends Interfaces.TwoPlug;
      parameter Modelica.SIunits.Current I[m](start=fill(1, m))
        "Amplitudes of cosine waves";
      parameter Modelica.SIunits.Angle phase[m]=-
          Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m)
        "Phases of cosine waves";
      parameter Modelica.SIunits.Frequency freqHz[m](start=fill(1, m))
        "Frequencies of cosine waves";
      parameter Modelica.SIunits.Current offset[m]=zeros(m) "Current offsets";
      parameter Modelica.SIunits.Time startTime[m]=zeros(m) "Time offsets";
      Analog.Sources.CosineCurrent cosineCurrent[m](
        final I=I,
        final phase=phase,
        final freqHz=freqHz,
        final offset=offset,
        final startTime=startTime) annotation (Placement(transformation(extent=
                {{-10,-10},{10,10}})));
    equation
      connect(cosineCurrent.p, plug_p.pin)
        annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
      connect(cosineCurrent.n, plug_n.pin)
        annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
      annotation (
        Icon(graphics={Line(points={{-90,0},{-50,0}}, color={0,0,255}),
              Line(points={{50,0},{90,0}}, color={0,0,255}),Ellipse(
                  extent={{-50,50},{50,-50}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{0,50},{0,-50}},
              color={0,0,255}), Polygon(
                  points={{90,0},{60,10},{60,-10},{90,0}},
                  lineColor={0,0,255},
                  fillColor={0,0,255},
                  fillPattern=FillPattern.Solid),
                                  Line(
                  points={{-71,70},{-68.4,69.8},{-63.5,67},{-58.6,61},{-53.6,52},{-48,38.6},{-40.98,18.6},{-26.21,-26.9},{-19.9,-44},{-14.2,-56.2},{-9.3,-64},{-4.4,-68.6},{0.5,-70},{5.5,-67.9},{10.4,-62.5},{15.3,-54.1},{20.9,-41.3},{28,-21.7},{35,0}},
                  color={192,192,192},
                  smooth=Smooth.Bezier),Line(points={{35,0},{44.8,29.9},{51.2,46.5},{56.8,58.1},{61.7,65.2},{66.7,69.2},{71.6,69.8}},
                                                                      color={
              192,192,192}), Text(
                  extent={{-150,60},{150,100}},
                  textString="%name",
                  lineColor={0,0,255}),
            Text(
              extent={{150,-100},{-150,-60}},
              textString="m=%m")}), Documentation(info="<html>
<p>
Contains m cosine current sources (Modelica.Electrical.Analog.Sources.CosineCurrent)
with a default phase shift determined by
<a href=\"modelica://Modelica.Electrical.MultiPhase.Functions.symmetricOrientation\">symmetricOrientation</a>.
</p>
</html>"));
    end CosineCurrent;
    annotation (Documentation(info="<html>
<p>
This package contains time-dependent and controlled multiphase voltage and current sources:
</p>
<ul>
<li>SignalVoltage: fed by Modelica.Blocks.Sources arbitrary waveforms of voltages are possible</li>
<li>ConstantVoltage: constant multi phase voltages</li>
<li>SineVoltage : phase shift between consecutive voltages by default given by
<a href=\"modelica://Modelica.Electrical.MultiPhase.Functions.symmetricOrientation\">symmetricOrientation</a></li>
<li>CosineVoltage : phase shift between consecutive voltages by default given by
<a href=\"modelica://Modelica.Electrical.MultiPhase.Functions.symmetricOrientation\">symmetricOrientation</a></li>
<li>SignalCurrent: fed by Modelica.Blocks.Sources arbitrary waveforms of currents are possible</li>
<li>ConstantCurrent: constant multi phase currents</li>
<li>SineCurrent : phase shift between consecutive currents by default given by
<a href=\"modelica://Modelica.Electrical.MultiPhase.Functions.symmetricOrientation\">symmetricOrientation</a></li>
<li>CosineCurrent : phase shift between consecutive currents by default given by
<a href=\"modelica://Modelica.Electrical.MultiPhase.Functions.symmetricOrientation\">symmetricOrientation</a></li>
</ul>
</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Release Notes:</strong></dt>
  <dd>
  <ul>
  <li> v1.0 2004/10/01 Anton Haumer</li>
  </ul>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
</html>"));
  end Sources;

  package Interfaces "Interfaces for electrical multiphase models"
    extends Modelica.Icons.InterfacesPackage;

    connector Plug "Polyphase electrical plug with m pins"
      parameter Integer m(final min=1) = 3 "Number of phases";
      Modelica.Electrical.Analog.Interfaces.Pin pin[m] "Pins of the plug";

      annotation (Documentation(info="<html>
<p>
Connectors PositivePlug and NegativePlug are nearly identical.
The only difference is that the icons are different in order
to identify more easily the plugs of a component.
Usually, connector PositivePlug is used for the positive and
connector NegativePlug for the negative plug of an electrical component.<br>
Connector Plug is a composite connector containing m Pins (Modelica.Electrical.Analog.Interfaces.Pin).
</p>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Text(
              extent={{-100,-99},{100,-179}},
              lineColor={0,0,255},
              textString="%name")}));
    end Plug;

    connector PositivePlug "Positive polyphase electrical plug with m pins"
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
        Documentation(info="<html>
<p>
Connectors PositivePlug and NegativePlug are nearly identical.
The only difference is that the icons are different in order
to identify more easily the plugs of a component.
Usually, connector PositivePlug is used for the positive and
connector NegativePlug for the negative plug of an electrical component.<br>
Connector Plug is a composite connector containing m Pins (Modelica.Electrical.Analog.Interfaces.Pin).
</p>
</html>"));
    end PositivePlug;

    connector NegativePlug "Negative polyphase electrical plug with m pins"
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
        Documentation(info="<html>
<p>
Connectors PositivePlug and NegativePlug are nearly identical.
The only difference is that the icons are different in order
to identify more easily the plugs of a component.
Usually, connector PositivePlug is used for the positive and
connector NegativePlug for the negative plug of an electrical component.<br>
Connector Plug is a composite connector containing m Pins (Modelica.Electrical.Analog.Interfaces.Pin).
</p>
</html>"));
    end NegativePlug;

    partial model ConditionalHeatPort
      "Partial model to include conditional HeatPorts in order to describe the power loss via a thermal network"
      parameter Integer mh(min=1) = 3 "Number of heatPorts=number of phases";
      parameter Boolean useHeatPort=false
        "=true, if all heat ports are enabled" annotation (
        Evaluate=true,
        HideResult=true,
        choices(checkBox=true));
      parameter Modelica.SIunits.Temperature T[mh]=fill(293.15, mh)
        "Fixed device temperatures if useHeatPort = false"
        annotation (Dialog(enable=not useHeatPort));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort[mh] if
        useHeatPort "Conditional heat ports" annotation (Placement(
            transformation(extent={{-10,-110},{10,-90}}), iconTransformation(
              extent={{-10,-110},{10,-90}})));
      annotation (Documentation(revisions="<html>
<ul>
<li><em>August 26, 2009 </em>by Anton Haumer initially implemented</li>
</ul>
</html>", info="<html>
<p>
This partial model provides conditional heat ports for the connection to a thermal network.
</p>
<ul>
<li> If <strong>useHeatPort</strong> is set to <strong>false</strong> (default), no heat port is available, and the thermal
     loss power flows internally to the ground. In this case, the parameter <strong>T</strong> specifies
     the fixed device temperatures.</li>
<li> If <strong>useHeatPort</strong> is set to <strong>true</strong>, all heat ports are available.</li>
</ul>
</html>"));
    end ConditionalHeatPort;

    partial model TwoPlug "Component with one polyphase electrical port"
      parameter Integer m(min=1) = 3 "Number of phases";
      Modelica.SIunits.Voltage v[m] "Voltage drops of the two polyphase plugs";
      Modelica.SIunits.Current i[m] "Currents flowing into positive polyphase plugs";
      PositivePlug plug_p(final m=m) "Positive polyphase electrical plug with m pins" annotation (Placement(transformation(
              extent={{-110,-10},{-90,10}})));
      NegativePlug plug_n(final m=m) "Negative polyphase electrical plug with m pins" annotation (Placement(transformation(
              extent={{90,-10},{110,10}})));
    equation
      v = plug_p.pin.v - plug_n.pin.v;
      i = plug_p.pin.i;
      annotation (Documentation(info="<html>
<p>
Superclass of elements which have <strong>two</strong> electrical plugs:
the positive plug connector <em>plug_p</em>, and the negative plug connector <em>plug_n</em>.
The currents flowing into plug_p are provided explicitly as currents i[m].
</p>
</html>"));
    end TwoPlug;

    partial model OnePort
      "Component with two electrical plugs and currents from plug_p to plug_n"

      extends TwoPlug;
    equation
      plug_p.pin.i + plug_n.pin.i = zeros(m);
      annotation (Documentation(info="<html>
<p>
Superclass of elements which have <strong>two</strong> electrical plugs:
the positive plug connector <em>plug_p</em>, and the negative plug connector <em>plug_n</em>.
The currents flowing into plug_p are provided explicitly as currents i[m].
It is assumed that the currents flowing into plug_p are identical to the currents flowing out of plug_n.
</p>
</html>"));
    end OnePort;

    partial model FourPlug "Component with two polyphase electrical ports"
      parameter Integer m(final min=1) = 3 "Number of phases";
      Modelica.SIunits.Voltage v1[m] "Voltage drops of port 1";
      Modelica.SIunits.Voltage v2[m] "Voltage drops of port 2";
      Modelica.SIunits.Current i1[m]
        "Currents flowing into positive polyphase plug of port 1";
      Modelica.SIunits.Current i2[m]
        "Currents flowing into positive polyphase plug of port 2";
      PositivePlug plug_p1(final m=m) "Positive electrical polyphase plug of port 1 with m pins" annotation (Placement(transformation(
              extent={{-110,90},{-90,110}})));
      PositivePlug plug_p2(final m=m) "Positive electrical polyphase plug of port 2 with m pins" annotation (Placement(transformation(
              extent={{90,90},{110,110}})));
      NegativePlug plug_n1(final m=m) "Negative electrical polyphase plug of port 1 with m pins" annotation (Placement(transformation(
              extent={{-110,-110},{-90,-90}})));
      NegativePlug plug_n2(final m=m) "Negative electrical polyphase plug of port 2 with m pins" annotation (Placement(transformation(
              extent={{90,-110},{110,-90}})));
    equation
      v1 = plug_p1.pin.v - plug_n1.pin.v;
      v2 = plug_p2.pin.v - plug_n2.pin.v;
      i1 = plug_p1.pin.i;
      i2 = plug_p2.pin.i;
      annotation (Documentation(info="<html>
<p>
Superclass of elements which have <strong>four</strong> electrical plugs.
</p>
</html>"));
    end FourPlug;

    partial model TwoPort
      "Component with two polyphase electrical ports, including currents"
      extends FourPlug;
    equation
      plug_p1.pin.i + plug_n1.pin.i = zeros(m);
      plug_p2.pin.i + plug_n2.pin.i = zeros(m);
      annotation (Documentation(info="<html>
<p>
Superclass of elements which have <strong>four</strong> electrical plugs.
It is assumed that the currents flowing into plug_p1 are identical to the currents flowing out of plug_n1,
and that the currents flowing into plug_p2 are identical to the currents flowing out of plug_n2.
</p>
</html>"));
    end TwoPort;
    annotation (Documentation(info="<html>
<p>
This package contains connectors and interfaces (partial models) for
electrical multiphase components, based on Modelica.Electrical.Analog.
</p>

</html>", revisions="<html>
<dl>
  <dt><strong>Main Authors:</strong></dt>
  <dd>
  <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  D-93049 Regensburg<br>Germany<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
  </dd>
  <dt><strong>Release Notes:</strong></dt>
  <dd>
  <ul>
  <li>v1.0 2004/10/01 Anton Haumer</li>
  <li>v1.2 2006/05/12 Anton Haumer<br>
      removed annotation from pin of Interfaces.Plug</li>
  </ul>
  </dd>
  <dt><strong>Copyright:</strong></dt>
  <dd>Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.<br>
  <em>The Modelica package is <strong>free</strong> software; it can be redistributed and/or modified
  under the terms of the <strong>Modelica license</strong>, see the license conditions
  and the accompanying <strong>disclaimer</strong> in the documentation of package
  Modelica in file \"Modelica/package.mo\".</em></dd>
</dl>
</html>"));
  end Interfaces;
  annotation (Documentation(info="<html>
<p>
Copyright &copy; 1998-2018, Modelica Association and Anton Haumer.
</p>
<p>
<em>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the 3-Clause BSD license. For license conditions (including the disclaimer of warranty) visit <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
</p>
</html>", revisions="<html>
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
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Ellipse(
          origin={14,56},
          lineColor={95,95,95},
          extent={{-84,-126},{56,14}}),
        Ellipse(
          origin={0,42},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          extent={{-40,-34},{-20,-14}}),
        Ellipse(
          origin={20,40},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          extent={{0,-34},{20,-14}}),
        Ellipse(
          origin={10,34},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          extent={{-20,-74},{0,-54}})}));
end MultiPhase;
