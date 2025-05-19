within Modelica.Electrical.Analog.Examples;
model ChuaCircuit "Chua's circuit"
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.Resistance R=1900 "Try R={1850,1800,1750}";
  SI.Voltage v1(start=+2.764331, fixed=true)=c1.v "Result: c1.v";
  SI.Voltage v2(start=+0.744123, fixed=true)=c2.v "Result: c2.v";
  Modelica.Electrical.Analog.Basic.Inductor inductor(i(fixed=true, start=0), L=18e-3)
    annotation (Placement(transformation(
        origin={-70,20},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor rL(R=14) annotation (Placement(transformation(
        origin={-70,-40},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor resistor(R=R)    annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={0,40})));
  Modelica.Electrical.Analog.Basic.Capacitor c1(C=10e-9)
    annotation (Placement(transformation(
        origin={20,-10},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor c2(C=100e-9)
    annotation (Placement(transformation(
        origin={-20,-10},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.Electrical.Analog.Examples.Utilities.NonlinearResistor chuasDiode(
    Ga(min=-1) = -757.7576e-6,
    Gb(min=-1) = -409.0909e-6,
    Ve=1)     annotation (Placement(transformation(
        origin={70,-10},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground Gnd annotation (Placement(transformation(extent={{-20,
            -100},{20,-60}})));
equation
  connect(inductor.n, rL.p) annotation (Line(points={{-70,0},{-70,-20}}));
  connect(c2.p, resistor.p)
    annotation (Line(points={{-20,10},{-20,40}}, color={0,0,255}));
  connect(inductor.p, resistor.p)
    annotation (Line(points={{-70,40},{-20,40}}, color={0,0,255}));
  connect(resistor.n, chuasDiode.p)
    annotation (Line(points={{20,40},{70,40},{70,10}}, color={0,0,255}));
  connect(c1.p, resistor.n)
    annotation (Line(points={{20,10},{20,40}}, color={0,0,255}));
  connect(rL.n, Gnd.p) annotation (Line(
      points={{-70,-60},{0,-60}},           color={0,0,255}));
  connect(c2.n, Gnd.p) annotation (Line(
      points={{-20,-30},{-20,-60},{0,-60}},           color={0,0,255}));
  connect(Gnd.p,c1. n) annotation (Line(
      points={{0,-60},{20,-60},{20,-30}}, color={0,0,255}));
  connect(Gnd.p, chuasDiode.n)
    annotation (Line(points={{0,-60},{70,-60},{70,-30}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=0.1,
      Interval=1e-06,
      Tolerance=1e-06),
    Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
            100,100}}), graphics={Text(
          extent={{-100,90},{100,60}},
          textColor={0,0,255},
          textString="Path to chaos: R = 
{1850, 1800, 1750} Ohm
Plot v2 vs. v1")}),
    Documentation(info="<html>
<p>This is a remake of the original implementation using realistic parameters for the components.</p>
<p>Chua&#39;s circuit is the most simple nonlinear circuit which shows chaotic behaviour. The circuit consists of linear basic elements (capacitors, resistor, conductor, inductor), and one nonlinear element, which is called Chua&#39;s diode. </p>
<p>It is possible to implement the nonlinear Chua&#39;s diode with two circuits called <a href=\"modelica://Modelica.Electrical.Analog.Examples.ChuaDiode\">NIC</a> 
(negative impedance converter) using each an operational amplifier.</p>
<p>
The default paremeterization shows periodic behaviour at least after initial transients have vanished.<br>
In the periodic region two attractors exist: Try initialization for v1 and v2 with exact negative values.<br>
To investigate the path to chaos set (one after the other) R = {1900, 1850, 1800, 1750} Ohm and plot v2 vs. v1 as independent variable.<br>
</p>
<p><strong>Reference:</strong></p>
<ul>
<li>Leon O. Chua, Chai Wah Wu, Anshan Huang and Guo-Qun Zhong: 
    A Universal Circuit for Studying and Generating Chaos - Part I: Routes to Chaos. 
    IEEE Transactions on Circuits and Systems, Vol. 40 (1993) 10, 732-744</li>
<li>Michael Peter Kennedy: 
    Three Steps to Chaos - Part I: Evolution. 
    IEEE Transactions on Circuits and Systems, Vol. 40 (1993)10, 640-656</li>
<li>Guo-Qun Zhong and F. Ayrom: 
    Periodicity and Chaos in Chua&#39;s Circuit. 
    IEEE Transactions on Circuits and Systems, Vol. 32 (1985) 5, 501-503</li>
</ul>
</html>",
   revisions="<html>
<dl>
<dt>
<strong>Main Authors:</strong>
</dt>
<dd>
    Christoph Clau&szlig;
    &lt;<a href=\"mailto:christoph@clauss-it.com\">christoph@clauss-it.com</a>&gt;<br>
    Andr&eacute; Schneider
    &lt;<a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden<br>
</dd>
<dt>
<strong>Revision 2025:</strong>
</dt>
<dd>
    Prof. Anton Haumer
    &lt;<a href=\"mailto:anton.haumer@oth-regensburg.de\">anton.haumer@oth-regensburg.de</a>&gt;<br>
    Estbavarian Technical University of Applied Sciences Regensburg<br>
    D-93053 Regensburg, Germany<br>
</dd>
</dl>
</html>"));
end ChuaCircuit;
