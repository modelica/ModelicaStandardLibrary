within Modelica.Electrical.Analog.Examples;
encapsulated model NandGate "CMOS NAND Gate (see Tietze/Schenk, page 157)" 
  import Modelica.Electrical.Analog.Basic;
  import Modelica.Electrical.Analog.Sources;
  import Modelica.Electrical.Analog.Examples.Utilities;
  import Modelica.Icons;
  extends Icons.Example;
  
  annotation (
    Icon,
    Documentation(info="<html>
<p>
The nand gate is a basic CMOS building block. It consists of four CMOS transistors.
The output voltage Nand.y.v is low if and only if the two input voltages at Nand.x1.v and Nand.x2.v
are both high. In this way the nand functionality is realized.
<p>
The simulation end time should be set to 1e-7. Please plot the input voltages Nand.x1.v,
d Nand.x2.v, and the output voltage Nand.y.v.
<p>
<dl>
<dt>
<b>Reference:</b>
<dd>
Tietze, U.; Schenk, Ch.: Halbleiter-Schaltungstechnik. Springer-Verlag Berlin Heidelberg NewYork 1980, p. 157
<p>
</dd>
</dl>
</HTML>
", revisions="<html>
<dl>
<dt>
<b>Main Authors:</b>
<dd>
<a href=\"http://people.eas.iis.fhg.de/Christoph.Clauss/\">Christoph Clau&szlig;</a>
    &lt;<a href=\"mailto:clauss@eas.iis.fhg.de\">clauss@eas.iis.fhg.de</a>&gt;<br>
    <a href=\"http://people.eas.iis.fhg.de/Andre.Schneider/\">Andr&eacute; Schneider</a>
    &lt;<a href=\"mailto:schneider@eas.iis.fhg.de\">schneider@eas.iis.fhg.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden<br>
<p>
<dt>
<b>Copyright:</b>
<dd>
Copyright &copy; 1998-2006, Modelica Association and Fraunhofer-Gesellschaft.<br>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".</i><br>
<p>
</dl>
</html>"),
    Window(
      x=0.36,
      y=0.01,
      width=0.44,
      height=0.6), 
    experiment(StopTime=1e-007), 
    experimentSetupOutput);
  Sources.TrapezoidVoltage VIN1(
    V=3.5,
    startTime=20e-9,
    rising=1e-9,
    width=19e-9,
    falling=1.e-9,
    period=40e-9) annotation (extent=[-80, 10; -60, 30], rotation=-90);
  Sources.TrapezoidVoltage VIN2(
    V=3.5,
    startTime=10e-9,
    rising=1e-9,
    width=19e-9,
    falling=1.e-9,
    period=40e-9) annotation (extent=[-80, -40; -60, -20], rotation=-90);
  Sources.RampVoltage VDD(V=5, duration=1e-9) annotation (extent=[40, 60; 60,
        80], rotation=-90);
  Basic.Ground Gnd1 annotation (extent=[45, 43; 55, 53]);
  Basic.Ground Gnd4 annotation (extent=[-75, -5; -65, 5]);
  Basic.Ground Gnd5 annotation (extent=[-75, -55; -65, -45]);
  Utilities.Nand Nand annotation (extent=[-40, -45; 40, 55]);
equation 
  connect(VDD.n, Gnd1.p) annotation (points=[50, 60; 50, 53]);
  connect(VIN1.n, Gnd4.p) annotation (points=[-70, 10; -70, 5]);
  connect(VIN2.n, Gnd5.p) annotation (points=[-70, -40; -70, -45]);
  connect(Nand.Vdd, VDD.p) annotation (points=[0, 55; 0, 90; 50, 90; 50, 80]);
  connect(VIN1.p, Nand.x1) annotation (points=[-70, 30; -40, 30]);
  connect(VIN2.p, Nand.x2) annotation (points=[-70, -20; -40, -20]);
end NandGate;
