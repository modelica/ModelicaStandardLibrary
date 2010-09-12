within Modelica.Electrical.Analog.Examples;
model HeatingRectifier "Heating rectifier"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Semiconductors.HeatingDiode HeatingDiode1(
      useHeatPort=true)
                annotation (Placement(transformation(extent={{-20,40},{0,60}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground G
  annotation (Placement(transformation(extent={{-80,0},{-60,20}}, rotation=0)));
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage1(V=1, freqHz=1)
  annotation (Placement(transformation(
        origin={-70,40},
        extent={{-10,-10},{10,10}},
        rotation=270)));

  Modelica.Electrical.Analog.Basic.Capacitor Capacitor1(C=1)
  annotation (Placement(transformation(extent={{20,40},{40,60}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor HeatCapacitor1(C=1)
  annotation (Placement(transformation(
        origin={-20,-50},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor ThermalConductor1(G=10)
  annotation (Placement(transformation(
        origin={-20,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor R(R=1)
  annotation (Placement(transformation(extent={{20,70},{40,90}}, rotation=0)));
equation
  connect(SineVoltage1.p, HeatingDiode1.p)
  annotation (Line(points={{-70,50},{-20,50}}, color={0,0,255}));
  connect(SineVoltage1.n, G.p)
  annotation (Line(points={{-70,30},{-70,20}}, color={0,0,255}));
  connect(Capacitor1.n, G.p)
  annotation (Line(points={{40,50},{40,20},{-70,20}}, color={0,0,255}));
  connect(HeatingDiode1.n, Capacitor1.p)
  annotation (Line(points={{0,50},{20,50}}, color={0,0,255}));
  connect(HeatingDiode1.heatPort, ThermalConductor1.port_a)
                                                          annotation (Line(
        points={{-20,40},{-20,0},{-20,0}},            color={191,0,0}));
  connect(ThermalConductor1.port_b, HeatCapacitor1.port)
                                                       annotation (Line(points={{-20,-20},
          {-20,-25.75},{-20,-40}},
        color={191,0,0}));
  connect(R.p, Capacitor1.p)
  annotation (Line(points={{20,80},{20,50}}, color={0,0,255}));
  connect(R.n, Capacitor1.n)
  annotation (Line(points={{40,80},{40,50}}, color={0,0,255}));

annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(
          extent={{-94,102},{0,74}},
          textString="HeatingRectifier",
          lineColor={0,0,255})}),
                                Documentation(info="<html>
<p>The heating rectifier shows a heat flow always if the electrical capacitor is loaded.</p>
<p>Simulate until T=5 s.</p>
<p>Plot in separate windows:</p><p>SineVoltage1.v and Capacitor1.p.v</p><p>HeatCapacitor1.port.T and HeatingDiode1.heatPort.T</p><p>HeatingDiode1.heatPort.Q_flow</p>
</html>",
   revisions="<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>Mai 6, 2004   </i>
       by Christoph Clauss<br> realized<br>
       </li>
</ul>
</html>"),  Documentation(info="<HTML>
<P>
The heating rectifier shows a heat flow always if the electrical capacitor is loaded.
</P>
<P>
Simulate until T=5 s.
</P>
<P>
Plot in separate windows:<br> <br>
SineVoltage1.v  and  Capacitor1.p.v <br>
HeatCapacitor1.port.T and HeatingDiode1.heatPort.T<br>
HeatingDiode1.heatPort.Q_flow<br>
</P>
<p><b>Release Notes:</b></p>
<ul>
<li><i>Mai 6, 2004   </i>
       by Christoph Clauss<br> realized<br>
       </li>
</ul>
</HTML>
"),
  experiment(
     StopTime=5));
end HeatingRectifier;
