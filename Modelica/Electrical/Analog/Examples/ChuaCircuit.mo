within Modelica.Electrical.Analog.Examples;
encapsulated model ChuaCircuit "Chua's circuit, ns, V, A" 
  import Modelica.Electrical.Analog.Basic;
  import Modelica.Electrical.Analog.Examples.Utilities;
  import Modelica.Icons;
  extends Icons.Example;
  
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true, 
        extent={{-100,-100},{100,100}}, 
        grid={1,1}), graphics),
    Documentation(info="<html>
<p>
 Chua's circuit is the most simple nonlinear circuit which shows chaotic behaviour. The circuit consists of linear basic elements (capacitors, resistor, conductor, inductor), and one nonlinear element, which is called Chua's diode. The chaotic behaviour is simulated.
<p>
The simulation end time should be set to 5e4. To get the chaotic behaviour please plot C1.v. Choose C2.v as the independent variable.
<p>
<dl>
<dt>
<b>Reference:</b>
<dd>
Kennedy, M.P.: Three Steps to Chaos - Part I: Evolution. IEEE Transactions on CAS I 40 (1993)10, 640-656
</dd>
</dl>
 
</HTML>
", revisions="<html>
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
      x=0.22,
      y=0.17,
      width=0.6,
      height=0.6),
    experiment(StopTime=1),
    experimentSetupOutput);
  Basic.Inductor L(L=18) annotation (Placement(transformation(
        origin={-75,50}, 
        extent={{-25,-25},{25,25}}, 
        rotation=270)));
  Basic.Resistor Ro(R=12.5e-3) annotation (Placement(transformation(
        origin={-75,-5}, 
        extent={{-25,-25},{25,25}}, 
        rotation=270)));
  Basic.Conductor G(G=0.565) annotation (Placement(transformation(extent={{-25,
            50},{25,100}}, rotation=0)));
  Basic.Capacitor C1(C=10, v(start=4)) annotation (Placement(transformation(
        origin={25,15}, 
        extent={{-25,-25},{25,25}}, 
        rotation=270)));
  Basic.Capacitor C2(C=100) annotation (Placement(transformation(
        origin={-25,15}, 
        extent={{-25,-25},{25,25}}, 
        rotation=270)));
  Utilities.NonlinearResistor Nr(
    Ga(min=-1) = -0.757576,
    Gb(min=-1) = -0.409091,
    Ve=1) annotation (Placement(transformation(
        origin={75,15}, 
        extent={{-25,-25},{25,25}}, 
        rotation=270)));
  Basic.Ground Gnd annotation (Placement(transformation(extent={{-25,-100},{25,
            -50}}, rotation=0)));
equation 
  connect(L.p, G.p) annotation (Line(points={{-75,75},{-25,75}}));
  connect(G.n, Nr.p) annotation (Line(points={{25,75},{75,75},{75,40}}));
  connect(Nr.n, Gnd.p) annotation (Line(points={{75,-10},{75,-50},{0,-50}}));
  connect(C1.p, G.n) annotation (Line(points={{25,40},{25,75}}));
  connect(L.n, Ro.p) annotation (Line(points={{-75,25},{-75,20}}));
  connect(G.p, C2.p) annotation (Line(points={{-25,75},{-25,40}}));
  connect(C1.n, Gnd.p) annotation (Line(points={{25,-10},{25,-50},{0,-50}}));
  connect(C2.n, Gnd.p) annotation (Line(points={{-25,-10},{-25,-50},{0,-50}}));
  connect(Ro.n, Gnd.p) annotation (Line(points={{-75,-30},{-75,-50},{0,-50}}));
end ChuaCircuit;
