within Modelica.Electrical.Analog.Examples;
encapsulated model ChuaCircuit "Chua's circuit, ns, V, A"
  import Modelica.Electrical.Analog.Basic;
  import Modelica.Electrical.Analog.Examples.Utilities;
  import Modelica.Icons;
  extends Icons.Example;

  Basic.Inductor L(L=18) annotation (Placement(transformation(
        origin={-75,38},
        extent={{-25,-25},{25,25}},
        rotation=270)));
  Basic.Resistor Ro(R=12.5e-3) annotation (Placement(transformation(
        origin={-75,-17},
        extent={{-25,-25},{25,25}},
        rotation=270)));
  Basic.Conductor G(G=0.565) annotation (Placement(transformation(extent={{-25,38},
            {25,88}},      rotation=0)));
  Basic.Capacitor C1(C=10, v(start=4)) annotation (Placement(transformation(
        origin={25,3},
        extent={{-25,-25},{25,25}},
        rotation=270)));
  Basic.Capacitor C2(C=100) annotation (Placement(transformation(
        origin={-25,3},
        extent={{-25,-25},{25,25}},
        rotation=270)));
  Utilities.NonlinearResistor Nr(
    Ga(min=-1) = -0.757576,
    Gb(min=-1) = -0.409091,
    Ve=1) annotation (Placement(transformation(
        origin={75,3},
        extent={{-25,-25},{25,25}},
        rotation=270)));
  Basic.Ground Gnd annotation (Placement(transformation(extent={{-25,-112},{25,
            -62}}, rotation=0)));
equation
  connect(L.p, G.p) annotation (Line(points={{-75,63},{-25,63}}));
  connect(G.n, Nr.p) annotation (Line(points={{25,63},{75,63},{75,28}}));
  connect(Nr.n, Gnd.p) annotation (Line(points={{75,-22},{75,-62},{0,-62}}));
  connect(C1.p, G.n) annotation (Line(points={{25,28},{25,45.5},{25,63}}));
  connect(L.n, Ro.p) annotation (Line(points={{-75,13},{-75,8}}));
  connect(G.p, C2.p) annotation (Line(points={{-25,63},{-26,46},{-26,28},{-25,
          28}}));
  connect(C1.n, Gnd.p) annotation (Line(points={{25,-22},{25,-62},{0,-62}}));
  connect(C2.n, Gnd.p) annotation (Line(points={{-25,-22},{-25,-62},{0,-62}}));
  connect(Ro.n, Gnd.p) annotation (Line(points={{-75,-42},{-75,-62},{0,-62}}));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics),
    Documentation(info="<html>
<p>
 Chua's circuit is the most simple nonlinear circuit which shows chaotic behaviour. The circuit consists of linear basic elements (capacitors, resistor, conductor, inductor), and one nonlinear element, which is called Chua's diode. The chaotic behaviour is simulated.
<p>
The simulation end time should be set to 5e4. To get the chaotic behaviour please plot C1.v. Choose C2.v as the independent variable .
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
Christoph Clau&szlig;
    &lt;<a href=\"mailto:Christoph.Clauss@eas.iis.fraunhofer.de\">Christoph.Clauss@eas.iis.fraunhofer.de</a>&gt;<br>
    Andr&eacute; Schneider
    &lt;<a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>&gt;<br>
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
    experiment(StopTime=1),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={Text(
          extent={{-98,104},{-32,72}},
          lineColor={0,0,255},
          textString="Chua Circuit")}));
end ChuaCircuit;
