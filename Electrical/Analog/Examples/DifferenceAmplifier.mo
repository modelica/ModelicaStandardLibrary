encapsulated model DifferenceAmplifier 
  import Modelica.Electrical.Analog.Basic;
  import Modelica.Electrical.Analog.Sources;
  import Modelica.Electrical.Analog.Examples.Utilities;
  import Modelica.Icons;
  extends Icons.Example;
  
  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[1, 1],
      component=[20, 20]),
    Icon,
    Documentation(info="<html>
<p>
It is a simple NPN transistor amplifier circuit. The voltage difference between R1.p and R3.n is amplified. The output signal is the voltage between R2.n and R4.n. In this example the voltage at V1 is amplified because R3.n is grounded.
<p>
The simulation end time should be set to 1e- 8. Please plot the input voltage V1.v, and the output voltages R2.n.v, and R4.n.v.
<p>
<dl>
<dt>
<b>Reference:</b>
<dd>
Tietze, U.; Schenk, Ch.: Halbleiter-Schaltungstechnik. Springer-Verlag Berlin Heidelberg NewYork 1980, p. 59
<p>
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
Copyright &copy; 1998-2002, Modelica Association and Fraunhofer-Gesellschaft.<br>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".</i><br>
<p>
</dl>
</HTML>
"), Window(
      x=0.35,
      y=0.01,
      width=0.45,
      height=0.61));
  Sources.ExpSineVoltage V1(
    V=0.2,
    freqHz=0.2e9,
    damping=0.1e8) annotation (extent=[-100, -60; -80, -40], rotation=-90);
  Sources.RampVoltage V2(V=15, duration=1e-9) annotation (extent=[70, 40; 90,
        60], rotation=-90);
  Sources.RampCurrent I1(I=0.16, duration=1e-9) annotation (extent=[-20, -60; 0,
          -40], rotation=-90);
  Basic.Resistor R1(R=0.0001) annotation (extent=[-90, -20; -70, 0]);
  Basic.Resistor R2(R=100) annotation (extent=[-50, 20; -30, 40], rotation=-90);
  Basic.Resistor R3(R=0.0001) annotation (extent=[70, -20; 90, 0]);
  Basic.Resistor R4(R=100) annotation (extent=[30, 20; 50, 40], rotation=-90);
  Basic.Capacitor C1(C=1e-10) annotation (extent=[-70, -60; -50, -40], rotation=
       -90);
  Basic.Capacitor C4(C=1e-10) annotation (extent=[10, -14; 30, 6]);
  Basic.Capacitor C5(C=1e-10) annotation (extent=[0, -60; 20, -40], rotation=-
        90);
  Basic.Capacitor C2(C=1e-10) annotation (extent=[-30, -14; -10, 6]);
  Basic.Capacitor C3(C=1e-10) annotation (extent=[50, -60; 70, -40], rotation=-
        90);
  Basic.Ground Gnd1 annotation (extent=[-95, -80; -85, -70]);
  Basic.Ground Gnd9 annotation (extent=[75, 20; 85, 30]);
  Basic.Ground Gnd3 annotation (extent=[-15, -20; -5, -10]);
  Basic.Ground Gnd2 annotation (extent=[-65, -80; -55, -70]);
  Basic.Ground Gnd6 annotation (extent=[5, -20; 15, -10]);
  Basic.Ground Gnd7 annotation (extent=[-15, -80; -5, -70]);
  Basic.Ground Gnd8 annotation (extent=[5, -80; 15, -70]);
  Basic.Ground Gnd5 annotation (extent=[55, -80; 65, -70]);
  Basic.Ground Gnd4 annotation (extent=[85, -50; 95, -40]);
  Utilities.Transistor Transistor1 annotation (extent=[-60, -20; -40, 0]);
  Utilities.Transistor Transistor2 annotation (extent=[60, -20; 40, 0]);
equation 
  connect(V1.n, Gnd1.p) annotation (points=[-90, -60; -90, -70]);
  connect(C1.n, Gnd2.p) annotation (points=[-60, -60; -60, -70]);
  connect(I1.n, Gnd7.p) annotation (points=[-10, -60; -10, -70]);
  connect(C5.n, Gnd8.p) annotation (points=[10, -60; 10, -70]);
  connect(C3.n, Gnd5.p) annotation (points=[60, -60; 60, -70]);
  connect(R3.n, Gnd4.p) annotation (points=[90, -10; 90, -40]);
  connect(C2.n, Gnd3.p) annotation (points=[-10, -4; -10, -10]);
  connect(C4.p, Gnd6.p) annotation (points=[10, -4; 10, -10]);
  connect(I1.p, C5.p) annotation (points=[-10, -40; 10, -40]);
  connect(R1.p, V1.p) annotation (points=[-90, -10; -90, -40]);
  connect(R2.p, V2.p) annotation (points=[-40, 40; -40, 70; 80, 70; 80, 60]);
  connect(R4.p, V2.p) annotation (points=[40, 40; 40, 70; 80, 70; 80, 60]);
  connect(V2.n, Gnd9.p) annotation (points=[80, 40; 80, 30]);
  connect(R1.n, Transistor1.b) annotation (points=[-70, -10; -60, -10]);
  connect(Transistor1.b, C1.p) annotation (points=[-60, -10; -60, -40]);
  connect(Transistor1.c, C2.p) annotation (points=[-40, -4; -30, -4]);
  connect(R2.n, Transistor1.c) annotation (points=[-40, 20; -40, -4]);
  connect(Transistor1.e, I1.p) annotation (points=[-40, -16; -30, -16; -30, -40;
          -10, -40]);
  connect(Transistor2.b, R3.p) annotation (points=[60, -10; 70, -10]);
  connect(Transistor2.b, C3.p) annotation (points=[60, -10; 60, -40]);
  connect(C4.n, Transistor2.c) annotation (points=[30, -4; 40, -4]);
  connect(R4.n, Transistor2.c) annotation (points=[40, 20; 40, -4]);
  connect(C5.p, Transistor2.e) annotation (points=[10, -40; 30, -40; 30, -16;
        40, -16]);
end DifferenceAmplifier;
