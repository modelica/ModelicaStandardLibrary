encapsulated model CauerFilter "CAUER Switched Capacitor Filter" 
  import Modelica.Electrical.Analog.Basic;
  import Modelica.Electrical.Analog.Sources;
  import Modelica.Electrical.Analog.Examples.Utilities;
  import Modelica.Icons;
  extends Icons.Example;
  
  annotation (
    Icon,
    Documentation(info="<html>
<p>
The example Cauer Filter is a low-pass-filter of the fifth order. It is realized
using a switched-capacitor network. The voltage source V is the input voltage,
and the Op5.p2.v is the filter output voltage. The pulse response is calculated.
<p>
The simulation end time should be 2e5. Please plot the output voltage Op5.p2.v.
<p>
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
<b>Version:</b>
<dd>
$Id$<br>
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
      x=0.11,
      y=0.1,
      width=0.6,
      height=0.6));
  Sources.TrapezoidVoltage V(
    V=1,
    startTime=499,
    rising=1,
    width=1500,
    falling=1,
    period=50000,
    nperiod=1) annotation (extent=[-95.7143, 75.7143; -75.7143, 95.7143]);
  Sources.TrapezoidVoltage Clk(
    V=5,
    rising=5,
    width=500,
    falling=5,
    period=1000) annotation (extent=[-67.1429, 75.7143; -47.1429, 95.7143]);
  Basic.Capacitor C1(C=1) annotation (extent=[-38.5714, 75.7143; -18.5714,
        95.7143]);
  Basic.Capacitor C2(C=1.55) annotation (extent=[-10, 75.7143; 10, 95.7143]);
  Basic.Capacitor C3(C=1.527) annotation (extent=[18.5714, 75.7143; 38.5714,
        95.7143]);
  Basic.Capacitor C4(C=1) annotation (extent=[47.1429, 75.7143; 67.1429,
        95.7143]);
  Basic.Capacitor C5(C=1) annotation (extent=[75.7143, 75.7143; 95.7143,
        95.7143]);
  Basic.Capacitor C6(C=1.018) annotation (extent=[-95.7143, 47.1429; -75.7143,
        67.1429]);
  Basic.Capacitor C7(C=1) annotation (extent=[-67.1429, 47.1429; -47.1429,
        67.1429]);
  Basic.Capacitor C8(C=1.644) annotation (extent=[-38.5714, 47.1429; -18.5714,
        67.1429]);
  Basic.Capacitor C9(C=2) annotation (extent=[-10, 47.1429; 10, 67.1429]);
  Basic.Capacitor C10(C=1) annotation (extent=[18.5714, 47.1429; 38.5714,
        67.1429]);
  Basic.Capacitor C11(C=2) annotation (extent=[47.1429, 47.1429; 67.1429,
        67.1429]);
  Basic.Capacitor C12(C=1) annotation (extent=[75.7143, 47.1429; 95.7143,
        67.1429]);
  Basic.Capacitor C13(C=9.862) annotation (extent=[-95.7143, 18.5714; -75.7143,
          38.5714]);
  Basic.Capacitor C14(C=7.23) annotation (extent=[-67.1429, 18.5714; -47.1429,
        38.5714]);
  Basic.Capacitor C15(C=10.06) annotation (extent=[-38.5714, 18.5714; -18.5714,
          38.5714]);
  Basic.Capacitor C16(C=10.23) annotation (extent=[-10, 18.5714; 10, 38.5714]);
  Basic.Capacitor C17(C=12.76) annotation (extent=[18.5714, 18.5714; 38.5714,
        38.5714]);
  Basic.Capacitor C18(C=8.676) annotation (extent=[47.1429, 18.5714; 67.1429,
        38.5714]);
  Utilities.RealSwitch S1 annotation (extent=[75.7143, 18.5714; 95.7143,
        38.5714]);
  Utilities.RealSwitch S2 annotation (extent=[-95.7143, -10; -75.7143, 10]);
  Utilities.RealSwitch S3 annotation (extent=[-67.1429, -10; -47.1429, 10]);
  Utilities.RealSwitch S4 annotation (extent=[-38.5714, -10; -18.5714, 10]);
  Utilities.RealSwitch S5 annotation (extent=[-10, -10; 10, 10]);
  Utilities.RealSwitch S6 annotation (extent=[18.5714, -10; 38.5714, 10]);
  Utilities.RealSwitch S7 annotation (extent=[47.1429, -10; 67.1429, 10]);
  Utilities.RealSwitch S8 annotation (extent=[75.7143, -10; 95.7143, 10]);
  Utilities.RealSwitch S9 annotation (extent=[-95.7143, -38.5714; -75.7143, -
        18.5714]);
  Utilities.RealSwitch S10 annotation (extent=[-67.1429, -38.5714; -47.1429, -
        18.5714]);
  Utilities.RealSwitch S11 annotation (extent=[-38.5714, -38.5714; -18.5714, -
        18.5714]);
  Utilities.RealSwitch S12 annotation (extent=[-10, -38.5714; 10, -18.5714]);
  Utilities.RealSwitch S13 annotation (extent=[18.5714, -38.5714; 38.5714, -
        18.5714]);
  Utilities.RealSwitch S14 annotation (extent=[47.1429, -38.5714; 67.1429, -
        18.5714]);
  Utilities.RealSwitch S15 annotation (extent=[75.7143, -38.5714; 95.7143, -
        18.5714]);
  Utilities.RealSwitch S16 annotation (extent=[-95.7143, -67.1429; -75.7143, -
        47.1429]);
  Utilities.RealSwitch S17 annotation (extent=[-67.1429, -67.1429; -47.1429, -
        47.1429]);
  Utilities.RealSwitch S18 annotation (extent=[-38.5714, -67.1429; -18.5714, -
        47.1429]);
  Basic.VCV Op1(gain=30000) annotation (extent=[-10, -67.1429; 10, -47.1429]);
  Basic.VCV Op2(gain=30000) annotation (extent=[18.5714, -67.1429; 38.5714, -
        47.1429]);
  Basic.VCV Op3(gain=30000) annotation (extent=[47.1429, -67.1429; 67.1429, -
        47.1429]);
  Basic.VCV Op4(gain=30000) annotation (extent=[75.7143, -67.1429; 95.7143, -
        47.1429]);
  Basic.VCV Op5(gain=30000) annotation (extent=[-95.7143, -95.7143; -75.7143, -
        75.7143]);
  Basic.Ground G annotation (extent=[-67.1429, -95.7143; -47.1429, -75.7143]);
  Basic.Ground M annotation (extent=[-38.5714, -95.7143; -18.5714, -75.7143]);
equation 
  connect(S1.n1, V.p) annotation (points=[95.7143, 34.5714; -95.7143, 85.7143]);
  connect(C8.p, C18.n) annotation (points=[-38.5714,57.1429; 67.1429,28.5714]);
  connect(C8.p, S11.n1) annotation (points=[-38.5714,57.1429; -18.5714,-22.5714]);
  connect(C8.p, S17.n1) annotation (points=[-38.5714, 57.1429; -47.1429, -
        51.1429]);
  connect(C8.p, Op5.p2) annotation (points=[-38.5714, 57.1429; -75.7143, -
        80.7143]);
  connect(C2.p, C13.p) annotation (points=[-10,85.7143; -95.7143,28.5714]);
  connect(C2.p, C16.n) annotation (points=[-10,85.7143; 10,28.5714]);
  connect(C2.p, S7.n1) annotation (points=[-10, 85.7143; 67.1429, 6]);
  connect(C2.p, S13.n1) annotation (points=[-10,85.7143; 38.5714,-22.5714]);
  connect(C2.p, Op3.p2) annotation (points=[-10, 85.7143; 67.1429, -52.1429]);
  connect(C6.p, C14.n) annotation (points=[-95.7143,57.1429; -47.1429,28.5714]);
  connect(C6.p, S1.n2) annotation (points=[-95.7143,57.1429; 95.7143,29.9714]);
  connect(C6.p, S5.n1) annotation (points=[-95.7143, 57.1429; 10, 6]);
  connect(C6.p, Op1.p2) annotation (points=[-95.7143, 57.1429; 10, -52.1429]);
  connect(C15.n, S9.n2) annotation (points=[-18.5714,28.5714; -75.7143,-27.1714]);
  connect(C15.n, S3.n1) annotation (points=[-18.5714,28.5714; -47.1429,6]);
  connect(C15.n, Op2.p2) annotation (points=[-18.5714,28.5714; 38.5714,-52.1429]);
  connect(C14.p, C2.n) annotation (points=[-67.1429,28.5714; 10,85.7143]);
  connect(C14.p, S2.n2) annotation (points=[-67.1429,28.5714; -75.7143,1.4]);
  connect(C14.p, S4.n1) annotation (points=[-67.1429,28.5714; -18.5714,6]);
  connect(C14.p, Op1.n1) annotation (points=[-67.1429,28.5714; -10,-62.1429]);
  connect(C15.p, S6.n2) annotation (points=[-38.5714,28.5714; 38.5714,1.4]);
  connect(C15.p, S8.n2) annotation (points=[-38.5714,28.5714; 95.7143,1.4]);
  connect(C15.p, Op2.n1) annotation (points=[-38.5714,28.5714; 18.5714,-62.1429]);
  connect(C16.p, C6.n) annotation (points=[-10,28.5714; -75.7143,57.1429]);
  connect(C16.p, C8.n) annotation (points=[-10,28.5714; -18.5714,57.1429]);
  connect(C16.p, S10.n2) annotation (points=[-10,28.5714; -47.1429,-27.1714]);
  connect(C16.p, Op3.n1) annotation (points=[-10,28.5714; 47.1429,-62.1429]);
  connect(C17.p, S12.n1) annotation (points=[18.5714,28.5714; 10,-22.5714]);
  connect(C17.p, S14.n1) annotation (points=[18.5714,28.5714; 67.1429,-22.5714]);
  connect(C17.p, Op4.n1) annotation (points=[18.5714,28.5714; 75.7143,-62.1429]);
  connect(C18.p, C13.n) annotation (points=[47.1429,28.5714; 16.4286,28.5714;
        16.4286,28.5714; -14.2857,28.5714; -14.2857,28.5714; -75.7143,28.5714]);
  connect(C18.p, S16.n1) annotation (points=[47.1429,28.5714; -75.7143,-51.1429]);
  connect(C18.p, S18.n1) annotation (points=[47.1429,28.5714; -18.5714,-51.1429]);
  connect(C18.p, Op5.n1) annotation (points=[47.1429,28.5714; -95.7143,-90.7143]);
  connect(C17.n, S15.n2) annotation (points=[38.5714,28.5714; 95.7143,-27.1714]);
  connect(C17.n, S17.n2) annotation (points=[38.5714,28.5714; -47.1429,-55.7429]);
  connect(C17.n, S9.n1) annotation (points=[38.5714,28.5714; -75.7143,-22.5714]);
  connect(C17.n, Op4.p2) annotation (points=[38.5714,28.5714; 95.7143,-52.1429]);
  connect(C1.n, S2.p) annotation (points=[-18.5714,85.7143; -95.7143,4]);
  connect(C3.p, S3.p) annotation (points=[18.5714,85.7143; -67.1429,4]);
  connect(C3.n, S4.p) annotation (points=[38.5714, 85.7143; -38.5714, 4]);
  connect(C4.p, S5.p) annotation (points=[47.1429, 85.7143; -10, 4]);
  connect(C4.n, S6.p) annotation (points=[67.1429,85.7143; 18.5714,4]);
  connect(C5.p, S7.p) annotation (points=[75.7143, 85.7143; 47.1429, 4]);
  connect(C5.n, S8.p) annotation (points=[95.7143, 85.7143; 75.7143, 4]);
  connect(C7.p, S9.p) annotation (points=[-67.1429,57.1429; -95.7143,-24.5714]);
  connect(C7.n, S10.p) annotation (points=[-47.1429,57.1429; -67.1429,-24.5714]);
  connect(C9.p, S11.p) annotation (points=[-10,57.1429; -38.5714,-24.5714]);
  connect(C9.n, S12.p) annotation (points=[10,57.1429; -10,-24.5714]);
  connect(C10.p, S13.p) annotation (points=[18.5714,57.1429; 18.5714,36.7143;
        18.5714,36.7143; 18.5714,16.2858; 18.5714,-24.5714; 18.5714,-24.5714]);
  connect(C10.n, S14.p) annotation (points=[38.5714,57.1429; 47.1429,-24.5714]);
  connect(C11.p, S15.p) annotation (points=[47.1429,57.1429; 75.7143,-24.5714]);
  connect(C11.n, S16.p) annotation (points=[67.1429, 57.1429; -95.7143, -
        53.1429]);
  connect(C12.p, S17.p) annotation (points=[75.7143, 57.1429; -67.1429, -
        53.1429]);
  connect(C12.n, S18.p) annotation (points=[95.7143, 57.1429; -38.5714, -
        53.1429]);
  connect(C1.p, S1.p) annotation (points=[-38.5714, 85.7143; 75.7143, 32.5714]);
  connect(S1.control, Clk.p) annotation (points=[89.1143, 38.5714; -67.1429,
        85.7143]);
  connect(S2.control, Clk.p) annotation (points=[-82.3143,10; -67.1429,85.7143]);
  connect(S3.control, Clk.p) annotation (points=[-53.7429, 10; -67.1429,
        85.7143]);
  connect(S4.control, Clk.p) annotation (points=[-25.1714, 10; -67.1429,
        85.7143]);
  connect(S5.control, Clk.p) annotation (points=[3.4,10; -67.1429,85.7143]);
  connect(S6.control, Clk.p) annotation (points=[31.9714,10; -67.1429,85.7143]);
  connect(S7.control, Clk.p) annotation (points=[60.5429,10; -67.1429,85.7143]);
  connect(S8.control, Clk.p) annotation (points=[89.1143, 10; -67.1429, 85.7143]);
  connect(S9.control, Clk.p) annotation (points=[-82.3143,-18.5714; -67.1429,
        85.7143]);
  connect(S10.control, Clk.p) annotation (points=[-53.7429,-18.5714; -67.1429,
        85.7143]);
  connect(S11.control, Clk.p) annotation (points=[-25.1714,-18.5714; -67.1429,
        85.7143]);
  connect(S12.control, Clk.p) annotation (points=[3.4,-18.5714; -67.1429,
        85.7143]);
  connect(S13.control, Clk.p) annotation (points=[31.9714,-18.5714; -67.1429,
        85.7143]);
  connect(S14.control, Clk.p) annotation (points=[60.5429,-18.5714; -67.1429,
        85.7143]);
  connect(S15.control, Clk.p) annotation (points=[89.1143,-18.5714; -67.1429,
        85.7143]);
  connect(S16.control, Clk.p) annotation (points=[-82.3143,-47.1429; -67.1429,
        85.7143]);
  connect(S17.control, Clk.p) annotation (points=[-53.7429, -47.1429; -67.1429,
          85.7143]);
  connect(S18.control, Clk.p) annotation (points=[-25.1714, -47.1429; -67.1429,
          85.7143]);
  connect(G.p, V.n) annotation (points=[-57.1429, -75.7143; -75.7143, 85.7143]);
  connect(G.p, S3.n2) annotation (points=[-57.1429,-75.7143; -47.1429,1.4]);
  connect(G.p, S4.n2) annotation (points=[-57.1429,-75.7143; -18.5714,1.4]);
  connect(G.p, S5.n2) annotation (points=[-57.1429,-75.7143; 10,1.4]);
  connect(G.p, S7.n2) annotation (points=[-57.1429,-75.7143; 67.1429,1.4]);
  connect(G.p, S11.n2) annotation (points=[-57.1429,-75.7143; -18.5714,-27.1714]);
  connect(G.p, S12.n2) annotation (points=[-57.1429, -75.7143; 10, -27.1714]);
  connect(G.p, S13.n2) annotation (points=[-57.1429, -75.7143; 38.5714, -
        27.1714]);
  connect(G.p, S14.n2) annotation (points=[-57.1429, -75.7143; 67.1429, -
        27.1714]);
  connect(G.p, S16.n2) annotation (points=[-57.1429, -75.7143; -75.7143, -
        55.7429]);
  connect(G.p, S18.n2) annotation (points=[-57.1429,-75.7143; -18.5714,-55.7429]);
  connect(G.p, S2.n1) annotation (points=[-57.1429, -75.7143; -75.7143, 6]);
  connect(G.p, S6.n1) annotation (points=[-57.1429, -75.7143; 38.5714, 6]);
  connect(G.p, S8.n1) annotation (points=[-57.1429, -75.7143; 95.7143, 6]);
  connect(G.p, S10.n1) annotation (points=[-57.1429,-75.7143; -47.1429,-22.5714]);
  connect(G.p, S15.n1) annotation (points=[-57.1429,-75.7143; 95.7143,-22.5714]);
  connect(M.p, Op1.p1) annotation (points=[-28.5714,-75.7143; -10,-52.1429]);
  connect(M.p, Op2.p1) annotation (points=[-28.5714,-75.7143; 18.5714,-52.1429]);
  connect(M.p, Op3.p1) annotation (points=[-28.5714,-75.7143; 47.1429,-52.1429]);
  connect(M.p, Op4.p1) annotation (points=[-28.5714,-75.7143; 75.7143,-52.1429]);
  connect(M.p, Op5.p1) annotation (points=[-28.5714,-75.7143; -95.7143,-80.7143]);
  connect(M.p, Op1.n2) annotation (points=[-28.5714,-75.7143; 10,-62.1429]);
  connect(M.p, Op2.n2) annotation (points=[-28.5714,-75.7143; 38.5714,-62.1429]);
  connect(M.p, Op3.n2) annotation (points=[-28.5714,-75.7143; 67.1429,-62.1429]);
  connect(M.p, Op4.n2) annotation (points=[-28.5714,-75.7143; 95.7143,-62.1429]);
  connect(M.p, Op5.n2) annotation (points=[-28.5714,-75.7143; -75.7143,-90.7143]);
  connect(M.p, Clk.n) annotation (points=[-28.5714,-75.7143; -47.1429,85.7143]);
  
  /*1*/
  
  /*2*/
  
  /*3*/
  
  /*4*/
  
  /*5*/
  /*6*/
  /*7*/
  /*8*/
  /*9*/
  /*10*/
  /*11*/
  /*12*/
  /*13*/
  /*14*/
  /*15*/
  /*16*/
  /*17*/
  /*18*/
  /*19*/
  /*20*/
  /*21*/
  /*22*/
  /*23*/
  /*24*/
  /*25*/
  /*26*/
  /*27*/
  /*28*/
  /*29*/
  /*CL*/
  /*G*/
end CauerFilter;
