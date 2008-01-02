model HeatingRectifier "Heating rectifier" 
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Semiconductors.HeatingDiode HeatingDiode1 
                annotation (extent=[-20, 40; 0, 60]);
  Modelica.Electrical.Analog.Basic.Ground G 
  annotation (extent=[-80, 0; -60, 20]);
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage1 
  annotation (extent=[-80, 30; -60, 50], rotation=270);
  
annotation (Diagram(Text(extent=[-94, 102; 0, 74], string=
          "HeatingRectifier")));
  Modelica.Electrical.Analog.Basic.Capacitor Capacitor1 
  annotation (extent=[20, 40; 40, 60]);
  Modelica.Thermal.HeatTransfer.HeatCapacitor HeatCapacitor1(C=1) 
  annotation (extent=[-20, -60; 0, -40], rotation=180);
  Modelica.Thermal.HeatTransfer.ThermalConductor ThermalConductor1(G=10) 
  annotation (extent=[-20, -20; 0, 0], rotation=270);
  Modelica.Electrical.Analog.Basic.Resistor R(R=1) 
  annotation (extent=[20, 70; 40, 90]);
equation 
  connect(SineVoltage1.p, HeatingDiode1.p) 
  annotation (points=[-70, 50; -20, 50], style(color=3));
  connect(SineVoltage1.n, G.p) 
  annotation (points=[-70, 30; -70, 20], style(color=3));
  connect(Capacitor1.n, G.p) 
  annotation (points=[40, 50; 40, 20; -70, 20], style(color=3));
  connect(HeatingDiode1.n, Capacitor1.p) 
  annotation (points=[0, 50; 20, 50], style(color=3));
  connect(HeatingDiode1.heatPort, ThermalConductor1.port_a) 
                                                          annotation (
   points=[-10,40; -10,20.5; -10,1; -10,1],     style(color=42));
  connect(ThermalConductor1.port_b, HeatCapacitor1.port) 
                                                       annotation (
    points=[-10,-21; -10,-25.75; -10,-25.75; -10,-30.5; -10,-40; -10,-40],
                  style(color=42));
  connect(R.p, Capacitor1.p) 
  annotation (points=[20, 80; 20, 50], style(color=3));
  connect(R.n, Capacitor1.n) 
  annotation (points=[40, 80; 40, 50], style(color=3));
  
annotation (Documentation(info="<HTML>
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
HeatingDiode1.heatPort.Q_dot<br>
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
