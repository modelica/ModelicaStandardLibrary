within Modelica.Electrical.Analog.Examples.Utilities;
model Nand "CMOS NAND Gate (see Tietze/Schenk, page 157)" 
  annotation (
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[1, 1],
      component=[20, 20]),
    Icon(
      Rectangle(extent=[-50, 70; 50, -70], style(color=0, fillColor=8)),
      Ellipse(extent=[50, 5; 60, -5], style(color=0, pattern=0)),
      Text(
        extent=[-16, 50; 14, 20],
        string="&",
        style(color=0)),
      Line(points=[60, 0; 100, 0]),
      Line(points=[0, 70; 0, 100]),
      Line(points=[-50, 50; -100, 50]),
      Line(points=[-50, -50; -100, -50]),
      Ellipse(extent=[50, 5; 60, -5], style(color=0)),
      Text(extent=[-100, 34; -90, 24], string="x1"),
      Text(extent=[-100, -65; -90, -75], string="x2"),
      Text(extent=[90, -15; 100, -25], string="y")),
    Documentation(info="<html>
<p>
The nand gate is a basic CMOS building block. It consists of four CMOS transistors.
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
      x=0.28,
      y=0.08,
      width=0.6,
      height=0.6),
    Diagram);
  Semiconductors.PMOS TP1(
    W=6.5e-6,
    L=3.1e-6,
    Beta=1.05e-5,
    Vt=-1,
    K2=0.41,
    K5=0.8385,
    dW=-2.5e-6,
    dL=-2.1e-6) annotation (extent=[10, 60; 30, 80]);
  Semiconductors.PMOS TP2(
    W=6.5e-6,
    L=3.1e-6,
    Beta=1.05e-5,
    Vt=-1,
    K2=0.41,
    K5=0.8385,
    dW=-2.5e-6,
    dL=-2.1e-6) annotation (extent=[-40, 45; -20, 65]);
  Semiconductors.NMOS TN1(
    W=6.5e-6,
    L=3.1e-6,
    Beta=4.1e-5,
    Vt=0.8,
    K2=1.144,
    K5=0.7311,
    dW=-2.5e-6,
    dL=-1.5e-6) annotation (extent=[10, 15; 30, 35]);
  Semiconductors.NMOS TN2(
    W=6.5e-6,
    L=3.1e-6,
    Beta=4.1e-5,
    Vt=0.8,
    K2=1.144,
    K5=0.7311,
    dW=-2.5e-6,
    dL=-1.5e-6) annotation (extent=[10, -25; 30, -5]);
  Basic.Capacitor C4(C=0.4e-13) annotation (extent=[50, 20; 70, 40], rotation=-
        90);
  Basic.Capacitor C7(C=0.4e-13) annotation (extent=[45, -60; 65, -40], rotation=
       -90);
  Basic.Ground Gnd annotation (extent=[40, -25; 50, -15]);
  Basic.Ground Gnd2 annotation (extent=[55, 0; 65, 10]);
  Basic.Ground Gnd3 annotation (extent=[50, -80; 60, -70]);
  Basic.Ground Gnd6 annotation (extent=[-15, 30; -5, 40]);
  Basic.Ground Gnd7 annotation (extent=[40, 15; 50, 25]);
  Basic.Ground Gnd8 annotation (extent=[40, 60; 50, 70]);
  Interfaces.Pin x1 annotation (extent=[-110, 40; -90, 60]);
  Interfaces.Pin x2 annotation (extent=[-110, -60; -90, -40]);
  Interfaces.Pin Vdd annotation (extent=[-10, 90; 10, 110]);
  Interfaces.Pin y annotation (extent=[90, -10; 110, 10]);
equation 
  connect(TN1.S, TN2.D) annotation (points=[30, 20; 30, -10]);
  connect(TN2.B, Gnd.p) annotation (points=[30, -15; 38, -15; 38, -15; 45, -15]);
  connect(TN2.D, C7.p) annotation (points=[30, -10; 55, -10; 55, -40]);
  connect(TN2.S, Gnd.p) annotation (points=[30, -20; 38, -20; 38, -15; 45, -15]);
  connect(TP1.S, TN1.D) annotation (points=[30, 65; 30, 30]);
  connect(TP1.G, TN1.G) annotation (points=[10, 65; 10, 20]);
  connect(C4.n, Gnd2.p) annotation (points=[60, 20; 60, 10]);
  connect(C7.n, Gnd3.p) annotation (points=[55, -60; 55, -70]);
  connect(TP2.B, Gnd6.p) annotation (points=[-20, 55; -10, 55; -10, 40]);
  connect(TN1.B, Gnd7.p) annotation (points=[30, 25; 45, 25]);
  connect(TP1.B, Gnd8.p) annotation (points=[30, 70; 45, 70]);
  connect(TP2.G, x1) annotation (points=[-40, 50; -100, 50]);
  connect(TP2.G, TN2.G) annotation (points=[-40, 50; -40, -20; 10, -20]);
  connect(TN1.G, x2) annotation (points=[10, 20; -70, 20; -70, -50; -100, -50]);
  connect(TP2.S, TN1.D) annotation (points=[-20, 50; 30, 50; 30, 30]);
  connect(TN1.D, C4.p) annotation (points=[30, 30; 30, 50; 60, 50; 60, 40]);
  connect(Vdd, TP1.D) annotation (points=[0, 100; 0, 80; 30, 80; 30, 75]);
  connect(TP2.D, Vdd) annotation (points=[-20, 60; -20, 80; 0, 80; 0, 100]);
  connect(C4.p, y) annotation (points=[60, 40; 60, 50; 80, 50; 80, 0; 100, 0]);
end Nand;
